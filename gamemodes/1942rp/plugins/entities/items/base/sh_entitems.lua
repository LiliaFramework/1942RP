ITEM.name = "Entity Dropper"
ITEM.desc = "Drops an Entity. You probably shouldnt be seeing this. tell a developer please."
ITEM.model = "models/weapons/w_package.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.entdrop = ""
ITEM.permit = "admin"
ITEM.limits = false
ITEM.limit = 1

ITEM.functions.Use = {
    name = "Use",
    icon = "icon16/cursor.png",
    onRun = function(item)
        local client = item.player
        local delay = 0

        if delay > CurTime() then
            client:notify("This item is on cooldown!")

            return false
        else
            delay = CurTime() + 60

            if item.limits == true then
                local NumEnts = 0

                for _, v in pairs(ents.FindByClass(item.entdrop)) do
                    if v.SteamID == client:SteamID() then
                        NumEnts = NumEnts + 1
                    end
                end

                if NumEnts >= item.limit then
                    client:notify("You have reached the maximum amount of " .. item.name .. "s.")

                    return false
                end
            end

            client:EmitSound("physics/flesh/flesh_bloody_break.wav", 75, 200)
            local ent = ents.Create(item.entdrop)
            ent:SetPos(client:EyePos() + (client:GetAimVector() * 50))
            ent:Spawn()
            ent.Owner = client
            ent.SteamID = client:SteamID()
            ent:SetMoveType(MOVETYPE_VPHYSICS)
            local phys = ent:GetPhysicsObject()

            if IsValid(phys) then
                phys:EnableMotion(true)
            end

            ent:SetCollisionGroup(COLLISION_GROUP_WORLD)

            return true
        end
    end
}