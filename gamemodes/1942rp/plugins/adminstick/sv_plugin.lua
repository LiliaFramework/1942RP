local PLUGIN = PLUGIN
local SCHEMA = SCHEMA
util.AddNetworkString("AS_ClearDecals")
util.AddNetworkString("namechange")
util.AddNetworkString("namechangeself")
util.AddNetworkString("nameupdate")

function PLUGIN:PostPlayerLoadout(ply)
    local uniqueID = ply:GetUserGroup()

    if SCHEMA.modRanks[uniqueID] or ply:Team() == FACTION_STAFF then
        ply:Give("adminstick")
    end
end

net.Receive("AS_ClearDecals", function(l, ply)
    local uniqueID = ply:GetUserGroup()

    if SCHEMA.superRanks[uniqueID] then
        for k, v in ipairs(player.GetHumans()) do
            v:ConCommand("r_cleardecals")
        end
    end
end)

net.Receive("nameupdate", function()
    local name = net.ReadString()
    local ply = net.ReadEntity()

    for k, v in ipairs(player.GetHumans()) do
        if v == ply then
            v:getChar():setName(name)
        end
    end
end)