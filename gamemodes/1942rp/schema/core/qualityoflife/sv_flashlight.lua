function SCHEMA:PlayerSwitchFlashlight(ply, on)
    if not ply:getChar() then return end

    if ply:getChar():getInv():hasItem("flashlight") then
        return true
    else
        return false
    end
end