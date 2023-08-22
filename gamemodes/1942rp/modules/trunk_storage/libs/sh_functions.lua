function LockTrunk(self, locked)
    assert(isbool(locked), "Expected bool, got", type(locked))
    if self:IsValid() and self:IsVehicle() and VEHICLE_DEFINITIONS[self:GetModel():lower()] then
        self:setNetVar("trunk_locked", locked)

        return true
    end

    return false
end

function IsTrunkLocked(self)
    if self:IsValid() and self:IsVehicle() then
        if VEHICLE_DEFINITIONS[self:GetModel():lower()] then return self:getNetVar("trunk_locked", false) end
    end

    return true
end

function getInv(self)
    if IsValid(self) and self:IsVehicle() and VEHICLE_DEFINITIONS[self:GetModel():lower()] then return lia.inventory.instances[self:getNetVar("trunk_id", self.trunk_id or 0)] end
end