------------------------------------------------------------------------------------------------------------------------
-- SETS NAME ON THE SERVER LIST
function SCHEMA:GetGameDescription()
    return "Lilia - Skeleton"
end

------------------------------------------------------------------------------------------------------------------------
-- DISABLES SPRAYING
function SCHEMA:PlayerSpray(client)
    return true
end

------------------------------------------------------------------------------------------------------------------------
-- DISABLES CROSSHAIRS
function SCHEMA:ShouldDrawCrosshair()
    return false
end

-------------------------------------------------------------------------------------------------------------------------
-- EVERYONE CAN USE FLASHLIGHT
function SCHEMA:PlayerSwitchFlashlight(ply, on)
    return true
end

------------------------------------------------------------------------------------------------------------------------
-- Removes F1 on Death
function SCHEMA:PlayerDeath(ply)
    netstream.Start(ply, "removeF1")
end

------------------------------------------------------------------------------------------------------------------------
-- Fixes Loud Ass Noises
function SCHEMA:EntityEmitSound(tbl)
    if table.HasValue(self.FixSounds, tbl.SoundName) then
        tbl.SoundLevel = 75

        return true
    end
end

-------------------------------------------------------------------------------------------------------------------------
-- Prevents Minge Dropping Weaposn
function SCHEMA:OnPlayerDropWeapon(client, item, entity)
    timer.Simple(30, function()
        if entity and entity:IsValid() then
            entity:Remove()
        end
    end)
end

------------------------------------------------------------------------------------------------------------------------
-- Prevents Item Collide Crashes
function SCHEMA:ShouldCollide(f, t)
    if (t:GetClass() == "lia_item" and f:GetClass() == "prop_physics") and (t:GetClass() == "lia_item" and f:IsPlayer()) and (f:GetClass() == "lia_item" and (t:GetClass() == "lia_item" or (t:GetClass() == "gmod_sent_vehicle_fphysics_wheel" or t:GetClass() == "gmod_sent_vehicle_fphysics_base"))) or (t:GetClass() == "lia_item" and (f:GetClass() == "lia_item" or (f:GetClass() == "gmod_sent_vehicle_fphysics_wheel" or f:GetClass() == "gmod_sent_vehicle_fphysics_base"))) then return false end
end

------------------------------------------------------------------------------------------------------------------------
--Prevents Sitting on Players/While Tied 
function SCHEMA:CheckValidSit(ply, trace)
    local ent = trace.Entity
    if ent:IsVehicle() or ply:getNetVar("restricted") or ent:IsPlayer() then return false end
end

-------------------------------------------------------------------------------------------------------------------------
-- Betters Ragdoll Rendeering
function SCHEMA:InitializedPlugins()
    timer.Simple(3, function()
        RunConsoleCommand("ai_serverragdolls", "1")
        SCHEMA_COMMANDS = true
    end)
end

------------------------------------------------------------------------------------------------------------------------
-- Betters VJ Base Rendeering
hook.Remove("PlayerInitialSpawn", "VJBaseSpawn")
------------------------------------------------------------------------------------------------------------------------
