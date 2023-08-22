local MODULE = MODULE
local ForceJump = {}

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:Think()
    for ply, v in pairs(ForceJump) do
        if not (IsValid(ply) and ply:OnGround()) then
            ForceJump[ply] = nil

            return
        end

        local tr = util.TraceLine({
            start = ply:GetPos(),
            endpos = ply:GetPos() + Vector(0, 0, 20),
            filter = ply
        })

        if tr.Hit then return end
        ply:SetPos(ply:GetPos() + Vector(0, 0, 5))
        ForceJump[ply] = nil
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[
local HeadBone = "ValveBiped.Bip01_Head1"
local DefaultRope = Material("cable/rope")

local RenderPos = {
    Blind = {Vector(3.5, 3, 2.6), Vector(3.8, 4.8, 0), Vector(3.5, 3, -2.8), Vector(2.4, -2, -3.8), Vector(1.5, -4.5, 0), Vector(2.4, -2, 3.8)},
    Gag = {Vector(1.0, 4.2, 2), Vector(1.0, 5.5, -0.1), Vector(1.0, 4.5, -2), Vector(0, 0, -3.4), Vector(-0.8, -3, 0), Vector(0, 0, 3.4)},
}

function MODULE:PostPlayerDraw(ply)
    if not IsValid(ply) or not ply:IsHandcuffed() then return end
    render.SetMaterial(DefaultRope)

    if ply:IsBlinded() then
        local pos, ang
        local bone = ply:LookupBone(HeadBone)

        if bone then
            pos, ang = ply:GetBonePosition(bone)
        end

        if pos and ang then
            local firstpos = pos + (ang:Forward() * RenderPos.Blind[1].x) + (ang:Right() * RenderPos.Blind[1].y) + (ang:Up() * RenderPos.Blind[1].z)
            local lastpos = firstpos

            for i = 2, #RenderPos.Blind do
                local newPos = pos + (ang:Forward() * RenderPos.Blind[i].x) + (ang:Right() * RenderPos.Blind[i].y) + (ang:Up() * RenderPos.Blind[i].z)
                render.DrawBeam(newPos, lastpos, 1.5, 0, 1, Color(255, 255, 255))
                lastpos = newPos
            end

            render.DrawBeam(lastpos, firstpos, 1.5, 0, 1, Color(255, 255, 255))
        end
    end

    if ply:IsGagged() then
        local pos, ang
        local bone = ply:LookupBone(HeadBone)

        if bone then
            pos, ang = ply:GetBonePosition(bone)
        end

        if pos and ang then
            local firstpos = pos + (ang:Forward() * RenderPos.Gag[1].x) + (ang:Right() * RenderPos.Gag[1].y) + (ang:Up() * RenderPos.Gag[1].z)
            local lastpos = firstpos

            for i = 2, #RenderPos.Gag do
                local newPos = pos + (ang:Forward() * RenderPos.Gag[i].x) + (ang:Right() * RenderPos.Gag[i].y) + (ang:Up() * RenderPos.Gag[i].z)
                render.DrawBeam(newPos, lastpos, 1.5, 0, 1, Color(255, 255, 255))
                lastpos = newPos
            end

            render.DrawBeam(lastpos, firstpos, 1.5, 0, 1, Color(255, 255, 255))
        end
    end
end]]