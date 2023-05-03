local PLUGIN = PLUGIN
PLUGIN.name = "Admin Stick"
PLUGIN.author = "Leonheart#7476"
PLUGIN.desc = "An Admin Stick To Aid Staff"
nut.util.include("cl_plugin.lua")
nut.util.include("cl_commands.lua")
nut.util.include("sv_commands.lua")
nut.util.include("sv_plugin.lua")

PLUGIN.CitizenFactions = {
    FACTION_STAFF = true,
    FACTION_CITIZEN = true,
    FACTION_INMATES = true,
}