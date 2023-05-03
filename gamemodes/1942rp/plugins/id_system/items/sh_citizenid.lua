ITEM.name = "Important Documents"
ITEM.flag = "Y"
ITEM.model = "models/props_lab/clipboard.mdl"
ITEM.uniqueID = "citizenid"

ITEM.functions.show = {
    icon = "icon16/user.png",
    name = "Show",
    onRun = function(item)
        local ply = item.player
        local data = {}
        data.start = ply:GetShootPos()
        data.endpos = data.start + ply:GetAimVector() * 96
        data.filter = ply
        local target = util.TraceLine(data).Entity
        local MAXDISTANCE_TARGET = 50 * 50 -- SQUARED FOR PERFORMANCE The distance the dragged player will try to achieve
        local TargetPos = target:GetPos()
        local myPos = ply:GetPos()
        local dist2Sqr = (TargetPos.x - myPos.x) ^ 2 + (TargetPos.y - myPos.y) ^ 2

        if ply.NextDocumentCheck and ply.NextDocumentCheck > SysTime() then
            ply:notify("You can't show documents that quickly...")

            return false
        end

        if not target:IsPlayer() then
            ply:notify("This target is invalid!!")
        elseif dist2Sqr > MAXDISTANCE_TARGET then
            ply:notify("You can't use this from this distance!")

            return
        end

        ply.NextDocumentCheck = SysTime() + 5
        netstream.Start(target, "openUpID", ply)
        ply:ChatPrint("USED!")

        return false
    end,
    onCanRun = function(item)
        local trEnt = item.player:GetEyeTrace().Entity

        return IsValid(trEnt) and trEnt:IsPlayer()
    end
}

ITEM.functions.showself = {
    icon = "icon16/user.png",
    name = "View",
    onRun = function(item)
        local ply = item.player

        if ply.NextDocumentCheck and ply.NextDocumentCheck > SysTime() then
            ply:notify("You can't see documents that quickly...")

            return false
        end

        ply.NextDocumentCheck = SysTime() + 5
        netstream.Start(ply, "openUpID", ply)

        return false
    end,
}

ITEM.functions.Drop = nil