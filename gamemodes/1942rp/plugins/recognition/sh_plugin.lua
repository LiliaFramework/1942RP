PLUGIN.name = "Recognition"
PLUGIN.author = "Leonheart#7476/Cheesenot"
PLUGIN.desc = "Adds the ability to recognize people / You can also allow auto faction recognition."
lia.util.include("sv_plugin.lua")
lia.util.include("cl_plugin.lua")
lia.config.set("FactionAutoRecognize", true)
PLUGIN.noRecognise = { // if true, the faction will not be recognizable by own faction
    [FACTION_ALLG] = false,
    [FACTION_CITIZEN] = true,
    [FACTION_DAF] = false,
    [FACTION_FD] = false,
    [FACTION_FUHRER] = false,
    [FACTION_INMATES] = false,
    [FACTION_LSSAH] = false,
    [FACTION_NSDAP] = false,
    [FACTION_OKH] = false,
    [FACTION_OKL] = false,
    [FACTION_OKM] = false,
    [FACTION_OKW] = false,
    [FACTION_ORPO] = false,
    [FACTION_RAD] = false,
    [FACTION_STAFF] = false,
    [FACTION_STATE] = false,
    [FACTION_SVE] = false,
    [FACTION_WK3] = false,
    [FACTION_RSHA] = false,
}
