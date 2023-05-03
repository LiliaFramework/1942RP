util.AddNetworkString("RadioTransmit")

hook.Add("PlayerCanHearPlayersVoiceHookRadio", "PlayerCanHearPlayersVoiceHookRadio", function(listener, speaker)
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
end)

netstream.Hook("radioAdjust", function(client, freq, id)
    local inv = client:getChar() and client:getChar():getInv() or nil

    if inv then
        local item

        if id then
            item = nut.item.instances[id]
        else
            item = inv:hasItem("radio")
        end

        local ent = item:getEntity()

        if item and (IsValid(ent) or item:getOwner() == client) then
            (ent or client):EmitSound("buttons/combine_button1.wav", 50, 170)
            item:setData("freq", freq, player.GetAll(), false, true)
        else
            client:notifyLocalized("radioNoRadio")
        end
    end
end)

net.Receive("RadioTransmit", function()
    local ply = net.ReadEntity()
    local value = net.ReadBool()
    ply:SetNW2Bool("radio_voice", value)
end)