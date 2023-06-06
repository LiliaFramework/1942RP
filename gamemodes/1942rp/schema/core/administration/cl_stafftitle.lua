local MANAGEMENT = Color(174, 0, 0)
local UPPERADMIN = Color(2, 0, 121)
local ADMINISTRATION = Color(255, 165, 0)
local MODERATION = Color(255, 255, 0)
local GAMEMASTER = Color(150, 75, 0)

function SCHEMA:DrawCharInfo(client, character, info)
    if client:Team() == FACTION_STAFF then
        if client:IsUserGroup("Owner") then
            info[#info + 1] = {"Owner", MANAGEMENT}
        elseif client:IsUserGroup("Upper Administration") then
            info[#info + 1] = {"Upper Administration", UPPERADMIN}
        elseif client:IsUserGroup("Senior Administrator") then
            info[#info + 1] = {"Senior Administrator", ADMINISTRATION}
        elseif client:IsUserGroup("Admistrator") then
            info[#info + 1] = {"Admistrator", ADMINISTRATION}
        elseif client:IsUserGroup("Junior Administrator") then
            info[#info + 1] = {"Junior Administrator", ADMINISTRATION}
        elseif client:IsUserGroup("Senior Moderator") then
            info[#info + 1] = {"Senior Moderator", MODERATION}
        elseif client:IsUserGroup("Moderator") then
            info[#info + 1] = {"Moderator", MODERATION}
        elseif client:IsUserGroup("Junior Moderator") then
            info[#info + 1] = {"Junior Moderator", MODERATION}
        elseif client:IsUserGroup("Senior Gamemaster") then
            info[#info + 1] = {"Senior Gamemaster", GAMEMASTER}
        elseif client:IsUserGroup("Senior Gamemaster") then
            info[#info + 1] = {"Experienced Gamemaster", GAMEMASTER}
        elseif client:IsUserGroup("Experienced Gamemaster") then
            info[#info + 1] = {"Gamemaster", GAMEMASTER}
        elseif client:IsUserGroup("Junior Gamemaster") then
            info[#info + 1] = {"Junior Gamemaster", GAMEMASTER}
        end
    end
end