AddCSLuaFile()
ENT.PrintName = "Pine Tree"
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
    if hp <= 0 then return end

    if wep == "weapon_hl2axe" then
        self:SetNWInt("HP", hp - 10)

        if hp == 50 then
            self:BreakTree(self, ply)
        elseif hp == 30 then
            self:BreakTree(self, ply)
        elseif hp >= 0 and hp < 30 then
            self:BreakTree(self, ply)
            self:SetNoDraw(true)
            self:SetNotSolid(true)
            self:SetCollisionGroup(COLLISION_GROUP_NONE)

            timer.Create("respawn_tree" .. self:EntIndex(), 120, 1, function()
                local newent = ents.Create("beechtree")
                newent:SetPos(self:GetPos())
                newent:SetNoDraw(false)
                newent:Spawn()
                self:Remove()
            end)
        end
    end
end

function ENT:BreakTree(ent, ply)
    local position = ply:getItemDropPos()

    if not ply:getChar():getInv():add("pine") then
        lia.item.spawn("pine", position)
    else
        ply:notify("You have harvested some Pine Wood!")
    end
end