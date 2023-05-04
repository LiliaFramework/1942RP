local playerMeta = FindMetaTable("Player")
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