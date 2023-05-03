local PLUGIN = PLUGIN

------------------------------------------------------------------------------------------
nut.command.add("sellhouse", {
    syntax = "[Target Player] [Property ID]",
    onRun = function(client, arguments)
        local target = nut.command.findPlayer(client, arguments[1])
        local propertyID = arguments[2]

        if not client:Team() == FACTION_REALESTATE or client:IsAdmin() then
            client:notify("No access!")

            return
        end

        for a, variable in pairs(PLUGIN.AvailableHouses) do
            if variable.id ~= propertyID then
                client:ChatPrint("Bad Argument! Available Houses: " .. variable.name .. " with the ID: " .. variable.id)

                return
            else
                if GetGlobalBool(propertyID .. "_owned", false) == false then
                    if target:getChar():hasMoney(variable.buy) then
                        target:getChar():takeMoney(variable.buy)
                        target:getChar():setData("property_owned", propertyID)
                        SetGlobalBool(propertyID .. "_owned", true)
                        target:notify("You just bought the apartment " .. variable.name .. "for " .. variable.buy .. " " .. nut.currency.plural)
                        target:Give("key")
                    else
                        client:ChatPrint("This character lacks the funds for such!")
                    end
                else
                    client:ChatPrint("Someone has bought this house already!")
                end
            end
        end
    end;
})

------------------------------------------------------------------------------------------
nut.command.add("renthouse", {
    syntax = "[Target Player] [Property ID]",
    onRun = function(client, arguments)
        local target = nut.command.findPlayer(client, arguments[1])
        local propertyID = arguments[2]

        if not client:Team() == FACTION_REALESTATE or client:IsAdmin() then
            client:notify("No access!")

            return
        end

        for a, variable in pairs(PLUGIN.AvailableHouses) do
            if variable.id ~= propertyID then
                client:ChatPrint("Bad Argument! Available Houses: " .. variable.name .. " with the ID: " .. variable.id)

                return
            else
                if GetGlobalBool(propertyID .. "_owned", false) == false then
                    if target:getChar():hasMoney(variable.rent) then
                        target:getChar():takeMoney(variable.rent)
                        character:setData("rent_timer", os.time() + PLUGIN.RentTimer)
                        target:getChar():setData("property_owned", propertyID)
                        SetGlobalBool(propertyID .. "_owned", true)
                        target:notify("You just rented the apartment " .. variable.name .. "for " .. variable.rent .. " " .. nut.currency.plural)
                        target:Give("key")
                    else
                        client:ChatPrint("This dude has no money, bozo!")
                    end
                else
                    client:ChatPrint("Someone has bought this house already!")
                end
            end
        end
    end;
})

------------------------------------------------------------------------------------------
nut.command.add("evict", {
    syntax = "[Target Player] [Property ID]",
    onRun = function(client, arguments)
        local target = nut.command.findPlayer(client, arguments[1])
        local propertyID = arguments[2]

        if not client:Team() == FACTION_REALESTATE or client:IsAdmin() then
            client:notify("No access!")

            return
        end

        for a, variable in pairs(PLUGIN.AvailableHouses) do
            if variable.id ~= propertyID then
                client:ChatPrint("Bad Argument! Available Houses: " .. variable.name .. " with the ID: " .. variable.id)

                return
            else
                if GetGlobalBool(propertyID .. "_owned", false) == true then
                    target:getChar():setData("property_owned")
                    SetGlobalBool(propertyID .. "_owned", false)
                    target:StripWeapon("key")
                    target:notify("You got evicted from " .. variable.name)
                else
                    client:ChatPrint("This property isn't owned!")
                end
            end
        end
    end;
})

------------------------------------------------------------------------------------------
nut.command.add("setup_housing", {
    onRun = function(client, arguments)
        if client:IsSuperAdmin() then
            PLUGIN:HouseRegister()
            client:notify("RESET VARS ON HOUSING SYSTEM!")
        end
    end
})

------------------------------------------------------------------------------------------
nut.command.add("doorname", {
    adminOnly = true,
    onRun = function(client, arguments)
        local tr = util.TraceLine(util.GetPlayerTrace(client))

        if IsValid(tr.Entity) then
            client:ChatPrint("ID: " .. tr.Entity:GetName())
            client:ChatPrint("Door Type: " .. tr.Entity:GetClass())
        end
    end
})