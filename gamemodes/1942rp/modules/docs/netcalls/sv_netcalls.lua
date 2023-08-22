--------------------------------------------------------------------------------------------------------
netstream.Hook("lia.docs.edit", function(ply, item, title, contents)
	item = lia.item.instances[item.id]

	if not lia.item.isItem(item) then return end
	if item:getOwner() ~= ply then return end

	item:setData("lia.docs.title", title)
	item:setData("lia.docs.contents", contents)
end)
--------------------------------------------------------------------------------------------------------