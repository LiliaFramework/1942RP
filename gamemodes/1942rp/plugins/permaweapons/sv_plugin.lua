local PLUGIN = PLUGIN

function PLUGIN:Check4DonationSWEP(client)
    local weps = self.donatorWeapons[client:SteamID()] or {}
    client:notify("Donator Weapons Retrieved!")

    for _, wep in ipairs(weps) do
        client:Give(wep)
    end
end