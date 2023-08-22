function MODULE:SaveData()
    self:setData(NSForgedItems.List)
end

function MODULE:LoadData()
    NSForgedItems.List = self:getData() or {}
    for uniqueID, itemData in pairs(NSForgedItems.List) do
        NSForgedItems.RegisterCustomItem(uniqueID, itemData)
    end

    netstream.Start(nil, "NSForgedItemsLoad", NSForgedItems.List)
end

function MODULE:PlayerInitialSpawn(client)
    netstream.Start(client, "NSForgedItemsLoad", NSForgedItems.List)
end