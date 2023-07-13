-- Configuration
DRAGGING_TARGETRADIUS = 100 * 100 -- SQUARED FOR PERFORMANCE The distance the dragged player will try to achieve
DRAGGING_MOVE_SPEED = 160 -- Dragged players always walk, so put this between 0 and walk speed (160 by default)
DRAGGING_MAX_DISTANCE = 300 * 300 -- SQUARED FOR PERFORMANCE When the drag gets interrupted
DRAGGING_START_RANGE = 100
DRAGGING_SWEP = "lia_keys"
Dragging = {}
Draggers = {}

function IsBeingDragged(dragee)
    return Dragging[dragee] ~= nil
end

function SetDrag(dragee, drager)
    if not IsValid(dragee) then return end
    dragee:setNetVar("dragged", true)

    if IsValid(Draggers[drager]) and IsValid(Dragging[Draggers[drager]]) then
        Dragging[Draggers[drager]] = nil
    end

    if drager == nil then
        if Dragging[dragee] then
            Draggers[Dragging[dragee]] = nil
        end
    else
        Draggers[drager] = dragee
    end

    Dragging[dragee] = drager
end

hook.Add("PlayerDisconnected", "Dragging::Disconnected", function(ply)
    for k, v in pairs(Dragging or {}) do
        if k == ply or v == ply then
            Dragging[k] = nil
            net.Start("Dragging::Update")
            net.WriteBool(false)
            net.Send(k)
        end
    end
end)

hook.Add("PlayerDeath", "Dragging::Death", function(ply)
    for k, v in pairs(Dragging or {}) do
        if k == ply or v == ply then
            Dragging[k] = nil
            net.Start("Dragging::Update")
            net.WriteBool(false)
            net.Send(k)
        end
    end
end)

hook.Add("StartCommand", "Dragging::StartCommand", function(ply, cmd)
    if not ply:getNetVar("dragged", false) then
        return
    else
        if Dragging[ply] and IsValid(Dragging[ply]) then
            local dragger = Dragging[ply]
            local TargetPos = dragger:GetPos()
            cmd:ClearMovement()
            local myPos = ply:GetPos()
            local MoveVector = WorldToLocal(TargetPos, Angle(0, 0, 0), myPos, ply:GetAngles())
            MoveVector:Normalize()
            MoveVector:Mul(DRAGGING_MOVE_SPEED)
            cmd:RemoveKey(IN_JUMP)
            cmd:RemoveKey(IN_SPEED)
            cmd:RemoveKey(IN_DUCK)
            local dist2Sqr = (TargetPos.x - myPos.x) ^ 2 + (TargetPos.y - myPos.y) ^ 2

            if dist2Sqr > DRAGGING_MAX_DISTANCE then
                ply:getNetVar("dragged", false)

                return
            elseif dist2Sqr > DRAGGING_TARGETRADIUS then
                cmd:SetForwardMove(MoveVector.x)
                cmd:SetSideMove(-MoveVector.y)
            end
        end
    end
end)

hook.Add("KeyPress", "Dragging::KeyPress", function(ply, key)
    if IsValid(ply) and key == IN_ATTACK and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == DRAGGING_SWEP and not ply:InVehicle() and not IsBeingDragged(ply) then
        local traceEnt = ply:GetEyeTrace().Entity

        if IsValid(traceEnt) and traceEnt:IsPlayer() and traceEnt:GetPos():DistToSqr(ply:GetPos()) <= DRAGGING_START_RANGE * DRAGGING_START_RANGE and traceEnt:getNetVar("restricted") and not traceEnt:InVehicle() then
            SetDrag(traceEnt, ply)
        end
    end
end)