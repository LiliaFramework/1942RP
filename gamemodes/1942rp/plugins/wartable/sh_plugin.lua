local PLUGIN = PLUGIN
PLUGIN.name = "War Table"
PLUGIN.author = "Zoephix"
PLUGIN.desc = "Adds a interactive War Table"
PLUGIN.camMoveSpeed = 5

PLUGIN.allowedImageTypes = {".PNG", ".JPG", ".JPEG"}

nut.util.include("sv_plugin.lua")

if CLIENT then
    netstream.Hook("UseWarTable", function(tableEnt, shouldAct)
        local ply = LocalPlayer()

        if shouldAct then
            local panel = vgui.Create("DFrame")
            panel:SetTitle("")
            panel:SetSize(ScrW() / 4, 100)
            panel:SetDraggable(false)
            panel:ShowCloseButton(false)
            panel:MakePopup()
            panel:SetPos(ScrW() * 0.5 - (panel:GetWide() / 2), ScrH() - panel:GetTall() * 1.25)

            panel.Paint = function(this, w, h)
                draw.RoundedBox(5, 0, h * 0.25, w, h * 0.75, Color(0, 0, 0, 150))
            end

            local clearButton = vgui.Create("DButton", panel)
            clearButton:Dock(TOP)
            clearButton:SetText("Clear out table")
            clearButton:SetTextColor(Color(255, 255, 255))

            clearButton.DoClick = function()
                panel:Remove()
                netstream.Start("ClearWarTable", tableEnt)
            end

            local setMapButton = vgui.Create("DButton", panel)
            setMapButton:Dock(TOP)
            setMapButton:SetText("Set new map")
            setMapButton:SetTextColor(Color(255, 255, 255))

            setMapButton.DoClick = function()
                panel:Remove()

                Derma_StringRequest("Set new map", "Input the link to set a new map", "", function(text)
                    netstream.Start("SetWarTableMap", tableEnt, text)
                end)
            end

            local exitButton = vgui.Create("DButton", panel)
            exitButton:Dock(TOP)
            exitButton:SetText("Exit")
            exitButton:SetTextColor(Color(255, 255, 255))

            exitButton.DoClick = function()
                panel:Remove()
            end
        else
            ply.LastPos = ply:GetPos()
            ply.LastAng = ply:EyeAngles()
            ply.tableEnt = tableEnt
            ply.UseWarTable = not ply.UseWarTable

            if not ply.UseWarTable and IsValid(ply.MarkerModel) then
                ply.MarkerModel:Remove()
            end
        end
    end)

    netstream.Hook("SetWarTableMap", function(tableEnt, text)
        tableEnt:SetMap(text)
    end)

    function PLUGIN:Think()
        if not LocalPlayer().UseWarTable then return end
        local ply = LocalPlayer()
        local tableEnt = ply.tableEnt

        if not IsValid(tableEnt) then
            ply.UseWarTable = false

            if IsValid(ply.MarkerModel) then
                ply.MarkerModel:Remove()
            end

            return
        end

        if not IsValid(ply.MarkerModel) then
            ply.MarkerModel = ClientsideModel("models/william/war_marker/war_marker.mdl")
            ply.MarkerModel:SetPos(tableEnt:GetPos())
            ply.MarkerModel:Spawn()
        end

        local tr = util.TraceLine({
            start = ply:EyePos(),
            endpos = ply:GetAngles():Forward() * 100000,
            filter = function(ent)
                if IsValid(ent) and not ent:IsPlayer() then return true end
            end
        })

        if not ply.MarkerModel.LastPos then
            ply.MarkerModel.LastPos = tr.HitPos
        end

        ply.MarkerModel.LastPos = LerpVector(FrameTime() * 15, ply.MarkerModel.LastPos, tr.HitPos)
        ply.MarkerModel:SetPos(ply.MarkerModel.LastPos)
    end

    function PLUGIN:CreateMove()
        if not LocalPlayer().UseWarTable then return end
        if not IsValid(LocalPlayer().MarkerModel) then return end
        if IsValid(LocalPlayer().WarTableModelViewer) then return end

        if input.WasMousePressed(MOUSE_LEFT) then
            LocalPlayer().WarTableModelViewer = vgui.Create("WarTableModelViewer")
            LocalPlayer().WarTableModelViewer:Display(LocalPlayer().MarkerModel, LocalPlayer().MarkerModel:GetPos())
        end
    end
    --[[ function PLUGIN:CalcView(ply, pos, angles, fov)
        if not ply.UseWarTable then return end

        ply.LastPos = LerpVector(FrameTime() * self.camMoveSpeed, ply.LastPos, ply.tableEnt:GetPos() + ply.tableEnt:GetUp() * 150 + ply.tableEnt:GetForward()*5)
        ply.LastAng = LerpAngle(FrameTime() * self.camMoveSpeed, ply.LastAng, ply.tableEnt:GetAngles() + Angle(90, -90, 0))

        local view = {
            origin = ply.LastPos,
            angles = ply.LastAng,
            fov = fov,
            drawviewer = true
        }

        return view
    end ]]
end