GM = GM or GAMEMODE

-- DEFINE THE DEVELOPMENT SERVER IP SETTINGS ON THE CONFIG FOLDER
function GM:Initialize()
    local ip, port = game.GetIPAddress():match("([^:]+):(%d+)")

    -- Check if the IP address and port match the target server
    if ip == DevServer.IP and port == DevServer.Port then
        DEV = true
    else
        DEV = false
    end

    if DEV then
        for i = 1, 5 do
            print("DEV is present!")
        end
    else
        for i = 1, 5 do
            print("DEDI is present!")
        end
    end
end