ITEM.name = "Citizen ID"
ITEM.model = "models/props_lab/clipboard.mdl"
ITEM.desc = "This is your Citizen ID."

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
        local MAXDISTANCE_TARGET = 50 * 50
        local TargetPos = target:GetPos()
        local myPos = ply:GetPos()
        local dist2Sqr = (TargetPos.x - myPos.x) ^ 2 + (TargetPos.y - myPos.y) ^ 2

        if ply.NextDocumentCheck and ply.NextDocumentCheck > SysTime() then
            ply:notify("You must wait to show your Passport again.")

            return false
        end

        if not target:IsPlayer() then
            ply:notify("This target is invalid!!")
        elseif dist2Sqr > MAXDISTANCE_TARGET then
            ply:notify("You can't use this from this distance!")

            return
        end

        ply.NextDocumentCheck = SysTime() + 5
        netstream.Start(target, "OpenID", ply)

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
            ply:notify("You must wait to look at your Passport again.")

            return false
        end

        ply.NextDocumentCheck = SysTime() + 5
        netstream.Start(ply, "OpenID", ply)

        return false
    end,
}

ITEM.functions.Drop = nil