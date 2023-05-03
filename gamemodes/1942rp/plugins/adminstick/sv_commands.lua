local SCHEMA = SCHEMA

nut.command.add("setpaygrade", {
    syntax = "[character name]",
    onRun = function(client, arguments)
        local target = nut.command.findPlayer(client, arguments[1])
        local uniqueID = client:GetUserGroup()

        if not SCHEMA.modRanks[uniqueID] then
            client:notify("Your rank is not high enough to use this command.")

            return false
        end

        if IsValid(target) and target:getChar() then
            local targetchar = target:getChar()

            if PLUGIN.CitizenFactions[targetchar:getFaction()] then
                client:notify("You cannot target Civilian Factions!")

                return
            else
                if arguments[2] == "1" then
                    targetchar:setData("paygrade", "Enlisted")
                    client:notify("You have set this player's paygrade to " .. targetchar:getData("paygrade", "Enlisted"))
                    target:notify("Your paygrade was set to " .. targetchar:getData("paygrade", "Enlisted"))
                elseif arguments[2] == "2" then
                    targetchar:setData("paygrade", "Non-Commissioned Officer")
                    client:notify("You have set this player's paygrade to " .. targetchar:getData("paygrade", "Enlisted"))
                    target:notify("Your paygrade was set to " .. targetchar:getData("paygrade", "Enlisted"))
                elseif arguments[2] == "3" then
                    targetchar:setData("paygrade", "Commissioned Officer")
                    client:notify("You have set this player's paygrade to " .. targetchar:getData("paygrade", "Enlisted"))
                    target:notify("Your paygrade was set to " .. targetchar:getData("paygrade", "Enlisted"))
                elseif arguments[2] == "4" then
                    targetchar:setData("paygrade", "General Officer")
                    client:notify("You have set this player's paygrade to " .. targetchar:getData("paygrade", "Enlisted"))
                    target:notify("Your paygrade was set to " .. targetchar:getData("paygrade", "Enlisted"))
                elseif arguments[2] == "5" then
                    targetchar:setData("paygrade", "National High Command")
                    client:notify("You have set this player's paygrade to " .. targetchar:getData("paygrade", "Enlisted"))
                    target:notify("Your paygrade was set to " .. targetchar:getData("paygrade", "Enlisted"))
                end
            end
        end
    end
})

nut.command.add("CharPK", {
    syntax = "[character name]",
    onRun = function(client, arguments)
        local target = nut.command.findPlayer(client, arguments[1])
        local uniqueID = client:GetUserGroup()

        if not SCHEMA.modRanks[uniqueID] then
            client:notify("Your rank is not high enough to use this command.")

            return false
        end

        if IsValid(target) and target:getChar() then
            local targetchar = target:getChar()

            if not targetchar:getData("permakilled") then
                targetchar:setData("permakilled", true)
                target:Spawn()
                client:notify("Perma killed " .. target:Name())
            end
        end
    end
})

nut.command.add("flagbank", {
    syntax = "[character name]",
    onRun = function(client, arguments)
        local target = nut.command.findPlayer(client, arguments[1])
        local uniqueID = client:GetUserGroup()

        if not SCHEMA.superRanks[uniqueID] then
            client:notify("Your rank is not high enough to use this command.")

            return false
        end

        if target:getChar():hasFlags("bl") then
            target:getChar():takeFlags("bl")
            client:notify("Taken bl Flag!")
        else
            target:getChar():giveFlags("bl")
            client:notify("Given bl Flag!")
        end
    end
})

nut.command.add("flagmedal", {
    syntax = "[character name]",
    onRun = function(client, arguments)
        local target = nut.command.findPlayer(client, arguments[1])
        local uniqueID = client:GetUserGroup()

        if not SCHEMA.modRanks[uniqueID] then
            client:notify("Your rank is not high enough to use this command.")

            return false
        end

        if target:getChar():hasFlags("m") then
            client:notify("Taken m Flag!")
            target:getChar():takeFlags("m")
        else
            client:notify("Given m Flag!")
            target:getChar():giveFlags("m")
        end
    end
})

nut.command.add("flagbroadcast", {
    syntax = "[character name]",
    onRun = function(client, arguments)
        local target = nut.command.findPlayer(client, arguments[1])
        local uniqueID = client:GetUserGroup()

        if not SCHEMA.modRanks[uniqueID] then
            client:notify("Your rank is not high enough to use this command.")

            return false
        end

        if target:getChar():hasFlags("B") then
            client:notify("Taken B Flag!")
            target:getChar():takeFlags("B")
        else
            target:getChar():giveFlags("B")
            client:notify("Given B Flag!")
        end
    end
})

nut.command.add("flagpet", {
    syntax = "[character name]",
    onRun = function(client, arguments)
        local target = nut.command.findPlayer(client, arguments[1])
        local uniqueID = client:GetUserGroup()

        if not SCHEMA.modRanks[uniqueID] then
            client:notify("Your rank is not high enough to use this command.")

            return false
        end

        if target:getChar():hasFlags("pet") then
            target:getChar():takeFlags("pet")
            client:notify("Taken pet Flags!")
        else
            target:getChar():giveFlags("pet")
            client:notify("Given pet Flags!")
        end
    end
})

--[[
nut.command.add("forcednamechange", {
    syntax = "[character name]",
    onRun = function(client, arguments)
        local uniqueID = client:GetUserGroup()

        if not SCHEMA.modRanks[uniqueID] then
            client:notify("Your rank is not high enough to use this command.")

            return false
        end

        local target = nut.command.findPlayer(client, arguments[1])
        net.Start("namechange")
        net.Send(target)
    end
})]]
nut.command.add("charkick", {
    syntax = "<string name>",
    onRun = function(client, arguments)
        local target = nut.command.findPlayer(client, arguments[1])
        local uniqueID = client:GetUserGroup()

        if not SCHEMA.modRanks[uniqueID] then
            client:notify("Your rank is not high enough to use this command.")

            return false
        end

        if IsValid(target) then
            local char = target:getChar()

            if char then
                for k, v in ipairs(player.GetAll()) do
                    v:notifyLocalized("charKick", client:Name(), target:Name())
                end

                char:kick()
            end
        end
    end
})