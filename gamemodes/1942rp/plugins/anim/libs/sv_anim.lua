--///////////////////////////////////////////////////// This was Ripped from EGM SWEPs \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
local PLUGIN = PLUGIN

function PLUGIN:GetComlinkAnim()
    return {
        ["ValveBiped.Bip01_R_UpperArm"] = Angle(32.9448, -103.5211, 2.2273),
        ["ValveBiped.Bip01_R_Forearm"] = Angle(-90.3271, -31.3616, -41.8804),
        ["ValveBiped.Bip01_R_Hand"] = Angle(0, 0, -24),
    }
end

function PLUGIN:GetCrossArmsInfrontAnim()
    return {
        ["ValveBiped.Bip01_R_Forearm"] = Angle(-43.779933929443, -107.18412780762, 15.918969154358),
        ["ValveBiped.Bip01_R_UpperArm"] = Angle(20.256689071655, -57.223915100098, -6.1269416809082),
        ["ValveBiped.Bip01_L_UpperArm"] = Angle(-28.913911819458, -59.408206939697, 1.0253102779388),
        ["ValveBiped.Bip01_R_Thigh"] = Angle(4.7250719070435, -6.0294013023376, -0.46876749396324),
        ["ValveBiped.Bip01_L_Thigh"] = Angle(-7.6583762168884, -0.21996378898621, 0.4060270190239),
        ["ValveBiped.Bip01_L_Forearm"] = Angle(51.038677215576, -120.44165039063, -18.86986541748),
        ["ValveBiped.Bip01_R_Hand"] = Angle(14.424224853516, -33.406204223633, -7.2624106407166),
        ["ValveBiped.Bip01_L_Hand"] = Angle(25.959447860718, 31.564517974854, -14.979378700256),
    }
end

function PLUGIN:GetCrossArmsAnim()
    return {
        ["ValveBiped.Bip01_R_UpperArm"] = Angle(3.809, 15.382, 2.654),
        ["ValveBiped.Bip01_R_Forearm"] = Angle(-63.658, 1.8, -84.928),
        ["ValveBiped.Bip01_L_UpperArm"] = Angle(3.809, 15.382, 2.654),
        ["ValveBiped.Bip01_L_Forearm"] = Angle(53.658, -29.718, 31.455),
        ["ValveBiped.Bip01_R_Thigh"] = Angle(4.829, 0, 0),
        ["ValveBiped.Bip01_L_Thigh"] = Angle(-8.89, 0, 0),
    }
end

function PLUGIN:GetHighFiveAnim()
    return {
        ["ValveBiped.Bip01_L_Forearm"] = Angle(25, -65, 25),
        ["ValveBiped.Bip01_L_UpperArm"] = Angle(-70, -180, 70),
    }
end

function PLUGIN:GetHololinkAnim()
    return {
        ["ValveBiped.Bip01_R_UpperArm"] = Angle(10, -20),
        ["ValveBiped.Bip01_R_Hand"] = Angle(0, 1, 50),
        ["ValveBiped.Bip01_Head1"] = Angle(0, -30, -20),
        ["ValveBiped.Bip01_R_Forearm"] = Angle(0, -65, 39.8863),
    }
end

function PLUGIN:GetMiddleFingerAnim()
    return {
        ["ValveBiped.Bip01_R_UpperArm"] = Angle(15, -55, -0),
        ["ValveBiped.Bip01_R_Forearm"] = Angle(0, -55, -0),
        ["ValveBiped.Bip01_R_Hand"] = Angle(20, 20, 90),
        ["ValveBiped.Bip01_R_Finger1"] = Angle(20, -40, -0),
        ["ValveBiped.Bip01_R_Finger3"] = Angle(0, -30, 0),
        ["ValveBiped.Bip01_R_Finger4"] = Angle(-10, -40, 0),
        ["ValveBiped.Bip01_R_Finger11"] = Angle(-0, -70, -0),
        ["ValveBiped.Bip01_R_Finger31"] = Angle(0, -70, 0),
        ["ValveBiped.Bip01_R_Finger41"] = Angle(0, -70, 0),
        ["ValveBiped.Bip01_R_Finger12"] = Angle(-0, -70, -0),
        ["ValveBiped.Bip01_R_Finger32"] = Angle(0, -70, 0),
        ["ValveBiped.Bip01_R_Finger42"] = Angle(0, -70, -0),
    }
