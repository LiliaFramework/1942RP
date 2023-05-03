PLUGIN.name = "Admin Spawn Menu"
PLUGIN.author = "Leonheart#7476"
PLUGIN.desc = "Allow admins to easily spawn items."
nut.util.include("sv_plugin.lua")
nut.util.include("cl_plugin.lua")

local owner2 = {
    root = true,
    communitymanager = true,
    superadmin = true,
    headadmin = true,
    headgm = true
}

nut.command.add("adminspawnmenu", {
    onRun = function(client, arguments)
        local uniqueID = client:GetUserGroup()

        if not owner2[uniqueID] then
            client:notify("Your rank is not high enough to use this command.")

            return false
        end

        net.Start("NutscriptResetVariablesNew")
        net.Send(client)
    end
})