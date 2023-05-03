local PLUGIN = PLUGIN

function PLUGIN:DrawCharInfo(client, character, info)
    if client:IsWanted() then
        info[#info + 1] = {"Warrant Active", Color(255, 0, 0)}
    end
end

nut.command.add("warrant", {
    onRun = function(client, arguments) end
})