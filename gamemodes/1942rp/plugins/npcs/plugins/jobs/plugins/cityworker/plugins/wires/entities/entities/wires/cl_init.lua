include("shared.lua")

function ENT:Initialize()
    self.emitter = ParticleEmitter(self:GetPos())
end

function ENT:OnRemove()
    if IsValid(self.emitter) then
        self.emitter:Finish()
    end
end

function ENT:Think()
    if not self:GetNWBool("broken", false) then
        return
    else
        if not self.nextEmit then
            self.nextEmit = 0
        end

        if CurTime() >= self.nextEmit then
            local sparks = EffectData()
            sparks:SetOrigin(self:GetPos())
            sparks:SetNormal(self:GetAngles():Forward())
            sparks:SetMagnitude(math.Rand(1, 4))
            sparks:SetEntity(self)
            util.Effect("TeslaHitboxes", sparks, true, true)
            util.Effect("ElectricSpark", sparks, true, true)
            self:EmitSound("ambient/energy/spark" .. math.random(1, 6) .. ".wav", 55)
            self.nextEmit = CurTime() + math.Rand(0.5, 2)
        end
    end
end