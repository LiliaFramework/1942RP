local light_table = {
    L_HeadLampPos = Vector(87.3, 29.59, 35.42),
    L_HeadLampAng = Angle(15, 0, 0),
    R_HeadLampPos = Vector(87.34, -31.76, 35.52),
    R_HeadLampAng = Angle(15, 0, 0),
    L_RearLampPos = Vector(-95.5, 22.25, 32),
    L_RearLampAng = Angle(45, 180, 0),
    R_RearLampPos = Vector(-95.5, -24.75, 32),
    R_RearLampAng = Angle(45, 180, 0),
    Headlight_sprites = {Vector(100, 32, 47), Vector(100, -31, 47)},
    Headlamp_sprites = {Vector(100, 32, 47), Vector(100, -31, 47)},
    Rearlight_sprites = {Vector(-138, 36, 25), Vector(-138, -33, 25)},
    Brakelight_sprites = {Vector(-138, 36, 25), Vector(-138, -33, 2)},
    Reverselight_sprites = {Vector(-138, 36, 25), Vector(-138, -33, 25)},
    Turnsignal_sprites = {
        Left = {Vector(86.78, 22.39, 31.92), Vector(-140, 36, 25), Vector(-140, 36, 25),},
        Right = {Vector(86.78, -24.39, 31.92), Vector(-140, -33, 25), Vector(-140, -33, 25),},
    },
}

list.Set("simfphys_lights", "opel_blitz_ww2", light_table)

local V = {
    Name = "Opel_Blitz_CODWWII",
    Model = "models/opelww2/ww2_opel_blitz.mdl",
    Class = "gmod_sent_vehicle_fphysics_base",
    Category = "German",
    SpawnAngleOffset = 90,
    Members = {
        Mass = 1150,
        SetMaxHealth = 500,
        EnginePos = Vector(63.64, 0, 47.96),
        LightsTable = "opel_blitz_ww2",
        CustomWheels = true,
        CustomSuspensionTravel = 10,
        CustomWheelModel = "models/opelww2/opel_wheel.mdl",
        CustomWheelModel_R = "models/opelww2/opel_wheelb.mdl",
        CustomWheelPosFL = Vector(75, 35, 23),
        CustomWheelPosFR = Vector(75, -35, 23),
        CustomWheelPosRL = Vector(-85, 37, 23),
        CustomWheelPosRR = Vector(-85, -36, 23),
        CustomWheelAngleOffset = Angle(0, 0, 0),
        CustomMassCenter = Vector(0, 0, 3.5),
        CustomSteerAngle = 35,
        SeatOffset = Vector(10, -17, 80),
        SeatPitch = 5,
        SeatYaw = 90,
                --[[
		ModelInfo = {
			Skin = 1
		},
		]] --
        PassengerSeats = {
            {
                pos = Vector(25, -18, 45),
                ang = Angle(0, -90, 12)
            },
            {
                pos = Vector(-30, 36, 57),
                ang = Angle(0, 180, 8)
            },
            {
                pos = Vector(-50, 36, 57),
                ang = Angle(0, 180, 8)
            },
            {
                pos = Vector(-70, 36, 57),
                ang = Angle(0, 180, 8)
            },
            {
                pos = Vector(-90, 36, 57),
                ang = Angle(0, 180, 8)
            },
            {
                pos = Vector(-30, -34, 57),
                ang = Angle(0, 0, 8)
            },
            {
                pos = Vector(-55, -34, 57),
                ang = Angle(0, 0, 8)
            },
            {
                pos = Vector(-75, -34, 57),
                ang = Angle(0, 0, 8)
            }
        },
        ExhaustPositions = {
            {
                pos = Vector(-124, 40, 25),
                ang = Angle(90, 60, 0)
            },
            {
                pos = Vector(-124, 40, 25),
                ang = Angle(90, 90, 0)
            }
        },
        FrontHeight = 6.5,
        FrontConstant = 25000,
        FrontDamping = 1300,
        FrontRelativeDamping = 1300,
        RearHeight = 6.5,
        RearConstant = 25000,
        RearDamping = 1300,
        RearRelativeDamping = 1300,
        FastSteeringAngle = 10,
        SteeringFadeFastSpeed = 400,
        TurnSpeed = 7,
        MaxGrip = 35,
        Efficiency = 1,
        GripOffset = -1.5,
        BrakePower = 38,
        IdleRPM = 350,
        LimitRPM = 5000,
        PeakTorque = 60,
        PowerbandStart = 2000,
        PowerbandEnd = 6950,
        Turbocharged = false,
        Supercharged = false,
        FuelFillPos = Vector(-67.9, -37.75, 38.59),
        FuelType = FUELTYPE_PETROL,
        FuelTankSize = 65,
        PowerBias = 1,
        EngineSoundPreset = -1,
        snd_pitch = 1,
        snd_idle = "simulated_vehicles/4banger/4banger_idle.wav",
        snd_low = "simulated_vehicles/4banger/4banger_low.wav",
        snd_low_pitch = 0.9,
        snd_mid = "simulated_vehicles/4banger/4banger_mid.wav",
        snd_mid_gearup = "simulated_vehicles/4banger/4banger_second.wav",
        snd_mid_pitch = 0.9,
        DifferentialGear = 0.42,
        Gears = {-0.1, 0, 0.1, 0.17, 0.24, 0.3, 0.37, 0.41}
    }
}

