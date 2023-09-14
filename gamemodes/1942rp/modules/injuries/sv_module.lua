--------------------------------------------------------------------------------------------------------
function MODULE:PlayerSpawn(client)
    if not client:getChar() then return end
    if client:getChar():getData("leg_broken", false) then
        client:getChar():setData("leg_broken", false)
        client:SetWalkSpeed(lia.config.WalkSpeed)
        client:SetRunSpeed(lia.config.RunSpeed)
    end
end
--------------------------------------------------------------------------------------------------------
function MODULE:ScalePlayerDamage(client, hitGroup, dmgInfo)
    local chance = math.random(1, 100)
    if table.HasValue(lia.config.LegGroups, hitGroup) and chance <= lia.config.ChanceToBreakLegByShooting then
        client:getChar():setData("leg_broken", true)
        client:SetWalkSpeed(lia.config.WalkSpeed * 0.1)
        client:SetRunSpeed(lia.config.RunSpeed * 0.1)
    elseif dmgInfo:GetDamageType() == DMG_FALL and dmgInfo:GetDamage() >= lia.config.DamageThresholdOnFallBreak then
        client:getChar():setData("leg_broken", true)
        client:SetWalkSpeed(lia.config.WalkSpeed * 0.1)
        client:SetRunSpeed(lia.config.RunSpeed * 0.1)
    end
end
--------------------------------------------------------------------------------------------------------