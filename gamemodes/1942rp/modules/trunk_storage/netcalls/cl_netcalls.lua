netstream.Hook(
    "trunkOpen",
    function(entity, index)
        local inventory = lia.inventory.instances[index]
        if IsValid(entity) and entity:IsVehicle() and inventory then
            local data = VEHICLE_DEFINITIONS[entity:GetModel():lower()]
            if data then
                local PADDING = 4
                local localInv = LocalPlayer():getChar() and LocalPlayer():getChar():getInv()
                local storageInv = inventory
                if not localInv or not storageInv then return false end --return liaStorageBase:exitStorage()
                local localInvPanel = localInv:show()
                local storageInvPanel = storageInv:show()
                storageInvPanel:SetTitle(data.name or "Vehicle")
                localInvPanel:ShowCloseButton(true)
                storageInvPanel:ShowCloseButton(true)
                local extraWidth = (storageInvPanel:GetWide() + PADDING) / 2
                localInvPanel:Center()
                storageInvPanel:Center()
                localInvPanel.x = localInvPanel.x + extraWidth
                storageInvPanel:MoveLeftOf(localInvPanel, PADDING)
                local firstToRemove = true
                localInvPanel.oldOnRemove = localInvPanel.OnRemove
                storageInvPanel.oldOnRemove = storageInvPanel.OnRemove
                local function exitStorageOnRemove(panel)
                    if firstToRemove then
                        firstToRemove = false
                        liaStorageBase:exitStorage()
                        local otherPanel = panel == localInvPanel and storageInvPanel or localInvPanel
                        if IsValid(otherPanel) then
                            otherPanel:Remove()
                        end
                    end

                    panel:oldOnRemove()
                end

                localInvPanel.OnRemove = exitStorageOnRemove
                storageInvPanel.OnRemove = exitStorageOnRemove
            end
        end
    end
)