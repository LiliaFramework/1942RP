local PLUGIN = PLUGIN

nut.command.add("viewnotes", {
    onRun = function(client, arguments)
        PLUGIN:openNotes(client, client, false)
    end
})

nut.command.add("adminnotes", {
    adminOnly = true,
    syntax = "<string target>",
    onRun = function(client, arguments)
        local target = nut.command.findPlayer(client, arguments[1])

        if target then
            PLUGIN:openNotes(client, target, true)
        end
    end
})