end

function PLUGIN:GetPointAnim()
    return {
        ["ValveBiped.Bip01_R_Finger2"] = Angle(4.151602268219, -52.963024139404, 0.42117667198181),
        ["ValveBiped.Bip01_R_Finger21"] = Angle(0.00057629722869024, -58.618747711182, 0.001297949347645),
        ["ValveBiped.Bip01_R_Finger3"] = Angle(4.151602268219, -52.963024139404, 0.42117667198181),
        ["ValveBiped.Bip01_R_Finger31"] = Angle(0.00057629722869024, -58.618747711182, 0.001297949347645),
        ["ValveBiped.Bip01_R_Finger4"] = Angle(4.151602268219, -52.963024139404, 0.42117667198181),
        ["ValveBiped.Bip01_R_Finger41"] = Angle(0.00057629722869024, -58.618747711182, 0.001297949347645),
        ["ValveBiped.Bip01_R_UpperArm"] = Angle(25.019514083862, -87.288040161133, -0.0012286090059206),
    }
end

function PLUGIN:GetSaluteAnim()
    return {
        ["ValveBiped.Bip01_R_UpperArm"] = Angle(80, -95, -77.5),
        ["ValveBiped.Bip01_R_Forearm"] = Angle(35, -125, -5),
    }
end

function PLUGIN:GetSurrenderAnim()
    return {
        ["ValveBiped.Bip01_L_Forearm"] = Angle(25, -65, 25),
        ["ValveBiped.Bip01_R_Forearm"] = Angle(-25, -65, -25),
        ["ValveBiped.Bip01_L_UpperArm"] = Angle(-70, -180, 70),
        ["ValveBiped.Bip01_R_UpperArm"] = Angle(70, -180, -70),
    }
end

PLUGIN.AnimTable = {
    [1] = {"high_five_swep", PLUGIN:GetHighFiveAnim()},
    [2] = {"cross_arms_infront_swep", PLUGIN:GetCrossArmsInfrontAnim()},
    [3] = {"surrender_animation_swep", PLUGIN:GetSurrenderAnim()},
    [4] = {"salute_swep", PLUGIN:GetSaluteAnim()},
    [5] = {"middlefinger_animation_swep", PLUGIN:GetMiddleFingerAnim()},
    [6] = {"point_in_direction_swep", PLUGIN:GetPointAnim()},
    [7] = {"hololink_swep", PLUGIN:GetHololinkAnim()},
    [8] = {"cross_arms_swep", PLUGIN:GetCrossArmsAnim()},
    [9] = {"comlink_swep", PLUGIN:GetComlinkAnim()},
}

function PLUGIN:VelocityIsHigher(ply, value)
    local x, y, z = math.abs(ply:GetVelocity().x), math.abs(ply:GetVelocity().y), math.abs(ply:GetVelocity().z)

    if x > value or y > value or z > value then
        return true
    else
        return false
    end
end

function PLUGIN:ApplyAnimation(ply, targetValue, class)
    local classassigned
    if not (IsValid(ply) or ply:getChar() or ply:Alive()) then return end

    for k, v in pairs(self.AnimTable) do
        if class == v[1] then
            classassigned = v[2]
            break
        end
    end

    if not classassigned then return end

    for boneName, angle in pairs(classassigned) do
        local bone = ply:LookupBone(boneName)

        if bone then
            if targetValue == 0 then
                ply:ManipulateBoneAngles(bone, angle * 0)
            else
                ply:ManipulateBoneAngles(bone, angle)
            end
        end
    end
end

function PLUGIN:ToggleAnimaton(ply, crossing, class, deactivateOnMove)
    if crossing then
        ply:SetNWBool("animationStatus", true)

        if class then
            ply:SetNWString("animationClass", class)
        end

        ply:SetNWInt("deactivateOnMove", deactivateOnMove)
    else
        ply:SetNWBool("animationStatus", false)
        ply:SetNWInt("deactivateOnMove", 5)
    end
end

function PLUGIN:Think()
    for _, ply in pairs(player.GetHumans()) do
        local animationClass = ply:GetNWString("animationClass")

        if ply:GetNWBool("animationStatus") then
            self:ApplyAnimation(ply, 1, animationClass)
        else
            self:ApplyAnimation(ply, 0, animationClass)
        end
    end
