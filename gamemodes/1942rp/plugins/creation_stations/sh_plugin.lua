PLUGIN.name = "Creation Stations"
PLUGIN.author = "Leonheart#7476"
PLUGIN.description = "This particular plugin allows you to use Creation Stations."
local playerMeta = FindMetaTable("Player")

nut.config.add("drugTime", 300, "The time (in seconds) it takes to produce some drugs.", nil, {
    data = {
        min = 5,
        max = 7200
    }
})

if SERVER then
    function PLUGIN:Think()
        for _, v in ipairs(ents.FindByClass("nut_item")) do
            local itemTable = v:getItemTable()

            if itemTable.uniqueID == "distillery" or itemTable.uniqueID == "drug_lab" then
                if v.lastProductionTime then
                    if CurTime() > v.lastProductionTime + nut.config.get("drugTime", 300) then
                        nut.item.spawn(v.lastProductionDrug, v:GetPos() + Vector(0, 0, 50))
                        v.lastProductionDrug = nil
                        v.lastProductionTime = nil
                    end
                end
            end
        end
    end

    function playerMeta:removeListOfItems(items)
        PrintTable(items)

        if self:getChar() then
            local character = self:getChar()
            local playerItems = table.fixkeys(self:getChar():getInv():getItems())

            for _, v in ipairs(items) do
                for i, o in ipairs(playerItems) do
                    if v == o.uniqueID then
                        print("Found " .. v .. " with ID " .. o.id)
                        o:remove()
                        playerItems[i] = nil
                        playerItems = table.fixkeys(playerItems)
                        break
                    end
                end
            end
        end
    end
end

function table.fixkeys(input)
    local outputTable = {}

    for _, v in pairs(input) do
        outputTable[#outputTable + 1] = v
    end

    return outputTable
end

function playerMeta:hasListOfItems(items)
    local playerItems = table.fixkeys(self:getChar():getInv():getItems())
    local neededItemCounts = {}
    local itemCounts = {}

    for _, v in ipairs(items) do
        itemCounts[v] = {}
    end

    for i, o in pairs(itemCounts) do
        for _, v in ipairs(playerItems) do
            if i == v.uniqueID then
                itemCounts[i][#itemCounts[i] + 1] = v.id
            end
        end
    end

    for i, o in pairs(items) do
        if not neededItemCounts[o] then
            neededItemCounts[o] = 0
        end

        neededItemCounts[o] = neededItemCounts[o] + 1
    end

    local enoughItems = true

    for i, o in pairs(neededItemCounts) do
        if itemCounts[i] then
        else
            enoughItems = false
            break
        end

        if not (#itemCounts[i] >= o) then
            enoughItems = false
            break
        end
    end

    return enoughItems
end