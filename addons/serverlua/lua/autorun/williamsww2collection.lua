local Category = "William's WW2 Vehicles"

local IV = {
    Name = "Citroen",
    Model = "models/william/citroen3/citroen3_body.mdl",
    Class = "gmod_sent_vehicle_fphysics_base",
    Category = "Civilian Vehicles",
    SpawnOffset = Vector(0, 0, 50),
    Members = {
        Mass = 1500,
        LightsTable = "citroen3",
        CustomWheels = true,
        CustomSuspensionTravel = 15,
        CustomWheelModel = "models/william/citroen3/citroen3_frontwhl.mdl",
        CustomWheelModel_R = "models/william/citroen3/citroen3_backwhl.mdl",
        CustomWheelPosFL = Vector(65, 32.5, -15.5),
        CustomWheelPosFR = Vector(65, -32.5, -15.5),
        CustomWheelPosRL = Vector(-54, 32.5, -15.5),
        CustomWheelPosRR = Vector(-54, -32.5, -15.5),
        CustomWheelAngleOffset = Angle(0, -90, 0),
        CustomMassCenter = Vector(2, 0, -1),
        CustomSteerAngle = 35,
        SeatOffset = Vector(-11.5, -12, 16.5),
        SeatPitch = 0,
        SeatYaw = 90,
        PassengerSeats = {
            {
                pos = Vector(-2.5, -14, -15),
                ang = Angle(0, -90, 10)
            },
            {
                pos = Vector(-41, 9, -15),
                ang = Angle(0, -90, 10)
            },
            {
                pos = Vector(-41, -9, -15),
                ang = Angle(0, -90, 10)
            },
        },
        FrontHeight = 6.5,
        FrontConstant = 40000,
        FrontDamping = 2200,
        FrontRelativeDamping = 2200,
        RearHeight = 6.5,
        RearConstant = 40000,
        RearDamping = 2200,
        RearRelativeDamping = 2200,
        TurnSpeed = 9,
        FastSteeringAngle = 1000,
        SteeringFadeFastSpeed = 535,
        MaxGrip = 37,
        Efficiency = 1.0,
        GripOffset = -2,
        BrakePower = 40,
        IdleRPM = 650,
        LimitRPM = 5000,
        PeakTorque = 80,
        Revlimiter = false,
        PowerbandStart = 1000,
        PowerbandEnd = 4500,
        Turbocharged = false,
        PowerBias = -1,
        EngineSoundPreset = 6,
        DifferentialGear = 0.8,
        Gears = {-0.12, 0, 0.06, 0.12, 0.21, 0.32, 0.42}
    }
}

list.Set("simfphys_vehicles", "sim_fphys_citroen3", IV)

local light_table = {
    L_HeadLampPos = Vector(150, 22, 30),
    L_HeadLampAng = Angle(0, 0, 0),
    R_HeadLampPos = Vector(150, -22, 30),
    R_HeadLampAng = Angle(0, 0, 0),
    L_RearLampPos = Vector(-80, 25, 16),
    L_RearLampAng = Angle(0, 0, 0),
    R_RearLampPos = Vector(-80, -25, 16),
    R_RearLampAng = Angle(0, 0, 0),
    Headlight_sprites = {Vector(77, 20, 5), Vector(77, 20, 5), Vector(77, -20, 5), Vector(77, -20, 5),},
    Headlamp_sprites = {Vector(77, 20, 5), Vector(77, 20, 5), Vector(77, -20, 5), Vector(77, -20, 5),},
    Rearlight_sprites = {Vector(-77, 30, -10), Vector(-77, -30, -10),},
    Brakelight_sprites = {Vector(-77, 30, -10), Vector(-77, -30, -10),},
    Reverselight_sprites = {Vector(-77, 30, -10), Vector(-77, -30, -10),},
}

list.Set("simfphys_lights", "citroen3", light_table)

local IV = {
    Name = "Horch Type 108",
    Model = "models/william/horch_type108/horchbody.mdl",
    Class = "gmod_sent_vehicle_fphysics_base",
    Category = "Government Vehicles",
    Members = {
        Mass = 1500,
        LightsTable = "Horch Type 108",
        CustomWheels = true,
        CustomSuspensionTravel = 15,
        CustomWheelModel = "models/william/horch_type108/horch_wheel.mdl",
        CustomWheelPosFL = Vector(48, -30.5, 14.5),
        CustomWheelPosFR = Vector(48, 30.5, 14.5),
        CustomWheelPosRL = Vector(-73.5, 30.5, 14.5),
        CustomWheelPosRR = Vector(-73.5, -30.5, 14.5),
        CustomWheelAngleOffset = Angle(0, -90, 0),
        CustomMassCenter = Vector(2, 0, -1),
        CustomSteerAngle = 35,
        SeatOffset = Vector(5, -13, 55.5),
        SeatPitch = 0,
        SeatYaw = 90,
        PassengerSeats = {
            {
                pos = Vector(11, -16, 22.5),
                ang = Angle(0, -90, 10)
            },
            {
                pos = Vector(-16, -16, 22.5),
                ang = Angle(0, 90, 10)
            },
            {
                pos = Vector(-16, 16, 22.5),
                ang = Angle(0, 90, 10)
            },
            {
                pos = Vector(-74.5, 16, 22.5),
                ang = Angle(0, -90, 10)
            },
            {
                pos = Vector(-74.5, -16, 22.5),
                ang = Angle(0, -90, 10)
            },
        },
        ExhaustPositions = {
            {
                pos = Vector(-77, 22, -14),
                ang = Angle(90, 165, 0)
            },
            {
                pos = Vector(-77, -22, -14),
                ang = Angle(90, 165, 0)
            },
        },
        FrontHeight = 6.5,
        FrontConstant = 40000,
        FrontDamping = 2200,
        FrontRelativeDamping = 2200,
        RearHeight = 6.5,
        RearConstant = 40000,
        RearDamping = 2200,
        RearRelativeDamping = 2200,
        TurnSpeed = 9,
        FastSteeringAngle = 1000,
        SteeringFadeFastSpeed = 535,
        MaxGrip = 37,
        Efficiency = 1.0,
        GripOffset = -2,
        BrakePower = 40,
        IdleRPM = 650,
        LimitRPM = 5000,
        PeakTorque = 80,
        Revlimiter = false,
        PowerbandStart = 1000,
        PowerbandEnd = 4500,
        Turbocharged = false,
        PowerBias = -1,
        EngineSoundPreset = 1,
        DifferentialGear = 0.8,
        Gears = {-0.12, 0, 0.06, 0.12, 0.21, 0.32, 0.42}
    }
}

