local playerMeta = FindMetaTable("Player")

function playerMeta:ForfeitHouse()
    self:getChar():setData("property_owned")
    self:getChar():setData("rent_timer")
end

function playerMeta:SellHouse(money)
    for _, v in pairs(PLUGIN.AvailableHouses) do
        if v.id == self:getChar():getData("property_owned") then
            self:getChar():giveMoney(v.buy)
            self:ChatPrint("You sold your house and got " .. nut.currency.get(v.buy))
            break
        end
    end

    self:getChar():setData("property_owned")
    self:getChar():setData("rent_timer")
end