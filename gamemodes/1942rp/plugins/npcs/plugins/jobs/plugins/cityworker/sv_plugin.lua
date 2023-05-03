local netcalls = {"cityworker_job", "cityworker_resign", "cityworker"}

for k, v in pairs(netcalls) do
    util.AddNetworkString(v)
end

-------------------------------------------------------------------------------------------
function PLUGIN:SaveData()
    local data = {}

    for k, v in ipairs(ents.FindByClass("cityworker")) do
        data[#data + 1] = {
            pos = v:GetPos(),
            angles = v:GetAngles()
        }
    end

    self:setData(data)
end

-------------------------------------------------------------------------------------------
function PLUGIN:LoadData()
    for k, v in ipairs(self:getData() or {}) do
        local entity = ents.Create("cityworker")
        entity:SetPos(v.pos)
        entity:SetAngles(v.angles)
        entity:Spawn()
    end
end

-------------------------------------------------------------------------------------------
net.Receive("cityworker_job", function()
    local ply = net.ReadEntity()

    if ply:Team() == FACTION_CITIZEN then
        local faction = nut.faction.indices[FACTION_WORKER]
        ply:getChar().vars.faction = faction.uniqueID
        ply:getChar():setFaction(faction.index)
        ply:notify("You have been hired into Quickie Fixie.")
    else
        ply:notify("You already have a job!")
    end
end)

-------------------------------------------------------------------------------------------
net.Receive("cityworker_resign", function()
    local ply = net.ReadEntity()
    if ply:Team() ~= FACTION_WORKER then return end
    local faction = nut.faction.indices[FACTION_CITIZEN]
    ply:getChar().vars.faction = faction.uniqueID
    ply:getChar():setFaction(faction.index)
end)