local MODULE = MODULE
lia.command.add(
    "ItemMaker",
    {
        adminOnly = true,
        syntax = "",
        onRun = function(client, arguments)
            if not MODULE.HasPermission[client:GetUserGroup()] then
                client:notify("You do not have access to this command.")

                return false
            end

            netstream.Start(client, "ItemMakerGUI")
        end
    }
)

lia.command.add(
    "ItemMakerlist",
    {
        adminOnly = true,
        syntax = "",
        onRun = function(client, arguments)
            if not MODULE.HasPermission[client:GetUserGroup()] then
                client:notify("You do not have access to this command.")

                return false
            end

            netstream.Start(client, "ItemMakerList", NSForgedItems.List)
        end
    }
)

lia.command.add(
    "ItemMakerdetails",
    {
        adminOnly = true,
        syntax = "<uniqueID>",
        onRun = function(client, arguments)
            if not MODULE.HasPermission[client:GetUserGroup()] then
                client:notify("You do not have access to this command.")

                return false
            end

            local uniqueID = arguments[1]
            if not uniqueID or not NSForgedItems.List[uniqueID] then
                client:notify("Unique ID is invalid. Consider using /ItemMakerlist")

                return
            end

            netstream.Start(client, "ItemMakerDetails", uniqueID, NSForgedItems.List[uniqueID])
        end
    }
)

lia.command.add(
    "ItemMakerdelete",
    {
        adminOnly = true,
        syntax = "<uniqueID>",
        onRun = function(client, arguments)
            if not MODULE.HasPermission[client:GetUserGroup()] then
                client:notify("You do not have access to this command.")

                return false
            end

            local uniqueID = arguments[1]
            if not uniqueID then
                client:notify("You have to specify a unique ID")

                return
            end

            if not NSForgedItems.List[uniqueID] then
                client:notify("That is not an item-forge generated item ID.")

                return
            end

            NSForgedItems.List[uniqueID] = nil
            local count = 0
            for k, v in pairs(lia.item.instances) do
                if v and istable(v) and v.uniqueID and v.uniqueID == uniqueID then
                    count = count + 1
                    v:remove()
                end
            end

            lia.item.list[uniqueID] = nil
            client:notify("Removed " .. count .. " instances of " .. uniqueID .. " in the world & removed item type!")
            netstream.Start(nil, "ItemMakerDelete", uniqueID)
        end
    }
)