LEG_GROUPS = LEG_GROUPS or {}
LEG_GROUPS[HITGROUP_LEFTLEG] = true
LEG_GROUPS[HITGROUP_RIGHTLEG] = true

function PLUGIN:PlayerSpawn(client)
    if not client:getChar() then return end

    if client:getChar():getData("leg_broken", false) then
        client:getChar():setData("leg_broken", false)
        client:SetWalkSpeed(nut.config.get("walkSpeed", 130))
        client:SetRunSpeed(nut.config.get("runSpeed", 235))
    end
end

function PLUGIN:ScalePlayerDamage(client, hitGroup, dmgInfo)
    local chance = math.random(0, 100)
    if client:getChar():getData("leg_broken", false) then return end

    if LEG_GROUPS[hitGroup] and chance < 50 then
        client:getChar():setData("leg_broken", true)
        client:SetWalkSpeed(nut.config.get("walkSpeed", 130) * 0.50)
        client:SetRunSpeed(nut.config.get("runSpeed", 235) * 0.50)
        client:notify("You got injuried in your leg!")
    end
end

function PLUGIN:EntityTakeDamage(client, dmgInfo)
    if not client:IsPlayer() or client:getChar():getData("leg_broken", false) then return end

    if dmgInfo:GetDamageType() == DMG_FALL and dmgInfo:GetDamage() >= 3 then
        client:getChar():setData("leg_broken", true)
        client:SetWalkSpeed(nut.config.get("walkSpeed", 130) * 0.50)
        client:SetRunSpeed(nut.config.get("runSpeed", 235) * 0.50)
        client:notify("You fell too hard and broke your leg!")
    end
end