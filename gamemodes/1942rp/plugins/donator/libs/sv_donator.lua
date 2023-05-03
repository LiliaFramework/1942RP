local plyMeta = FindMetaTable("Player")
local PLUGIN = PLUGIN

PLUGIN.overrideCharLimit = {
    ["root"] = 10,
    ["superadmin"] = 10,
    ["communitymanager"] = 10,
    ["headadmin"] = 3,
    ["headgm"] = 3,
    ["senioradmin"] = 3,
    ["admin"] = 3,
    ["moderator"] = 3,
    ["trusted"] = 3,
    ["vip"] = 3,
}

PLUGIN.Ranks = {
    root = true,
    superadmin = true,
    communitymanager = true
}

-----------------------------------------------------------------------------------------------------------------
function PLUGIN:GetMaxPlayerCharacter(ply)
    local rank = ply:GetNWString("usergroup", nil)
    local defchars = nut.config.get("maxChars", 2)
    local addSlots = ply:getNutData("CharacterSlots", 0)
    if not rank then return defchars end

    for group, slots in pairs(self.overrideCharLimit) do
        if rank == group then return slots + addSlots end
    end

    ply:ChatPrint("Char Amount: " .. defchars + addSlots)

    return defchars + addSlots
end

-----------------------------------------------------------------------------------------------------------------
hook.Add("getOOCDelay", "checkForDonator", function(ply)
    if ply:GetUserGroup() ~= "user" then return 1 end
end)

-----------------------------------------------------------------------------------------------------------------
function plyMeta:SetAdditionalCharSlots(val)
    self:setNutData("CharacterSlots", val)
    self:saveNutData()
end

-----------------------------------------------------------------------------------------------------------------
function plyMeta:GiveAdditionalCharSlots(AddValue)
    AddValue = math.max(0, AddValue or 1)
    self:SetAdditionalCharSlots(self:GetAdditionalCharSlots() + AddValue)
end

-----------------------------------------------------------------------------------------------------------------
function plyMeta:TakeAdditionalCharSlots(TakeValue)
    TakeValue = math.max(0, TakeValue or 1)
    self:SetAdditionalCharSlots(self:GetAdditionalCharSlots() - TakeValue)
end

-----------------------------------------------------------------------------------------------------------------
function plyMeta:GetAdditionalCharSlots()
    return self:getNutData("CharacterSlots", 0)
end

-----------------------------------------------------------------------------------------------------------------
nut.command.add("addcharslot", {
    onRun = function(client, arguments)
        local uniqueID = client:GetUserGroup()
        local target = nut.command.findPlayer(client, arguments[1])

        if not PLUGIN.Ranks[uniqueID] then
            client:notify("Your rank is not high enough to use this command.")

            return false
        end

        target:GiveAdditionalCharSlots(arguments[2])
        client:notify("You gave " .. target:Nick() .. arguments[2] .. " slots! They now have " .. target:GetAdditionalCharSlots())
        target:notify("An admin gave you CharSlots! You now have " .. target:GetAdditionalCharSlots())
    end
})

-----------------------------------------------------------------------------------------------------------------
nut.command.add("removecharslot", {
    onRun = function(client, arguments)
        local uniqueID = client:GetUserGroup()
        local target = nut.command.findPlayer(client, arguments[1])

        if not PLUGIN.Ranks[uniqueID] then
            client:notify("Your rank is not high enough to use this command.")

            return false
        end

        if (target:GetAdditionalCharSlots() - arguments[2]) <= 0 then
            client:notify("You gave an invalid value! Their Slots have been resetted to 0!")
            target:notify("An admin took CharSlots from you. You now have " .. target:GetAdditionalCharSlots())
            target:SetAdditionalCharSlots(0)
        else
            client:notify("You took " .. target:Nick() .. arguments[2] .. " slots! They now have " .. target:GetAdditionalCharSlots())
            target:notify("An admin took CharSlots from you. You now have " .. target:GetAdditionalCharSlots())
            target:TakeAdditionalCharSlots(arguments[2])
        end
    end
})
-----------------------------------------------------------------------------------------------------------------