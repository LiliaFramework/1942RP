local playerMeta = FindMetaTable("Player")

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function playerMeta:SetVehicleAllowed()
    if self:getNetVar("vehicle_allowed") then
        self:setNetVar("vehicle_allowed", false)
    else
        self:setNetVar("vehicle_allowed", true)
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function playerMeta:FreeTies()
    self:setNetVar("vehicle_allowed", false)
    self:setNetVar("blinded", false)
    self:setNetVar("dragged", false)
    self:setNetVar("gagged", false)
    self:setNetVar("restricted", false)
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function playerMeta:SetBlinded()
    if self:getNetVar("blinded") then
        self:setNetVar("blinded", false)
    else
        self:setNetVar("blinded", true)
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function playerMeta:SetGagged()
    if self:getNetVar("gagged") then
        self:setNetVar("gagged", false)
    else
        self:setNetVar("gagged", true)
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function playerMeta:SetRestricted()
    if self:getNetVar("restricted") then
        self:setNetVar("restricted", false)
    else
        self:setNetVar("restricted", true)
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function playerMeta:setRestrictedTying(state, noMessage)
    if state then
        self:SetWalkSpeed(lia.config.get("walkSpeed", 130) * 0.5)
        self:SetRunSpeed(lia.config.get("runSpeed", 235) * 0.5)
        self:setNetVar("restricted", true)

        if noMessage then
            self:setLocalVar("restrictNoMsg", true)
        end

        self.liaRestrictWeps = self.liaRestrictWeps or {}

        for k, v in ipairs(self:GetWeapons()) do
            self.liaRestrictWeps[k] = v:GetClass()
        end

        timer.Simple(0, function()
            self:StripWeapons()
        end)

        hook.Run("OnPlayerRestricted", self)
    else
        self:setNetVar("restricted")
        self:SetWalkSpeed(lia.config.get("walkSpeed", 130))
        self:SetRunSpeed(lia.config.get("runSpeed", 235))

        if self:getLocalVar("restrictNoMsg") then
            self:setLocalVar("restrictNoMsg")
        end

        if self.liaRestrictWeps then
            for k, v in ipairs(self.liaRestrictWeps) do
                self:Give(v)
            end

            self.liaRestrictWeps = nil
        end

        hook.Run("OnPlayerUnRestricted", self)
    end
end