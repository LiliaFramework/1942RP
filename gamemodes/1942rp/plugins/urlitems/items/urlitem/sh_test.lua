ITEM.name = "xd"
ITEM.desc = "xd"
ITEM.model = "models/props_interiors/pot01a.mdl"
ITEM.url = "https://trello.com/b/hgLOEj9v/mg-1943rp-server"

ITEM.functions.use = {
    name = "Open",
    icon = "icon16/book_link.png",
    onRun = function(item)
        net.Start("sendURL", true)
        net.WriteString(item.url)
        net.Send(item.player)

        return false
    end,
}