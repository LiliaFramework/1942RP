PlayerSpawnedVehicles = PlayerSpawnedVehicles or {}

-------------------------------------------------------------------------------------------------------------------------
-- ALLOWS THE SPAWN OF VEHICLES WITH LIMITS
function SCHEMA:PlayerSpawnVehicle(ply, model, name, table)
    local uniqueID = ply:GetUserGroup()

    if ply.NextVehicleSpawn and not UserGroups.trustedRanks[uniqueID] and ply.NextVehicleSpawn > SysTime() then
        ply:notify("You must wait another " .. math.floor(SysTime() - ply.NextVehicleSpawn) .. "s before spawning another vehicle")

        return false
    end

    PlayerSpawnedVehicles[ply] = PlayerSpawnedVehicles[ply] or {}
    local count = 0

    for k, v in pairs(PlayerSpawnedVehicles[ply]) do
        if not IsValid(v) or v:GetCreator() ~= ply then
            PlayerSpawnedVehicles[ply][k] = nil
        else
            count = count + 1
        end
    end

    if count >= self.MaximumPlayerSpawnedVehicles then
        ply:notify("You've reached your maximum spawned vehicle count (max: " .. self.MaximumPlayerSpawnedVehicles .. ")")

        return false
    end

    if table.Category == "Chairs" then
        if ply:getChar():hasFlags("c") or UserGroups.adminRanks[uniqueID] then
            return true
        else
            return false
        end
    else
        if UserGroups.uaRanks[uniqueID] then
            return true
        elseif ply:getChar():hasFlags("C") or (UserGroups.adminRanks[uniqueID] or uniqueID == "gm") then
            if table.HasValue(self.RestrictedVehicles, name) then
                ply:notify("You can't spawn this vehicle since it's restricted!")

                return false
            else
                return true
            end
        else
            return false
        end
    end
end

-------------------------------------------------------------------------------------------------------------------------
--DELAYS SPAWNS
function SCHEMA:PlayerSpawnedVehicle(ply, ent)
    local uniqueID = ply:GetUserGroup()

    if not UserGroups.trustedRanks[uniqueID] then
        ply.NextVehicleSpawn = SysTime() + self.PlayerSpawnVehicleDelay
    end
end
-------------------------------------------------------------------------------------------------------------------------