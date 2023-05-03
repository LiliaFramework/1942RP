local PLUGIN = PLUGIN

------------------------------------------------------------------------------------------
function PLUGIN:InitializedPlugins()
    for k, v in ipairs(ents.GetAll()) do
        for a, variable in pairs(self.AvailableHouses) do
            if v:IsValid() and v:GetName() == variable.door1 or v:GetName() == variable.door2 or v:GetName() == variable.door3 or v:GetName() == variable.door4 or v:GetName() == variable.door5 then
                v:Fire("lock", "", .1)
            end
        end
    end
end