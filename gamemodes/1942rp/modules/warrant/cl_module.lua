local MODULE = MODULE
function MODULE:DrawCharInfo(client, character, info)
    if client:IsWanted() then
        info[#info + 1] = {"Has Active Warrants", Color(255, 0, 0)}
    end
end