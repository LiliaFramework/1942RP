--------------------------------------------------------------------------------------------------------
function MODULE:DrawCharInfo(client, character, info)
    local PoliceMan = LocalPlayer():Team() == self.PoliceFaction
    if client:IsWanted() then
        if self.OnlyPoliceSeeWarranted then
            if PoliceMan then
                info[#info + 1] = {"Has Active Warrants", Color(255, 0, 0)}
            end
        else
            info[#info + 1] = {"Has Active Warrants", Color(255, 0, 0)}
        end
    end
end
--------------------------------------------------------------------------------------------------------