lia.command.add(
    "trunk",
    {
        adminOnly = false,
        syntax = "",
        onRun = function(client, arguments)
            local trace = client:GetEyeTraceNoCursor()
            local ent = trace.Entity
            local dist = ent:GetPos():DistToSqr(client:GetPos())
            -- Validate vehicle
            if not ent or not ent:IsValid() then return end
            if not ent:IsVehicle() then return client:notifyLocalized("invalidVehicle") end
            if not VEHICLE_DEFINITIONS[ent:GetModel():lower()] then return client:notifyLocalized("noTrunk") end
            local def = VEHICLE_DEFINITIONS[ent:GetModel():lower()]
            -- Check action criteria
            if dist > 16384 then return client:notifyLocalized("tooFar") end
            if ent:IsTrunkLocked() then
                ent:EmitSound("doors/default_locked.wav")

                return client:notifyLocalized("trunkLocked")
            end

            -- Perform action
            client:setAction(
                "Opening...",
                .7,
                function()
                    local inventory = ent:getInv()
                    --make sure this exists so item transfers can happen
                    if not ent.receivers then
                        ent.receivers = {}
                    end

                    client.liaStorageEntity = ent
                    ent.receivers[client] = true
                    inventory:sync(client)
                    netstream.Start(client, "trunkOpen", ent, inventory:getID())
                    ent:EmitSound(def.trunkSound or "items/ammocrate_open.wav")
                end
            )
        end
    }
)

lia.command.add(
    "locktrunk",
    {
        adminOnly = false,
        syntax = "",
        onRun = function(client, arguments)
            local trace = client:GetEyeTraceNoCursor()
            local ent = trace.Entity
            local dist = ent:GetPos():DistToSqr(client:GetPos())
            -- Valdiate vehicle
            if not ent or not ent:IsValid() then return nil end
            if not ent:IsVehicle() then return client:notifyLocalized("invalidVehicle") end
            if not VEHICLE_DEFINITIONS[ent:GetModel():lower()] then return client:notifyLocalized("noTrunk") end
            local def = VEHICLE_DEFINITIONS[ent:GetModel():lower()]
            -- Check action criteria
            if dist > 16384 then return client:notifyLocalized("tooFar") end
            if ent.WCDOwner ~= client and ent.EntityOwner ~= client then return client:notifyLocalized("notOwner") end
            -- Perform action
            ent:LockTrunk(true)
            ent:EmitSound(def.lockSound or "doors/default_locked.wav")
            client:notifyLocalized("lockTrunk")
        end
    }
)

lia.command.add(
    "unlocktrunk",
    {
        adminOnly = false,
        syntax = "",
        onRun = function(client, arguments)
            local trace = client:GetEyeTraceNoCursor()
            local ent = trace.Entity
            local dist = ent:GetPos():DistToSqr(client:GetPos())
            -- Valdiate vehicle
            if not ent or not ent:IsValid() then return nil end
            if not ent:IsVehicle() then return client:notifyLocalized("invalidVehicle") end
            if not VEHICLE_DEFINITIONS[ent:GetModel():lower()] then return client:notifyLocalized("noTrunk") end
            local def = VEHICLE_DEFINITIONS[ent:GetModel():lower()]
            -- Check action criteria
            if dist > 16384 then return client:notifyLocalized("tooFar") end
            if ent.WCDOwner ~= client and ent.EntityOwner ~= client then return client:notifyLocalized("notOwner") end
            -- Perform action
            ent:LockTrunk(false)
            ent:EmitSound(def.unlockSound or "items/ammocrate_open.wav")
            client:notifyLocalized("unlockTrunk")
        end
    }
)