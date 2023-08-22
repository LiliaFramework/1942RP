LEG_GROUPS = LEG_GROUPS or {}
LEG_GROUPS[HITGROUP_LEFTLEG] = true
LEG_GROUPS[HITGROUP_RIGHTLEG] = true

function MODULE:PlayerSpawn(client)
    if not client:getChar() then return end

    if client:getChar():getData("leg_broken", false) then
        client:getChar():setData("leg_broken", false)
        client:SetWalkSpeed(lia.config.get("walkSpeed", 130))
        client:SetRunSpeed(lia.config.get("runSpeed", 235))
    end
end

function MODULE:ScalePlayerDamage(client, hitGroup, dmgInfo)
    local chance = math.random(1, 100)

    if LEG_GROUPS[hitGroup] and chance <= 35 then
        client:getChar():setData("leg_broken", true)
        client:SetWalkSpeed(lia.config.get("walkSpeed", 130) * 0.1)
        client:SetRunSpeed(lia.config.get("runSpeed", 235) * 0.1)
    elseif dmgInfo:GetDamageType() == DMG_FALL and dmgInfo:GetDamage() >= 10 then
        client:getChar():setData("leg_broken", true)
        client:SetWalkSpeed(lia.config.get("walkSpeed", 130) * 0.1)
        client:SetRunSpeed(lia.config.get("runSpeed", 235) * 0.1)
    end
end