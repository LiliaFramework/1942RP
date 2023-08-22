local MODULE = MODULE
netstream.Hook(
    "ItemMakerGUI",
    function(client, id, itemData)
        if not MODULE.HasPermission[client:GetUserGroup()] then return end
        if not id or not itemData then return end
        if not itemData.name or not itemData.desc then return end
        NSForgedItems.List[id] = itemData
        NSForgedItems.RegisterCustomItem(id, itemData)
        netstream.Start(nil, "NSForgedItemsLoadSingle", id, itemData)
        client:notify("You've successfully registered '" .. id .. "'. It can now be spawned in and used as an item!")
    end
)

netstream.Hook(
    "ItemMakerDelete",
    function(uniqueID)
        lia.item.list[uniqueID] = nil
        NSForgedItems.List[uniqueID] = nil
    end
)