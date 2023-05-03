local PLUGIN = PLUGIN
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_c17/FurnitureDrawer001a_Chunk05.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetCollisionGroup(COLLISION_GROUP_WORLD)
    self:SetNWBool("broken", false)
    self:SetUseType(SIMPLE_USE)
    local physObj = self:GetPhysicsObject()
    physObj:EnableMotion(false)
    print(tostring(DEV))

    if DEV then
        self:SetNoDraw(false)

        timer.Create("breaktimer_" .. self:EntIndex(), PLUGIN.BreakTimer, 0, function()
            self:SetNWBool("broken", true)
        end)
    else
        self:SetNoDraw(true)

        timer.Create("breaktimer_" .. self:EntIndex(), 30, 0, function()
            self:SetNWBool("broken", true)
        end)
    end
end