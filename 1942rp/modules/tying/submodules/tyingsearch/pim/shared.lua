----------------------------------------------------------------------------------------------
local MODULE = MODULE
--------------------------------------------------------------------------------------------------------
PIM:AddOption("Request Search", {
    runServer = true,
    shouldShow = function(client, target) return IsHandcuffed(target) and not target.SearchRequested and not client.SearchRequested and not IsBeingSearched(target) end,
    onRun = function(client, target)
        if not SERVER then return end
        net.Start("RequestSearch")
        net.Send(target)
        client:notify("Request to search sent.")
        target.SearchRequested = client
        client.SearchRequested = target
    end
})

----------------------------------------------------------------------------------------------
PIM:AddOption("Search", {
    runServer = true,
    shouldShow = function(client, target) return IsHandcuffed(target) and not IsBeingSearched(target) end,
    onRun = function(client, target)
        if not SERVER then return end
        MODULE:SetupInventorySearch(client, target)
        netstream.Start(client, "searchPly", target, target:getChar():getInv():getID())
        client.liaSearchTarget = target
        target:setNetVar("searcher", client)
    end
})
----------------------------------------------------------------------------------------------
