AddCSLuaFile()
ENT.PrintName = "Oak Tree"
ENT.Type = "anim"
ENT.Author = "Barata"
ENT.Category = "Woodcuting"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.PhysgunDisable = true
ENT.PhysgunAllowAdmin = true

function ENT:Initialize()
    if SERVER then
        self:SetModel("models/props_foliage/tree_pine_01.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetNoDraw(false)
        self:SetNWInt("HP", 70)
        local physObj = self:GetPhysicsObject()
        physObj:EnableMotion(false)
    end
end

function ENT:OnTakeDamage(dmginfo)
    local ply = dmginfo:GetAttacker()
    local wep = ply:GetActiveWeapon():GetClass()
    local hp = self:GetNWInt("HP", 0)

    if wep == "weapon_hl2axe" then
        self:SetNWInt("HP", hp - 10)

        if hp == 50 then
            BreakTree(self, ply)
        elseif hp == 30 then
            BreakTree(self, ply)
        elseif hp >= 0 and hp < 30 then
            BreakTree(self, ply)
            self:SetNoDraw(true)
            self:Remove()

            timer.Create("respawn_tree" .. self:EntIndex(), 120, 1, function()
                local newent = ents.Create("beechtree")
                newent:SetPos(self:GetPos())
                newent:SetNoDraw(false)
                newent:Spawn()
            end)
        end
    end
end

function BreakTree(ent, ply)
    if not ply:getChar():getInv():add("oak") then
        local hp = ent:GetNWInt("HP", 0)
        ent:SetNWInt("HP", hp + 10)
        ply:notify("You have no space in your inventory!")
    else
        ply:notify("You have harvested some Oak Wood!")
    end
end