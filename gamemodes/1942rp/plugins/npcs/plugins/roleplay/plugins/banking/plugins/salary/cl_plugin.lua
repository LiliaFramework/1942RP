local PLUGIN = PLUGIN

function PLUGIN:DrawCharInfo(client, character, info)
    local recog = LocalPlayer():getChar():doesRecognize(character)

    if not PLUGIN.CitizenFactions[character:getFaction()] and recog then
        info[#info + 1] = {client:getData("paygrade", "Enlisted"), Color(245, 215, 110)}
    end
end