list.Set("simfphys_vehicles", "sim_fphys_horch", IV)

local light_table = {
    L_HeadLampPos = Vector(150, 22, 30),
    L_HeadLampAng = Angle(0, 0, 0),
    R_HeadLampPos = Vector(150, -22, 30),
    R_HeadLampAng = Angle(0, 0, 0),
    L_RearLampPos = Vector(-80, 25, 16),
    L_RearLampAng = Angle(0, 0, 0),
    R_RearLampPos = Vector(-80, -25, 16),
    R_RearLampAng = Angle(0, 0, 0),
    Headlight_sprites = {Vector(76, 30, 33), Vector(76, 30, 33), Vector(76, -30, 33), Vector(76, -30, 33),},
    Headlamp_sprites = {Vector(76, 30, 33), Vector(76, 30, 33), Vector(76, -30, 33), Vector(76, -30, 33),},
}

list.Set("simfphys_lights", "Horch Type 108", light_table)

local IV = {
    Name = "Kubelwagen v2",
    Model = "models/william/kublewagen/kublebody.mdl",
    Class = "gmod_sent_vehicle_fphysics_base",
    Category = "Government Vehicles",
    SpawnOffset = Vector(0, 0, 30),
    Members = {
        Mass = 1500,
        LightsTable = "Kubelwagenv2",
        CustomWheels = true,
        CustomSuspensionTravel = 15,
        CustomWheelModel = "models/william/kublewagen/kublewheel.mdl",
        CustomWheelPosFL = Vector(53.5, 31.4, -18),
        CustomWheelPosFR = Vector(53.5, -31.4, -18),
        CustomWheelPosRL = Vector(-52.5, 31.4, -18.5),
        CustomWheelPosRR = Vector(-52.5, -31.4, -18.5),
        CustomWheelAngleOffset = Angle(0, -90, 0),
        CustomMassCenter = Vector(2, 0, -1),
        CustomSteerAngle = 35,
        SeatOffset = Vector(2, -12.4, 17),
        SeatPitch = 0,
        SeatYaw = 90,
        PassengerSeats = {
            {
                pos = Vector(9, -13, -14),
                ang = Angle(0, -90, 10)
            },
            {
                pos = Vector(-28, 12, -14),
                ang = Angle(0, -90, 10)
            },
            {
                pos = Vector(-28, -13, -14),
                ang = Angle(0, -90, 10)
            },
        },
        ExhaustPositions = {
            {
                pos = Vector(-77, 22, -14),
                ang = Angle(90, 165, 0)
            },
            {
                pos = Vector(-77, -22, -14),
                ang = Angle(90, 165, 0)
            },
        },
        FrontHeight = 6.5,
        FrontConstant = 40000,
        FrontDamping = 2200,
        FrontRelativeDamping = 2200,
        RearHeight = 6.5,
        RearConstant = 40000,
        RearDamping = 2200,
        RearRelativeDamping = 2200,
        TurnSpeed = 9,
        FastSteeringAngle = 1000,
        SteeringFadeFastSpeed = 535,
        MaxGrip = 37,
        Efficiency = 1.0,
        GripOffset = -2,
        BrakePower = 40,
        IdleRPM = 650,
        LimitRPM = 5000,
        PeakTorque = 80,
        Revlimiter = false,
        PowerbandStart = 1000,
        PowerbandEnd = 4500,
        Turbocharged = false,
        PowerBias = -1,
        EngineSoundPreset = 2,
        DifferentialGear = 0.8,
        Gears = {-0.12, 0, 0.06, 0.12, 0.21, 0.32, 0.42}
    }
}

list.Set("simfphys_vehicles", "sim_fphys_kubelwagonv2", IV)

local light_table = {
    L_HeadLampPos = Vector(150, 22, 30),
    L_HeadLampAng = Angle(0, 0, 0),
    R_HeadLampPos = Vector(150, -22, 30),
    R_HeadLampAng = Angle(0, 0, 0),
    L_RearLampPos = Vector(-80, 25, 16),
    L_RearLampAng = Angle(0, 0, 0),
    R_RearLampPos = Vector(-80, -25, 16),
    R_RearLampAng = Angle(0, 0, 0),
    Headlight_sprites = {Vector(69, 24, 3), Vector(69, 24, 3), Vector(69, -27, 3), Vector(69, -27, 3),},
    Headlamp_sprites = {Vector(68, 24, 3), Vector(69, 24, 3), Vector(69, -27, 3), Vector(69, -27, 3),},
    FogLight_sprites = {
        {
            pos = Vector(70, 27, 3),
            material = "sprites/light_ignorez",
            size = 24
        },
        {
            pos = Vector(70, 27, 3),
            material = "sprites/light_ignorez",
            size = 24
        },
        {
            pos = Vector(70, 27, 3),
            material = "sprites/light_ignorez",
            size = 24
        },
        {
            pos = Vector(70, -28, 3),
            material = "sprites/light_ignorez",
            size = 24
        },
        {
            pos = Vector(70, -28, 3),
            material = "sprites/light_ignorez",
            size = 24
        },
        {
            pos = Vector(70, -28, 3),
            material = "sprites/light_ignorez",
            size = 24
        },
    },
    Rearlight_sprites = {Vector(-80, 26.5, 7.4), Vector(-80, -26.5, 7.4),},
    Brakelight_sprites = {Vector(-80, 26.5, 7.4), Vector(-80, -26.5, 7.4),},
    Reverselight_sprites = {Vector(-80, 26.5, 7.4), Vector(-80, -26.5, 7.4),},
}

