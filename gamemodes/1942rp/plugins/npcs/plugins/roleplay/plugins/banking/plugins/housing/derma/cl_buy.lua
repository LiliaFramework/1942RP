local PLUGIN = PLUGIN
local PANEL = {}

function PANEL:Init()
    local housingmenu = vgui.Create("DFrame")
    housingmenu:SetSize(665 * .5, 357 * .5)
    housingmenu:Center()
    housingmenu:SetTitle("")
    housingmenu:MakePopup()
    housingmenu:SetDraggable(false)
    housingmenu:ShowCloseButton(true)
    local house_picker = vgui.Create("DComboBox", housingmenu)
    house_picker:SetSize(100, 20)
    house_picker:SetPos(110, 60)
    house_picker:SetValue("No house picked!")

    for _, v in pairs(PLUGIN.AvailableHouses) do
        house_picker:AddChoice(v.name)
    end

    local pickbutton = vgui.Create("DButton", housingmenu)
    pickbutton:SetSize(239 * .5, 64 * .5)
    pickbutton:SetPos(100, 90)
    pickbutton:SetText("Inspect House")

    function pickbutton:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
    end

    pickbutton.DoClick = function()
        for _, v in pairs(PLUGIN.AvailableHouses) do
            if v.name == house_picker:GetValue() then
                house_picker:SetValue(v.id)
            end
        end
    end
end

vgui.Register("house_inspect_menu_buy", PANEL, "DFrame")