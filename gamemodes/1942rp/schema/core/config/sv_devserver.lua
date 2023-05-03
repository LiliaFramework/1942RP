DevServer = DevServer or {}
DevServer.IP = "" -- DEV SERVER IP 
DevServer.Port = "" -- DEV SERVER PORT 

--[[
This allows you to make reduced cooldowns or certain scenarios only happen on the Dev server. Example:

function SCHEMA:PlayerSpawn(ply)
    if not ply:getChar() then return end -- If the character isn't loaded, the function won't run

    -- will load after the default spawn
    timer.Simple(0.5, function()
        -- if it detects it is the Dev Server, the HP will be set to 69420 
        if DEV then
            ply:SetMaxHealth(69420)
            ply:SetHealth(69420)
        end
    end)
end
--]]