-------------------------------------------------------------------------------------------
function PLUGIN:SaveData()
    local data = {}

    for k, v in ipairs(ents.GetAll()) do
        if v:GetClass() == "rock_big" or v:GetClass() == "rock_medium" or v:GetClass() == "rock_small" then
            data[#data + 1] = {
                pos = v:GetPos(),
                angles = v:GetAngles(),
                class = v:GetClass(),
            }
        end
    end

    self:setData(data)
end

-------------------------------------------------------------------------------------------
function PLUGIN:LoadData()
    for k, v in ipairs(self:getData() or {}) do
        local entity = ents.Create(v.class)
        entity:SetPos(v.pos)
        entity:SetAngles(v.angles)
        entity:Spawn()
    end
end