local PLUGIN = PLUGIN
local UserGroups = UserGroups
util.AddNetworkString("AS_ClearDecals")
util.AddNetworkString("namechange")
util.AddNetworkString("namechangeself")
util.AddNetworkString("nameupdate")

function PLUGIN:PostPlayerLoadout(ply)
    local uniqueID = ply:GetUserGroup()

    if UserGroups.modRanks[uniqueID] or ply:Team() == FACTION_STAFF then
        ply:Give("adminstick")
    end
end
