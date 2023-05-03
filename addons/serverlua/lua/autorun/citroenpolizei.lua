local light_table = {
    L_HeadLampPos = Vector(150, 22, 30),
    L_HeadLampAng = Angle(0, 0, 0),
    R_HeadLampPos = Vector(150, -22, 30),
    R_HeadLampAng = Angle(0, 0, 0),
    --L_RearLampPos = Vector(-80,25,16), --L_RearLampAng = Angle(0, 0, 0), --R_RearLampPos = Vector(-80,-25,16), --R_RearLampAng = Angle(0,0,0),
    Headlight_sprites = {Vector(74, 18, 37), Vector(74, 16, 38), Vector(74, 20, 37), Vector(74, -18, 37), Vector(74, -16, 38), Vector(74, -20, 37),},
    Headlamp_sprites = {Vector(74, 18, 37), Vector(74, 16, 38), Vector(74, 20, 37), Vector(74, -18, 37), Vector(74, -16, 38), Vector(74, -20, 37),},
    Rearlight_sprites = {Vector(-76, 26.5, 20), Vector(-76, 26.5, 20), Vector(-76, -26.5, 20), Vector(-76, -26.5, 20),},
    Brakelight_sprites = {Vector(-76, 26.5, 20), Vector(-76, -26.5, 20),},
    Reverselight_sprites = {Vector(-76, 26.5, 20), Vector(-76, -26.5, 20),},
    DelayOn = 0.1,
    DelayOff = 0.1,
    ems_sounds = {"polizei/siren.wav"},
    ems_sprites = {
        {
            pos = Vector(-21, 0, 70),
            material = "sprites/light_glow02_add_noz",
            size = 80,
            Colors = {Color(0, 100, 205, 255), Color(0, 150, 255, 255)}, -- the script will go from color to color
            Speed = 0.5, -- for how long each color will be drawn
            
        }
    }
}

list.Set("simfphys_lights", "citroenpolizei_rigged", light_table)

local V = {
    Name = "Citroen Avant (Polizei)",
    Model = "models/wilhelm/polcitroen_rigged.mdl", -- models/william/opelblitz_cod.mdl
    Class = "gmod_sent_vehicle_fphysics_base",
    Category = "William's WW2 Vehicles",
    Members = {
        Mass = 1200,
        LightsTable = "citroenpolizei_rigged",
        FrontWheelRadius = 13,
        RearWheelRadius = 13,
        SeatOffset = Vector(-14, -10, 48),
        SeatPitch = 10,
        SeatYaw = 93,
        PassengerSeats = {
            {
                pos = Vector(4, -12, 14),
                ang = Angle(0, -90, 15)
            },
            {
                pos = Vector(-32, 12, 14),
                ang = Angle(0, -90, 15)
            },
            {
                pos = Vector(-32, -12, 14),
                ang = Angle(0, -90, 15)
            },
        },
        FrontHeight = 9,
        FrontConstant = 27000,
        FrontDamping = 2800,
        FrontRelativeDamping = 2800,
        RearHeight = 6,
        RearConstant = 32000,
        RearDamping = 2900,
        RearRelativeDamping = 2900,
        FastSteeringAngle = 20,
        SteeringFadeFastSpeed = 535,
        StrengthenSuspension = false,
        TurnSpeed = 8,
        MaxGrip = 44,
        Efficiency = 1,
        GripOffset = 0,
        BrakePower = 40,
        BulletProofTires = false,
        IdleRPM = 750,
        LimitRPM = 6500,
        PeakTorque = 100,
        PowerbandStart = 2200,
        PowerbandEnd = 6300,
        FuelFillPos = Vector(17.64, -14.55, 30.06),
        FuelType = FUELTYPE_PETROL,
        FuelTankSize = 65,
        PowerBias = 0.5,
        --EngineSoundPreset = 1,
        EngineSoundPreset = -1,
        ExhaustPositions = {
            --Left side
            {
                pos = Vector(-96, 26, 15),
                ang = Angle(-90, -90, 0)
            },
            {
                pos = Vector(-96, 26, 15),
                ang = Angle(-90, -90, 0)
            },
            {
                pos = Vector(-96, 26, 15),
                ang = Angle(-90, -90, 0)
            },
        },
        snd_pitch = 1,
        snd_idle = "simulated_vehicles/jeep/jeep_idle.wav",
        snd_low = "simulated_vehicles/jeep/jeep_low.wav",
        snd_low_revdown = "simulated_vehicles/jeep/jeep_revdown.wav",
        snd_low_pitch = 0.9,
        snd_mid = "simulated_vehicles/jeep/jeep_mid.wav",
        snd_mid_gearup = "simulated_vehicles/jeep/jeep_second.wav",
        snd_mid_pitch = 1,
        snd_horn = "simulated_vehicles/horn_1.wav",
        ForceTransmission = 1,
        DifferentialGear = 0.3,
        Gears = {-0.15, 0, 0.15, 0.25, 0.35, 0.45}
    }
}

list.Set("simfphys_vehicles", "sim_fphy_citroenpolizeiRigged", V)