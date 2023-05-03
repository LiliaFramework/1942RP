net.Receive("housing_npc", function()
    talkablenpcs.dialog("John Big Ox", "models/breen.mdl", "House Merchant", "Ordnungspolizei", function(ply)
        talkablenpcs.dialogframe("John Big Ox", "models/breen.mdl", "House Merchant", "Ordnungspolizei")
        talkablenpcs.dialogtext("What are you looking to do?")

        talkablenpcs.dialogbutton("Rent a House", 40, function()
            vgui.Create("house_inspect_menu_rent")
            self:Remove()
        end)

        talkablenpcs.dialogbutton("Buy a House", 40, function()
            vgui.Create("house_inspect_menu_buy")
            self:Remove()
        end)
--[[
        if LocalPlayer():IsRenting() then
            talkablenpcs.dialogbutton("Forfeit a House", 40, function()

                self:Remove()
            end)
        end

        if LocalPlayer():HasHouse() then
            talkablenpcs.dialogbutton("Sell a House", 40, function()
                self:Remove()
            end)
        end]]
    end)
end)