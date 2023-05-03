local SUPERADMIN = Color(255, 209, 20)
local MANAGEMENT = Color(255, 209, 20)
local SENIORADMINISTRATOR = Color(255, 209, 20)
local ADMIN = Color(255, 209, 20)
local MODERATOR = Color(255, 209, 20)

function SCHEMA:DrawCharInfo(client, character, info)
    if client:Team() == FACTION_STAFF then
        if client:IsUserGroup("root") then
            info[#info + 1] = {"Management", MANAGEMENT}
        elseif client:IsUserGroup("superadmin") then
            info[#info + 1] = {"Management", MANAGEMENT}
        elseif client:IsUserGroup("communitymanager") then
            info[#info + 1] = {"Upper Administration", MANAGEMENT}
        elseif client:IsUserGroup("headgm") then
            info[#info + 1] = {"Upper Administration", SUPERADMIN}
        elseif client:IsUserGroup("headadmin") then
            info[#info + 1] = {"Upper Administration", SUPERADMIN}
        elseif client:IsUserGroup("senioradmin") then
            info[#info + 1] = {"Upper Administration", SENIORADMINISTRATOR}
        elseif client:IsUserGroup("admin") then
            info[#info + 1] = {"Administration", ADMIN}
        elseif client:IsUserGroup("moderator") then
            info[#info + 1] = {"Moderator", MODERATOR}
        elseif client:IsUserGroup("gm") then
            info[#info + 1] = {"Gamemaster", MODERATOR}
        end
    end
end