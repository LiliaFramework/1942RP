local PLUGIN = PLUGIN
PLUGIN.searchPanels = PLUGIN.searchPanels or {}

function PLUGIN:CanPlayerViewInventory()
    if IsValid(LocalPlayer():getNetVar("searcher")) then return false end
end

if lia.version then
    netstream.Hook("searchPly", function(target, id)
        local targetInv = lia.inventory.instances[id]
        if not targetInv then return netstream.Start("searchExit") end
        local myInvPanel, targetInvPanel
        local exitLock = true

        local function onRemove(panel)
            local other = panel == myInvPanel and targetInvPanel or myInvPanel

            if IsValid(other) and exitLock then
                exitLock = false
                other:Remove()
            end

            netstream.Start("searchExit")
            panel:searchOnRemove()
        end

        myInvPanel = LocalPlayer():getChar():getInv():show()
        myInvPanel:ShowCloseButton(true)
        myInvPanel.searchOnRemove = myInvPanel.OnRemove
        myInvPanel.OnRemove = onRemove
        targetInvPanel = targetInv:show()
        targetInvPanel:ShowCloseButton(true)
        targetInvPanel:SetTitle(target:Name())
        targetInvPanel.searchOnRemove = targetInvPanel.OnRemove
        targetInvPanel.OnRemove = onRemove
        myInvPanel.x = myInvPanel.x + (myInvPanel:GetWide() * 0.5) + 2
        targetInvPanel:MoveLeftOf(myInvPanel, 4)
        PLUGIN.searchPanels[#PLUGIN.searchPanels + 1] = myInvPanel
        PLUGIN.searchPanels[#PLUGIN.searchPanels + 1] = targetInvPanel
    end)
else
    netstream.Hook("searchPly", function(target, index)
        local inventory = lia.item.inventories[index]
        if not inventory then return netstream.Start("searchExit") end
        lia.gui.inv1 = vgui.Create("liaInventory")
        lia.gui.inv1:ShowCloseButton(true)
        lia.gui.inv1:setInventory(LocalPlayer():getChar():getInv())
        PLUGIN.searchPanels[#PLUGIN.searchPanels + 1] = lia.gui.inv1
        local panel = vgui.Create("liaInventory")
        panel:ShowCloseButton(true)
        panel:SetTitle(target:Name())
        panel:setInventory(inventory)
        panel:MoveLeftOf(lia.gui.inv1, 4)

        panel.OnClose = function(this)
            if IsValid(lia.gui.inv1) and not IsValid(lia.gui.menu) then
                lia.gui.inv1:Remove()
            end

            netstream.Start("searchExit")
        end

        local oldClose = lia.gui.inv1.OnClose

        lia.gui.inv1.OnClose = function()
            if IsValid(panel) and not IsValid(lia.gui.menu) then
                panel:Remove()
            end

            netstream.Start("searchExit")
            lia.gui.inv1.OnClose = oldClose
        end

        lia.gui["inv" .. index] = panel
        PLUGIN.searchPanels[#PLUGIN.searchPanels + 1] = panel
    end)
end

netstream.Hook("searchExit", function()
    for _, panel in pairs(PLUGIN.searchPanels) do
        if IsValid(panel) then
            panel:Remove()
        end
    end

    PLUGIN.searchPanels = {}
end)