list.Set("simfphys_lights", "Kubelwagenv2", light_table)

local IV = {
    Name = "Sdkfz 222",
    Model = "models/william/sdkfz 222/sdkfz222_body.mdl",
    Class = "gmod_sent_vehicle_fphysics_base",
    Category = "Government Vehicles",
    Members = {
        Mass = 1500,
        LightsTable = "Sdkfz 222",
        CustomWheels = true,
        CustomSuspensionTravel = 15,
        CustomWheelModel = "models/william/sdkfz 222/sdkfz222_wheel.mdl",
        CustomWheelPosFL = Vector(36, -34.5, 8),
        CustomWheelPosFR = Vector(36, 34.5, 8),
        CustomWheelPosRL = Vector(-75, -34.5, 8),
        CustomWheelPosRR = Vector(-75, 34.5, 8),
        CustomWheelAngleOffset = Angle(0, -90, 0),
        CustomMassCenter = Vector(2, 0, -1),
        CustomSteerAngle = 35,
        SeatOffset = Vector(-6, -10, 46.5),
        SeatPitch = 16,
        SeatYaw = 90,
        PassengerSeats = {
            {
                pos = Vector(-43, 1, 40),
                ang = Angle(0, -90, 10)
            },
        },
        ExhaustPositions = {
            {
                pos = Vector(-77, 22, -14),
                ang = Angle(90, 165, 0)
            },
            {
                pos = Vector(-77, -22, -14),
                ang = Angle(90, 165, 0)
            },
        },
        FrontHeight = 6.5,
        FrontConstant = 40000,
        FrontDamping = 2200,
        FrontRelativeDamping = 2200,
        RearHeight = 6.5,
        RearConstant = 40000,
        RearDamping = 2200,
        RearRelativeDamping = 2200,
        TurnSpeed = 9,
        FastSteeringAngle = 1000,
        SteeringFadeFastSpeed = 535,
        MaxGrip = 37,
        Efficiency = 1.0,
        GripOffset = -2,
        BrakePower = 40,
        IdleRPM = 650,
        LimitRPM = 5000,
        PeakTorque = 80,
        Revlimiter = false,
        PowerbandStart = 1000,
        PowerbandEnd = 4500,
        Turbocharged = false,
        PowerBias = -1,
        EngineSoundPreset = 8,
        DifferentialGear = 0.8,
        Gears = {-0.12, 0, 0.06, 0.12, 0.21, 0.32, 0.42}
    }
}

list.Set("simfphys_vehicles", "sim_fphys_sdkfz222", IV)

local IV = {
    Name = "Citroen Van",
    Model = "models/william/citroen van/citroenvan_chassis.mdl",
    Class = "gmod_sent_vehicle_fphysics_base",
    Category = "Civilian Vehicles",
    Members = {
        Mass = 1500,
        LightsTable = "CitroenV",
        CustomWheels = true,
        CustomSuspensionTravel = 15,
        CustomWheelModel = "models/william/citroen van/citroenvan_tyre.mdl",
        CustomWheelPosFL = Vector(66, 31.5, 16.5),
        CustomWheelPosFR = Vector(66, -31.5, 16.5),
        CustomWheelPosRL = Vector(-65, 35.5, 18.5),
        CustomWheelPosRR = Vector(-65, -35.5, 18.5),
        CustomWheelAngleOffset = Angle(0, -90, 0),
        CustomMassCenter = Vector(2, 0, -1),
        CustomSteerAngle = 35,
        SeatOffset = Vector(-13.5, -16, 58.5),
        SeatPitch = 0,
        SeatYaw = 90,
        PassengerSeats = {
            {
                pos = Vector(-8.5, -14, 25),
                ang = Angle(0, -90, 10)
            },
        },
        ExhaustPositions = {
            {
                pos = Vector(-77, 22, -14),
                ang = Angle(90, 165, 0)
            },
            {
                pos = Vector(-77, -22, -14),
                ang = Angle(90, 165, 0)
            },
        },
        FrontHeight = 6.5,
        FrontConstant = 40000,
        FrontDamping = 2200,
        FrontRelativeDamping = 2200,
        RearHeight = 6.5,
        RearConstant = 40000,
        RearDamping = 2200,
        RearRelativeDamping = 2200,
        TurnSpeed = 9,
        FastSteeringAngle = 1000,
        SteeringFadeFastSpeed = 535,
        MaxGrip = 37,
        Efficiency = 1.0,
        GripOffset = -2,
        BrakePower = 40,
        IdleRPM = 650,
        LimitRPM = 5000,
        PeakTorque = 80,
        Revlimiter = false,
        PowerbandStart = 1000,
        PowerbandEnd = 4500,
        Turbocharged = false,
        PowerBias = -1,
        EngineSoundPreset = 9,
        DifferentialGear = 0.8,
        Gears = {-0.12, 0, 0.06, 0.12, 0.21, 0.32, 0.42}
    }
}

list.Set("simfphys_vehicles", "sim_fphys_citroenvan", IV)

local light_table = {
    L_HeadLampPos = Vector(150, 22, 30),
    L_HeadLampAng = Angle(0, 0, 0),
    R_HeadLampPos = Vector(150, -22, 30),
    R_HeadLampAng = Angle(0, 0, 0),
    L_RearLampPos = Vector(-80, 25, 16),
    L_RearLampAng = Angle(0, 0, 0),
    R_RearLampPos = Vector(-80, -25, 16),
    R_RearLampAng = Angle(0, 0, 0),
    Headlight_sprites = {Vector(88, 24, 42), Vector(88, 24, 42), Vector(88, -24, 42), Vector(88, -24, 42),},
    Headlamp_sprites = {Vector(88, 24, 42), Vector(88, 24, 42), Vector(88, -24, 42), Vector(88, -24, 42),},
    Rearlight_sprites = {Vector(-89, 34.5, 27.25), Vector(-89, -34.5, 27.25),},
    Brakelight_sprites = {Vector(-89, 34.5, 27.25), Vector(-89, -34.5, 27.25),},
    Reverselight_sprites = {Vector(-89, 34.5, 27.25), Vector(-89, -34.5, 27.25),},
}

