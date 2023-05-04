local PLUGIN = PLUGIN
ENT.Type = "anim"
ENT.PrintName = "Perma Weapons NPCs"
ENT.Category = "Lilia"
ENT.Spawnable = true
ENT.AdminOnly = true

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/brot/prometheus/sssuits/gspcoat5.mdl")
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

        timer.Simple(1, function()
            if IsValid(self) then
                self:setAnim()
            end
        end)
    end

    function ENT:Use(client)
        local delay = 0
        client:notify("This entity is in cooldown!")

        if delay > CurTime() then
            return
        else
            delay = CurTime() + 900
            PLUGIN:Check4DonationSWEP(client)
        end
    end

    function ENT:setAnim()
        for k, v in ipairs(self:GetSequenceList()) do
            if v:lower():find("idle") and v ~= "idlenoise" then return self:ResetSequence(k) end
        end

        self:ResetSequence(4)
    end
else
    local TEXT_OFFSET = Vector(0, 0, 20)
    local toScreen = FindMetaTable("Vector").ToScreen
    local colorAlpha = ColorAlpha
    local drawText = lia.util.drawText
    local configGet = lia.config.get
    ENT.DrawEntityInfo = true

    function ENT:onDrawEntityInfo(alpha)
        local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)) + TEXT_OFFSET)
        local x, y = position.x, position.y
        local desc = self.getNetVar(self, "desc")
        drawText("Perma Weapons NPC", x, y, colorAlpha(configGet("color"), alpha), 1, 1, nil, alpha * 0.65)
    end
end