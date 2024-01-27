lia.command.add("permflaggive", {
    adminOnly = true,
    privilege = "Give Permanent Flags",
    syntax = "<string name> [string flags]",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        if IsValid(target) then
            local flags = arguments[2]
            if not flags then
                client:notify("No flags specified")
                return
            end

            if target:hasAnyFlagBlacklist(flags) then
                client:notifyP("Failed to give PermFlags. Player is blacklisted from '" .. target:getFlagBlacklist() .. "'.")
                client:notifyP("Last reason for blacklist: " .. target:getLiliaData("LastBlacklistReason", "N/A"))
                return
            end

            target:givePermFlags(flags)
            lia.util.notifyLocalized(client:Name() .. " has given PermFlags '" .. flags .. "' to " .. target:Name())
        end
    end
})

lia.command.add("permflagtake", {
    adminOnly = true,
    privilege = "Take Permanent Flags",
    syntax = "<string name> [string flags]",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        if IsValid(target) then
            local flags = arguments[2]
            if not flags then
                client:notify("No flags specified")
                return
            end

            target:takePermFlags(flags)
            lia.util.notifyLocalized(client:Name() .. " has taken PermFlags '" .. flags .. "' from " .. target:Name())
        end
    end
})

lia.command.add("permflags", {
    adminOnly = true,
    privilege = "List Permanent Flags",
    syntax = "<string name>",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        if IsValid(target) and target:getChar() then client:notifyP("Their PermFlags are: '" .. target:getPermFlags() .. "'") end
    end
})

lia.command.add("flagblacklist", {
    adminOnly = true,
    privilege = "Blacklist Flags",
    syntax = "<string name> <string flags> <number minutes> <string reason>",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        if IsValid(target) then
            if #arguments < 4 then return "Invalid syntax" end
            if not tonumber(arguments[3]) or tonumber(arguments[3]) < 0 then return "Blacklist time (minutes) must be a number. Invalid syntax" end
            local flags = arguments[2]
            local time = tonumber(arguments[3])
            local reason = table.concat(arguments, " ", 4)
            if not flags then
                client:notify("No flags specified")
                return
            end

            if not reason then
                client:notify("No reason specified")
                return
            end

            lia.util.notifyLocalized(client:Name() .. " has blacklisted " .. target:Name() .. " from '" .. flags .. "' flags " .. (time == 0 and "permanently" or " for " .. time .. " minute(s)."))
            local blInfo = {
                time = time * 60,
                admin = client:SteamName(),
                adminsteam = client:SteamID(),
                flags = flags,
                reason = reason
            }

            target:addFlagBlacklist(flags, blInfo)
            target:setLiliaData("LastBlacklistReason", reason)
            target:saveLiliaData()
        end
    end
})

lia.command.add("flagunblacklist", {
    adminOnly = true,
    privilege = "UnBlacklist Flags",
    syntax = "<string name> [string flags]",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        if IsValid(target) then
            local flags = arguments[2]
            if not flags then
                client:notify("No flags specified")
                return
            end

            if not target:hasAnyFlagBlacklist(flags) then client:notify("They aren't blacklisted from any of those flags.") end
            lia.util.notifyLocalized(client:Name() .. " has lifted " .. target:Name() .. "'s '" .. flags .. "' flag blacklists")
            target:removeFlagBlacklist(flags)
        end
    end
})

lia.command.add("flagblacklists", {
    adminOnly = true,
    privilege = "List Blacklisted Flags",
    syntax = "<string name>",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        if IsValid(target) and target:getChar() then
            local blacklists = target:getFlagBlacklist() or ""
            local blacklistLog = target:getLiliaData("flagblacklistlog", {})
            netstream.Start(client, "openBlacklistLog", target, blacklists, blacklistLog)
        end
    end
})