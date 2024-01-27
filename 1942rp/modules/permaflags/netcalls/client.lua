netstream.Hook("openBlacklistLog", function(target, blacklists, blacklistLog)
    local fr = vgui.Create("DFrame")
    fr:SetSize(700, 500)
    fr:Center()
    fr:MakePopup()
    fr:SetTitle(target:Nick() .. " (" .. target:SteamID() .. ")'s Blacklists")
    local blText = "N/A"
    if blacklists and blacklists ~= "" then blText = blacklists end
    local label = vgui.Create("DLabel", fr)
    label:SetPos(5, 29)
    label:SetText("Current Blacklists: " .. blText)
    label:SizeToContents()
    label:SetFont("liaBigFont")
    label:SizeToContents()
    label = vgui.Create("DLabel", fr)
    label:SetPos(5, 29 + 16 * 3)
    label:SetText("!NOTE! Do not use /flagunblacklist for logged blacklists. Use Deactive-Blacklist instead!\nAll times are in your Local Timezone!")
    label:SizeToContents()
    label:SetTextColor(Color(255, 0, 0))
    local listView = vgui.Create("DListView", fr)
    listView:SetPos(5, 110)
    listView:SetSize(690, 335)
    listView:AddColumn("Timestamp (Local)")
    listView:AddColumn("Active?")
    listView:AddColumn("Unblacklist Time")
    listView:AddColumn("Blacklist Length")
    listView:AddColumn("Flags")
    listView:AddColumn("AdminSteam")
    listView:AddColumn("Admin")
    listView:AddColumn("Reason")
    local unbanButton = vgui.Create("DButton", fr)
    unbanButton:SetPos(5, 448)
    unbanButton:SetWidth(690)
    unbanButton:SetText("Deactive Selected Blacklist (Unblacklist)")
    unbanButton:SetSkin("Default")
    unbanButton.DoClick = function() if IsValid(listView:GetSelected()[1]) then netstream.Start("unflagblacklistRequest", target, listView:GetSelected()[1].bID) end end
    local printButton = vgui.Create("DButton", fr)
    printButton:SetPos(5, 473)
    printButton:SetWidth(690)
    printButton:SetText("Print Selected Blacklist To Console")
    printButton:SetSkin("Default")
    printButton.DoClick = function() if IsValid(listView:GetSelected()[1]) then print(listView:GetSelected()[1].printData) end end
    for k, v in pairs(blacklistLog) do
        v.bID = k
    end

    table.sort(blacklistLog, function(a, b) return a.starttime > b.starttime end)
    for k, v in pairs(blacklistLog) do
        local ln = listView:AddLine(os.date("%d/%m/%Y %H:%M:%S", v.starttime), v.active and "Yes" or "No", v.endtime ~= 0 and os.date("%d/%m/%Y %H:%M:%S", v.endtime) or "Never", v.time ~= 0 and string.NiceTime(v.time) or "Perm", v.flags, v.adminsteam, v.admin, v.reason)
        if v.active then
            ln.OldPaint = ln.Paint
            ln.Paint = function(pnl, w, h)
                pnl:OldPaint(w, h)
                surface.SetDrawColor(255, 0, 0, 100)
                surface.DrawRect(0, 0, w, h)
            end
        end

        ln.bID = v.bID
        ln.printData = target:Nick() .. " [" .. target:SteamID() .. "] Blacklist ID " .. v.bID .. "\nStart: " .. os.date("%d/%m/%Y %H:%M:%S", v.starttime) .. "\n" .. "Active: " .. (v.active and "Yes" or "No") .. "\nEnd Time: " .. (v.endtime ~= 0 and os.date("%d/%m/%Y %H:%M:%S", v.endtime) or "Never") .. "\nLength: " .. (v.time ~= 0 and string.NiceTime(v.time) or "Perm") .. "\nFlags: " .. v.flags .. "\nAdminSteam: " .. v.adminsteam .. "\nAdmin: " .. v.admin .. "\nReason: " .. v.reason
    end
end)