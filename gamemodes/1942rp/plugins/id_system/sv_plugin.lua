local PLUGIN = PLUGIN
resource.AddFile("materials/documents/cover.png")
resource.AddFile("materials/documents/infos.png")
resource.AddFile("materials/documents/infos.png")

-------------------------------------------------------------------------------------------------------------------------
netstream.Hook("showIDToPlayer", function(ply, target)
    netstream.Start(ply, "OpenID")
end)

-------------------------------------------------------------------------------------------------------------------------
netstream.Hook("setCharCharacteristics", function(ply, vals, setOnChar)
    if setOnChar then
        ply:getChar():setData("charCharacteristics", vals)
    elseif setOnChar == nil or not setOnChar then
        ply:setNetVar("characsToBeSet", vals)
    end
end)

-------------------------------------------------------------------------------------------------------------------------
netstream.Hook("getPlayerCharacs", function(ply, target)
    local data = target:getChar():getData("charCharacteristics", {})
    netstream.Start(ply, "returnPlayerCharacs", data)
end)

-------------------------------------------------------------------------------------------------------------------------
function PLUGIN:PlayerLoadedChar(ply, char)
    --[[
    for characteristic, v in pairs(char:getData("charCharacteristics", {})) do
        for _, var in pairs(self.HeightEquivalentTable) do
            if characteristic == "Height" and v == var[1] then
                ply:SetModelScale(ply:GetModelScale() * var[2], 1)
            end
        end
    end]]
    if not char:getInv():hasItem("citizenid") then
        char:getInv():add("citizenid")
    end

    if not char:getData("charCharacteristics", nil) and not ply:getNetVar("characsToBeSet") then
        netstream.Start(ply, "missingCharacteristics")
    elseif ply:getNetVar("characsToBeSet") and not char:getData("charCharacteristics", nil) then
        char:setData("charCharacteristics", ply:getNetVar("characsToBeSet", {}))
        ply:setNetVar("characsToBeSet", nil)
    else
        local hasAllInfos = false
        local corruptDataMessage = "There has been an update with the papers plugin therefor you need to update some of your information."
        local data = char:getData("charCharacteristics", nil)

        for k, v in pairs(data) do
            local keyExists = false

            for k2, v2 in pairs(PLUGIN.charCharacteristics) do
                if k == k2 then
                    keyExists = true
                end
            end

            if not keyExists then
                netstream.Start(ply, "missingCharacteristics", corruptDataMessage, true)
                break
            end
        end

        if table.Count(data) ~= table.Count(PLUGIN.charCharacteristics) then
            netstream.Start(ply, "missingCharacteristics", corruptDataMessage, true)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------------
function PLUGIN:CanPlayerDropItem(client, item)
    if item.uniqueID == "citizenid" and item.uniqueID == "driverlicense" then
        return false
    else
        return true
    end
end

-------------------------------------------------------------------------------------------------------------------------
lia.command.add("chareditpapers", {
    syntax = "",
    onRun = function(ply, args)
        netstream.Start(ply, "missingCharacteristics", "Edit your information", true)
    end
})

-------------------------------------------------------------------------------------------------------------------------
concommand.Add("rebuildInfo", function(ply)
    local char = ply:getChar()
    local hasAllInfos = false
    local corruptDataMessage = "There has been an update with the papers plugin therefor you need to update some of your information."
    local data = char:getData("charCharacteristics", nil)

    for k, v in pairs(data) do
        local keyExists = false

        for k2, v2 in pairs(PLUGIN.charCharacteristics) do
            if k == k2 then
                keyExists = true
            end
        end

        if not keyExists then
            netstream.Start(ply, "missingCharacteristics", corruptDataMessage, true)
            break
        end
    end

    if table.Count(data) ~= table.Count(PLUGIN.charCharacteristics) then
        netstream.Start(ply, "missingCharacteristics", corruptDataMessage, true)
    end
end)