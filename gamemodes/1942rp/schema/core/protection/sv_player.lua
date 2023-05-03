-------------------------------------------------------------------------------------------------------------------------
-- Ragdolls you if you get VDM
function SCHEMA:EntityTakeDamage(target, dmginfo)
    if not IsValid(target) or not target:IsPlayer() then return end
    local inflictor = dmginfo:GetInflictor()
    local attacker = dmginfo:GetAttacker()

    if not dmginfo:IsFallDamage() and IsValid(attacker) and attacker:IsPlayer() and attacker ~= target and target:Team() ~= FACTION_STAFF then
        target.LastDamaged = CurTime()
    end

    if IsValid(inflictor) and (inflictor:GetClass() == "gmod_sent_vehicle_fphysics_base" or inflictor:GetClass() == "gmod_sent_vehicle_fphysics_wheel") and not IsValid(target:GetVehicle()) then
        dmginfo:ScaleDamage(0)

        if not IsValid(target.liaRagdoll) then
            target:setRagdolled(true, 5)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------------
-- Prevents infinite Money Glitch
function SCHEMA:CanDeleteChar(ply, char)
    if char:getMoney() < lia.config.get("defMoney", 0) or ply:getNetVar("restricted") then return true end
end

------------------------------------------------------------------------------------------------------------------------
-- Prevents Mingy Character Switches
function SCHEMA:CanPlayerUseChar(client, character)
    if client:getChar() and client:getChar():getID() == character:getID() then return false, "You are already using this character!" end
    if client.LastDamaged and client.LastDamaged > CurTime() - 120 and character:getFaction() ~= FACTION_STAFF and client:getChar() then return false, "You took damage too recently to switch characters!" end
    if client:getNetVar("restricted") then return false, "You can't change characters while tied, you sneaky bastard!" end
end

------------------------------------------------------------------------------------------------------------------------
-- Clears Player Props on Disconnect 
function SCHEMA:PlayerDisconnected(client)
    for _, entity in pairs(ents.GetAll()) do
        if entity:GetCreator() == client then
            entity:Remove()
        end
    end
end

------------------------------------------------------------------------------------------------------------------------
--Staff God Mode & Automatic pet Flags to VIP
function SCHEMA:PlayerLoadedChar(client, character, lastChar)
    if client:Team() == FACTION_STAFF then
        client:GodEnable()
    else
        client:GodDisable()
    end

    if client:Team() == FACTION_STAFF and not UserGroups.modRanks[client:GetUserGroup()] then
        client:getChar():kick()
        client:notify("You cannot access a staff character unless you are a staff member!")
    end

    if UserGroups.vipRanks[client:GetUserGroup()] and not client:getChar():hasFlags("pet") then
        client:getChar():giveFlags("pet")
    end
end
------------------------------------------------------------------------------------------------------------------------