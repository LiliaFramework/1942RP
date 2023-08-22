--------------------------------------------------------------------------------------------------------
netstream.Hook("lia.docs.read", function(title, contents)
	local panel = vgui.Create("lia.docs.read")
	panel:SetHeader(title)
	panel:SetContents(contents)
end)
--------------------------------------------------------------------------------------------------------
netstream.Hook("lia.docs.edit", function(item)
	local panel = vgui.Create("lia.docs.edit")
	panel:SetItem(item)
end)
--------------------------------------------------------------------------------------------------------