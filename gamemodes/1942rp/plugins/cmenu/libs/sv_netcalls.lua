local netcalls = {"cmenu", "liaApproveSearch", "liaRequestSearch", "blindfold", "gag_player", "vehicle_usage", "cmenu_tying", "Dragging::Update", "FF", "moneyprompt", "liaRequestID", "liaApproveID"}

for k, v in pairs(netcalls) do
    util.AddNetworkString(v)
end

net.Receive("cmenu_tying", function()
    local entity = net.ReadEntity()
    netstream.Start(entity, "startcmeliaying")
end)

net.Receive("cmenu", function()
    local entity = net.ReadEntity()
    netstream.Start(entity, "startcmenu")
end)