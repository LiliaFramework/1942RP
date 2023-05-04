ITEM.name = "Distillery"
ITEM.model = "models/props_c17/oildrum001.mdl"
ITEM.desc = "A Distillery."
ITEM.width = 2
ITEM.height = 2
ITEM.price = 2000
ITEM.color = Color(50, 255, 50)
ITEM.functions.Moonshine = {
    name = "Create Moonshine",
    icon = "icon16/cog.png",
    sound = "buttons/lightswitch2.wav",
    onRun = function(item)
        local client = item.player
        local inventory = client:getChar():getInv()

        if not IsValid(item.entity) then
            client:notify("The distillery must be on the ground")

            return false
        end

        local barley = inventory:getFirstItemOfType("barley")
        local water = inventory:getFirstItemOfType("water")
        local yeast = inventory:getFirstItemOfType("yeast")
        local grains = inventory:getFirstItemOfType("grains")
        local granulated_sugar = inventory:getFirstItemOfType("granulated_sugar")
        local corncrop = inventory:getFirstItemOfType("corncrop")

        if not corncrop then
            client:notify("You need Corn!")

            return false
        end

        if not granulated_sugar then
            client:notify("You need Granulated Sugar!")

            return false
        end

        if not grains then
            client:notify("You need fermented grains!")

            return false
        end

        if not barley then
            client:notify("You need Barley!")

            return false
        end

        if not water then
            client:notify("You need Water!")

            return false
        end

        if not yeast then
            client:notify("You need Yeast!")

            return false
        end

        yeast:remove()
        barley:remove()
        water:remove()
        item:setData("producing2", CurTime())
        client:notify("The drink is brewing.")

        -- 3 minutes
        timer.Simple(60 * 3, function()
            local position = client:getItemDropPos()

            if item then
                item:setData("producing2", nil)

                --checks if item is not on the ground
                if not IsValid(item:getEntity()) then
                    --if the inventory has space, put it in the inventory
                    if not inventory:add("Moonshine") then
                        lia.item.spawn("Moonshine", position) --if not, drop it on the ground
                    end
                else --if the item it on the ground
                    lia.item.spawn("Moonshine", item:getEntity():GetPos() + item:getEntity():GetUp() * 50) --spawn the grow item above the item
                end

                client:notify("The Moonshine is ready.")
            end
        end)

        return false
    end,
    onCanRun = function(item)
        if item:getData("producing2") ~= nil then
            local endTime = item:getData("producing2", 0) + 60 * 3
            if item:getData("producing2", 0) > CurTime() or CurTime() > endTime then return true end

            return false
        end

        return true
    end
}

ITEM.functions.Beer = {
    name = "Create Beer",
    icon = "icon16/cog.png",
    sound = "buttons/lightswitch2.wav",
    onRun = function(item)
        local client = item.player
        local inventory = client:getChar():getInv()

        if not IsValid(item.entity) then
            client:notify("The drug lab must be on the ground")

            return false
        end

        local barley = inventory:getFirstItemOfType("barley")
        local water = inventory:getFirstItemOfType("water")
        local yeast = inventory:getFirstItemOfType("yeast")
        local grains = inventory:getFirstItemOfType("grains")
        local hops = inventory:getFirstItemOfType("hops")

        if not hops then
            client:notify("You need hops!")

            return false
        end

        if not grains then
            client:notify("You need fermented grains!")

            return false
        end

        if not barley then
            client:notify("You need Barley!")

            return false
        end

        if not water then
            client:notify("You need Water!")

            return false
        end

        if not yeast then
            client:notify("You need Yeast!")

            return false
        end

        yeast:remove()
        barley:remove()
        water:remove()
        item:setData("producing2", CurTime())
        client:notify("The drink is brewing.")

        -- 3 minutes
        timer.Simple(60 * 3, function()
            local position = client:getItemDropPos()

            if item then
                item:setData("producing2", nil)

                --checks if item is not on the ground
                if not IsValid(item:getEntity()) then
                    --if the inventory has space, put it in the inventory
                    if not inventory:add("beer") then
                        lia.item.spawn("beer", position) --if not, drop it on the ground
                    end
                else --if the item it on the ground
                    lia.item.spawn("beer", item:getEntity():GetPos() + item:getEntity():GetUp() * 50) --spawn the grow item above the item
                end

                client:notify("The Beer is ready.")
            end
        end)

        return false
    end,
    onCanRun = function(item)
        if item:getData("producing2") ~= nil then
            local endTime = item:getData("producing2", 0) + 60 * 3
            if item:getData("producing2", 0) > CurTime() or CurTime() > endTime then return true end

            return false
        end

        return true
    end
}

ITEM.functions.Whisky = {
    name = "Create Whiskey",
    icon = "icon16/cog.png",
    sound = "buttons/lightswitch2.wav",
    onRun = function(item)
        local client = item.player
        local inventory = client:getChar():getInv()

        if not IsValid(item.entity) then
            client:notify("The drug lab must be on the ground")

            return false
        end

        local barley = inventory:getFirstItemOfType("barley")
        local water = inventory:getFirstItemOfType("water")
        local yeast = inventory:getFirstItemOfType("yeast")
        local grains = inventory:getFirstItemOfType("grains")

        if not grains then
            client:notify("You need fermented grains!")

            return false
        end

        if not barley then
            client:notify("You need Barley!")

            return false
        end

        if not water then
            client:notify("You need Water!")

            return false
        end

        if not yeast then
            client:notify("You need Yeast!")

            return false
        end

        yeast:remove()
        barley:remove()
        water:remove()
        item:setData("producing2", CurTime())
        client:notify("The drink is brewing.")

        -- 3 minutes
        timer.Simple(60 * 3, function()
            local position = client:getItemDropPos()

            if item then
                item:setData("producing2", nil)

                --checks if item is not on the ground
                if not IsValid(item:getEntity()) then
                    --if the inventory has space, put it in the inventory
                    if not inventory:add("whisky") then
                        lia.item.spawn("whisky", position) --if not, drop it on the ground
                    end
                else --if the item it on the ground
                    lia.item.spawn("whisky", item:getEntity():GetPos() + item:getEntity():GetUp() * 50) --spawn the grow item above the item
                end

                client:notify("The Whiskey is ready.")
            end
        end)

        return false
    end,
    onCanRun = function(item)
        if item:getData("producing2") ~= nil then
            local endTime = item:getData("producing2", 0) + 60 * 3
            if item:getData("producing2", 0) > CurTime() or CurTime() > endTime then return true end

            return false
        end

        return true
    end
}

ITEM.functions.take.onCanRun = function(item)
    return IsValid(item.entity) and item:getData("producing2", 0) == 0
end

function ITEM:getDesc()
    local desc = self.desc

    if self:getData("producing2") ~= nil then
        desc = desc .. "\nIt is currently producing something."
    end

    return Format(desc)
end
