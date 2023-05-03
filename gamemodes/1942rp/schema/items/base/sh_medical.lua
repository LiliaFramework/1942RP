ITEM.name = "Aid Items"
ITEM.desc = "Heals you bruh."
ITEM.model = "models/weapons/w_package.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.heal = 0

ITEM.functions.use = {
    sound = "items/medshot4.wav",
    onRun = function(item)
        local client = item.player

        if (client:Health() + item.heal) >= client:GetMaxHealth() then
            client:SetHealth(client:GetMaxHealth())
            client:notify("Your Health was set to max due to the value surpassing your Health limit.")
        else
            client:SetHealth(client:Health() + item.heal)
        end
    end
}

ITEM.functions.target = {
    sound = "items/medshot4.wav",
    onRun = function(item)
        local client = item.player
        local target = client:GetEyeTrace().Entity

        if not (target:Alive() or IsValid(target) and target:IsPlayer()) then
            client:notify("Target not valid! You must be looking at it!")

            return
        else
            if (target:Health() + item.heal) >= target:GetMaxHealth() then
                target:SetHealth(target:GetMaxHealth())
                client:notify("This target Health was set to max due to the value surpassing his Health limit.")
            else
                target:SetHealth(target:Health() + item.heal)
            end
        end
    end
}