list.Set("simfphys_lights", "CitroenV", light_table)

local IV = {
    Name = "Opel Blitz ",
    Model = "models/william/opel_blitz/opel_blitz_rigged.mdl",
    Class = "gmod_sent_vehicle_fphysics_base",
    Category = "Government Vehicles",
    Members = {
        Mass = 3500,
        CustomMassCenter = Vector(0, 0, 17),
        EnginePos = Vector(0, 70, 40),
        SpeedoMax = 60,
        LightsTable = "opel_blitz",
        CustomWheels = true,
        CustomSuspensionTravel = 20,
        CustomWheelModel = "models/william/opel_blitz/opel_f_wheel.mdl",
        CustomWheelModel_R = "models/william/opel_blitz/opel_r_wheel.mdl",
        CustomWheelPosFL = Vector(-40, 100, 20),
        CustomWheelPosFR = Vector(40, 100, 20),
        CustomWheelPosRL = Vector(-40, -65, 20),
        CustomWheelPosRR = Vector(40, -65, 20),
        CustomWheelAngleOffset = Angle(0, 0, 0),
        CustomSteerAngle = 30,
        SeatOffset = Vector(42, -17, 75),
        SeatPitch = 0,
        PassengerSeats = {
            {
                pos = Vector(17, 42, 40),
                ang = Angle(0, 0, 0)
            },
            {
                pos = Vector(-41, 0, 65),
                ang = Angle(0, -90, 10)
            },
            {
                pos = Vector(41, 0, 65),
                ang = Angle(0, 90, 10)
            },
            {
                pos = Vector(-41, -25, 65),
                ang = Angle(0, -90, 10)
            },
            {
                pos = Vector(41, -25, 65),
                ang = Angle(0, 90, 10)
            },
            {
                pos = Vector(-41, -65, 65),
                ang = Angle(0, -90, 10)
            },
            {
                pos = Vector(41, -65, 65),
                ang = Angle(0, 90, 10)
            },
        },
        ExhaustPositions = {
            {
                pos = Vector(-26, -37, 22),
                ang = Angle(-75, 0, 0)
            },
        },
        StrengthenSuspension = true,
        FrontHeight = 10,
        FrontConstant = 40000,
        FrontDamping = 2000,
        FrontRelativeDamping = 2000,
        RearHeight = 10,
        RearConstant = 40000,
        RearDamping = 2000,
        RearRelativeDamping = 2000,
        FastSteeringAngle = 19,
        SteeringFadeFastSpeed = 215,
        TurnSpeed = 1,
        MaxGrip = 70,
        Efficiency = 0.70,
        GripOffset = -2,
        BrakePower = 20,
        IdleRPM = 700,
        LimitRPM = 5000,
        PeakTorque = 80,
        PowerbandStart = 1000,
        PowerbandEnd = 4500,
        Turbocharged = false,
        Supercharged = false,
        PowerBias = 0,
        EngineSoundPreset = 0,
        Sound_Idle = "simulated_vehicles/jeep/jeep_idle.wav",
        Sound_IdlePitch = 0.8,
        Sound_Mid = "simulated_vehicles/jeep/jeep_mid.wav",
        Sound_MidPitch = 0.8,
        Sound_MidVolume = 3,
        Sound_MidFadeOutRPMpercent = 57, -- at wich percentage of limitrpm the sound fades out
        Sound_MidFadeOutRate = 0.476, --how fast it fades out   0 = instant       1 = never
        Sound_High = "simulated_vehicles/jeep/jeep_low.wav",
        Sound_HighPitch = 0.4,
        Sound_HighVolume = 7.0,
        Sound_HighFadeInRPMpercent = 30,
        Sound_HighFadeInRate = 0.19,
        Sound_Throttle = "", -- mutes the default throttle sound
        Sound_ThrottlePitch = 0,
        Sound_ThrottleVolume = 0,
        snd_horn = "simulated_vehicles/horn_1.wav",
        DifferentialGear = 0.2,
        Gears = {-0.11, 0, 0.11, 0.2, 0.28, 0.37, 0.4}
    }
}

list.Set("simfphys_vehicles", "sim_fphys_opel_blitz", IV)

local light_table = {
    L_HeadLampPos = Vector(-30, 128, 48),
    L_HeadLampAng = Angle(0, 90, 0),
    R_HeadLampPos = Vector(30, 128, 48),
    R_HeadLampAng = Angle(0, 90, 0),
    L_RearLampPos = Vector(-40, -130, 47),
    L_RearLampAng = Angle(0, -90, 0),
    R_RearLampPos = Vector(40, -130, 47),
    R_RearLampAng = Angle(0, -90, 0),
    Headlight_sprites = {Vector(-30, 128, 48), Vector(30, 128, 48),},
    Headlamp_sprites = {Vector(-30, 128, 48), Vector(30, 128, 48),},
    FogLight_sprites = {Vector(-30, 128, 48), Vector(30, 128, 48),},
    Rearlight_sprites = {Vector(-35, -130, 47), Vector(35, -130, 47),},
    Brakelight_sprites = {Vector(-35, -130, 38), Vector(35, -130, 38),},
}

list.Set("simfphys_lights", "opel_blitz", light_table)

