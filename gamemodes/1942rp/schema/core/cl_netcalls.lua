-------------------------------------------------------------------------------------------------------------------------
net.Receive("announcement_client", function()
    local message = net.ReadString()
    chat.AddText(Color(255, 56, 252), "[Admin Announcement]: ", Color(255, 255, 255), message)
end)

-------------------------------------------------------------------------------------------------------------------------
net.Receive("advert_client", function()
    local nick = net.ReadString()
    local message = net.ReadString()
    chat.AddText(Color(216, 190, 18), "[Advertisement by " .. nick .. "]: ", Color(255, 255, 255), message)
end)

-------------------------------------------------------------------------------------------------------------------------
net.Receive("OpenInvMenu", function()
    local target = net.ReadEntity()
    local index = net.ReadType()
    local targetInv = lia.inventory.instances[index]
    local myInv = LocalPlayer():getChar():getInv()
    local inventoryDerma = targetInv:show()
    inventoryDerma:SetTitle(target:getChar():getName() .. "'s Inventory")
    inventoryDerma:MakePopup()
    inventoryDerma:ShowCloseButton(true)
    local myInventoryDerma = myInv:show()
    myInventoryDerma:MakePopup()
    myInventoryDerma:ShowCloseButton(true)
    myInventoryDerma:SetParent(inventoryDerma)
    myInventoryDerma:MoveLeftOf(inventoryDerma, 4)
end)

-------------------------------------------------------------------------------------------------------------------------
netstream.Hook("adminClearChat", function()
    local chat = lia.plugin.list["chatbox"]

    if chat and IsValid(chat.panel) then
        chat.panel:Remove()
        chat:createChat()
    else
        LocalPlayer():ConCommand("fixchatplz")
    end
end)