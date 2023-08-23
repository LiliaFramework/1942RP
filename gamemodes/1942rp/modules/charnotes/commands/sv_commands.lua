--------------------------------------------------------------------------------------------------------
local MODULE = MODULE
--------------------------------------------------------------------------------------------------------
lia.command.add(
    "viewnotes",
    {
        adminOnly = false,
        privilege = "Basic User Permissions",
        onRun = function(client, arguments)
            MODULE:openNotes(client, client, false)
        end
    }
)

--------------------------------------------------------------------------------------------------------
lia.command.add(
    "adminnotes",
    {
        adminOnly = true,
        privilege = "Characters - View Notse",
        syntax = "<string target>",
        onRun = function(client, arguments)
            local target = lia.command.findPlayer(client, arguments[1])
            if target then
                MODULE:openNotes(client, target, true)
            end
        end
    }
)
--------------------------------------------------------------------------------------------------------