local IV = {
    Name = "Deuce and a Half",
    Model = "models/william/deuce/cckw_chassis.mdl",
    Class = "gmod_sent_vehicle_fphysics_base",
    Category = "Government Vehicles",
    Members = {
        Mass = 1500,
        LightsTable = "deuce",
        CustomWheels = true,
        CustomSuspensionTravel = 15,
        CustomWheelModel = "models/william/deuce/cckw_tyre_f.mdl",
        CustomWheelModel_R = "models/william/deuce/cckw_tire_f.mdl",
        CustomWheelPosFL = Vector(125, -41.5, 20.5),
        CustomWheelPosFR = Vector(125, 41.5, 20.5),
        CustomWheelPosRL = Vector(-75, -35.5, 19.5),
        CustomWheelPosRR = Vector(-75, 35.5, 19.5),
        CustomWheelPosML = Vector(-24, -35.5, 19.5),
        CustomWheelPosMR = Vector(-24, 35.5, 19.5),
        CustomWheelAngleOffset = Angle(0, -90, 0),
        CustomMassCenter = Vector(2, 0, -1),
        CustomSteerAngle = 35,
        SeatOffset = Vector(50, -20, 80),
        SeatPitch = 0,
        SeatYaw = 90,
        PassengerSeats = {
            {
                pos = Vector(52, -20, 50),
                ang = Angle(0, -90, 10)
            },
            {
                pos = Vector(-15, 35, 60),
                ang = Angle(0, -180, 10)
            },
            {
                pos = Vector(-15, -35, 60),
                ang = Angle(0, 360, 10)
            },
            {
                pos = Vector(-30, 35, 60),
                ang = Angle(0, -180, 10)
            },
            {
                pos = Vector(-30, -35, 60),
                ang = Angle(0, 360, 10)
            },
        },
        ExhaustPositions = {
            {
                pos = Vector(-77, 22, -14),
                ang = Angle(90, 165, 0)
            },
            {
                pos = Vector(-77, -22, -14),
                ang = Angle(90, 165, 0)
            },
        },
        FrontHeight = 6.5,
        FrontConstant = 40000,
        FrontDamping = 2200,
        FrontRelativeDamping = 2200,
        RearHeight = 6.5,
        RearConstant = 40000,
        RearDamping = 2200,
        RearRelativeDamping = 2200,
        TurnSpeed = 9,
        FastSteeringAngle = 1000,
        SteeringFadeFastSpeed = 535,
        MaxGrip = 37,
        Efficiency = 1.0,
        GripOffset = -2,
        BrakePower = 40,
        IdleRPM = 650,
        LimitRPM = 5000,
        PeakTorque = 80,
        Revlimiter = false,
        PowerbandStart = 1000,
        PowerbandEnd = 4500,
        Turbocharged = false,
        PowerBias = -1,
        EngineSoundPreset = 8,
        DifferentialGear = 0.8,
        Gears = {-0.12, 0, 0.06, 0.12, 0.21, 0.32, 0.42}
    }
}

list.Set("simfphys_vehicles", "sim_fphys_deuce", IV)

local light_table = {
    L_HeadLampPos = Vector(150, 22, 30),
    L_HeadLampAng = Angle(0, 0, 0),
    R_HeadLampPos = Vector(150, -22, 30),
    R_HeadLampAng = Angle(0, 0, 0),
    L_RearLampPos = Vector(-80, 25, 16),
    L_RearLampAng = Angle(0, 0, 0),
    R_RearLampPos = Vector(-80, -25, 16),
    R_RearLampAng = Angle(0, 0, 0),
    Headlight_sprites = {Vector(145, 33, 51), Vector(145, 24, 53), Vector(145, -33, 51), Vector(145, -24, 53),},
    Headlamp_sprites = {Vector(145, 33, 51), Vector(145, 24, 53), Vector(145, -33, 51), Vector(145, -24, 53),},
    Rearlight_sprites = {Vector(-114, 15, 29), Vector(-114, -15, 29),},
    Brakelight_sprites = {Vector(-112, 10, 36), Vector(-112, -10, 36),},
    Reverselight_sprites = {Vector(-112, -10, 28), Vector(-112, 10, 28),},
}

list.Set("simfphys_lights", "deuce", light_table)

local IV = {
    Name = "Sonderkraftfahrzeug 251",
    Model = "models/william/german_halftrack/halftrack_body.mdl",
    Class = "gmod_sent_vehicle_fphysics_base",
    Category = "Government Vehicles",
    SpawnOffset = Vector(0, 0, 40),
    Members = {
        Mass = 1500,
        LightsTable = "halftrackG",
        CustomWheels = true,
        CustomSuspensionTravel = 15,
        CustomWheelModel = "models/william/german_halftrack/halftrack_wheel.mdl",
        --CustomWheelModel_R = "models/props_c17/canisterchunk01g.mdl",
        CustomWheelModel_R = "models/william/german_halftrack/halftrack_track_wheel_front.mdl",
        CustomWheelPosFL = Vector(95, -34.5, -25.5),
        CustomWheelPosFR = Vector(95, 31.5, -25.5),
        CustomWheelPosRL = Vector(-75, -35.5, -23.5),
        CustomWheelPosRR = Vector(-75, 35.5, -23.5),
        CustomWheelAngleOffset = Angle(0, -90, 0),
        CustomMassCenter = Vector(0, 0, 0),
        CustomSteerAngle = 35,
        SeatOffset = Vector(-1, -13, 22),
        SeatPitch = 0,
        SeatYaw = 90,
        PassengerSeats = {
            {
                pos = Vector(6, -17, -10),
                ang = Angle(0, -90, 10)
            },
            {
                pos = Vector(-26, 15, -10),
                ang = Angle(0, -180, 10)
            },
            {
                pos = Vector(-42, -15, -10),
                ang = Angle(0, 360, 10)
            },
            {
                pos = Vector(-68, 15, -10),
                ang = Angle(0, -180, 10)
            },
            {
                pos = Vector(-86, -15, -10),
                ang = Angle(0, 360, 10)
            },
        },
        ExhaustPositions = {
            {
                pos = Vector(-77, 22, -14),
                ang = Angle(90, 165, 0)
            },
            {
                pos = Vector(-77, -22, -14),
                ang = Angle(90, 165, 0)
            },
        },
        FrontHeight = 6.5,
        FrontConstant = 40000,
        FrontDamping = 2200,
        FrontRelativeDamping = 2200,
        RearHeight = 6.5,
        RearConstant = 40000,
        RearDamping = 2200,
        RearRelativeDamping = 2200,
        TurnSpeed = 9,
        FastSteeringAngle = 1000,
        SteeringFadeFastSpeed = 535,
        MaxGrip = 37,
        Efficiency = 1.0,
        GripOffset = -2,
        BrakePower = 40,
        IdleRPM = 650,
        LimitRPM = 5000,
        PeakTorque = 80,
        Revlimiter = false,
        PowerbandStart = 1000,
        PowerbandEnd = 4500,
        Turbocharged = false,
        PowerBias = -1,
        EngineSoundPreset = 8,
        DifferentialGear = 0.8,
        Gears = {-0.12, 0, 0.06, 0.12, 0.21, 0.32, 0.42}
    }
}

