PLUGIN.name = "Ammo Saver"
PLUGIN.author = "Black Tea"
PLUGIN.desc = "Saves the ammo of a character."
PLUGIN.ammoList = {}
nut.ammo = nut.ammo or {}

function nut.ammo.register(name)
    table.insert(PLUGIN.ammoList, name)
end

-- Register Default HL2 Ammunition.
nut.ammo.register("ar2")
nut.ammo.register("pistol")
nut.ammo.register("357")
nut.ammo.register("smg1")
nut.ammo.register("xbowbolt")
nut.ammo.register("buckshot")
nut.ammo.register("rpg_round")
nut.ammo.register("smg1_grenade")
nut.ammo.register("grenade")
nut.ammo.register("ar2altfire")
nut.ammo.register("slam")
-- Register Cut HL2 Ammunition.
nut.ammo.register("alyxgun")
nut.ammo.register("sniperround")
nut.ammo.register("sniperpenetratedround")
nut.ammo.register("thumper")
nut.ammo.register("gravity")
nut.ammo.register("battery")
nut.ammo.register("gaussenergy")
nut.ammo.register("combinecannon")
nut.ammo.register("airboatgun")
nut.ammo.register("striderminigun")
nut.ammo.register("helicoptergun")

local ammo = {
    ["7.92x33mm Kurz"] = "ar2",
    ["300 AAC Blackout"] = "ar2",
    ["5.7x28mm"] = "ar2",
    ["7.62x25mm Tokarev"] = "smg1",
    [".50 BMG"] = "ar2",
    ["5.56x45mm"] = "ar2",
    ["7.62x51mm"] = "ar2",
    ["7.62x31mm"] = "ar2",
    ["Frag Grenades"] = "grenade",
    ["Flash Grenades"] = "grenade",
    ["Smoke Grenades"] = "grenade",
    ["9x17MM"] = "pistol",
    ["9x19MM"] = "pistol",
    ["9x19mm"] = "pistol",
    [".45 ACP"] = "pistol",
    ["9x18MM"] = "pistol",
    ["9x39MM"] = "pistol",
    [".40 S&W"] = "pistol",
    [".44 Magnum"] = "357",
    [".50 AE"] = "357",
    ["5.45x39MM"] = "ar2",
    ["5.56x45MM"] = "ar2",
    ["5.7x28MM"] = "ar2",
    ["7.62x51MM"] = "ar2",
    ["7.62x54mmR"] = "ar2",
    ["12 Gauge"] = "buckshot",
    [".338 Lapua"] = "sniperround",
}

for k, v in pairs(ammo) do
    nut.ammo.register(v)
    nut.ammo.register(k)
end

-- Called right before the character has its information save.
function PLUGIN:CharacterPreSave(character)
    -- Get the player from the character.
    local client = character:getPlayer()

    -- Check to see if we can get the player's ammo.
    if IsValid(client) then
        local ammoTable = {}

        for k, v in ipairs(self.ammoList) do
            local ammo = client:GetAmmoCount(v)

            if ammo > 0 then
                ammoTable[v] = ammo
            end
        end

        character:setData("ammo", ammoTable)
    end
end

-- Called after the player's loadout has been set.
function PLUGIN:PlayerLoadedChar(client)
    timer.Simple(0.25, function()
        if not IsValid(client) then return end
        -- Get the saved ammo table from the character data.
        local character = client:getChar()
        if not character then return end
        local ammoTable = character:getData("ammo")

        -- Check if the ammotable is exists.
        if ammoTable then
            for k, v in pairs(ammoTable) do
                client:SetAmmo(v, tostring(k))
            end
        end
    end)
end