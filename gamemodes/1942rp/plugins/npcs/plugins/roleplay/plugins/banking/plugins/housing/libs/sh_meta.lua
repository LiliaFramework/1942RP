local playerMeta = FindMetaTable("Player")

function playerMeta:IsRenting(money)
    if self:getChar():getData("property_owned") and self:getChar():setData("rent_timer") then return true end

    return false
end

function playerMeta:HasHouse(money)
    if self:getChar():getData("property_owned") and not self:getChar():setData("rent_timer") then return true end

    return false
end