list.Set("simfphys_vehicles", "sim_fphys_halftrackG", IV)

local light_table = {
    L_HeadLampPos = Vector(150, 22, 30),
    L_HeadLampAng = Angle(0, 0, 0),
    R_HeadLampPos = Vector(150, -22, 30),
    R_HeadLampAng = Angle(0, 0, 0),
    L_RearLampPos = Vector(-80, 25, 16),
    L_RearLampAng = Angle(0, 0, 0),
    R_RearLampPos = Vector(-80, -25, 16),
    R_RearLampAng = Angle(0, 0, 0),
    Headlight_sprites = {Vector(116, 26, 2), Vector(116, 26, 2), Vector(116, -28, 2), Vector(116, -28, 2),},
    Headlamp_sprites = {Vector(116, 26, 2), Vector(116, 26, 2), Vector(116, -28, 2), Vector(116, -28, 2),},
    Rearlight_sprites = {Vector(-89, -38.5, 0), Vector(-89, -38.5, 0),},
    Brakelight_sprites = {Vector(-89, -38.5, 0), Vector(-89, -38.5, 0),},
    Reverselight_sprites = {Vector(-89, -38.5, 0), Vector(-89, -38.5, 0),},
}

list.Set("simfphys_lights", "halftrackG", light_table)

local IV = {
    Name = "Opel Olympia Staff Car",
    Model = "models/william/opel_o/opel_o_body.mdl",
    Class = "gmod_sent_vehicle_fphysics_base",
    Category = "Civilian Vehicles",
    SpawnOffset = Vector(0, 0, 40),
    Members = {
        Mass = 1500,
        LightsTable = "opelolym",
        CustomWheels = true,
        CustomSuspensionTravel = 15,
        CustomWheelModel = "models/william/opel_o/opel_o_wheel.mdl",
        CustomWheelPosFL = Vector(65, -33.5, -20.5),
        CustomWheelPosFR = Vector(65, 28.5, -20.5),
        CustomWheelPosRL = Vector(-53, -35.5, -21.5),
        CustomWheelPosRR = Vector(-53, 30.5, -21.5),
        CustomWheelAngleOffset = Angle(0, -90, 0),
        CustomMassCenter = Vector(2, 0, -1),
        CustomSteerAngle = 35,
        SeatOffset = Vector(-9.5, -12, 18.5),
        SeatPitch = 0,
        SeatYaw = 90,
        PassengerSeats = {
            {
                pos = Vector(-2.5, -16, -15),
                ang = Angle(0, -90, 10)
            },
            {
                pos = Vector(-40.5, 13, -15),
                ang = Angle(0, -90, 10)
            },
            {
                pos = Vector(-40.5, -15, -15),
                ang = Angle(0, -90, 10)
            },
        },
        ExhaustPositions = {
            {
                pos = Vector(-77, 22, -14),
                ang = Angle(90, 165, 0)
            },
            {
                pos = Vector(-77, -22, -14),
                ang = Angle(90, 165, 0)
            },
        },
        FrontHeight = 6.5,
        FrontConstant = 40000,
        FrontDamping = 2200,
        FrontRelativeDamping = 2200,
        RearHeight = 6.5,
        RearConstant = 40000,
        RearDamping = 2200,
        RearRelativeDamping = 2200,
        TurnSpeed = 9,
        FastSteeringAngle = 1000,
        SteeringFadeFastSpeed = 535,
        MaxGrip = 37,
        Efficiency = 1.0,
        GripOffset = -2,
        BrakePower = 40,
        IdleRPM = 650,
        LimitRPM = 5000,
        PeakTorque = 80,
        Revlimiter = false,
        PowerbandStart = 1000,
        PowerbandEnd = 4500,
        Turbocharged = false,
        PowerBias = -1,
        EngineSoundPreset = 1,
        DifferentialGear = 0.8,
        Gears = {-0.12, 0, 0.06, 0.12, 0.21, 0.32, 0.42}
    }
}

list.Set("simfphys_vehicles", "sim_fphys_opelolym", IV)

local light_table = {
    L_HeadLampPos = Vector(150, 22, 30),
    L_HeadLampAng = Angle(0, 0, 0),
    R_HeadLampPos = Vector(150, -22, 30),
    R_HeadLampAng = Angle(0, 0, 0),
    L_RearLampPos = Vector(-80, 25, 16),
    L_RearLampAng = Angle(0, 0, 0),
    R_RearLampPos = Vector(-80, -25, 16),
    R_RearLampAng = Angle(0, 0, 0),
    Headlight_sprites = {Vector(81, 20, 5), Vector(81, 20, 5), Vector(81, -24, 5), Vector(81, -24, 5),},
    Headlamp_sprites = {Vector(81, 20, 5), Vector(81, 20, 5), Vector(81, -24, 5), Vector(81, -24, 5),},
    Rearlight_sprites = {Vector(-100, 12.75, -16.7), Vector(-100, -18, -16.7),},
    Brakelight_sprites = {Vector(-100, 12.75, -16.7), Vector(-100, -18, -16.7),},
    Reverselight_sprites = {Vector(-100, 12.75, -16.7), Vector(-100, -18, -16.7),},
}

list.Set("simfphys_lights", "opelolym", light_table)

