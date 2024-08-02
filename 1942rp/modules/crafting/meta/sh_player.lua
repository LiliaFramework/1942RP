<<<<<<< HEAD

=======
--- Meta Tables for Crafting.
-- @playermeta Crafting
local playerMeta = FindMetaTable("Player")
--- Checks if the player can craft.
-- @treturn bool True if the player is alive and has a character, false otherwise.
-- @realm shared
function playerMeta:CanCraft()
    return self:Alive() and self:getChar()
end
>>>>>>> 8366d2b6b1d2328b8748e3e5ddb1a96a75c60f7e