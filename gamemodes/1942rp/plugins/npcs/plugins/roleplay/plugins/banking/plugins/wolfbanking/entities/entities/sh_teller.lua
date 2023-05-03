ENT.Type = "anim"
ENT.PrintName = "IBM"
ENT.Category = "NutScript"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.isVendor = true

function ENT:Initialize()
    if SERVER then
        self:SetModel("models/player/breen.mdl")
        self:SetUseType(SIMPLE_USE)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:DrawShadow(true)
        self:SetSolid(SOLID_OBB)
        self:PhysicsInit(SOLID_OBB)
        local physObj = self:GetPhysicsObject()

        if IsValid(physObj) then
            physObj:EnableMotion(false)
            physObj:Sleep()
        end
    end

    timer.Simple(1, function()
        if IsValid(self) then
            self:setAnim()
        end
    end)
end


if SERVER then
    function ENT:SpawnFunction(client, trace)
        local angles = (trace.HitPos - client:GetPos()):Angle()
        angles.r = 0
        angles.p = 0
        angles.y = angles.y + 180
        local entity = ents.Create("sh_teller")
        entity:SetPos(trace.HitPos)
        entity:SetAngles(angles)
        entity:Spawn()
        -- entity:AddToPerma()

        return entity
    end
else

end

function ENT:Use(ply)
end