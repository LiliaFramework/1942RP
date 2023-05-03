net.Receive("sendURL", function()
    local url = net.ReadString()
    gui.OpenURL(url)
end)