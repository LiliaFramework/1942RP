local owner2 = {
    root = true,
    communitymanager = true,
    superadmin = true,
}

nut.command.add("warrant", {
    onRun = function(client, arguments)
        local target = nut.command.findPlayer(client, arguments[1])
        local uniqueID = client:GetUserGroup()

        if not (client:getChar():hasFlags("W") or owner2[uniqueID]) then
            client:notify("No permissions to run this command!")

            return
        end

        if IsValid(target) and target:getChar() then
            if target:IsWanted() then
                target:SetWanted()
                client:notify("You Removed This Person's Wanted State!")
            else
                target:SetWanted()
                client:notify("You Set This Person's as Wanted!")
            end
        end
    end
})

local playerMeta = FindMetaTable("Player")

function playerMeta:SetWanted()
    if self:IsWanted() then
        self:setNetVar("wanted", false)
    else
        self:setNetVar("wanted", true)
    end
end