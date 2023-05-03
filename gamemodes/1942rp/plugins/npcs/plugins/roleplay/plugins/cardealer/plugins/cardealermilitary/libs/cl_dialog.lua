local PLUGIN = PLUGIN

net.Receive("car_dealer", function()
    local client = LocalPlayer()
    local entity = net.ReadEntity()

    talkablenpcs.dialog("Killian Roth", "models/player/suits/male_09_shirt.mdl", "Car Dealer", "Dolfie Hittie Cars", function(ply)
        talkablenpcs.dialogframe("Killian Roth", "models/player/suits/male_09_shirt.mdl", "Car Dealer", "Dolfie Hittie Cars")
        talkablenpcs.dialogtext("What are you looking to do?")

        talkablenpcs.dialogbutton("Buy a Car", 40, function()
            if entity.faction and entity.faction > 0 and not client:IsAdmin() then
                if client:Team() ~= entity.faction then
                    client:notify("You are not allowed to access this NPC", NOT_ERROR)

                    return
                end
            end

            net.Start("carvendoropenaction")
            net.WriteEntity(client)
            net.WriteEntity(entity)
            net.SendToServer()
            self:Remove()
        end)

        talkablenpcs.dialogbutton("Retrieve Car", 40, function()
            net.Start("carvendorretrieveaction")
            net.WriteEntity(client)
            net.WriteEntity(entity)
            net.SendToServer()
            self:Remove()
        end)
    end)
end)

net.Receive("car_dealer_ss", function()
    local client = LocalPlayer()
    local entity = net.ReadEntity()

    talkablenpcs.dialog("Fritz Jäger", "models/brot/prometheus/ss/baseline/en4.mdl", "Internal Security Car Vendor", "Internal Security", function(ply)
        talkablenpcs.dialogframe("Fritz Jäger", "models/brot/prometheus/ss/baseline/en4.mdl", "Internal Security Car Vendor", "Internal Security")
        talkablenpcs.dialogtext("What are you looking to do?")

        talkablenpcs.dialogbutton("Buy a Car", 40, function()
            if entity.faction and entity.faction > 0 and not client:IsAdmin() then
                if client:Team() ~= entity.faction then
                    client:notify("You are not allowed to access this NPC", NOT_ERROR)

                    return
                end
            end

            net.Start("carvendoropenaction")
            net.WriteEntity(client)
            net.WriteEntity(entity)
            net.SendToServer()
            self:Remove()
        end)

        talkablenpcs.dialogbutton("Retrieve Car", 40, function()
            net.Start("carvendorretrieveaction")
            net.WriteEntity(client)
            net.WriteEntity(entity)
            net.SendToServer()
            self:Remove()
        end)
    end)
end)

net.Receive("car_dealer_wehrkreis", function()
    local client = LocalPlayer()
    local entity = net.ReadEntity()

    talkablenpcs.dialog("Georg Schäfer", "models/brot/prometheus/heer/wehrkreisiii/en6.mdl", "Military Car Vendor", "German Military", function(ply)
        talkablenpcs.dialogframe("Georg Schäfer", "models/brot/prometheus/heer/wehrkreisiii/en6.mdl", "Military Car Vendor", "German Military")
        talkablenpcs.dialogtext("What are you looking to do?")

        talkablenpcs.dialogbutton("Buy a Car", 40, function()
            if entity.faction and entity.faction > 0 and not client:IsAdmin() then
                if client:Team() ~= entity.faction then
                    client:notify("You are not allowed to access this NPC", NOT_ERROR)

                    return
                end
            end

            net.Start("carvendoropenaction")
            net.WriteEntity(client)
            net.WriteEntity(entity)
            net.SendToServer()
            self:Remove()
        end)

        talkablenpcs.dialogbutton("Retrieve Car", 40, function()
            net.Start("carvendorretrieveaction")
            net.WriteEntity(client)
            net.WriteEntity(entity)
            net.SendToServer()
            self:Remove()
        end)
    end)
end)