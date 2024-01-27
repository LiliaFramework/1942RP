----------------------------------------------------------------------------------------------
function TyingSearchCore:SetupInventorySearch(client, target)
    local function searcherCanAccess(inventory, action, context)
        if context.client == client then return true end
    end

    target:getChar():getInv():addAccessRule(searcherCanAccess)
    target.liaSearchAccessRule = searcherCanAccess
    target:getChar():getInv():sync(client)
end

----------------------------------------------------------------------------------------------
function TyingSearchCore:RemoveInventorySearchPermissions(client, target)
    local rule = target.liaSearchAccessRule
    if rule then
        target:getChar():getInv():removeAccessRule(rule)
    end
end

----------------------------------------------------------------------------------------------
function TyingSearchCore:searchPlayer(client, target)
    if IsValid(target:getNetVar("searcher")) or IsValid(client.liaSearchTarget) then
        client:notifyLocalized("This person is already being searched.")

        return false
    end

    if not target:getChar() or not target:getChar():getInv() then
        client:notifyLocalized("invalidPly")

        return false
    end

    self:SetupInventorySearch(client, target)
    netstream.Start(client, "searchPly", target, target:getChar():getInv():getID())
    client.liaSearchTarget = target
    target:setNetVar("searcher", client)

    return true
end

----------------------------------------------------------------------------------------------
function TyingSearchCore:CanPlayerInteractItem(client, action, item)
    if IsValid(client:getNetVar("searcher")) then return false end
end

----------------------------------------------------------------------------------------------
function TyingSearchCore:stopSearching(client)
    local target = client.liaSearchTarget
    if IsValid(target) and target:getNetVar("searcher") == client then
        TyingSearchCore:RemoveInventorySearchPermissions(client, target)
        target:setNetVar("searcher", nil)
        client.liaSearchTarget = nil
        netstream.Start(client, "searchExit")
    end
end

----------------------------------------------------------------------------------------------
function TyingSearchCore:OnPlayerUnRestricted(client)
    local searcher = client:getNetVar("searcher")
    if IsValid(searcher) then
        self:stopSearching(searcher)
    end
end
----------------------------------------------------------------------------------------------