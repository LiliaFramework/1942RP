ITEM.name = "Splint"
ITEM.desc = "Splint."
ITEM.model = "models/props_c17/BriefCase001a.mdl"
ITEM.width = 1
ITEM.height = 1

ITEM.functions.use = {
    name = "Use",
    tip = "equipTip",
    icon = "icon16/tick.png",
    onRun = function(item)
        local client = item.player
        client:getChar():setData("leg_broken", false)
        client:SetWalkSpeed(nut.config.get("walkSpeed", 130))
        client:SetRunSpeed(nut.config.get("runSpeed", 235))

        return true
    end
}

ITEM.functions.usef = {
    name = "Use Forward",
    tip = "useTip",
    icon = "icon16/arrow_up.png",
    onRun = function(item)
        local client = item.player
        local trace = client:GetEyeTraceNoCursor() -- We don't need cursors.
        local target = trace.Entity

        if target and target:IsValid() and target:IsPlayer() and target:Alive() then
            target:getChar():setData("leg_broken", false)
            target:SetWalkSpeed(nut.config.get("walkSpeed", 130))
            target:SetRunSpeed(nut.config.get("runSpeed", 235))

            return true
        end

        return false
    end,
    onCanRun = function(item)
        return not IsValid(item.entity)
    end
}