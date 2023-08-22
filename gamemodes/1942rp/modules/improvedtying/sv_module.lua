local MODULE = MODULE

function MODULE:ns1SetupInventorySearch(client, target)
    local inventory = target:getChar():getInv(client, target)
    -- Permit the player to move items from their inventory to the target's inventory.
    inventory.oldOnAuthorizeTransfer = inventory.onAuthorizeTransfer

    inventory.onAuthorizeTransfer = function(inventory, client2, oldInventory, item)
        if IsValid(client2) and client2 == client then return true end

        return false
    end

    inventory:sync(client)
    inventory.oldGetReceiver = inventory.getReceiver

    inventory.getReceiver = function(inventory)
        return {client, target}
    end

    inventory.onCheckAccess = function(inventory, client2)
        if client2 == client then return true end
    end

    -- Permit the player to move items from the target's inventory back into their inventory.
    local inventory2 = client:getChar():getInv()
    inventory2.oldOnAuthorizeTransfer = inventory2.onAuthorizeTransfer

    inventory2.onAuthorizeTransfer = function(inventory3, client2, oldInventory, item)
        if oldInventory == inventory then return true end

        return inventory2.oldOnAuthorizeTransfer(inventory3, client2, oldInventory, item)
    end
end

function MODULE:ns1RemoveInventorySearchPermissions(client, target)
    local inventory = target:getChar():getInv()
    inventory.onAuthorizeTransfer = inventory.oldOnAuthorizeTransfer
    inventory.oldOnAuthorizeTransfer = nil
    inventory.getReceiver = inventory.oldGetReceiver
    inventory.oldGetReceiver = nil
    inventory.onCheckAccess = nil
    local inventory2 = client:getChar():getInv()
    inventory2.onAuthorizeTransfer = inventory2.oldOnAuthorizeTransfer
    inventory2.oldOnAuthorizeTransfer = nil
end

function MODULE:ns2SetupInventorySearch(client, target)
    local function searcherCanAccess(inventory, action, context)
        if context.client == client then return true end
    end

    target:getChar():getInv():addAccessRule(searcherCanAccess)
    target.liaSearchAccessRule = searcherCanAccess
    target:getChar():getInv():sync(client)
end

function MODULE:ns2RemoveInventorySearchPermissions(client, target)
    local rule = target.liaSearchAccessRule

    if rule then
        target:getChar():getInv():removeAccessRule(rule)
    end
end

function MODULE:searchPlayer(client, target)
    if IsValid(target:getNetVar("searcher")) or IsValid(client.liaSearchTarget) then
        client:notifyLocalized("This person is already being searched.")

        return false
    end

    if not target:getChar() or not target:getChar():getInv() then
        client:notifyLocalized("invalidPly")

        return false
    end

    if lia.version then
        self:ns2SetupInventorySearch(client, target)
    else
        self:ns1SetupInventorySearch(client, target)
    end

    -- Show the inventory menu to the searcher.
    netstream.Start(client, "searchPly", target, target:getChar():getInv():getID())
    client.liaSearchTarget = target
    target:setNetVar("searcher", client)

    return true
end

----------------------------------------------------------------------------------------------
function MODULE:CanPlayerInteractItem(client, action, item)
    if IsValid(client:getNetVar("searcher")) then return false end
end

function MODULE:stopSearching(client)
    local target = client.liaSearchTarget

    if IsValid(target) and target:getNetVar("searcher") == client then
        if lia.version then
            MODULE:ns2RemoveInventorySearchPermissions(client, target)
        else
            MODULE:ns1RemoveInventorySearchPermissions(client, target)
        end

        target:setNetVar("searcher", nil)
        client.liaSearchTarget = nil
        netstream.Start(client, "searchExit")
    end
end

netstream.Hook("searchExit", function(client)
    MODULE:stopSearching(client)
end)