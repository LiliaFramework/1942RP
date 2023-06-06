function SCHEMA:OnCharCreated(client, character)
    local faction = lia.faction.get(character:getFaction())

    if faction and faction.Items then
        for _, v in pairs(faction.Items) do
            character:getInv():add(v, 1)
        end
    end
end