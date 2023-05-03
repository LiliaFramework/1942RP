AddCSLuaFile()
ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Jailer NPC"
ENT.Author = "Leonheart#7476"
ENT.Category = "Leonheart NPCs"
ENT.Spawnable = true
ENT.AdminOnly = true

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/brot/prometheus/mattimodels/orpo/en6.mdl")
        self:SetHullType(HULL_HUMAN)
        self:SetHullSizeNormal()
        self:SetSolid(SOLID_BBOX)
        self:CapabilitiesAdd(CAP_ANIMATEDFACE)
        self:SetUseType(SIMPLE_USE)

        timer.Simple(1, function()
            if IsValid(self) then
                self:setAnim()
            end
        end)
    end

    function ENT:OnTakeDamage()
        return false
    end

    function ENT:Use(activator, caller, useType, value)
        if activator:Team() == FACTION_ORPO or activator:Team() == FACTION_ALLG or activator:Team() == FACTION_STAFF or activator:Team() == FACTION_RSHA or activator:IsAdmin() then
            net.Start("jailer_npc")
            net.Send(activator)
        else
            activator:notify("You can't use this!")
        end
    end
end

function ENT:setAnim()
    for k, v in ipairs(self:GetSequenceList()) do
        if v:lower():find("idle") and v ~= "idlenoise" then return self:ResetSequence(k) end
    end

    self:ResetSequence(4)
end