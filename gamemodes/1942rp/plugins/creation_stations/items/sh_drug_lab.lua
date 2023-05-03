ITEM.name = "Drug Lab"
ITEM.model = "models/props_junk/PropaneCanister001a.mdl"
ITEM.desc = "A complex drug lab with all the tools required to make heroin, or meth. You must only provide the ingredients."
ITEM.width = 2
ITEM.height = 2
ITEM.price = 2000
ITEM.permit = "permit_fake"
ITEM.category = "Drugs"
ITEM.color = Color(50, 255, 50)

ITEM.functions.Opium = {
    name = "Create Opium",
    icon = "icon16/cog.png",
    sound = "buttons/lightswitch2.wav",
    onRun = function(item)
        local client = item.player
        local inventory = client:getChar():getInv()

        if not IsValid(item.entity) then
            client:notify("The drug lab must be on the ground")

            return false
        end

        local seed = inventory:getFirstItemOfType("poppy_seed")

        if not seed then
            client:notify("You need poppy seeds!")

            return false
        end

        seed:remove()
        item:setData("producing2", CurTime())
        client:notify("The drug is cooking.")

        --2.5 minutes 
        timer.Simple(580, function()
            local position = client:getItemDropPos()

            if item then
                item:setData("producing2", nil)

                --checks if item is not on the ground
                if not IsValid(item:getEntity()) then
                    --if the inventory has space, put it in the inventory
                    if not inventory:add("opium") then
                        nut.item.spawn("opium", client:getItemDropPos()) --if not, drop it on the ground
                    end
                else --if the item it on the ground
                    nut.item.spawn("opium", item:getEntity():GetPos() + item:getEntity():GetUp() * 50) --spawn the grow item above the item
                end

                client:notify("The opium is ready.")
            end
        end)

        return false
    end,
    onCanRun = function(item)
        if item:getData("producing2") ~= nil then
            local endTime = item:getData("producing2", 0) + 900
            if item:getData("producing2", 0) > CurTime() or CurTime() > endTime then return true end

            return false
        end

        return true
    end
}

ITEM.functions.Heroin = {
    name = "Create Heroin",
    icon = "icon16/cog.png",
    sound = "buttons/lightswitch2.wav",
    onRun = function(item)
        local client = item.player
        local inventory = client:getChar():getInv()

        if not IsValid(item.entity) then
            client:notify("The drug lab must be on the ground")

            return false
        end

        local seed = inventory:getFirstItemOfType("poppy_seed")

        if not seed then
            client:notify("You needz poppy seeds!")

            return false
        end

        seed:remove()
        item:setData("producing2", CurTime())
        client:notify("The drug is cooking.")

        --2.5 minutes 
        timer.Simple(580, function()
            local position = client:getItemDropPos()

            if item then
                item:setData("producing2", nil)

                --checks if item is not on the ground
                if not IsValid(item:getEntity()) then
                    --if the inventory has space, put it in the inventory
                    if not inventory:add("heroin") then
                        nut.item.spawn("heroin", client:getItemDropPos()) --if not, drop it on the ground
                    end
                else --if the item it on the ground
                    nut.item.spawn("heroin", item:getEntity():GetPos() + item:getEntity():GetUp() * 50) --spawn the grow item above the item
                end

                client:notify("The heroin is ready.")
            end
        end)

        return false
    end,
    onCanRun = function(item)
        if item:getData("producing2") ~= nil then
            local endTime = item:getData("producing2", 0) + 900
            if item:getData("producing2", 0) > CurTime() or CurTime() > endTime then return true end

            return false
        end

        return true
    end
}

--only one farm action should be happening at once with one item
--only one farm action should be happening at once with one item.
ITEM.functions.Cocaine = {
    name = "Create Cocaine",
    icon = "icon16/cog.png",
    sound = "buttons/lightswitch2.wav",
    onRun = function(item)
        local client = item.player
        local inventory = client:getChar():getInv()

        if not IsValid(item.entity) then
            client:notify("The drug lab must be on the ground")

            return false
        end

        local muri = inventory:getFirstItemOfType("acid_muri")
        local hydro = inventory:getFirstItemOfType("acid_hydro")
        local soda = inventory:getFirstItemOfType("hydro_salt")
        local kerosine = inventory:getFirstItemOfType("Kerosine")

        if not muri or not hydro or not soda or not kerosine then
            client:notifyLocalized("You need muriatic acid, hydrochloric acid, and a tub of hydrochloride salt!")

            return false
        end

        muri:remove()
        hydro:remove()
        soda:remove()
        item:setData("producing2", CurTime())
        client:notify("The drug is cooking.")

        --5 minutes 
        timer.Simple(580, function()
            local position = client:getItemDropPos()

            if item then
                item:setData("producing2", nil)

                --checks if item is not on the ground
                if not IsValid(item:getEntity()) then
                    --if the inventory has space, put it in the inventory
                    if not inventory:add("cocaine") then
                        nut.item.spawn("cocaine", client:getItemDropPos()) --if not, drop it on the ground
                    end
                else --if the item it on the ground
                    nut.item.spawn("cocaine", item:getEntity():GetPos() + item:getEntity():GetUp() * 50) --spawn the grow item above the item
                end

                client:notify("The cocaine has finished cooking.")
            end
        end)

        return false
    end,
    onCanRun = function(item)
        if item:getData("producing2") ~= nil then
            local endTime = item:getData("producing2", 0) + 1200 -- 600s
            if item:getData("producing2", 0) > CurTime() or CurTime() > endTime then return true end

            return false
        end

        return true
    end
}

--only one farm action should be happening at once with one item.
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