------------------------------------------------------------------------------------------------------------------------
-- Adds PhysGun Restrictions
function SCHEMA:PhysgunPickup(client, entity)
    local uniqueID = client:GetUserGroup()
    if UserGroups.uaRanks[uniqueID] then return true end
    if table.HasValue(self.RestrictedEntityList, entity:GetClass()) and not UserGroups.uaRanks[uniqueID] then return false end
    if entity:IsVehicle() and not UserGroups.uaRanks[uniqueID] then return false end
    if entity:GetCreator() == client then return true end
end

------------------------------------------------------------------------------------------------------------------------
-- Adds Property Tool Restrictions
function SCHEMA:CanProperty(client, property, entity)
    local uniqueID = client:GetUserGroup()
    if UserGroups.uaRanks[uniqueID] then return true end
    if table.HasValue(self.RestrictedEntityList, entity:GetClass()) and not UserGroups.uaRanks[uniqueID] then return false end
    if entity:GetCreator() == client and (property == "remover" or property == "collision") then return true end
end

------------------------------------------------------------------------------------------------------------------------
-- Adds Toolgun Restrictions
function SCHEMA:CanTool(client, trace, tool)
    local entity = trace.Entity
    local uniqueID = client:GetUserGroup()
    if UserGroups.uaRanks[uniqueID] then return true end
    if entity:IsPlayer() or entity:IsNPC() then return false end
    if table.HasValue(self.Disallowed, tool) then return false end

    if tool == "remover" then
        if table.HasValue(self.blockedEntities, entity:GetClass()) then return false end

        if entity:GetCreator() ~= client and (UserGroups.modRanks[uniqueID] and table.HasValue(self.blockedEntities, entity:GetClass())) then
            return false
        elseif entity:GetCreator() == client and not table.HasValue(self.blockedEntities, entity:GetClass()) then
            return true
        elseif entity:GetCreator() ~= client and (UserGroups.modRanks[uniqueID] and not table.HasValue(self.blockedEntities, entity:GetClass())) then
            return false
        elseif entity:GetCreator() ~= client then
            return false
        end
    elseif tool == "colour" or tool == "material" then
        if uniqueID == "admin" then
            return false
        elseif UserGroups.adminRanks[uniqueID] and not table.HasValue(self.blockedEntities, entity:GetClass()) then
            return true
        elseif entity:GetCreator() == client and not table.HasValue(self.blockedEntities, entity:GetClass()) then
            return true
        else
            return false
        end
    end
end