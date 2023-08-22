----------------------------------------------------------------------------------------------
function MODULE:PlayerBindPress(ply, bind, down)
    local tr = util.TraceLine(util.GetPlayerTrace(ply))
    local target = tr.Entity
    if not target:IsPlayer() then return end
    if target == ply then return end

    if down and string.find(bind, "+menu_context") then
        if target:IsHandcuffed() then
            if ply:GetActiveWeapon():GetClass() ~= "gmod_tool" then
                net.Start("cmenu_tying")
                net.SendToServer()
            elseif ply:GetActiveWeapon():GetClass() == "gmod_tool" then
                hook.Run("OnContextMenuOpen")

                return true
            end
        else
            if ply:GetActiveWeapon():GetClass() ~= "gmod_tool" then
                net.Start("cmenu")
                net.SendToServer()
            elseif ply:GetActiveWeapon():GetClass() == "gmod_tool" then
                hook.Run("OnContextMenuOpen")

                return true
            end
        end
    end
end
----------------------------------------------------------------------------------------------