AddCSLuaFile()
ENT.PrintName = "Big Rock"
ENT.Type = "anim"
ENT.Author = "Barata"
ENT.Category = "Mining"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.PhysgunDisable = true
ENT.PhysgunAllowAdmin = true

function ENT:Initialize()
    if SERVER then
        self:SetModel("models/fallenlogic_environment/rocks/medium_04.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetNoDraw(false)
        self:SetModelScale(1)
        self:SetNWFloat("HP", 300)
        local physObj = self:GetPhysicsObject()
        physObj:EnableMotion(false)
    end
end

function ENT:OnTakeDamage(dmginfo)
    local ply = dmginfo:GetAttacker()
    local wep = ply:GetActiveWeapon():GetClass()
    local hp = self:GetNWFloat("HP", 0)

    if wep == "weapon_hl2pickaxe" then
        self:SetNWFloat("HP", hp - dmginfo:GetDamage())

        if hp == 270 then
            RockBreakBig(self, ply)
        elseif hp == 240 then
            RockBreakBig(self, ply)
        elseif hp == 210 then
            RockBreakBig(self, ply)
        elseif hp == 180 then
            RockBreakBig(self, ply)
        elseif hp == 150 then
            RockBreakBig(self, ply)
        elseif hp == 120 then
            RockBreakBig(self, ply)
        elseif hp == 90 then
            RockBreakBig(self, ply)
        elseif hp == 60 then
            RockBreakBig(self, ply)
        elseif hp == 30 then
            RockBreakBig(self, ply)
        elseif hp == 0 or hp <= 0 then
            RockBreakBig(self, ply)
            self:RockSpawnBig(self, ply)
            self:Remove()
        end
    end
end

function ENT:RockSpawnBig(ent, ply)
    local newent = ents.Create("rock_medium")
    newent:SetPos(ent:GetPos())
    newent:SetNoDraw(false)
    newent:Spawn()
end

function RockBreakBig(ent, ply)
    local randnum = math.random(0, 104)
    local position = ply:getItemDropPos()

    if randnum >= 0 and randnum <= 20 then
        if not ply:getChar():getInv():add("coal_ore") then
            ply:notify("You have collected some Coal Ore!")
            nut.item.spawn("coal_ore", position)
        else
            ply:notify("You have collected some Coal Ore!")
        end
    elseif randnum >= 21 and randnum <= 51 then
        if not ply:getChar():getInv():add("iron_ore") then
            ply:notify("You have collected some Iron Ore!")
            nut.item.spawn("iron_ore", position)
        else
            ply:notify("You have collected some Iron Ore!")
        end
    elseif randnum >= 52 and randnum <= 82 then
        if not ply:getChar():getInv():add("silver_ore") then
            ply:notify("You have collected some Silver Ore!")
            nut.item.spawn("silver_ore", position)
        else
            ply:notify("You have collected some Silver Ore!")
        end
    elseif randnum >= 83 and randnum <= 93 then
        if not ply:getChar():getInv():add("gold_ore") then
            ply:notify("You have collected some Gold Ore!")
            nut.item.spawn("gold_ore", position)
        else
            ply:notify("You have collected some Gold Ore!")
        end
    else
        if not ply:getChar():getInv():add("diamond_ore") then
            ply:notify("You have collected some Diamond Ore!")
            nut.item.spawn("diamond_ore", position)
        else
            ply:notify("You have collected some Diamond Ore!")
        end
    end
end