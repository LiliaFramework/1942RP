AddCSLuaFile()
ENT.PrintName = "Medium Rock"
ENT.Type = "anim"
ENT.Author = "Barata"
ENT.Category = "Mining"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.PhysgunDisable = true
ENT.PhysgunAllowAdmin = true

function ENT:Initialize()
    if SERVER then
        self:SetModel("models/fallenlogic_environment/rocks/medium_05.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetNoDraw(false)
        self:SetModelScale(1)
        self:SetNWFloat("HP", 180)
        local physObj = self:GetPhysicsObject()
        physObj:EnableMotion(false)
    end
end

function ENT:OnTakeDamage(dmginfo)
    local ply = dmginfo:GetAttacker()
    local wep = ply:GetActiveWeapon():GetClass()

    if wep == "weapon_hl2pickaxe" then
        local hp = self:GetNWFloat("HP", 0)
        self:SetNWFloat("HP", hp - dmginfo:GetDamage())
        self:EmitSound("physics/concrete/boulder_impact_hard" .. math.random(1, 4) .. ".wav", 75)

        if hp <= 0 then
            RockBreakMedium(self, ply)
            self:RockSpawnMed(self, ply)
            self:Remove()
        elseif hp == 150 then
            RockBreakMedium(self, ply)
        elseif hp == 120 then
            RockBreakMedium(self, ply)
        elseif hp == 90 then
            RockBreakMedium(self, ply)
        elseif hp == 60 then
            RockBreakMedium(self, ply)
        elseif hp == 30 then
            RockBreakMedium(self, ply)
        end
    end
end

function ENT:RockSpawnMed(ent, ply)
    local newent = ents.Create("rock_small")
    newent:SetPos(ent:GetPos())
    newent:SetNoDraw(false)
    newent:Spawn()
end

function RockBreakMedium(ent, ply)
    local randnum = math.random(0, 104)
    local position = ply:getItemDropPos()

    if randnum >= 0 or randnum <= 30 then
        if not ply:getChar():getInv():add("coal_ore") then
            ply:notify("You have collected some Coal Ore!")
            lia.item.spawn("coal_ore", position)
        else
            ply:notify("You have collected some Coal Ore!")
        end
    elseif randnum >= 31 and randnum <= 71 then
        if not ply:getChar():getInv():add("iron_ore") then
            ply:notify("You have collected some Iron Ore!")
            lia.item.spawn("iron_ore", position)
        else
            ply:notify("You have collected some Iron Ore!")
        end
    elseif randnum >= 72 and randnum <= 92 then
        if not ply:getChar():getInv():add("silver_ore") then
            ply:notify("You have collected some Silver Ore!")
            lia.item.spawn("silver_ore", position)
        else
            ply:notify("You have collected some Silver Ore!")
        end
    elseif randnum >= 93 and randnum <= 100 then
        if not ply:getChar():getInv():add("gold_ore") then
            ply:notify("You have collected some Gold Ore!")
            lia.item.spawn("gold_ore", position)
        else
            ply:notify("You have collected some Gold Ore!")
        end
    else
        if not ply:getChar():getInv():add("diamond_ore") then
            ply:notify("You have collected some Diamond Ore!")
            lia.item.spawn("diamond_ore", position)
        else
            ply:notify("You have collected some Diamond Ore!")
        end
    end
end