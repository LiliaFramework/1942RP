local MODULE = MODULE
function MODULE:PlayerLoadout(client)
    client:setNetVar("restricted")
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:CanPlayerEnterVehicle(ply)
    if ply:IsHandcuffed() and not ply:IsVehicleAllowed() then
        return false
    elseif ply:IsHandcuffed() and ply:IsVehicleAllowed() then
        return true
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
hook.Add(
    "PlayerCanHearPlayersVoiceHookTying",
    "PlayerCanHearPlayersVoiceHookTying",
    function(listener, speaker)
        if not speaker:getChar() then return false end
        if not listener:getChar() then return false end
        if speaker:IsHandcuffed() and speaker:IsGagged() then return false end
    end
)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:OnPlayerUnRestricted(client)
    local searcher = client:getNetVar("searcher")
    if IsValid(searcher) then
        self:stopSearching(searcher)
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:PlayerUse(client, entity)
    if not client:getNetVar("restricted") and entity:IsPlayer() and entity:getNetVar("restricted") then
        if not entity.liaBeingUnTied then
            entity.liaBeingUnTied = true
            entity:setAction("@beingUntied", 5)
            client:setAction("@unTying", 5)
            client:doStaredAction(
                entity,
                function()
                    entity:setRestricted(false)
                    entity.liaBeingUnTied = false
                    client:EmitSound("npc/roller/blade_in.wav")
                    entity:FreeTies()
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
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:PlayerSpawn(ply)
    if not ply:getChar() then return end
    ply:FreeTies()
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function liaApproveSearch(len, ply)
    local requester = ply.SearchRequested
    if not requester then return end
    if not requester.SearchRequested then return end
    local approveSearch = net.ReadBool()
    if not approveSearch then
        requester:notify("Player denied your request to view their inventory.")
        requester.SearchRequested = nil
        ply.SearchRequested = nil

        return
    end

    if requester:GetPos():DistToSqr(ply:GetPos()) > 250 * 250 then return end
    MODULE:searchPlayer(requester, ply, true)
    requester.SearchRequested = nil
    ply.SearchRequested = nil
end

net.Receive("liaApproveSearch", liaApproveSearch)