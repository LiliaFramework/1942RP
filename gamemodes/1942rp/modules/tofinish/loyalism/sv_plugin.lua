local MODULE = MODULE

function MODULE:PlayerLoadedChar(client)
    for k, v in pairs(player.GetAll()) do
        local char = v:getChar()

        if char then
            local tier = char:getData("party_tier", 0)
            char:setData("party_tier", tier, false, player.GetAll())
        end
    end
end

lia.command.add("partytier", {
    syntax = "<string name> <string number>",
    onRun = function(client, arguments)
        local char = client:getChar()
        if not char then return "You must be on a character to use this" end
        local target = lia.command.findPlayer(client, arguments[1])

        if not char:hasFlags("T") then
            client:notify("You don't have permissions for that.")

            return
        end

        if not target then
            client:notify("Invalid target.")

            return
        end

        local tChar = target:getChar()

        if tChar then
            tChar:setData("party_tier", tonumber(arguments[2]), false, player.GetAll())
            client:notify("You have updated " .. target:Name() .. "'s Party Tier " .. tonumber(arguments[2]) .. " .")

            if tonumber(arguments[2]) > 0 and tonumber(arguments[2]) <= 5 then
                target:notify("You have been set as Party Tier " .. tonumber(arguments[2]) .. " .")
            elseif tonumber(arguments[2]) == 0 then
                target:notify(client:Name() .. " has removed your Party Tier!")
            end
        end
    end
})