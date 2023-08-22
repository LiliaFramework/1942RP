--------------------------------------------------------------------------------------------------------
netstream.Hook("lia_charNoteSave", function(client, charID, notes)
    local path = "lilia/" .. SCHEMA.folder .. "/charnotes/" .. charID .. ".txt"
    file.Write(path, notes)
end)
--------------------------------------------------------------------------------------------------------
netstream.Hook("lia_charNoteSaveI", function(client, charID, notes)
    local path = "lilia/" .. SCHEMA.folder .. "/charnotes/" .. charID .. "I.txt"
    file.Write(path, notes)
end)
--------------------------------------------------------------------------------------------------------
netstream.Hook("lia_charNoteSaveE", function(client, charID, notes)
    local path = "lilia/" .. SCHEMA.folder .. "/charnotes/" .. charID .. "E.txt"
    file.Write(path, notes)
end)
--------------------------------------------------------------------------------------------------------