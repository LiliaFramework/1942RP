--------------------------------------------------------------------------------------------------------
function WatermarkCore:HUDPaint()
    local w, h = 64, 64
    surface.SetMaterial(Material("ares.png"))
    surface.SetDrawColor(255, 255, 255, 80)
    surface.DrawTexturedRect(5, ScrH() - h - 5, w, h)
    surface.SetTextColor(255, 255, 255, 80)
    surface.SetFont("WB_Large")
    local tw, th = surface.GetTextSize(self.CommunityName)
    surface.SetTextPos(15 + w, ScrH() - 15 - h / 2 - th / 2)
    surface.DrawText(self.CommunityName)
    surface.SetFont("WB_Medium")
    surface.SetTextPos(15 + w, ScrH() - 25 - h / 2 + th / 2)
    surface.DrawText(self.WelcomeText)
end
--------------------------------------------------------------------------------------------------------
