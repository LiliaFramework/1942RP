PLUGIN.name = "NS Character Selection"
PLUGIN.author = "Cheesenot"
PLUGIN.desc = "The Lilia character selection screen."
lia.util.includeDir(PLUGIN.path .. "/derma/steps", true)

hook.Add("PluginShouldLoad", "MultichardisablePlugins", function(id)
    if id == "multichar" then return false end
end)