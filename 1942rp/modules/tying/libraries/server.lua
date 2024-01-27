----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TyingCore:PlayerBindPress(client, bind, pressed)
    bind = bind:lower()
    if IsHandcuffed(client) and (string.find(bind, "+speed") or string.find(bind, "gm_showhelp") or string.find(bind, "+jump") or string.find(bind, "+walk") or string.find(bind, "+use")) then return true end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TyingCore:CheckValidSit(client, trace)
    if IsHandcuffed(client) then return false end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TyingCore:CanDeleteChar(client, char)
    if IsHandcuffed(client) then return true end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TyingCore:PlayerSwitchWeapon(client, old, new)
    if IsHandcuffed(client) then return true end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TyingCore:CanExitVehicle(veh, client)
    if IsHandcuffed(client) then return false end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TyingCore:CanPlayerUseChar(client, char)
    if IsHandcuffed(client) then return false, "You're currently handcuffed." end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TyingCore:PostPlayerLoadout(client)
    OnHandcuffRemove(client)
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TyingCore:ShouldWeaponBeRaised(client, weapon)
    if IsHandcuffed(client) then return false end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TyingCore:CanPlayerUseDoor(client, entity)
    if IsHandcuffed(client) then return false end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TyingCore:CanPlayerInteractItem(client, action, item)
    if IsHandcuffed(client) then return false end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TyingCore:VC_canEnterPassengerSeat(client, seat, veh)
    return not IsHandcuffed(client)
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TyingCore:CanPlayerInteractItem(client, action, item)
    if IsHandcuffed(client) then return false end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TyingCore:PlayerUse(client, entity)
    if IsHandcuffed(client) then return false end
    if (IsHandcuffed(entity) and entity:IsPlayer()) and not entity.liaBeingUnTied then
        entity.liaBeingUnTied = true
        entity:setAction("@beingUntied", 5)
        client:setAction("@unTying", 5)
        client:doStaredAction(
            entity,
            function()
                OnHandcuffRemove(entity)
                entity.liaBeingUnTied = false
                client:EmitSound("npc/roller/blade_in.wav")
            end,
            5,
            function()
                entity.liaBeingUnTied = false
                entity:setAction()
                client:setAction()
            end
        )
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TyingCore:CanPlayerEnterVehicle(client)
    if IsHandcuffed(client) then return false end

    return true
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TyingCore:PlayerLeaveVehicle(client)
    if client:GetNWBool("WasCuffed", false) then
        client:SetNWBool("WasCuffed", true)
        HandcuffPlayer(client)
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function HandcuffPlayer(target)
    target:SetRunSpeed(target:GetWalkSpeed())
    for k, v in pairs(target:getChar():getInv():getItems()) do
        if v.isWeapon and v:getData("equip") then
            v:setData("equip", nil)
        end
    end

    if target.carryWeapons then
        for _, weapon in pairs(target.carryWeapons) do
            target:StripWeapon(weapon:GetClass())
        end

        target.carryWeapons = {}
    end

    timer.Simple(
        .2,
        function()
            target:SelectWeapon("lia_keys")
            target:setNetVar("ziptied", true)
        end
    )
    target:StartHandcuffAnim()
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OnHandcuffRemove(target)
    target:setNetVar("ziptied", false)
    target:SetWalkSpeed(lia.config.WalkSpeed)
    target:SetRunSpeed(lia.config.RunSpeed)
    hook.Run("ResetSubModuleCuffData", target)
    target:EndHandcuffAnim()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------