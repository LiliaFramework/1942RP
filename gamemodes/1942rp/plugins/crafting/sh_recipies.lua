--
local RECIPE = {}
RECIPE.uid = "Processed Beech Wood"
RECIPE.name = "Processed Beech Wood"
RECIPE.category = "Crafting"
RECIPE.model = Model("models/props_debris/wood_board02a.mdl")
RECIPE.desc = "A Blueprint."
RECIPE.noBlueprint = true

RECIPE.items = {
    ["beech"] = 1,
}

RECIPE.result = {
    ["processedwood"] = 1
}

RECIPES:Register(RECIPE)
--
local RECIPE = {}
RECIPE.uid = "Processed Oak Wood"
RECIPE.name = "Processed Oak Wood"
RECIPE.category = "Crafting"
RECIPE.model = Model("models/props_debris/wood_board02a.mdl")
RECIPE.desc = "A Blueprint."
RECIPE.noBlueprint = true

RECIPE.items = {
    ["oak"] = 1,
}

RECIPE.result = {
    ["processedwood"] = 1
}

RECIPES:Register(RECIPE)
--
local RECIPE = {}
RECIPE.uid = "Processed Pine Wood"
RECIPE.name = "Processed Pine Wood"
RECIPE.category = "Crafting"
RECIPE.model = Model("models/props_debris/wood_board02a.mdl")
RECIPE.desc = "A Blueprint."
RECIPE.noBlueprint = true

RECIPE.items = {
    ["pine"] = 1,
}

RECIPE.result = {
    ["processedwood"] = 1
}

RECIPES:Register(RECIPE)
--
local RECIPE = {}
RECIPE.uid = "Processed Spruce Wood"
RECIPE.name = "Processed Spruce Wood"
RECIPE.category = "Crafting"
RECIPE.model = Model("models/props_debris/wood_board02a.mdl")
RECIPE.desc = "A Blueprint."
RECIPE.noBlueprint = true

RECIPE.items = {
    ["spruce"] = 1,
}

RECIPE.result = {
    ["processedwood"] = 1
}

RECIPES:Register(RECIPE)
--
local RECIPE = {}
RECIPE.uid = "Processed Silver"
RECIPE.name = "Processed Silver"
RECIPE.category = "Crafting"
RECIPE.model = Model("models/props_debris/wood_board02a.mdl")
RECIPE.desc = "A Blueprint."
RECIPE.noBlueprint = true

RECIPE.items = {
    ["coal_ore"] = 1,
    ["silver_ore"] = 1,
}

RECIPE.result = {
    ["processedsilver"] = 1
}

RECIPES:Register(RECIPE)
--
local RECIPE = {}
RECIPE.uid = "Processed Gold"
RECIPE.name = "Processed Gold"
RECIPE.category = "Crafting"
RECIPE.model = Model("models/props_debris/wood_board02a.mdl")
RECIPE.desc = "A Blueprint."
RECIPE.noBlueprint = true

RECIPE.items = {
    ["coal_ore"] = 1,
    ["gold_ore"] = 1,
}

RECIPE.result = {
    ["processedgold"] = 1
}

RECIPES:Register(RECIPE)
--
local RECIPE = {}
RECIPE.uid = "Processed Iron"
RECIPE.name = "Processed Iron"
RECIPE.category = "Crafting"
RECIPE.model = Model("models/props_debris/wood_board02a.mdl")
RECIPE.desc = "A Blueprint."
RECIPE.noBlueprint = true

RECIPE.items = {
    ["coal_ore"] = 1,
    ["iron_ore"] = 1,
}

RECIPE.result = {
    ["processediron"] = 1
}

RECIPES:Register(RECIPE)
--
local RECIPE = {}
RECIPE.uid = "Processed Diamond"
RECIPE.name = "Processed Diamond"
RECIPE.category = "Crafting"
RECIPE.model = Model("models/props_debris/wood_board02a.mdl")
RECIPE.desc = "A Blueprint."
RECIPE.noBlueprint = true

RECIPE.items = {
    ["coal_ore"] = 5,
    ["diamond_ore"] = 1,
}

RECIPE.result = {
    ["processeddiamond"] = 1
}

RECIPES:Register(RECIPE)
--
local RECIPE = {}
RECIPE.uid = "Luger P08"
RECIPE.name = "Luger P08"
RECIPE.category = "Crafting"
RECIPE.model = Model("models/props_c17/BriefCase001a.mdl")
RECIPE.desc = "A Blueprint."
RECIPE.noBlueprint = true

RECIPE.items = {
    ["processedwood"] = 1,
    ["processedsilver"] = 1,
}

RECIPE.result = {
    ["doi_atow_p38"] = 1
}

RECIPES:Register(RECIPE)
--
local RECIPE = {}
RECIPE.uid = "Kar98k"
RECIPE.name = "Kar98k"
RECIPE.category = "Crafting"
RECIPE.model = Model("models/props_c17/BriefCase001a.mdl")
RECIPE.desc = "A Blueprint."
RECIPE.noBlueprint = true

RECIPE.items = {
    ["processedwood"] = 2,
    ["processedsilver"] = 2,
}

RECIPE.result = {
    ["doi_atow_k98k"] = 1
}

RECIPES:Register(RECIPE)
--
local RECIPE = {}
RECIPE.uid = "Box Of Ammo"
RECIPE.name = "Box Of Ammo"
RECIPE.category = "Crafting"
RECIPE.model = Model("models/Items/BoxSRounds.mdl")
RECIPE.desc = "A Blueprint."
RECIPE.noBlueprint = true

RECIPE.items = {
    ["processedsilver"] = 1,
}

RECIPE.result = {
    ["universalammo"] = 1
}

RECIPES:Register(RECIPE)