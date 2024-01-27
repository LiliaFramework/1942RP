lia.command.add("permflaggive", {
    adminOnly = true,
    privilege = "Give Permanent Flags",
    syntax = "<string name> [string flags]",
    onRun = function(client, arguments) end
})

lia.command.add("permflagtake", {
    adminOnly = true,
    privilege = "Take Permanent Flags",
    syntax = "<string name> [string flags]",
    onRun = function(client, arguments) end
})

lia.command.add("permflags", {
    adminOnly = true,
    privilege = "List Permanent Flags",
    syntax = "<string name>",
    onRun = function(client, arguments) end
})

lia.command.add("flagblacklist", {
    adminOnly = true,
    privilege = "Blacklist Flags",
    syntax = "<string name> <string flags> <number minutes> <string reason>",
    onRun = function(client, arguments) end
})

lia.command.add("flagunblacklist", {
    adminOnly = true,
    privilege = "UnBlacklist Flags",
    syntax = "<string name> [string flags]",
    onRun = function(client, arguments) end
})

lia.command.add("flagblacklists", {
    adminOnly = true,
    privilege = "List Blacklisted Flags",
    syntax = "<string name>",
    onRun = function(client, arguments) end
})