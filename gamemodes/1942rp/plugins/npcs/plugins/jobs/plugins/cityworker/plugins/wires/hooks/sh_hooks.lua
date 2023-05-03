local entityMeta = FindMetaTable("Entity")

function entityMeta:IsFixable()
    local class = self:GetClass()

    return class == "wires"
end