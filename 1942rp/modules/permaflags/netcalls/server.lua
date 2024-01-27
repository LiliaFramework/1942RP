netstream.Hook("unflagblacklistRequest", function(ply, target, bid)
    if not ply:IsAdmin() then return end
    if not IsValid(target) then
        ply:notify("That target is no longer online")
        return
    end

    local bData = target:getLiliaData("flagblacklistlog", {})[bid]
    if not bData then
        ply:notify("Blacklist ID invalid")
        return
    end

    bData = target:getLiliaData("flagblacklistlog")
    bData[bid].remove = true
    target:setLiliaData("flagblacklistlog", bData)
    target:saveLiliaData()
    ply:notify("Target blacklist has been flagged for deactivation. It may take up to 10 seconds.")
end)