local IV = {
    Name = "Ordnungspolizei Fire Truck",
    Model = "models/william/opelft/opelft_body.mdl",
    Class = "gmod_sent_vehicle_fphysics_base",
    Category = "Government Vehicles",
    SpawnOffset = Vector(0, 0, 65),
    Members = {
        Mass = 1500,
        LightsTable = "orpoft",
        CustomWheels = true,
        CustomSuspensionTravel = 15,
        CustomWheelModel = "models/william/opel_blitz/opel_f_wheel.mdl",
        CustomWheelModel_R = "models/william/opel_blitz/opel_r_wheel.mdl",
        CustomWheelPosFL = Vector(124.5, 36.75, -46.5),
        CustomWheelPosFR = Vector(124.5, -30.75, -46.5),
        CustomWheelPosRL = Vector(-26.5, 32.75, -49.5),
        CustomWheelPosRR = Vector(-26.5, -23.75, -49.5),
        CustomWheelAngleOffset = Angle(0, 0, 0),
        CustomMassCenter = Vector(2, 0, -1),
        CustomSteerAngle = 35,
        SeatOffset = Vector(68, -19, 8),
        SeatPitch = 0,
        SeatYaw = 90,
        PassengerSeats = {
            {
                pos = Vector(75, -13, -26),
                ang = Angle(0, -90, 10)
            },
            {
                pos = Vector(43, -16, -24),
                ang = Angle(0, 90, 10)
            },
            {
                pos = Vector(43, 16, -24),
                ang = Angle(0, 90, 10)
            },
            {
                pos = Vector(13, 16, -24),
                ang = Angle(0, -90, 10)
            },
            {
                pos = Vector(13, -16, -24),
                ang = Angle(0, -90, 10)
            },
        },
        ExhaustPositions = {
            {
                pos = Vector(-77, 22, -1004),
                ang = Angle(90, 165, 0)
            },
            {
                pos = Vector(-77, -22, -1004),
                ang = Angle(90, 165, 0)
            },
        },
        FrontHeight = 6.5,
        FrontConstant = 40000,
        FrontDamping = 2200,
        FrontRelativeDamping = 2200,
        RearHeight = 6.5,
        RearConstant = 40000,
        RearDamping = 2200,
        RearRelativeDamping = 2200,
        TurnSpeed = 6,
        FastSteeringAngle = 1000,
        SteeringFadeFastSpeed = 535,
        MaxGrip = 37,
        Efficiency = 1.0,
        GripOffset = -2,
        BrakePower = 40,
        IdleRPM = 400,
        LimitRPM = 4500,
        PeakTorque = 80,
        Revlimiter = false,
        PowerbandStart = 1000,
        PowerbandEnd = 4500,
        Turbocharged = false,
        PowerBias = -1,
        EngineSoundPreset = 8,
        DifferentialGear = 0.8,
        Gears = {-0.12, 0, 0.06, 0.12, 0.21, 0.32, 0.42}
    }
}

list.Set("simfphys_vehicles", "sim_fphys_orpoft", IV)

local light_table = {
    L_HeadLampPos = Vector(150, 22, 30),
    L_HeadLampAng = Angle(0, 0, 0),
    R_HeadLampPos = Vector(150, -22, 30),
    R_HeadLampAng = Angle(0, 0, 0),
    L_RearLampPos = Vector(-80, 25, 16),
    L_RearLampAng = Angle(0, 0, 0),
    R_RearLampPos = Vector(-80, -25, 16),
    R_RearLampAng = Angle(0, 0, 0),
    Headlight_sprites = {Vector(148, 27, -23), Vector(148, -22, -23), Vector(148, 27, -23), Vector(148, -22, -23),},
    ems_sounds = {"simulated_vehicles/police/ordnungsiren2.wav", "simulated_vehicles/police/ordnungsiren.wav", "common/null.wav"},
    --ems_sounds = {"simulated_vehicles/police/siren_madmax.wav","common/null.wav"},
    ems_sprites = {
        {
            pos = Vector(90, 25, 24),
            size = 60,
            material = "sprites/light_ignorez",
            Colors = {Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0)},
            Speed = 0.07,
        },
        {
            pos = Vector(90, 25, 24),
            size = 60,
            material = "sprites/light_ignorez",
            Colors = {Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0)},
            Speed = 0.07,
        },
        {
            pos = Vector(90, 25, 24),
            size = 60,
            material = "sprites/light_ignorez",
            Colors = {Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0)},
            Speed = 0.07,
        },
        {
            pos = Vector(90, 25, 24),
            size = 60,
            material = "sprites/light_ignorez",
            Colors = {Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0)},
            Speed = 0.07,
        },
        {
            pos = Vector(90, 25, 24),
            size = 60,
            material = "sprites/light_ignorez",
            Colors = {Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0)},
            Speed = 0.07,
        },
        {
            pos = Vector(90, 25, 24),
            size = 60,
            material = "sprites/light_ignorez",
            Colors = {Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0)},
            Speed = 0.07,
        },
        {
            pos = Vector(90, 25, 24),
            size = 60,
            material = "sprites/light_ignorez",
            Colors = {Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0)},
            Speed = 0.07,
        },
        {
            pos = Vector(90, 25, 24),
            size = 60,
            material = "sprites/light_ignorez",
            Colors = {Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0)},
            Speed = 0.07,
        },
        {
            pos = Vector(90, 25, 24),
            size = 60,
            material = "sprites/light_ignorez",
            Colors = {Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0)},
            Speed = 0.07,
        },
        {
            pos = Vector(90, -20, 24),
            size = 60,
            material = "sprites/light_ignorez",
            Colors = {Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0)},
            Speed = 0.07,
        },
        {
            pos = Vector(90, -20, 24),
            size = 60,
            material = "sprites/light_ignorez",
            Colors = {Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0)},
            Speed = 0.07,
        },
        {
            pos = Vector(90, -20, 24),
            size = 60,
            material = "sprites/light_ignorez",
            Colors = {Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0)},
            Speed = 0.07,
        },
        {
            pos = Vector(90, -20, 24),
            size = 60,
            material = "sprites/light_ignorez",
            Colors = {Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0)},
            Speed = 0.07,
        },
        {
            pos = Vector(90, -20, 24),
            size = 60,
            material = "sprites/light_ignorez",
            Colors = {Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0)},
            Speed = 0.07,
        },
        {
            pos = Vector(90, -20, 24),
            size = 60,
            material = "sprites/light_ignorez",
            Colors = {Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0)},
            Speed = 0.07,
        },
        {
            pos = Vector(90, -20, 24),
            size = 60,
            material = "sprites/light_ignorez",
            Colors = {Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0)},
            Speed = 0.07,
        },
        {
            pos = Vector(90, -20, 24),
            size = 60,
            material = "sprites/light_ignorez",
            Colors = {Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0)},
            Speed = 0.07,
        },
        {
            pos = Vector(90, -20, 24),
            size = 60,
            material = "sprites/light_ignorez",
            Colors = {Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 150, 255, 255), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0), Color(0, 0, 0, 0)},
            Speed = 0.07,
        },
    },
    Headlamp_sprites = {Vector(148, 27, -23), Vector(148, -22, -23), Vector(148, 27, -23), Vector(148, -22, -23),},
    Rearlight_sprites = {Vector(-84, 34, -27), Vector(-84, -23, -27),},
    Brakelight_sprites = {Vector(-84, 34, -27), Vector(-84, -23, -27),},
    Reverselight_sprites = {Vector(-84, 34, -27), Vector(-84, -23, -27),},
}

