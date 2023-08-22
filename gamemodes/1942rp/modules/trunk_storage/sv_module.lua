function MODULE:PlayerSpawnedVehicle(client, ent)
    local char = client:getChar()
    local def = VEHICLE_DEFINITIONS[ent:GetModel():lower()]
    if def then
        ent.WCDOwner = client
        ent.LockTrunk = LockTrunk
        ent.IsTrunkLocked = IsTrunkLocked
        ent.getInv = getInv
        local wcd_trunks
        local old_inventory
        if char then
            wcd_trunks = char:getData("wcd_trunks", {})
            old_inventory = wcd_trunks[ent:GetModel():lower()]
        end

        --load the old inventory if it exists
        if old_inventory then
            lia.inventory.loadByID(old_inventory):next(
                function(inventory)
                    if inventory then
                        inventory.isStorage = true
                        ent:setNetVar("trunk_id", inventory:getID())
                        ent.trunk_id = inventory:getID()
                        hook.Run("StorageInventorySet", ent, inventory)
                    end
                end
            )
        else --create a new inventory
            lia.inventory.instance(
                "grid",
                {
                    w = def.width,
                    h = def.height
                }
            ):next(
                function(inventory)
                    if IsValid(ent) then
                        inventory.isStorage = true
                        ent:setNetVar("trunk_id", inventory:getID())
                        ent.trunk_id = inventory:getID()
                        hook.Run("StorageInventorySet", ent, inventory)
                    end
                end
            )
        end
    end
end

function MODULE:EntityRemoved(ent)
    if IsValid(ent) and ent:IsVehicle() and VEHICLE_DEFINITIONS[ent:GetModel():lower()] then
        if not IsValid(ent.WCDOwner) then
            -- Drop the items (Might cause issues)
            local inventory = ent:getInv()
            if inventory then
                for k, v in pairs(inventory:getItems()) do
                    v:removeFromInventory(true)
                    v:spawn(ent:GetPos(), ent:GetAngles())
                end
            end
        else
            -- Save data
            local inventory = ent:getInv()
            local char = ent.WCDOwner:getChar()
            if char then
                local wcd_trunks = char:getData("wcd_trunks", {})
                wcd_trunks[ent:GetModel():lower()] = inventory:getID()
                char:setData("wcd_trunks", wcd_trunks)
            end
        end
    end
end
--this shouldnt be necessary anymore
--[[
	hook.Add("WCD::SpawnedVehicle", "TrunkLoadData", function(client, entity)
		if (!IsValid(entity)) then return end
		if (!entity:IsVehicle()) then return end

		local def = VEHICLE_DEFINITIONS[entity:GetModel():lower()]
		if (!def) then return end

		local char = client:getChar()
		if (!char) then return end

		entity.WCDOwner = client

		local wcd_trunks = char:getData("wcd_trunks", {})
		if (wcd_trunks[entity:GetModel():lower()]) then
			local old_inventory = wcd_trunks[entity:GetModel():lower()]
			if (old_inventory) then return end

			lia.inventory.loadByID(old_inventory)
			:next(function(inventory)
				if (inventory) then
					inventory.isStorage = true
					entity:setNetVar("trunk_id", inventory:getID())
					entity.trunk_id = inventory:getID()
					
					hook.Run("StorageInventorySet", entity, inventory)
				end
			end)
		end
	end)
	--]]