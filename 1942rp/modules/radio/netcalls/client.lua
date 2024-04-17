--------------------------------------------------------------------------------------------------------
netstream.Hook("radioAdjust", function(freq, id)
    local adjust = vgui.Create("liaRadioMenu")
    if id then adjust.itemID = id end
    freq = tostring(freq)
    if freq then
        for i = 1, 5 do
            if i ~= 4 then adjust.dial[i].number = tostring(freq[i]) end
        end
    end
end)
--------------------------------------------------------------------------------------------------------