end

function PLUGIN:SetupMove(ply, moveData, cmd)
    if ply:GetNWBool("animationStatus") then
        local deactivateOnMove = ply:GetNWInt("deactivateOnMove", 5)

        if self:VelocityIsHigher(ply, deactivateOnMove) then
            self:ToggleAnimaton(ply, false)
        end

        if ply:KeyDown(IN_DUCK) then
            self:ToggleAnimaton(ply, false)
        end

        if ply:KeyDown(IN_USE) then
            self:ToggleAnimaton(ply, false)
        end

        if ply:KeyDown(IN_JUMP) then
            self:ToggleAnimaton(ply, false)
        end
    end
end

--[[ LEGACY
nut.command.add("anim", {
    onRun = function(client, arguments)
        if arguments[1] then
            PLUGIN:GetAnimationID(client, arguments[1])
        else
            client:notify("You need to provide an animation!")
        end
    end
})

function PLUGIN:GetAnimationID(client, AnimationID)
    if not client:GetNWBool("animationStatus") then
        if not client:Crouching() and client:GetVelocity():Length() < 5 and not client:InVehicle() then
            if AnimationID == "comlink_swep" then
                self:ToggleAnimaton(client, true, "comlink_swep", 0)
            elseif AnimationID == "cross_arms_infront_swep" then
                self:ToggleAnimaton(client, true, "cross_arms_infront_swep", 0)
            elseif AnimationID == "cross_arms_swep" then
                self:ToggleAnimaton(client, true, "cross_arms_swep", 0)
            elseif AnimationID == "high_five_swep" then
                self:ToggleAnimaton(client, true, "high_five_swep", 0)
            elseif AnimationID == "hololink_swep" then
                self:ToggleAnimaton(client, true, "hololink_swep", 0)
            elseif AnimationID == "middlefinger_animation_swep" then
                self:ToggleAnimaton(client, true, "middlefinger_animation_swep", 0)
            elseif AnimationID == "point_in_direction_swep" then
                self:ToggleAnimaton(client, true, "point_in_direction_swep", 0)
            elseif AnimationID == "salute_swep" then
                self:ToggleAnimaton(client, true, "salute_swep", 0)
            elseif AnimationID == "surrender_animation_swep" then
                self:ToggleAnimaton(client, true, "surrender_animation_swep", 0)
            else
                client:notify("Unknown Anim!")
            end
        end
    else
        self:ToggleAnimaton(client, false)
    end
end]]
nut.command.add("anim", {
    onRun = function(client, arguments)
        if not client:GetNWBool("animationStatus") then
            if tonumber(arguments[1]) > 0 and tonumber(arguments[1]) < 4 then
                PLUGIN:GetAnimationID(client, arguments[1])
            else
                client:notify("You need to provide an invalid animation!")
                client:ChatPrint("Valid Animations:")
                client:ChatPrint("1 = Salute")
                client:ChatPrint("2 = Crossarms Back")
                client:ChatPrint("3 = Crossarms Front")
                client:ChatPrint("4 = Point Forward")
                client:ChatPrint("5 = Surrender")
            end
        else
            if tonumber(arguments[1]) ~= 0 then
                client:notify("You need to provide an invalid animation!")
                client:ChatPrint("Valid Animations:")
                client:ChatPrint("0 = Return to Normal Standing")
            else
                PLUGIN:ToggleAnimaton(ply, false)
            end
        end
    end
})

function PLUGIN:GetAnimationID(client, AnimationID)
    if not client:Crouching() and client:GetVelocity():Length() < 5 and not client:InVehicle() then
        if tonumber(AnimationID) == 1 then
            self:ToggleAnimaton(client, true, "salute_swep", 0)
        elseif tonumber(AnimationID) == 2 then
            self:ToggleAnimaton(client, true, "cross_arms_swep", 0)
        elseif tonumber(AnimationID) == 3 then
            self:ToggleAnimaton(client, true, "cross_arms_infront_swep", 0)
        elseif tonumber(AnimationID) == 4 then
            self:ToggleAnimaton(client, true, "point_in_direction_swep", 0)
        elseif tonumber(AnimationID) == 5 then
            self:ToggleAnimaton(client, true, "surrender_animation_swep", 0)
        else
            client:notify("Unknown Anim!")
        end
    end
end