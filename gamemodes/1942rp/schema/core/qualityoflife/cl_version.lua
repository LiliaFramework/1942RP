function SCHEMA:HUDPaint()
    local w, h = 45, 45
    surface.SetFont("liaSmallChatFont")
    local tw, th = surface.GetTextSize("BETA 3.0")
    surface.SetTextPos(5, ScrH() - 20, w, h)
    surface.DrawText("Server Current Version: " .. SCHEMA.version)
end