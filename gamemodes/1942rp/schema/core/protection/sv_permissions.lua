------------------------------------------------------------------------------------------------------------------------
function SCHEMA:PlayerSpawnEffect(client, model)
    local uniqueID = client:GetUserGroup()

    if UserGroups.adminRanks[uniqueID] then
        return true
    else
        return false
    end
end

------------------------------------------------------------------------------------------------------------------------
function SCHEMA:PlayerSpawnRagdoll(client, model)
    local uniqueID = client:GetUserGroup()

    if client:getChar():hasFlags("r") or UserGroups.adminRanks[uniqueID] then
        return true
    else
        return false
    end
end

------------------------------------------------------------------------------------------------------------------------
function SCHEMA:PlayerSpawnSENT(client, class)
    local uniqueID = client:GetUserGroup()

    if UserGroups.adminRanks[uniqueID] then
        return true
    else
        return false
    end
end

-------------------------------------------------------------------------------------------------------------------------
function SCHEMA:PlayerSpawnNPC(client, npcType, weapon)
    local uniqueID = client:GetUserGroup()

    if UserGroups.adminRanks[uniqueID] then
        return true
    else
        return false
    end
end

-------------------------------------------------------------------------------------------------------------------------
function SCHEMA:PlayerSpawnProp(client)
    local uniqueID = client:GetUserGroup()

    if client:getChar():hasFlags("e") or UserGroups.adminRanks[uniqueID] then
        return true
    else
        return false
    end

    return false
end

------------------------------------------------------------------------------------------------------------------------
function SCHEMA:CanPlayerSpawnStorage(client)
    local uniqueID = client:GetUserGroup()

    if UserGroups.adminRanks[uniqueID] then
        return true
    else
        return false
    end
end

------------------------------------------------------------------------------------------------------------------------
function SCHEMA:PlayerSpawnedProp(client, model, entity)
    -- Removes Problematic Models
    for _, gredwitch in pairs(file.Find("models/gredwitch/bombs/*.mdl", "GAME")) do
        if model == "models/gredwitch/bombs/" .. gredwitch then
            entity:Remove()

            return
        end
    end

    for _, gbombs in pairs(file.Find("models/gbombs/*.mdl", "GAME")) do
        if model == "models/gbombs/" .. gbombs then
            entity:Remove()

            return
        end
    end

    for _, phx in pairs(file.Find("models/props_phx/*.mdl", "GAME")) do
        if model == "models/props_phx/" .. phx then
            entity:Remove()

            return
        end
    end

    for _, mikeprops in pairs(file.Find("models/mikeprops/*.mdl", "GAME")) do
        if model == "models/mikeprops/" .. mikeprops then
            entity:Remove()

            return
        end
    end

    if table.HasValue(self.PropBlacklist, model:lower()) then
        client:notify("You cannot spawn this prop.")
        entity:Remove()

        return
    end

    self:PlayerSpawnedEntity(client, entity)
end

------------------------------------------------------------------------------------------------------------------------
function SCHEMA:PlayerSpawnedNPC(client, entity)
    entity:SetCreator(client)
    entity:SetNWString("Creator_Nick", client:Nick())
end

------------------------------------------------------------------------------------------------------------------------
-- Slows Down Spawning
function SCHEMA:PlayerSpawnObject(client, model, skin)
    if (client.liaNextSpawn or 0) < CurTime() then
        client.liaNextSpawn = CurTime() + 0.75
    else
        if client.AdvDupe2 and client.AdvDupe2.Pasting then return true end

        return false
    end
end

------------------------------------------------------------------------------------------------------------------------
function SCHEMA:PlayerSpawnedEntity(client, entity)
    entity:SetNWString("Creator_Nick", client:Nick())
    entity:SetCreator(client)
end