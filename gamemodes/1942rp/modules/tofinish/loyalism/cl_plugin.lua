local MODULE = MODULE
local COLOR_LEVEL = Color(255, 209, 20)

function MODULE:DrawCharInfo(client, character, info)
    local tier = character:getData("party_tier", 0)

    if tier == 1 then
        info[#info + 1] = {"Tier I Party Member", COLOR_LEVEL}
    elseif tier == 2 then
        info[#info + 1] = {"Tier II Party Member", COLOR_LEVEL}
    elseif tier == 3 then
        info[#info + 1] = {"Tier III Party Member", COLOR_LEVEL}
    elseif tier == 4 then
        info[#info + 1] = {"Tier IV Party Member", COLOR_LEVEL}
    elseif tier == 5 then
        info[#info + 1] = {"Tier V Party Member", COLOR_LEVEL}
    end
end

lia.command.add("partytier", {
    syntax = "<string name> <string number>",
    onRun = function(client, arguments) end
})