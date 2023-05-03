PLUGIN.name = "Perma Weapons"
PLUGIN.desc = "Adds Perma Weapons"
PLUGIN.author = "Leonheart#7476"
lia.util.include("sv_plugin.lua")
lia.util.include("cl_plugin.lua")
local playerMeta = FindMetaTable("Player")

function playerMeta:IsWanted()
    return self:getNetVar("wanted", false)
end