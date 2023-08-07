local DisabledPlugins = {"multichar"}
SCHEMA.name = "1942RP"
SCHEMA.author = "Leonheart"
SCHEMA.desc = " A Sample 1942RP"
SCHEMA.version = "BETA 1.0" -- Shows the Version in the Bottom Left
lia.util.includeDir("core", nil, true) -- LOADS THE CORE FOLDER

function SCHEMA:PluginShouldLoad(uniqueID)
    if table.HasValue(DisabledPlugins, uniqueID) then
        return false
    end
end