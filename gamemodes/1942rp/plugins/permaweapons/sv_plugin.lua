local PLUGIN = PLUGIN

function PLUGIN:Check4DonationSWEP(client)
    local weps = self.donatorWeapons[client:SteamID()] or {}

    for _, wep in ipairs(weps) do
        client:Give(wep)
    end
end

function PLUGIN:PlayerSpawn(client)
    if not client:getChar() then return end
    self:Check4DonationSWEP(client)
end