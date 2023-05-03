local playerMeta = FindMetaTable("Player")
function PLUGIN:Think()
    for _, v in ipairs(ents.FindByClass("lia_item")) do
        local itemTable = v:getItemTable()

        if itemTable.uniqueID == "distillery" or itemTable.uniqueID == "drug_lab" then
            if v.lastProductionTime then
                if CurTime() > v.lastProductionTime + lia.config.get("drugTime", 300) then
                    lia.item.spawn(v.lastProductionDrug, v:GetPos() + Vector(0, 0, 50))
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