list.Set("simfphys_vehicles", "sim_fphys_opel_blitz_ww2", V)

local V = {
    Name = "Half Track Ger",
    Model = "models/half_track_german/german_half_track.mdl",
    Class = "gmod_sent_vehicle_fphysics_base",
    Category = "German",
    SpawnOffset = Vector(0, 0, 60),
    SpawnAngleOffset = 0,
    Members = {
        Mass = 7000,
        AirFriction = 7,
        Inertia = Vector(14000, 47000, 48000),
        OnSpawn = function(ent)
            ent:SetNWBool("simfphys_NoRacingHud", true)
        end,
        MaxHealth = 1500,
        IsArmored = true,
        NoWheelGibs = true,
        LightsTable = "sdkfz_halftrack",
        FirstPersonViewPos = Vector(0, -50, 50),
        FrontWheelRadius = 38,
        RearWheelRadius = 38,
        EnginePos = Vector(0, -125.72, 69.45),
        CustomWheels = true,
        CustomSuspensionTravel = 10,
        CustomWheelModel = "models/props_phx/smallwheel.mdl",
        CustomWheelPosFL = Vector(92, 35, 47),
        CustomWheelPosFR = Vector(92, -29, 47),
        CustomWheelPosML = Vector(0, 40, 45),
        CustomWheelPosMR = Vector(0, -36, 45),
        CustomWheelPosRL = Vector(-85, 40, 45),
        CustomWheelPosRR = Vector(-85, -36, 45),
        CustomWheelAngleOffset = Angle(0, 0, 90),
        CustomMassCenter = Vector(0, 0, 3),
        CustomSteerAngle = 60,
        SeatOffset = Vector(-3, -20, 60),
        SeatPitch = 0,
        SeatYaw = 90,
        ModelInfo = {
            WheelColor = Color(0, 0, 0, 0),
        },
        ExhaustPositions = {
            {
                pos = Vector(60, 53, 30),
                ang = Angle(-90, 0, 0)
            }
        },
        PassengerSeats = {
            {
                pos = Vector(-30, 5, 55),
                ang = Angle(0, -90, -40)
            },
            {
                pos = Vector(5, -10, 25),
                ang = Angle(0, -90, 0)
            },
            {
                pos = Vector(-25, -15, 30),
                ang = Angle(0, 0, 0)
            },
            {
                pos = Vector(-50, -15, 30),
                ang = Angle(0, 0, 0)
            },
            {
                pos = Vector(-70, -15, 30),
                ang = Angle(0, 0, 0)
            },
            {
                pos = Vector(-90, -15, 30),
                ang = Angle(0, 0, 0)
            },
            {
                pos = Vector(-25, 25, 30),
                ang = Angle(0, 180, 0)
            },
            {
                pos = Vector(-50, 25, 30),
                ang = Angle(0, 180, 0)
            }
        },
        FrontHeight = 23,
        FrontConstant = 50000,
        FrontDamping = 6000,
        FrontRelativeDamping = 6000,
        RearHeight = 23,
        RearConstant = 50000,
        RearDamping = 6000,
        RearRelativeDamping = 6000,
        FastSteeringAngle = 14,
        SteeringFadeFastSpeed = 400,
        TurnSpeed = 3,
        MaxGrip = 800,
        Efficiency = 0.85,
        GripOffset = -300,
        BrakePower = 100,
        BulletProofTires = true,
        IdleRPM = 350,
        LimitRPM = 1900,
        PeakTorque = 250,
        PowerbandStart = 600,
        PowerbandEnd = 3500,
        Turbocharged = false,
        Supercharged = false,
        DoNotStall = true,
        FuelFillPos = Vector(-46.03, -34.64, 75.23),
        FuelType = FUELTYPE_PETROL,
        FuelTankSize = 160,
        PowerBias = -0.5,
        EngineSoundPreset = 0,
        Sound_Idle = "simulated_vehicles/sherman/idle.wav",
        Sound_IdlePitch = 1,
        Sound_Mid = "simulated_vehicles/sherman/low.wav",
        Sound_MidPitch = 1.3,
        Sound_MidVolume = 0.75,
        Sound_MidFadeOutRPMpercent = 50,
        Sound_MidFadeOutRate = 0.85,
        Sound_High = "simulated_vehicles/sherma/high.wav",
        Sound_HighPitch = 1,
        Sound_HighVolume = 1,
        Sound_HighFadeInRPMpercent = 20,
        Sound_HighFadeInRate = 0.2,
        Sound_Throttle = "",
        Sound_ThrottlePitch = 0,
        Sound_ThrottleVolume = 0,
        snd_horn = "common/null.wav",
        ForceTransmission = 1,
        DifferentialGear = 0.3,
        Gears = {-0.1, 0, 0.05, 0.08, 0.11, 0.14}
    }
}

list.Set("simfphys_vehicles", "sim_fphys_tank_sdkfz_halftrack", V)

local light_table = {
    L_HeadLampPos = Vector(95, 50, 60),
    L_HeadLampAng = Angle(0, 0, 0),
    Headlight_sprites = {Vector(115, -23, 45), Vector(115, 30, 45)},
}

list.Set("simfphys_lights", "sdkfz_halftrack", light_table)
-------------------------------------------------------------------------------------