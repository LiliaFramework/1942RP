local PLUGIN = PLUGIN
local color = Color(39, 174, 96)

do
    nut.bar.add(function()
        return 1 - LocalPlayer():getHungerPercent()
    end, color, nil, "hunger")
end

local hungerBar, percent, wave

function PLUGIN:Think()
    hungerBar = hungerBar or nut.bar.get("hunger")
    percent = 1 - LocalPlayer():getHungerPercent()

    -- if hunger is 33%
    if percent < .33 then
        wave = math.abs(math.sin(RealTime() * 5) * 100)
        hungerBar.lifeTime = CurTime() + 1
        hungerBar.color = Color(color.r + wave, color.g - wave, color.b - wave)
    else
        hungerBar.color = color
    end
end