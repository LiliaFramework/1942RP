util.AddNetworkString("NutscriptResetVariablesNew")
util.AddNetworkString("NutscriptResetVariables2")
util.AddNetworkString("SpawnMenuWarn")

local owner2 = {
    root = true,
    communitymanager = true,
    superadmin = true,
    headadmin = true,
    headgm = true
}

net.Receive("NutscriptResetVariables2", function(len, client)
    local uniqueID = client:GetUserGroup()

    if not owner2[uniqueID] then
        client:notify("Your rank is not high enough to use this command.")

        return false
    end

    local name = net.ReadString()

    for k, v in pairs(nut.item.list) do
        if v.name == name then
            nut.item.spawn(v.uniqueID, client:getItemDropPos())
            nut.log.add(client:getChar():getName(), "has spawned ", v.name)
        end
    end
end)