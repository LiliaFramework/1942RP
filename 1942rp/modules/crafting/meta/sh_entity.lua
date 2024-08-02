<<<<<<< HEAD
=======
--- Meta Tables for Crafting.
-- @entitymeta Crafting
local entityMeta = FindMetaTable("Entity")
if SERVER then
    --- Locks or unlocks a crafting table.
    -- @bool locked Whether the table should be locked or unlocked.
    -- @treturn bool True if the operation was successful, false otherwise.
    -- @realm server
    function entityMeta:LockTable(locked)
        assert(isbool(locked), "Expected bool, got " .. type(locked))
        if self:IsValid() and self.IsCraftingTable then
            self:setNetVar("table_locked", locked)
            return true
        end
        return false
    end
end
>>>>>>> 8366d2b6b1d2328b8748e3e5ddb1a96a75c60f7e
