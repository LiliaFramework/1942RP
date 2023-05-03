local PLUGIN = PLUGIN
PLUGIN.name = "Dynamic Food"
PLUGIN.author = "Leonheart#7476"
PLUGIN.desc = "Adds creation of food thingies"

local files = {"sh_items.lua", "sh_config.lua", "sh_meta.lua", "sv_plugin.lua", "cl_plugin.lua"}

for k, v in pairs(files) do
    nut.util.include(v)
end