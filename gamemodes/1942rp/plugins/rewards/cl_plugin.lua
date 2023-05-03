net.Receive("sgrMenuCheck", function()
    local group = nut.config.get("sgrGroupName")

    if group ~= "" then
        gui.OpenURL("https://steamcommunity.com/groups/" .. group)
    end
end)

-------------------------------------------------------------------------------------------------------------------------
nut.command.add("group", {
    onRun = function(client, arguments) end
})

-------------------------------------------------------------------------------------------------------------------------
nut.command.add("claim", {
    onRun = function(client, arguments) end
})