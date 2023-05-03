-- @module lia.item
-- @moduleCommentStart
-- Library functions for items.
-- @moduleCommentEnd

lia.item = lia.item or {}
lia.item.list = lia.item.list or {}
lia.item.base = lia.item.base or {}
lia.item.instances = lia.item.instances or {}
lia.item.inventories = lia.item.inventories or {
	[0] = {}
}
lia.item.inventoryTypes = lia.item.inventoryTypes or {}

lia.util.include("lilia/gamemode/core/meta/sh_item.lua")

-- @type function lia.item.get(identifier)
-- @typeCommentStart
-- Retrieves an item table.
-- @typeCommentEnd
-- @realm shared
-- @string identifier Unique ID of the item
-- @treturn item Item table
-- @usageStart
-- print(lia.item.get("example"))
-- "item[example][0]"
-- @usageEnd
function lia.item.get(identifier)
	return lia.item.base[identifier] or lia.item.list[identifier]
end

-- @type function lia.item.load(identifier)
-- @typeCommentStart
-- Loads item from file.
-- @typeCommentEnd
-- @realm shared
-- @internal
-- @string path Path of the item file
-- @string baseID Unique ID of the item's base
-- @bool isBaseItem Whether the item is a base item
-- @usageStart
-- lia.item.load("sh_guacamole.lua", "foodstuff", false")
-- @usageEnd
function lia.item.load(path, baseID, isBaseItem)
	local uniqueID = path:match("sh_([_%w]+)%.lua")

	if (uniqueID) then
		uniqueID = (isBaseItem and "base_" or "")..uniqueID
		lia.item.register(uniqueID, baseID, isBaseItem, path)
	elseif (not path:find(".txt")) then
		ErrorNoHalt(
			"[Lilia] Item at '"..path.."' follows invalid "..
			"naming convention!\n"
		)
	end
end

-- @type function lia.item.isItem(object)
-- @typeCommentStart
-- Returns whether input is an item object or not.
-- @typeCommentEnd
-- @realm shared
-- @table object Object to check
-- @usageStart
-- lia.item.isItem(lia.item.instances[1])
-- "true"
-- @usageEnd
function lia.item.isItem(object)
	return istable(object) and object.isItem == true
end

-- @type function lia.item.register(uniqueID, baseID, isBaseItem, path, luaGenerated)
-- @typeCommentStart
-- Registers an item with a given uniqueID.
-- @typeCommentEnd
-- @realm shared
-- @internal
-- @string uniqueID Unique ID of the item
-- @string baseID Unique ID of the item's base
-- @bool isBaseItem Whether the item is a base item
-- @string path Path of the item file
-- @bool luaGenerated Whether the item is generated by Lua
-- @usageStart
-- lia.item.register("example", "base_food", false, "sh_example.lua", false)
-- @usageEnd
function lia.item.register(uniqueID, baseID, isBaseItem, path, luaGenerated)
	assert(isstring(uniqueID), "uniqueID must be a string")

	local baseTable = lia.item.base[baseID] or lia.meta.item
	if (baseID) then
		assert(baseTable, "Item "..uniqueID.." has a non-existent base "..baseID)
	end
	local targetTable = (isBaseItem and lia.item.base or lia.item.list)

	if luaGenerated then
		ITEM = setmetatable({
			hooks = table.Copy(baseTable.hooks or {}),
			postHooks = table.Copy(baseTable.postHooks or {}),
			BaseClass = baseTable,
			__tostring = baseTable.__tostring,
		}, {
			__eq = baseTable.__eq,
			__tostring = baseTable.__tostring,
			__index = baseTable
		})

		ITEM.__tostring = baseTable.__tostring
		ITEM.desc = "noDesc"
		ITEM.uniqueID = uniqueID
		ITEM.base = baseID
		ITEM.isBase = isBaseItem
		ITEM.category = ITEM.category or "misc"
		ITEM.functions = ITEM.functions or table.Copy(
			baseTable.functions or LIA_ITEM_DEFAULT_FUNCTIONS
		)
	else
		ITEM = targetTable[uniqueID] or setmetatable({
			hooks = table.Copy(baseTable.hooks or {}),
			postHooks = table.Copy(baseTable.postHooks or {}),
			BaseClass = baseTable,
			__tostring = baseTable.__tostring,
		}, {
			__eq = baseTable.__eq,
			__tostring = baseTable.__tostring,
			__index = baseTable
		})

		ITEM.__tostring = baseTable.__tostring
		ITEM.desc = "noDesc"
		ITEM.uniqueID = uniqueID
		ITEM.base = baseID
		ITEM.isBase = isBaseItem
		ITEM.category = ITEM.category or "misc"
		ITEM.functions = ITEM.functions or table.Copy(
			baseTable.functions or LIA_ITEM_DEFAULT_FUNCTIONS
		)
	end

	if (not luaGenerated and path) then
		lia.util.include(path)
	end

	ITEM:onRegistered()

	local itemType = ITEM.uniqueID
	targetTable[itemType] = ITEM
	ITEM = nil

	return targetTable[itemType]
end


-- @type function lia.item.loadFromDir(directory)
-- @typeCommentStart
-- Loads items from a directory.
-- @typeCommentEnd
-- @realm shared
-- @string directory Directory to load items from
-- @usageStart
-- lia.item.loadFromDir("items")
-- @usageEnd

function lia.item.loadFromDir(directory)
	local files, folders

	files = file.Find(directory.."/base/*.lua", "LUA")

	for _, v in ipairs(files) do
		lia.item.load(directory.."/base/"..v, nil, true)
	end

	files, folders = file.Find(directory.."/*", "LUA")

	for _, v in ipairs(folders) do
		if (v == "base") then
			continue
		end

		for _, v2 in ipairs(file.Find(directory.."/"..v.."/*.lua", "LUA")) do
			lia.item.load(directory.."/"..v .. "/".. v2, "base_"..v)
		end
	end

	for _, v in ipairs(files) do
		lia.item.load(directory.."/"..v)
	end
end

-- @type function lia.item.new(uniqueID, id)
-- @typeCommentStart
-- Creates a new item object.
-- @typeCommentEnd
-- @realm shared
-- @string uniqueID Unique ID of the item
-- @number id ID of the item
-- @usageStart
-- local item = lia.item.new("example", 15)
-- @usageEnd
function lia.item.new(uniqueID, id)

	id = id and tonumber(id) or id
	assert(isnumber(id), "non-number ID given to lia.item.new")

	if (
		lia.item.instances[id] and
		lia.item.instances[id].uniqueID == uniqueID
	) then
		return lia.item.instances[id]
	end

	local stockItem = lia.item.list[uniqueID]

	if (stockItem) then
		local item = setmetatable({
			id = id,
			data = {}
		}, {
			__eq = stockItem.__eq,
			__tostring = stockItem.__tostring,
			__index = stockItem
		})

		lia.item.instances[id] = item

		return item
	else
		error(
			"[Lilia] Attempt to create unknown item '"
			..tostring(uniqueID).."'\n"
		)
	end
end

lia.char.registerVar("inv", {
	noNetworking = true,
	noDisplay = true,
	onGet = function(character, index)
		if (index and type(index) ~= "number") then
			return character.vars.inv or {}
		end

		return character.vars.inv and character.vars.inv[index or 1]
	end,
	onSync = function(character, recipient)
		net.Start("liaCharacterInvList")
			net.WriteUInt(character:getID(), 32)
			net.WriteUInt(#character.vars.inv, 32)

			for i = 1, #character.vars.inv do
				net.WriteType(character.vars.inv[i].id)
			end
		if (recipient == nil) then
			net.Broadcast()
		else
			net.Send(recipient)
		end
	end
})

lia.util.include("item/sv_item.lua")
lia.util.include("item/sh_item_functions.lua")
lia.util.include("item/sv_networking.lua")
lia.util.include("item/cl_networking.lua")