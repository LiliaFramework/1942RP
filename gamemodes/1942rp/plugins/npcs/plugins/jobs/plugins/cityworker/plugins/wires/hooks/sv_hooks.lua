function PLUGIN:LoadData()
    local savedTable = self:getData() or {}

    for k, v in ipairs(savedTable) do
        local cPlayer = ents.Create(v.class)
        cPlayer:SetPos(v.pos)
        cPlayer:SetAngles(v.ang)
        cPlayer:Spawn()
        cPlayer:Activate()
    end
end

function PLUGIN:SaveData()
    local savedTable = {}

    for k, v in ipairs(ents.GetAll()) do
        if v:IsFixable() then
            table.insert(savedTable, {
                class = v:GetClass(),
                pos = v:GetPos(),
                ang = v:GetAngles()
            })
        end
    end

    self:setData(savedTable)
end