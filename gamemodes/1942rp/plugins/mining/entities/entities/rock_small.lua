AddCSLuaFile()
ENT.PrintName = "Small Rock"
ENT.Type = "anim"
ENT.Author = "Barata"
ENT.Category = "Mining"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.PhysgunDisable = true
ENT.PhysgunAllowAdmin = true

function ENT:Initialize()
    if SERVER then
        self:SetModel("models/fallenlogic_environment/rocks/medium_01.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetNoDraw(false)
        self:SetModelScale(1)
        self:SetNWInt("HP", 60)
        local physObj = self:GetPhysicsObject()
        physObj:EnableMotion(false)
    end
end

function ENT:OnTakeDamage(dmginfo)
    local ply = dmginfo:GetAttacker()
    local wep = ply:GetActiveWeapon():GetClass()
    local hp = self:GetNWFloat("HP", 0)

    if wep == "weapon_hl2pickaxe" then
        self:SetNWFloat("HP", hp - 10)
        self:EmitSound("physics/concrete/boulder_impact_hard" .. math.random(1, 4) .. ".wav", 75)
        ply:notify("Times that Barata has fucked my sister: " .. tostring(hp))

        if hp == 0 then
            self:SetNoDraw(true)

            timer.Create("respawn_rock_big_" .. self:EntIndex(), 120, 1, function()
                local newent = ents.Create("rock_big")
                newent:SetPos(self:GetPos())
                newent:SetNoDraw(false)
                newent:Spawn()
                self:Remove()
            end)
        elseif hp == 30 then
            RockBreakSmall(self, ply)
        elseif hp == 20 then
            RockBreakSmall(self, ply)
        elseif hp == 10 then
            RockBreakSmall(self, ply)
        end
    end
end

function RockBreakSmall(ent, ply)
    local randnum = math.random(0, 104)
    local position = ply:getItemDropPos()

    if randnum >= 0 and randnum <= 50 then
        if not ply:getChar():getInv():add("coal_ore") then
            ply:notify("You have collected some Coal Ore!")
            lia.item.spawn("coal_ore", position)
        else
            ply:notify("You have collected some Coal Ore!")
        end
    elseif randnum >= 51 and randnum <= 86 then
        if not ply:getChar():getInv():add("iron_ore") then
            ply:notify("You have collected some Iron Ore!")
            lia.item.spawn("iron_ore", position)
        else
            ply:notify("You have collected some Iron Ore!")
        end
    elseif randnum >= 87 and randnum <= 97 then
        if not ply:getChar():getInv():add("silver_ore") then
            ply:notify("You have collected some Silver Ore!")
            lia.item.spawn("silver_ore", position)
        else
            ply:notify("You have collected some Silver Ore!")
        end
    elseif randnum >= 98 and randnum <= 102 then
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