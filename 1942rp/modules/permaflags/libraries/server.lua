function PermFlags_ExecuteOneTimeVIPGive()
    print("[!] Performing one-time Give All VIPs Perm Flags command")
    local ranks_to_give = {
        ["vip"] = true
    }

    local give_flags = "pet"
    local OnlineVIPs = {}
    for k, v in pairs(player.GetAll()) do
        if ranks_to_give[v:GetUserGroup()] then
            v:givePermFlags(give_flags)
            OnlineVIPs[v:SteamID()] = true
            v:ChatPrint("You have automatically been given permanent '" .. give_flags .. "' due to being a VIP. All existing and new characters will automatically have these flags applied.")
        end
    end

    local SuccessCount = 0
    local ErrorCount = 0
    for k, v in pairs(ULib.ucl.users) do
        if ranks_to_give[v.group] and not OnlineVIPs[k] then
            local steam64 = util.SteamIDTo64(k)
            local res = sql.Query("SELECT _data FROM lia_players WHERE _steamID=" .. steam64)
            if res == false then
                print("[!] SQL Error: " .. sql.LastError())
                ErrorCount = ErrorCount + 1
            elseif res ~= nil then
                local dataTbl = util.JSONToTable(res[1]._data or "{}")
                if not dataTbl or type(dataTbl) ~= "table" then
                    print("[!] Error trying to retrieve dataTbl! SteamID: " .. k .. ", data: " .. (res[1]._data or "nil"))
                    ErrorCount = ErrorCount + 1
                else
                    dataTbl.permflags = dataTbl.permflags or ""
                    for i = 1, #give_flags do
                        local iterFlag = give_flags[i]
                        if not dataTbl.permflags:find(iterFlag) then dataTbl.permflags = dataTbl.permflags .. iterFlag end
                    end

                    dataTbl = util.TableToJSON(dataTbl)
                    local updateQuery = sql.Query("UPDATE lia_players SET _data=" .. sql.SQLStr(dataTbl) .. " WHERE _steamID=" .. steam64)
                    if updateQuery == false then
                        print("[!] SQL Update Error: " .. sql.LastError())
                        ErrorCount = ErrorCount + 1
                    else
                        SuccessCount = SuccessCount + 1
                    end
                end
            end
        end
    end

    print("[!] Done. ErrorCount: " .. ErrorCount .. ", SuccessCount: " .. SuccessCount)
end

function PermaFlagsCore:OnCharCreated(client, char)
    local permFlags = client:getPermFlags()
    if permFlags and #permFlags > 0 then char:giveFlags(permFlags) end
end

timer.Create("flagBlacklistTick", 10, 0, function()
    for k, v in pairs(player.GetAll()) do
        local blacklistLog = v:getLiliaData("flagblacklistlog")
        if blacklistLog then
            for m, bl in pairs(blacklistLog) do
                if not bl.active and not bl.remove then continue end
                if (bl.endtime <= 0 or bl.endtime > os.time()) and not bl.remove then continue end
                bl.active = false
                bl.remove = nil
                local flagBuffer = bl.flags
                for a, b in pairs(blacklistLog) do
                    if b ~= bl and b.active then
                        for i = 1, #b.flags do
                            flagBuffer = string.Replace(flagBuffer, b.flags[i], "")
                        end
                    end
                end

                v:removeFlagBlacklist(flagBuffer)
            end
        end
    end
end)