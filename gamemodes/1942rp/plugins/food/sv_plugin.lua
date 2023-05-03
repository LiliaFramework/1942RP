local PLUGIN = PLUGIN

function PLUGIN:CharacterPreSave(character)
    local savedHunger = math.Clamp(CurTime() - character.player:getHunger(), 0, PLUGIN.hungrySeconds)
    character:setData("hunger", savedHunger)
end

function PLUGIN:PlayerLoadedChar(client, character, lastChar)
    if character:getData("hunger") then
        client:setNetVar("hunger", CurTime() - character:getData("hunger"))
    else
        client:setNetVar("hunger", CurTime())
    end
end

function PLUGIN:PlayerDeath(client)
    client.refillHunger = true
end

function PLUGIN:PlayerSpawn(client)
    if client.refillHunger then
        client:setNetVar("hunger", CurTime())
        client.refillHunger = false
    end
end

local thinkTime = CurTime()

function PLUGIN:PlayerPostThink(client)
    if thinkTime < CurTime() then
        local percent = 1 - client:getHungerPercent()

        if percent <= 0 then
            if client:Alive() and client:Health() <= 0 then
                client:Kill()
            else
                client:SetHealth(math.Clamp(client:Health() - 1, 0, client:GetMaxHealth()))
            end
        end

        thinkTime = CurTime() + PLUGIN.hungerTimer
    end
end