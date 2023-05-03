local PLUGIN = PLUGIN
PLUGIN.searchPanels = PLUGIN.searchPanels or {}

function PLUGIN:CanPlayerViewInventory()
    if IsValid(LocalPlayer():getNetVar("searcher")) then return false end
end

if nut.version then
    netstream.Hook("searchPly", function(target, id)
        local targetInv = nut.inventory.instances[id]
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
        local inventory = nut.item.inventories[index]
        if not inventory then return netstream.Start("searchExit") end
        nut.gui.inv1 = vgui.Create("nutInventory")
        nut.gui.inv1:ShowCloseButton(true)
        nut.gui.inv1:setInventory(LocalPlayer():getChar():getInv())
        PLUGIN.searchPanels[#PLUGIN.searchPanels + 1] = nut.gui.inv1
        local panel = vgui.Create("nutInventory")
        panel:ShowCloseButton(true)
        panel:SetTitle(target:Name())
        panel:setInventory(inventory)
        panel:MoveLeftOf(nut.gui.inv1, 4)

        panel.OnClose = function(this)
            if IsValid(nut.gui.inv1) and not IsValid(nut.gui.menu) then
                nut.gui.inv1:Remove()
            end

            netstream.Start("searchExit")
        end

        local oldClose = nut.gui.inv1.OnClose

        nut.gui.inv1.OnClose = function()
            if IsValid(panel) and not IsValid(nut.gui.menu) then
                panel:Remove()
            end

            netstream.Start("searchExit")
            nut.gui.inv1.OnClose = oldClose
        end

        nut.gui["inv" .. index] = panel
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