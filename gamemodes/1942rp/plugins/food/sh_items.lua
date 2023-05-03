local foods = {
    ["models/props_junk/watermelon01.mdl"] = {"Watermelon", 30},
    ["models/foodnhouseholditems/apple.mdl"] = {"Apple", 10},
    ["models/foodnhouseholditems/baconcooked.mdl"] = {"Bacon", 18},
    ["models/foodnhouseholditems/bagel3.mdl"] = {"Bagel", 25},
    ["models/foodnhouseholditems/bagette.mdl"] = {"Bagette", 36},
    ["models/foodnhouseholditems/bananna.mdl"] = {"Banana", 10},
    ["models/foodnhouseholditems/bread_loaf.mdl"] = {"Bread", 18},
    ["models/foodnhouseholditems/burgergtasa.mdl"] = {"Burger", 86},
    ["models/foodnhouseholditems/grapes1.mdl"] = {"Grapes", 10},
    ["models/foodnhouseholditems/hotdog.mdl"] = {"Hot Dog", 46},
    ["models/foodnhouseholditems/icecream.mdl"] = {"Ice Cream", 12},
    ["models/foodnhouseholditems/lobster.mdl"] = {"Lobster", 45},
    ["models/foodnhouseholditems/lettuce.mdl"] = {"Salad", 26},
    ["models/foodnhouseholditems/meat5.mdl"] = {"Beef Steak", 72},
    ["models/foodnhouseholditems/meat4.mdl"] = {"Lamb Joint", 72},
    ["models/foodnhouseholditems/meat_ribs.mdl"] = {"Ribs", 80},
    ["models/foodnhouseholditems/orange.mdl"] = {"Orange", 10},
    ["models/foodnhouseholditems/pancakes.mdl"] = {"Pancakes", 50},
    ["models/foodnhouseholditems/pie.mdl"] = {"Apple Pie", 60},
    ["models/foodnhouseholditems/pizza.mdl"] = {"Pizza", 55},
    ["models/foodnhouseholditems/pizzaslice.mdl"] = {"Pizza Slice", 20},
    ["models/foodnhouseholditems/sandwich.mdl"] = {"Sandwich", 55},
    ["models/foodnhouseholditems/salmon.mdl"] = {"Salmon", 50},
    ["models/foodnhouseholditems/turkey2.mdl"] = {"Turkey Dinner", 200},
    ["models/foodnhouseholditems/turkeyleg.mdl"] = {"Turkey Leg", 36},
    ["models/foodnhouseholditems/corn.mdl"] = {"Corn", 10},
    ["models/foodnhouseholditems/croissant.mdl"] = {"Croissant", 26},
    ["models/foodnhouseholditems/cheesewheel1c.mdl"] = {"Slice of Cheese", 28},
    ["models/foodnhouseholditems/cheesewheel1a.mdl"] = {"Cheese Wheel", 70},
    ["models/foodnhouseholditems/potato.mdl"] = {"Potato", 10},
    ["models/foodnhouseholditems/fishsteak.mdl"] = {"Fish Steak", 56},
    ["models/foodnhouseholditems/tomato.mdl"] = {"Tomato", 10},
    ["models/foodnhouseholditems/steak2.mdl"] = {"Pork Joint", 72},
    ["models/foodnhouseholditems/cake_b.mdl"] = {"Cake", 66},
    ["models/foodnhouseholditems/cake_b.mdl"] = {"Coffee Grain", 66},
    ["models/craphead_scripts/ch_farming/crops/corn.mdl"] = {"Corn Crop", 66},
    ["models/craphead_scripts/ch_farming/crops/lettuce.mdl"] = {"Lettuce Crop", 66},
    ["models/craphead_scripts/ch_farming/crops/pepper.mdl"] = {"Pepper Crop", 66},
    ["models/craphead_scripts/ch_farming/crops/tomato.mdl"] = {"Tomato Crop", 66},
    ["models/craphead_scripts/ch_farming/crops/wheat.mdl"] = {"Wheat Crop", 66},
}

for i, v in pairs(foods) do
    local model = i
    local name = v[1]
    local hunger = v[2]
    local ITEM = nut.item.register(name, "base_food", nil, nil, true)
    ITEM.name = name
    ITEM.model = model
    ITEM.hunger = hunger
    ITEM.price = 0
    ITEM.desc = "A " .. name .. "."

    ITEM.functions.Eat = {
        text = "Eat",
        icon = "icon16/cup.png",
        onRun = function(item)
            local client = item.player

            -- If the player is not observing
            if client:isObserving() then
                client:notify("You can't eat while observing.")

                return false
            end

            client:EmitSound("npc/barnacle/barnacle_gulp1.wav")
            client:notify("You eat the " .. name .. ".")
            client:addHunger(item.hunger)
        end
    }

    function ITEM:onInstanced(index)
        local entity = nut.item.instances[index]
    end

    function ITEM:onUse(item)
        local client = self.player
    end
end