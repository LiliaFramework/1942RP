util.AddNetworkString("nutTypeStatus")

net.Receive("nutTypeStatus", function(_, client)
    client:setNetVar("typing", net.ReadBool())
end)