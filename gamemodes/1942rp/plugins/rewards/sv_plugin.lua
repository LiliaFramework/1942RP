local PLUGIN = PLUGIN
util.AddNetworkString("sgrMenuCheck")

-------------------------------------------------------------------------------------------------------------------------
function SteamGroup_SendClaim(ply)
    local char = ply:getChar()
    if not char then return end
    char:giveMoney(nut.config.get("sgrMoneyAmount"))
    ply:notify("You have receieved " .. nut.config.get("sgrMoneyAmount") .. " " .. nut.currency.plural .. " for joining the steam group!")
    char:setData("sgrClaimed", true)
end

-------------------------------------------------------------------------------------------------------------------------
function SteamGroup_TryClaim(ply)
    local char = ply:getChar()

    if char:getData("sgrClaimed") then
        ply:notify("You've already claimed this reward.")

        return
    end

    if SteamGroupRewardList[ply:SteamID64()] then
        SteamGroup_SendClaim(ply)

        return
    end

    if SteamGroup_LastManualCheck == nil or SysTime() > SteamGroup_LastManualCheck + nut.config.get("sgrManualRequestDelay", 30) then
        SteamGroup_LastManualCheck = SysTime()
        SteamGroup_PerformCheck()
        print("[Steam Rewards] Player " .. (ply.SteamName and ply:SteamName() or ply:Name()) .. " (" .. ply:SteamID() .. ") triggered a manual check.")
    else
        ply:notify("Manual check system too busy. Try again in " .. nut.config.get("sgrManualRequestDelay", 30) .. "s or wait for automatic check (every " .. nut.config.get("sgrAutomaticRequestDelay", 300) .. "s)")
    end
end

-------------------------------------------------------------------------------------------------------------------------
function SteamGroup_PerformCheck()
    local group = nut.config.get("sgrGroupName")
    if not group or group == "" then return end

    http.Fetch("http://steamcommunity.com/groups/" .. group .. "/memberslistxml/?xml=1&p=1", function(body)
        SteamGroupRewardList_Temp = {}
        local totalMembers = SteamGroup_ProccessPageData(body)
        local pagesAccountedFor = 1
        local _, _, pgCount = body:find("<totalPages>(%d+)")
        pgCount = tonumber(pgCount)
        if not pgCount then return end

        for i = 2, pgCount do
            http.Fetch("http://steamcommunity.com/groups/" .. group .. "/memberslistxml/?xml=1&p=" .. i, function(body_s)
                local countR = SteamGroup_ProccessPageData(body_s)
                totalMembers = totalMembers + countR
                pagesAccountedFor = pagesAccountedFor + 1

                if pagesAccountedFor == pgCount then
                    SteamGroupRewardList = table.Copy(SteamGroupRewardList_Temp)
                    SteamGroupRewardList_Temp = nil
                end
            end)
        end
    end)
end

-------------------------------------------------------------------------------------------------------------------------
function SteamGroup_CreateTimer()
    timer.Create("SteamGroup_AutomaticRequestDelay", nut.config.get("sgrAutomaticRequestDelay", 300), 0, SteamGroup_PerformCheck)
end

-------------------------------------------------------------------------------------------------------------------------
function SteamGroup_ProccessPageData(data)
    local count = 0
    local dataLen = #data
    local tmpStr = ""
    local token = "<steamID64>"
    local tokenLength = #token
    local building = false
    local ignoring = false

    for i = 1, dataLen do
        if not building and not ignoring and SteamGroup_effCheckToken(data, "<steamID64>", i) then
            ignoring = true
        elseif not building and ignoring then
            if data[i - 1] == ">" then
                building = true
            end
        end

        if building then
            if tonumber(data[i]) then
                tmpStr = tmpStr .. data[i]
            else
                SteamGroup_ProcessSteamID64(tmpStr)
                building = false
                ignoring = false
                tmpStr = ""
                count = count + 1
            end
        end
    end

    return count
end

-------------------------------------------------------------------------------------------------------------------------
function SteamGroup_ProcessSteamID64(st64, main)
    if main then
        SteamGroupRewardList[st64] = true
    else
        SteamGroupRewardList_Temp[st64] = true
    end

    SteamGroupRewardList_Temp = SteamGroupRewardList_Temp or {}
    local ply = player.GetBySteamID64(st64)

    if ply and IsValid(ply) then
        local char = ply:getChar()

        if char and not char:getData("sgrClaimed") then
            SteamGroup_SendClaim(ply)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------------
function SteamGroup_effCheckToken(str, token, start, strLen)
    strLen = strLen or #str
    local tokenLen = #token
    if start + tokenLen > strLen + 1 then return false end

    for i = 1, tokenLen do
        if str[start + i - 1] ~= token[i] then return false end
    end

    return true
end

-------------------------------------------------------------------------------------------------------------------------
function PLUGIN:PlayerLoadout(ply)
    local char = ply:getChar()
    if not char then return end

    if char:getData("sgrClaimed", false) then
        ply:Give("weapon_ciga")
    end
end

-------------------------------------------------------------------------------------------------------------------------
nut.command.add("group", {
    onRun = function(ply, arguments)
        net.Start("sgrMenuCheck")
        net.Send(ply)
        ply:notify("Once you have joined the group, type /claim to make a request to check for group rewards immediately.")
    end
})

-------------------------------------------------------------------------------------------------------------------------
nut.command.add("claim", {
    onRun = function(ply, arguments)
        SteamGroup_TryClaim(ply)
    end
})

-------------------------------------------------------------------------------------------------------------------------
function PLUGIN:PlayerLoadedChar(client)
    for k, v in pairs(player.GetAll()) do
        local char = v:getChar()

        if char then
            local hasSteamReward = char:getData("sgrClaimed") or false
            char:setData("sgrClaimed", hasSteamReward)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------------
SteamGroup_CreateTimer()