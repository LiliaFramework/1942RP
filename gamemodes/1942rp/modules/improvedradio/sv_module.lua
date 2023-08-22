--------------------------------------------------------------------------------------------------------
util.AddNetworkString("RadioTransmit")
--------------------------------------------------------------------------------------------------------
function MODULE:PlayerCanHearPlayersVoice(listener, speaker)
    if not speaker:getChar() then return false end
    if not listener:getChar() then return false end
    local talitem = speaker:getChar():getInv():getFirstItemOfType("radio")
    local lisitem = listener:getChar():getInv():getFirstItemOfType("radio")
    if (speaker:getChar():getInv():hasItem("radio") and talitem:getData("enabled")) and (listener:getChar():getInv():hasItem("radio") and lisitem:getData("enabled")) then
        local speakerFreq = tonumber(talitem:getData("freq"))
        local listenerFreq = tonumber(lisitem:getData("freq"))
        if speakerFreq == listenerFreq then
            if speaker:GetNW2Bool("radio_voice") then return true end
        end
    end
end
--------------------------------------------------------------------------------------------------------