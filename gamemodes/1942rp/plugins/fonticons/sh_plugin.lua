PLUGIN.name = "Font Icons"
PLUGIN.desc = "Easy way to get the right character for the right icon"
resource.AddFile("resource/fonts/wolficonfont.ttf")
lia.util.include("cl_plugin.lua")
ICON = {}
ICON.font = "wolficonfont"

ICON.characters = {
    trash = "-",
    male = "a",
    female = "b",
    bank = "d",
    tick = "e",
    phone = "CALL",
    hamburger = "g"
}

function ICON:GetIconChar(iconDesc)
    return self.characters[iconDesc] or "nil"
end