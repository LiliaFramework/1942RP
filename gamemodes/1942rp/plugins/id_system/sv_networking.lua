--Network stuff
netstream.Hook("showIDToPlayer", function(ply, target)
    netstream.Start(ply, "openUpID")
end)

netstream.Hook("setCharCharacteristics", function(ply, vals, setOnChar)
    if setOnChar then
        ply:getChar():setData("charCharacteristics", vals)
    elseif setOnChar == nil or not setOnChar then
        ply:setNetVar("characsToBeSet", vals)
    end
end)

resource.AddFile("materials/documents/cover.png")
resource.AddFile("materials/documents/infos.jpg")

--Checks if the player has all the infos
hook.Add("PlayerLoadedChar", "checkForMissingInfo", function(ply, char)
    if not char:getData("charCharacteristics", nil) and not ply:getNetVar("characsToBeSet") then
        print("missing data")
        netstream.Start(ply, "missingCharacteristics")
    elseif ply:getNetVar("characsToBeSet") and not char:getData("charCharacteristics", nil) then
        print("Setting characters' data")
        char:setData("charCharacteristics", ply:getNetVar("characsToBeSet", {}))
        ply:setNetVar("characsToBeSet", nil)
    else
        local hasAllInfos = false
        local corruptDataMessage = "There has been an update with the papers plugin therefor you need to update some of your information."
        local data = char:getData("charCharacteristics", nil)

        for k, v in pairs(data) do
            local keyExists = false

            for k2, v2 in pairs(charCharacteristics) do
                if k == k2 then
                    keyExists = true
                end
            end

            if not keyExists then
                netstream.Start(ply, "missingCharacteristics", corruptDataMessage, true)
                break
            end
        end

        if table.Count(data) ~= table.Count(charCharacteristics) then
            netstream.Start(ply, "missingCharacteristics", corruptDataMessage, true)
        end
    end
end)

netstream.Hook("getPlayerCharacs", function(ply, target)
    local data = target:getChar():getData("charCharacteristics", {})
    netstream.Start(ply, "returnPlayerCharacs", data)
end)

concommand.Add("rebuildInfo", function(ply)
    local char = ply:getChar()
    local hasAllInfos = false
    local corruptDataMessage = "There has been an update with the papers plugin therefor you need to update some of your information."
    local data = char:getData("charCharacteristics", nil)

    for k, v in pairs(data) do
        local keyExists = false

        for k2, v2 in pairs(charCharacteristics) do
            if k == k2 then
                keyExists = true
            end
        end

        print(k, keyExists)

        if not keyExists then
            netstream.Start(ply, "missingCharacteristics", corruptDataMessage, true)
            break
        end
    end

    if table.Count(data) ~= table.Count(charCharacteristics) then
        netstream.Start(ply, "missingCharacteristics", corruptDataMessage, true)
    end
end)