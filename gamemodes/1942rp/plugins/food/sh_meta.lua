local PLUGIN = PLUGIN
local playerMeta = FindMetaTable("Player")

function playerMeta:getHungerPercent()
    return math.Clamp((CurTime() - self:getHunger()) / PLUGIN.hungrySeconds, 0, 1)
end

function playerMeta:getHunger()
    return self:getNetVar("hunger") or 0
end

function playerMeta:addHunger(amount)
    local curHunger = CurTime() - self:getHunger()
    self:setNetVar("hunger", CurTime() - math.Clamp(math.min(curHunger, PLUGIN.hungrySeconds) - amount, 0, PLUGIN.hungrySeconds))
end

function playerMeta:isObserving()
    if self:GetMoveType() == MOVETYPE_NOCLIP and not self:InVehicle() then
        return true
    else
        return false
    end
end