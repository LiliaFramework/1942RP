GM = GM or GAMEMODE

function GM:PlayerCanHearPlayersVoice(listener, speaker)
    local VoiceRadios = lia.plugin.list.radio // Leonheart's Radios
    local ImprovedTying = lia.plugin.list.improvedtying // Leonheart's Tying
    local ImprovedVoice = lia.plugin.list.improvedvoice // 3D Voice
    local distance = 600 * 600
    local allowVoice = lia.config.get("allowVoice")

    if allowVoice then
        if listener:GetPos():DistToSqr(speaker:GetPos()) < distance then
            return true, true
        else
            if ImprovedVoice then
                if hook.Run("PlayerCanHearPlayersVoiceHook3DVoice", listener, speaker) then return true end
            end

            if ImprovedTying then
                if hook.Run("PlayerCanHearPlayersVoiceHookTying", listener, speaker) then return true end
            end

            if VoiceRadios then
                if hook.Run("PlayerCanHearPlayersVoiceHookRadio", listener, speaker) then return true end
            end
        end
    end

    return false, false
end