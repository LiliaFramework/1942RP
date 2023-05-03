local PLUGIN = PLUGIN

function PLUGIN:PlayerLoadedChar(client, character, lastChar)
    for a, variable in pairs(self.AvailableHouses) do
        if variable.id == character:getData("property_owned") then
            timer.Simple(1, function()
                client:Give("key")

                if (character:getData("rent_timer") < os.time()) and character:getData("property_owned") ~= "nil" then
                    if character:getMoney() >= variable.rent then
                        character:setData("rent_timer", os.time() + self.RentTimer)
                        character:takeMoney(variable.rent)
                    else
                        client:notify("You haven't got enough money for rent! Your keys were removed!")
                        SetGlobalBool(character:getData("property_owned") .. "_owned", false)
                        character:setData("property_owned")
                        character:setData("rent_timer")
                        client:StripWeapon("key")
                    end
                end
            end)
        end
    end
end

------------------------------------------------------------------------------------------
function PLUGIN:HouseRegister()
    for a, variable in pairs(self.AvailableHouses) do
        SetGlobalBool(variable.id .. "_owned", false)
    end
end