list.Set("simfphys_lights", "orpoft", light_table)

local IV = {
    Name = "Krupp Protze",
    Model = "models/william/krupp/krupphull.mdl",
    Class = "gmod_sent_vehicle_fphysics_base",
    Category = "Government Vehicles",
    SpawnOffset = Vector(0, 0, 50),
    Members = {
        Mass = 1500,
        LightsTable = "krupp",
        CustomWheels = true,
        CustomSuspensionTravel = 15,
        CustomWheelModel = "models/william/krupp/kruppwheel.mdl",
        CustomWheelPosFL = Vector(65, 37, -24),
        CustomWheelPosFR = Vector(65, -38, -24),
        CustomWheelPosML = Vector(-49, 33.5, -24),
        CustomWheelPosMR = Vector(-49, -34.5, -24),
        CustomWheelPosRL = Vector(-89, 33.5, -24),
        CustomWheelPosRR = Vector(-89, -34.5, -24),
        CustomWheelAngleOffset = Angle(0, -90, 0),
        CustomMassCenter = Vector(2, 0, -1),
        CustomSteerAngle = 35,
        SeatOffset = Vector(0.5, -12, 20.5),
        SeatPitch = 0,
        SeatYaw = 90,
        PassengerSeats = {
            {
                pos = Vector(7.5, -12, -9),
                ang = Angle(0, -90, 10)
            },
            {
                pos = Vector(-28, 34, 7),
                ang = Angle(0, 180, -10)
            },
            {
                pos = Vector(-28, -28, 7),
                ang = Angle(0, -360, -10)
            },
            {
                pos = Vector(-61, 34, 7),
                ang = Angle(0, 180, -10)
            },
            {
                pos = Vector(-61, -28, 7),
                ang = Angle(0, -360, -10)
            },
            {
                pos = Vector(-101, 34, 7),
                ang = Angle(0, 180, -10)
            },
            {
                pos = Vector(-101, -28, 7),
                ang = Angle(0, -360, -10)
            },
        },
        ExhaustPositions = {
            {
                pos = Vector(-77, 22, -14),
                ang = Angle(90, 165, 0)
            },
            {
                pos = Vector(-77, -22, -14),
                ang = Angle(90, 165, 0)
            },
        },
        FrontHeight = 6.5,
        FrontConstant = 40000,
        FrontDamping = 2200,
        FrontRelativeDamping = 2200,
        RearHeight = 6.5,
        RearConstant = 40000,
        RearDamping = 2200,
        RearRelativeDamping = 2200,
        TurnSpeed = 9,
        FastSteeringAngle = 1000,
        SteeringFadeFastSpeed = 535,
        MaxGrip = 37,
        Efficiency = 1.0,
        GripOffset = -2,
        BrakePower = 40,
        IdleRPM = 650,
        LimitRPM = 5000,
        PeakTorque = 80,
        Revlimiter = false,
        PowerbandStart = 1000,
        PowerbandEnd = 4500,
        Turbocharged = false,
        PowerBias = -1,
        EngineSoundPreset = 11,
        DifferentialGear = 0.8,
        Gears = {-0.12, 0, 0.06, 0.12, 0.21, 0.32, 0.42}
    }
}

list.Set("simfphys_vehicles", "sim_fphys_krupp", IV)

local light_table = {
    L_HeadLampPos = Vector(150, 22, 30),
    L_HeadLampAng = Angle(0, 0, 0),
    R_HeadLampPos = Vector(150, -22, 30),
    R_HeadLampAng = Angle(0, 0, 0),
    L_RearLampPos = Vector(-80, 25, 16),
    L_RearLampAng = Angle(0, 0, 0),
    R_RearLampPos = Vector(-80, -25, 16),
    R_RearLampAng = Angle(0, 0, 0),
    Headlight_sprites = {Vector(88, 26, -4.5), Vector(88, 26, -4.5), Vector(88, -26.6, -4.5), Vector(88, -26.6, -4.5),},
    Headlamp_sprites = {Vector(88, 26, -4.5), Vector(88, 26, -4.5), Vector(88, -26.6, -4.5), Vector(88, -26.6, -4.5),},
    Vector(-155, 37.8, -28), Vector(-155, -33.6, -28), Vector(-155, 37.8, -28), Vector(-155, -33.6, -28), Vector(-155, 37.8, -28), Vector(-155, -33.6, -28),
}

--Rearlight_sprites = {
--},
--Brakelight_sprites = {
--},
--Reverselight_sprites = {
--},
list.Set("simfphys_lights", "krupp", light_table)