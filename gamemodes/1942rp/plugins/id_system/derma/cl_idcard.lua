netstream.Hook("OpenID", function(from)
    local frame = vgui.Create("DFrame")
    frame:SetSize(600, 430)
    frame:MakePopup()
    frame:Center()
    frame:ShowCloseButton(false)
    frame:SetTitle("")

    function frame:OnKeyCodePressed(key)
        if key == KEY_F1 then
            self:Close()
        end
    end

    function frame:Paint(w, h)
        draw.RoundedBoxEx(4, 0, 0, w, h, Color(60, 60, 60, 80), true, true)
    end

    local cover = frame:Add("DPanel")
    cover:SetSize(frame:GetWide() / 2, frame:GetTall() - 30)
    cover:CenterHorizontal()
    cover.mat = Material("documents/cover.png", "smooth")

    function cover:Paint(w, h)
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(self.mat)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    local complete = frame:Add("DPanel")
    complete:SetSize(frame:GetWide(), frame:GetTall() - 30)
    complete:CenterHorizontal()
    complete:SetAlpha(0)
    complete.mat = Material("documents/infos.jpg", "smooth")
    local anchor = frame:GetWide() / 2

    function complete:Paint(w, h)
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(self.mat)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    function complete:ShowModel()
        self.mdl = self:Add("DModelPanel")
        self.mdl:SetSize(250, 250)
        self.mdl:SetPos(22, 14)
        self.mdl:SetModel(from:GetModel())
        self.mdl:SetFOV(20)
        self.mdl:SetAlpha(0)
        self.mdl:AlphaTo(255, 0.2)
        local head = self.mdl.Entity:LookupBone("ValveBiped.Bip01_Head1") --Look at the model head

        if head and head >= 0 then
            self.mdl:SetLookAt(self.mdl.Entity:GetBonePosition(head))
        end

        function self.mdl:LayoutEntity(ent)
            ent:SetAngles(Angle(0, 45, 0))
            ent:ResetSequence(2)
        end
    end

    local name = complete:Add("DLabel")
    name:SetText(from:Nick())
    name:SetFont("liaMediumFont")
    name:SetColor(Color(60, 60, 60))
    name:SizeToContents()
    name:SetPos((complete:GetWide() / 2) / 2 - name:GetWide() / 2 - 85 + 85, complete:GetTall() - 55 - 45)
    netstream.Start("getPlayerCharacs", from)

    netstream.Hook("returnPlayerCharacs", function(data)
        for k, v in pairs(data) do
            if k == "Country of Birth" then
                local cob = complete:Add("DLabel")
                cob:SetText(k .. ": " .. v)
                cob:SetFont("liaSmallFont")
                cob:SetColor(Color(60, 60, 60))
                cob:SizeToContents()
                cob:SetPos(complete:GetWide() / 2 - -95, 10)
            end

            if k == "State of Birth" then
                local pob = complete:Add("DLabel")
                pob:SetText(k .. ": " .. v)
                pob:SetFont("liaSmallFont")
                pob:SetColor(Color(60, 60, 60))
                pob:SizeToContents()
                pob:SetPos(complete:GetWide() / 2 - -115, 35)
            end

            if k == "Age(18+)" then
                local age = complete:Add("DLabel")
                age:SetText("Age: " .. v)
                age:SetFont("liaSmallFont")
                age:SetColor(Color(60, 60, 60))
                age:SizeToContents()
                age:SetPos(complete:GetWide() / 2 - -70, 55)
            end

            if k == "Date of Birth" then
                local dob = complete:Add("DLabel")
                dob:SetText(k .. ": " .. v)
                dob:SetFont("liaSmallFont")
                dob:SetColor(Color(60, 60, 60))
                dob:SizeToContents()
                dob:SetPos(complete:GetWide() / 2 - -130, 55)
            end

            if k == "Visa Type" then
                local visa = complete:Add("DLabel")
                visa:SetText(k .. ": " .. v)
                visa:SetFont("liaSmallFont")
                visa:SetColor(Color(60, 60, 60))
                visa:SizeToContents()
                visa:SetPos(complete:GetWide() / 2 - -150, 80)
            end

            if k == "Gender" then
                local gender = complete:Add("DLabel")
                gender:SetText("Gender: " .. v)
                gender:SetFont("liaSmallFont")
                gender:SetColor(Color(60, 60, 60))
                gender:SizeToContents()
                gender:SetPos(complete:GetWide() / 2 - -90, 102)
            end

            if k == "Blood Type" then
                local bloodtype = complete:Add("DLabel")
                bloodtype:SetText(k .. ": " .. v)
                bloodtype:SetFont("liaSmallFont")
                bloodtype:SetColor(Color(60, 60, 60))
                bloodtype:SizeToContents()
                bloodtype:SetPos(complete:GetWide() / 2 - -180, 102)
            end

            if k == "Eye Color" then
                local eyecolor = complete:Add("DLabel")
                eyecolor:SetText(k .. ": " .. v)
                eyecolor:SetFont("liaSmallFont")
                eyecolor:SetColor(Color(60, 60, 60))
                eyecolor:SizeToContents()
                eyecolor:SetPos(complete:GetWide() / 2 - -60, 125)
            end

            if k == "Hair Color" then
                local haircolor = complete:Add("DLabel")
                haircolor:SetText(k .. ": " .. v)
                haircolor:SetFont("liaSmallFont")
                haircolor:SetColor(Color(60, 60, 60))
                haircolor:SizeToContents()
                haircolor:SetPos(complete:GetWide() / 2 - -170, 125)
            end

            if k == "Weight" then
                local weight = complete:Add("DLabel")
                weight:SetText(k .. ": " .. v)
                weight:SetFont("liaSmallFont")
                weight:SetColor(Color(60, 60, 60))
                weight:SizeToContents()
                weight:SetPos(complete:GetWide() / 2 - -110, 148)
            end

            if k == "Height" then
                local height = complete:Add("DLabel")
                height:SetText(k .. ": " .. v)
                height:SetFont("liaSmallFont")
                height:SetColor(Color(60, 60, 60))
                height:SizeToContents()
                height:SetPos(complete:GetWide() / 2 - -200, 148)
            end

            if k == "Occupation" then
                local occ = complete:Add("DLabel")
                occ:SetText(k .. ": " .. v)
                occ:SetFont("liaSmallFont")
                occ:SetColor(Color(60, 60, 60))
                occ:SizeToContents()
                occ:SetPos(complete:GetWide() / 2 - -50, 172)
            end

            if k == "Passport Number" then
                local issued = complete:Add("DLabel")
                issued:SetText(k .. ": 2F6-H5D1-R1940")
                issued:SetFont("liaSmallFont")
                issued:SetColor(Color(60, 60, 60))
                issued:SizeToContents()
                issued:SetPos(complete:GetWide() / 2 - -72, 195)
            end
        end
    end)

    local cont = frame:Add("DButton")
    cont:SetSize(frame:GetWide(), 30)
    cont:SetPos(0, frame:GetTall() - cont:GetTall())
    cont:SetText("Continue")
    cont:SetFont("liaSmallFont")
    cont:SetColor(color_white)
    cont.finish = false

    function cont:Paint(w, h)
        if self:IsHovered() then
            draw.RoundedBoxEx(4, 0, 0, w, h, Color(46, 152, 204), false, false, true, true)
        else
            draw.RoundedBoxEx(4, 0, 0, w, h, Color(60, 60, 60, 80), false, false, true, true)
        end
    end

    function cont:DoClick()
        cover:MoveTo(frame:GetWide() - cover:GetWide(), 0, 0.2, 0.2, -1, function()
            cover:AlphaTo(0, 0.2)

            complete:AlphaTo(255, 0.2, 0, function()
                complete:ShowModel()
                self:SetText("Finish")
                self.finish = true

                self.DoClick = function(this)
                    frame:AlphaTo(0, 0.2, 0, function()
                        if frame and IsValid(frame) then
                            frame:Remove()
                        end
                    end)
                end
            end)
        end)
    end
end)