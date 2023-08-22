MODULE.name = "Item Maker"
MODULE.author = "STEAM_0:1:176123778"
MODULE.desc = "Allows creating custom items in-game"
NSForgedItems = NSForgedItems or {}
NSForgedItems.List = NSForgedItems.List or {}
lia.util.include("sv_module.lua")
lia.util.include("cl_module.lua")
lia.util.include("cl_commands.lua")

function NSForgedItems.RegisterCustomItem(id, itemData)
    if (not id) then return end
    local ITEM = lia.item.register(id, nil, false, nil, true)

    if (ITEM) then
        for k, v in pairs(itemData) do
            ITEM[k] = v
        end

        if (itemData.restore) then
            ITEM.functions.Use = {
                onRun = function(item)
                    item.player:SetHealth(math.min(item.player:Health() + item.restore, 100))
                    item.player:setLocalVar("stm", math.min(item.player:getLocalVar("stm", 100) + item.restore, 100))
                end
            }
        end
    end
end