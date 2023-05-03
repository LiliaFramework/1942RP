
local tableinsert = table.insert
gred = gred or {}
gred.AddonList = gred.AddonList or {}
tableinsert(gred.AddonList,1131455085) -- Base addon
tableinsert(gred.AddonList,771487490) -- simfphys
tableinsert(gred.AddonList,831680603) -- simfphys armed

local Type
function table.FullCopy(tab)
	if (!tab) then return nil end
	
	local res = {}
	for k,v in pairs(tab) do
		Type = type(v)
		
		if Type == "table" then
			res[k] = table.FullCopy(v)
		elseif Type == "Vector" then
			res[k] = Vector(v.x,v.y,v.z)
		elseif Type == "Angle" then
			res[k] = Angle(v.p,v.y,v.r)
		else
			res[k] = v
		end
	end
	
	return res
end

list.Set("simfphys_lights","panzer_4_f1",{
	L_HeadLampPos = Vector(100.012,43.78,59.972),
	L_HeadLampAng = Angle(15,0,0),
	R_HeadLampPos = Vector(100.012,-43.78,59.972),
	R_HeadLampAng = Angle(15,0,0),
	Headlight_sprites = { 
		Vector(97.064,48.312,61.776),
		Vector(100.012,43.78,59.972),
		Vector(100.012,-43.78,59.972),
	},
	Rearlight_sprites = {
		Vector(-126.456,51,43.802),
	},
	Brakelight_sprites = {
		Vector(-101.772,56.542,59.86),
		Vector(-106.304,-56.076,57.948),
	},
})

list.Set("simfphys_vehicles","gred_simfphys_panzerivd",{
	Name = "Panzerkampfwagen IV Ausf. D",
	Model = Model("models/gredwitch/panzer_IV_F1/pzIV_F1.mdl"),
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Gredwitch's Stuff",
	SpawnOffset = Vector(0,0,30),
	SpawnAngleOffset = 0,

	Members = {
		Mass = 8000,
		AirFriction = 16,
		Inertia = Vector(20000,80000,100000),
		
		LightsTable = "panzer_4_f1",
		
		ApplyDamage = function( ent, damage, type ) 
			simfphys.TankApplyDamage(ent, damage, type)
		end,
		
		OnDestroyed = function(ent)
			local gib = ent.Gib
			if !IsValid(gib) then return end
			
			local pos,ang,skin,pitch,yaw = gib:GetPos(),gib:GetAngles(),gib:GetSkin(),ent:GetPoseParameter("spin_cannon"),ent:GetPoseParameter("spin_tower")
			gib:SetPoseParameter("spin_cannon",pitch)
			gib:SetPoseParameter("spin_tower",yaw)
			
			local function CreateAmmoFire(gib,ang)
				local bonepos = gib:GetBonePosition(gib:LookupBone("tower"))
				gib.AmmoFire = ents.Create("info_particle_system")
				gib.AmmoFire:SetKeyValue("effect_name","flame_jet")
				gib.AmmoFire:SetKeyValue("start_active",1)
				gib.AmmoFire:SetOwner(gib)
				gib.AmmoFire:SetPos(bonepos)
				gib.AmmoFire:SetAngles(ang)
				gib.AmmoFire:Spawn()
				gib.AmmoFire:Activate()
				gib.AmmoFire:SetParent(gib)
				
				gib.AmmoFireSound = CreateSound(gib,"gredwitch/burning_jet.wav")
				gib.AmmoFireSound:SetSoundLevel(120)
				gib.AmmoFireSound:Play()
				gib:CallOnRemove("removesnd",function(gib)
					gib.AmmoFireSound:Stop()
				end)
			end
			
			local function CreateTurret(gib,ang,pitch,yaw)
				for i = 1,12 do
					gib:SetBodygroup(i,1)
				end
				
				local bonepos = gib:GetBonePosition(gib:LookupBone("tower"))
				local prop = ents.Create("prop_physics")
				prop:SetModel("models/gredwitch/panzer_IV_F1/pziv_f1_turret.mdl")
				prop:SetAngles(ang + Angle(pitch,yaw))
				prop:SetPos(bonepos)
				prop:Spawn()
				prop:Activate()
				prop:SetMaterial( "models/player/player_chrome1" )
				prop:SetRenderMode( RENDERMODE_TRANSALPHA )
				gib.Turret = prop
				
				local phys = prop:GetPhysicsObject()
				if IsValid(phys) then
					phys:AddVelocity(gib:GetUp()*1200)
					phys:AddAngleVelocity(VectorRand()*math.random(600,1200))
				end
				
				gib:CallOnRemove("removeturret",function(gib)
					if IsValid(gib.Turret) then gib.Turret:Remove() end
				end)
			end
			
			local function StopAmmoFire(gib)
				gib.AmmoFire:Remove()
				gib.AmmoFireSound:Stop()
			end
			
			local function CreateExplosion(gib,ang)
				local pos = gib:LocalToWorld(Vector(-10,0,40))
				net.Start("gred_net_createparticle")
					net.WriteString("doi_flak88_explosion")
					net.WriteVector(pos)
					net.WriteAngle(ang)
					net.WriteBool(false)
				net.Broadcast()
				gred.CreateSound(pos,false,"explosions/fuel_depot_explode_close.wav","explosions/fuel_depot_explode_dist.wav","explosions/fuel_depot_explode_far.wav")
			end
			
			gred.TankDestruction(ent,gib,ang,skin,pitch,yaw,CreateAmmoFire,StopAmmoFire,CreateExplosion,CreateTurret)
		end,
		
		
		MaxHealth = 2593,
		
		IsArmored = true,
		
		NoWheelGibs = true,
		
		FirstPersonViewPos = Vector(-10,-30,20),
		
		FrontWheelRadius = 35,
		RearWheelRadius = 35,
		
		EnginePos = Vector(-70,2,70),
		
		CustomWheels = true,
		
		-- CustomWheelModel = "models/hunter/blocks/cube1x1x1.mdl",
		CustomWheelModel = "models/mm1/box.mdl",
		
		CustomWheelPosFL = Vector(70,30,20),
		CustomWheelPosFR = Vector(70,-30,20),
		
		CustomWheelPosML = Vector(0,30,20),
		CustomWheelPosMR = Vector(0,-30,20),
		
		CustomWheelPosRL = Vector(-80,30,20),
		CustomWheelPosRR = Vector(-80,-30,20),
		CustomWheelAngleOffset = Angle(0,180,0),
		CustomWheelAngleOffset = Angle(0,180,0),
		
		-- CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 30,
		
		TurnSpeed = 10,
		
		SeatOffset = Vector(50,-20,47),
		SeatPitch = 0,
		SeatYaw = 90,
		
		
		ExhaustPositions = {
			{
				pos = Vector(-113.4,-6.5,56),
				ang = Angle(-18,30,0)
			},
		},
		
		
		PassengerSeats = {
			{
				pos = Vector(55,-28,17),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-17,20,52),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-17,-15,50),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-32,2,58),
				ang = Angle(0,-90,0)
			},
		},
		
		CustomSuspensionTravel = 10,
		
		FrontHeight = -0,
		FrontConstant = 800000,
		FrontDamping = 9000000000,
		FrontRelativeDamping = 9000000000,
		
		RearHeight = -0,
		RearConstant = 800000,
		RearDamping = 9000000000,
		RearRelativeDamping = 9000000000,
		
		MaxGrip = 800,
		Efficiency = 0.8,
		GripOffset = 0,
		BrakePower = 80,
		BulletProofTires = true,
		
		IdleRPM = 600,
		LimitRPM = 3000,
		PeakTorque = 100,
		PowerbandStart = 600,
		PowerbandEnd = 2500,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		
		FuelFillPos = Vector(-102.19,-25.74,57.882),
		FuelType = FUELTYPE_DIESEL,
		FuelTankSize = 470,
		
		PowerBias = -0.3,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "gredwitch/panzer_iv/panzer4_engine_rpm_00.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "gredwitch/panzer_iv/panzer4_engine_rpm_66_load.wav",
		Sound_MidPitch = 1.5,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 100,
		Sound_MidFadeOutRate = 1,
		
		Sound_High = "gredwitch/panzer_iv/panzer4_engine_rpm_99_load.wav",
		Sound_HighPitch = 1.5,
		Sound_HighVolume = 1,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.2,
		
		Sound_Throttle = "",
		Sound_ThrottlePitch = 0,
		Sound_ThrottleVolume = 0,
		
		snd_horn = "common/null.wav",
		-- ForceTransmission = 1,
		
		DifferentialGear = 0.3,
		Gears = {-0.01,0,0.04,0.06,0.09,0.12,0.16}
	}
})
list.Set("simfphys_vehicles","gred_simfphys_panzerivf1",{
	Name = "Panzerkampfwagen IV Ausf. F1",
	Model = Model("models/gredwitch/panzer_IV_F1/pzIV_F1.mdl"),
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Gredwitch's Stuff",
	SpawnOffset = Vector(0,0,30),
	SpawnAngleOffset = 0,

	Members = {
		Mass = 8000,
		AirFriction = 16,
		Inertia = Vector(20000,80000,100000),
		
		LightsTable = "panzer_4_f1",
		
		ApplyDamage = function( ent, damage, type ) 
			simfphys.TankApplyDamage(ent, damage, type)
		end,
		
		OnDestroyed = function(ent)
			local gib = ent.Gib
			if !IsValid(gib) then return end
			
			local pos,ang,skin,pitch,yaw = gib:GetPos(),gib:GetAngles(),gib:GetSkin(),ent:GetPoseParameter("spin_cannon"),ent:GetPoseParameter("spin_tower")
			gib:SetPoseParameter("spin_cannon",pitch)
			gib:SetPoseParameter("spin_tower",yaw)
			
			local function CreateAmmoFire(gib,ang)
				local bonepos = gib:GetBonePosition(gib:LookupBone("tower"))
				gib.AmmoFire = ents.Create("info_particle_system")
				gib.AmmoFire:SetKeyValue("effect_name","flame_jet")
				gib.AmmoFire:SetKeyValue("start_active",1)
				gib.AmmoFire:SetOwner(gib)
				gib.AmmoFire:SetPos(bonepos)
				gib.AmmoFire:SetAngles(ang)
				gib.AmmoFire:Spawn()
				gib.AmmoFire:Activate()
				gib.AmmoFire:SetParent(gib)
				
				gib.AmmoFireSound = CreateSound(gib,"gredwitch/burning_jet.wav")
				gib.AmmoFireSound:SetSoundLevel(120)
				gib.AmmoFireSound:Play()
				gib:CallOnRemove("removesnd",function(gib)
					gib.AmmoFireSound:Stop()
				end)
			end
			
			local function CreateTurret(gib,ang,pitch,yaw)
				for i = 1,12 do
					gib:SetBodygroup(i,1)
				end
				
				local bonepos = gib:GetBonePosition(gib:LookupBone("tower"))
				local prop = ents.Create("prop_physics")
				prop:SetModel("models/gredwitch/panzer_IV_F1/pziv_f1_turret.mdl")
				prop:SetAngles(ang + Angle(pitch,yaw))
				prop:SetPos(bonepos)
				prop:Spawn()
				prop:Activate()
				prop:SetMaterial( "models/player/player_chrome1" )
				prop:SetRenderMode( RENDERMODE_TRANSALPHA )
				gib.Turret = prop
				
				local phys = prop:GetPhysicsObject()
				if IsValid(phys) then
					phys:AddVelocity(gib:GetUp()*1200)
					phys:AddAngleVelocity(VectorRand()*math.random(600,1200))
				end
				
				gib:CallOnRemove("removeturret",function(gib)
					if IsValid(gib.Turret) then gib.Turret:Remove() end
				end)
			end
			
			local function StopAmmoFire(gib)
				gib.AmmoFire:Remove()
				gib.AmmoFireSound:Stop()
			end
			
			local function CreateExplosion(gib,ang)
				local pos = gib:LocalToWorld(Vector(-10,0,40))
				net.Start("gred_net_createparticle")
					net.WriteString("doi_flak88_explosion")
					net.WriteVector(pos)
					net.WriteAngle(ang)
					net.WriteBool(false)
				net.Broadcast()
				gred.CreateSound(pos,false,"explosions/fuel_depot_explode_close.wav","explosions/fuel_depot_explode_dist.wav","explosions/fuel_depot_explode_far.wav")
			end
			
			gred.TankDestruction(ent,gib,ang,skin,pitch,yaw,CreateAmmoFire,StopAmmoFire,CreateExplosion,CreateTurret)
		end,
		
		
		MaxHealth = 3077,
		
		IsArmored = true,
		
		NoWheelGibs = true,
		
		FirstPersonViewPos = Vector(-10,-30,20),
		
		FrontWheelRadius = 35,
		RearWheelRadius = 35,
		
		EnginePos = Vector(-70,2,70),
		
		CustomWheels = true,
		
		-- CustomWheelModel = "models/hunter/blocks/cube1x1x1.mdl",
		CustomWheelModel = "models/mm1/box.mdl",
		
		CustomWheelPosFL = Vector(70,30,20),
		CustomWheelPosFR = Vector(70,-30,20),
		
		CustomWheelPosML = Vector(0,30,20),
		CustomWheelPosMR = Vector(0,-30,20),
		
		CustomWheelPosRL = Vector(-80,30,20),
		CustomWheelPosRR = Vector(-80,-30,20),
		CustomWheelAngleOffset = Angle(0,180,0),
		CustomWheelAngleOffset = Angle(0,180,0),
		
		-- CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 30,
		
		TurnSpeed = 10,
		
		SeatOffset = Vector(50,-20,47),
		SeatPitch = 0,
		SeatYaw = 90,
		
		
		ExhaustPositions = {
			{
				pos = Vector(-113.4,-6.5,56),
				ang = Angle(-18,30,0)
			},
		},
		
		
		PassengerSeats = {
			{
				pos = Vector(55,-28,17),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-17,20,52),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-17,-15,50),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-32,2,58),
				ang = Angle(0,-90,0)
			},
		},
		
		CustomSuspensionTravel = 10,
		
		FrontHeight = -0,
		FrontConstant = 800000,
		FrontDamping = 9000000000,
		FrontRelativeDamping = 9000000000,
		
		RearHeight = -0,
		RearConstant = 800000,
		RearDamping = 9000000000,
		RearRelativeDamping = 9000000000,
		
		MaxGrip = 800,
		Efficiency = 0.8,
		GripOffset = 0,
		BrakePower = 80,
		BulletProofTires = true,
		
		IdleRPM = 600,
		LimitRPM = 3000,
		PeakTorque = 100,
		PowerbandStart = 600,
		PowerbandEnd = 2500,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		
		FuelFillPos = Vector(-102.19,-25.74,57.882),
		FuelType = FUELTYPE_DIESEL,
		FuelTankSize = 470,
		
		PowerBias = -0.3,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "gredwitch/panzer_iv/panzer4_engine_rpm_00.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "gredwitch/panzer_iv/panzer4_engine_rpm_66_load.wav",
		Sound_MidPitch = 1.5,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 100,
		Sound_MidFadeOutRate = 1,
		
		Sound_High = "gredwitch/panzer_iv/panzer4_engine_rpm_99_load.wav",
		Sound_HighPitch = 1.5,
		Sound_HighVolume = 1,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.2,
		
		Sound_Throttle = "",
		Sound_ThrottlePitch = 0,
		Sound_ThrottleVolume = 0,
		
		snd_horn = "common/null.wav",
		-- ForceTransmission = 1,
		
		DifferentialGear = 0.3,
		Gears = {-0.01,0,0.04,0.06,0.09,0.12,0.16}
	}
})
list.Set("simfphys_vehicles","gred_simfphys_panzerivf2",{
	Name = "Panzerkampfwagen IV Ausf. F2",
	Model = Model("models/gredwitch/panzer_IV_F1/pzIV_F2.mdl"),
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Gredwitch's Stuff",
	SpawnOffset = Vector(0,0,30),
	SpawnAngleOffset = 0,

	Members = {
		Mass = 8000,
		AirFriction = 16,
		Inertia = Vector(20000,80000,100000),
		
		LightsTable = "panzer_4_f1",
		
		ApplyDamage = function( ent, damage, type ) 
			simfphys.TankApplyDamage(ent, damage, type)
		end,
		
		OnDestroyed = function(ent)
			local gib = ent.Gib
			if !IsValid(gib) then return end
			
			local pos,ang,skin,pitch,yaw = gib:GetPos(),gib:GetAngles(),gib:GetSkin(),ent:GetPoseParameter("spin_cannon"),ent:GetPoseParameter("spin_tower")
			gib:SetPoseParameter("spin_cannon",pitch)
			gib:SetPoseParameter("spin_tower",yaw)
			
			local function CreateAmmoFire(gib,ang)
				local bonepos = gib:GetBonePosition(gib:LookupBone("tower"))
				gib.AmmoFire = ents.Create("info_particle_system")
				gib.AmmoFire:SetKeyValue("effect_name","flame_jet")
				gib.AmmoFire:SetKeyValue("start_active",1)
				gib.AmmoFire:SetOwner(gib)
				gib.AmmoFire:SetPos(bonepos)
				gib.AmmoFire:SetAngles(ang)
				gib.AmmoFire:Spawn()
				gib.AmmoFire:Activate()
				gib.AmmoFire:SetParent(gib)
				
				gib.AmmoFireSound = CreateSound(gib,"gredwitch/burning_jet.wav")
				gib.AmmoFireSound:SetSoundLevel(120)
				gib.AmmoFireSound:Play()
				gib:CallOnRemove("removesnd",function(gib)
					gib.AmmoFireSound:Stop()
				end)
			end
			
			local function CreateTurret(gib,ang,pitch,yaw)
				for i = 1,13 do
					gib:SetBodygroup(i,1)
				end
				
				local bonepos = gib:GetBonePosition(gib:LookupBone("tower"))
				local prop = ents.Create("prop_physics")
				prop:SetModel("models/gredwitch/panzer_IV_F1/pziv_f2_turret.mdl")
				prop:SetAngles(ang + Angle(pitch,yaw))
				prop:SetPos(bonepos)
				prop:Spawn()
				prop:Activate()
				prop:SetMaterial( "models/player/player_chrome1" )
				prop:SetRenderMode( RENDERMODE_TRANSALPHA )
				gib.Turret = prop
				
				local phys = prop:GetPhysicsObject()
				if IsValid(phys) then
					phys:AddVelocity(gib:GetUp()*1200)
					phys:AddAngleVelocity(VectorRand()*math.random(600,1200))
				end
				
				gib:CallOnRemove("removeturret",function(gib)
					if IsValid(gib.Turret) then gib.Turret:Remove() end
				end)
			end
			
			local function StopAmmoFire(gib)
				gib.AmmoFire:Remove()
				gib.AmmoFireSound:Stop()
			end
			
			local function CreateExplosion(gib,ang)
				local pos = gib:LocalToWorld(Vector(-10,0,40))
				net.Start("gred_net_createparticle")
					net.WriteString("doi_flak88_explosion")
					net.WriteVector(pos)
					net.WriteAngle(ang)
					net.WriteBool(false)
				net.Broadcast()
				gred.CreateSound(pos,false,"explosions/fuel_depot_explode_close.wav","explosions/fuel_depot_explode_dist.wav","explosions/fuel_depot_explode_far.wav")
			end
			
			gred.TankDestruction(ent,gib,ang,skin,pitch,yaw,CreateAmmoFire,StopAmmoFire,CreateExplosion,CreateTurret)
		end,
		
		
		MaxHealth = 3077,
		
		IsArmored = true,
		
		NoWheelGibs = true,
		
		FirstPersonViewPos = Vector(-10,-30,20),
		
		FrontWheelRadius = 35,
		RearWheelRadius = 35,
		
		EnginePos = Vector(-70,2,70),
		
		CustomWheels = true,
		
		-- CustomWheelModel = "models/hunter/blocks/cube1x1x1.mdl",
		CustomWheelModel = "models/mm1/box.mdl",
		
		CustomWheelPosFL = Vector(70,30,20),
		CustomWheelPosFR = Vector(70,-30,20),
		
		CustomWheelPosML = Vector(0,30,20),
		CustomWheelPosMR = Vector(0,-30,20),
		
		CustomWheelPosRL = Vector(-80,30,20),
		CustomWheelPosRR = Vector(-80,-30,20),
		CustomWheelAngleOffset = Angle(0,180,0),
		CustomWheelAngleOffset = Angle(0,180,0),
		
		-- CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 30,
		
		TurnSpeed = 10,
		
		SeatOffset = Vector(50,-20,47),
		SeatPitch = 0,
		SeatYaw = 90,
		
		
		ExhaustPositions = {
			{
				pos = Vector(-113.4,-6.5,56),
				ang = Angle(-18,30,0)
			},
		},
		
		
		PassengerSeats = {
			{
				pos = Vector(55,-28,17),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-17,20,52),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-17,-15,50),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-32,2,58),
				ang = Angle(0,-90,0)
			},
		},
		
		CustomSuspensionTravel = 10,
		
		FrontHeight = -0,
		FrontConstant = 800000,
		FrontDamping = 9000000000,
		FrontRelativeDamping = 9000000000,
		
		RearHeight = -0,
		RearConstant = 800000,
		RearDamping = 9000000000,
		RearRelativeDamping = 9000000000,
		
		MaxGrip = 800,
		Efficiency = 0.8,
		GripOffset = 0,
		BrakePower = 80,
		BulletProofTires = true,
		
		IdleRPM = 600,
		LimitRPM = 3000,
		PeakTorque = 100,
		PowerbandStart = 600,
		PowerbandEnd = 2500,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		
		FuelFillPos = Vector(-102.19,-25.74,57.882),
		FuelType = FUELTYPE_DIESEL,
		FuelTankSize = 470,
		
		PowerBias = -0.3,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "gredwitch/panzer_iv/panzer4_engine_rpm_00.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "gredwitch/panzer_iv/panzer4_engine_rpm_66_load.wav",
		Sound_MidPitch = 1.5,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 100,
		Sound_MidFadeOutRate = 1,
		
		Sound_High = "gredwitch/panzer_iv/panzer4_engine_rpm_99_load.wav",
		Sound_HighPitch = 1.5,
		Sound_HighVolume = 1,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.2,
		
		Sound_Throttle = "",
		Sound_ThrottlePitch = 0,
		Sound_ThrottleVolume = 0,
		
		snd_horn = "common/null.wav",
		-- ForceTransmission = 1,
		
		DifferentialGear = 0.3,
		Gears = {-0.01,0,0.04,0.06,0.09,0.12,0.16}
	}
})


local PanzerIVSusData = {}
local Maxs = Vector(15,15,0)
for i = 1,8 do
	PanzerIVSusData[i] = { 
		Attachment = "vehicle_suspension_l_"..i,
		PoseParameter = "suspension_l_0"..i,
		PoseParameterMultiplier = 1,
		ReversePoseParam = true,
		Height = 13,
		GroundHeight = -30,
		Mins = -Maxs,
		Maxs = Maxs,
	}
	
	PanzerIVSusData[i + 8] = { 
		Attachment = "vehicle_suspension_r_"..i,
		PoseParameter = "suspension_r_0"..i,
		PoseParameterMultiplier = 1,
		ReversePoseParam = true,
		Height = 13,
		GroundHeight = -30,
		Mins = -Maxs,
		Maxs = Maxs,
	}
end

gred.simfphys = gred.simfphys or {}
gred.simfphys["gred_simfphys_panzerivf1"] = {
	Seats = {
		[0] = { -- Driver
			ArcadeMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(-10,-30),
					["ValveBiped.Bip01_L_Calf"] = Angle(10,-30),
				},
				ViewAttachment = "turret_machinegun",
				FirstPersonViewPos = Vector(6,0,5),
				ThirdPersonViewPos = Vector(20,50,80),
				
				MuzzleDirection = Vector(0,0.5,0),
				MuzzleAttachment = "turret_cannon",
				TraverseIndicator = true,
				FirstPersonViewPosIsInside = true,
				
				Hatches = {
					{
						PoseParameters = {
							"hatch_12"
						},
						ViewPosOffset = Vector(0,0,5),
						ViewAttachment = "",
						PosOffset = Vector(15,5,30),
						AngOffset = Angle(0,0,0),
						PlayerBoneManipulation = {
							["ValveBiped.Bip01_R_Calf"] = Angle(10,20,0),
							["ValveBiped.Bip01_L_Calf"] = Angle(-10,20,0),
							
							["ValveBiped.Bip01_R_Thigh"] = Angle(10,60,-10),
							["ValveBiped.Bip01_L_Thigh"] = Angle(-10,60,10),
							
							["ValveBiped.Bip01_R_Foot"] = Angle(20,-20),
							["ValveBiped.Bip01_L_Foot"] = Angle(-20,-20),
							
							-- ["ValveBiped.Bip01_R_Bicept"] = Angle(90,0),
							-- ["ValveBiped.Bip01_L_Bicept"] = Angle(90,0),
						},
					},
				},
				
				Sight = {
					SightPosOffset = Vector(-20,35,0),
					SightAngOffset = Angle(0,0,0),
					SightAttachment = "turret_machinegun",
					SightFOV = 40,
					SightFOVZoom = 19, -- ammount of FOV to remove, not the actual zoom value
					Stabilizer = false,
					SightMaterial = "gredwitch/overlay_german_tanksight_01",
				},
				
				Primary = {
					{
						Type = "Cannon",
						
						CrosshairType = 2,
						ReloadTime = 4.3,
						ShootAnimation = "shoot",
						GunBreachModuleID = 0, -- Module ID
						
						Sounds = {
							Shoot = {
								"75MM_KWK40_1",
								"75MM_KWK40_2",
								"75MM_KWK40_3",
							},
							ShootInside = {
								"GRED_MED_CANNON_01",
								"GRED_MED_CANNON_02",
								"GRED_MED_CANNON_03",
							},
							Reload = {
								"sherman_reload",
							},
						},
						MuzzleFlash = "gred_arti_muzzle_blast_alt",
						Muzzles = {
							"turret_cannon",
						},
						-- MuzzlePosOffset = Vector(0,0,0),
						-- MuzzleAngOffset = Angle(0,0,0),
						
						ShellTypes = {
							{
								Caliber = 75,
								ShellType = "HE",
								MuzzleVelocity = 420,
								Mass = 5.7,
								TracerColor = "red",
								LinearPenetration = 10,
								TNTEquivalent = 0.686,
								
							},
							{
								Caliber = 75,
								ShellType = "APCBC",
								MuzzleVelocity = 385,
								Mass = 6.8,
								TracerColor = "white",
								TNTEquivalent = 0.08,
								Normalization = 4,
								
							},
							{
								Caliber = 75,
								ShellType = "HEAT",
								MuzzleVelocity = 385,
								Mass = 4.6,
								TracerColor = "white",
								TNTEquivalent = 0.8721,
								LinearPenetration = 100,
								
							},
							{
								Caliber = 75,
								ShellType = "Smoke",
								MuzzleVelocity = 423,
								Mass = 6.8,
								TracerColor = "",
								
							},
						},
						MaxAmmo = 80,
						RecoilForce = 250000,
					},
				},
				
				Secondary = {
					Type = "MG",
					Caliber = "wac_base_7mm",
					ModuleID = 0,
					ExactCaliber = "7.92",
					Sequential = false,
					Muzzles = {
						"turret_machinegun",
					},
					FireRate = 850,
					Sounds = {
						Reload = {
							"GRED_MG34_RELOAD",
						},
						Loop = {
							"GRED_MG34_LOOP",
						},
						LoopInside = {
							"GRED_MG34_LOOP_INSIDE",
						},
						Stop = {
							"GRED_MG_8MM_LASTSHOT_01",
							"GRED_MG_8MM_LASTSHOT_02",
							"GRED_MG_8MM_LASTSHOT_03",
						},
						StopInside = {
							"GRED_MG_8MM_LASTSHOT_INSIDE_01",
							"GRED_MG_8MM_LASTSHOT_INSIDE_02",
							"GRED_MG_8MM_LASTSHOT_INSIDE_03",
						},
					},
					Spread = 0.3,
					ReloadTime = 4,
					Ammo = 100,
					MuzzleFlash = "muzzleflash_mg42_3p",
					TracerColor = "green",
				},
				-- Secondary = {
					-- Type = "Flamethrower",
					
					-- Muzzles = {
						-- "turret_machinegun",
					-- },
					
					-- ReloadTime = 4,
					-- Ammo = 100,
					
					-- Effect = "flamethrower_long",
					-- FlameRange = 1200,
					-- FlameRate = 0.05,
					-- RaySize = 20,
					-- FireBallSize = 60,
				-- },
				
				TurretTraverseSoundPitch = 100,
				TurretTraverseSoundLevel = 60,
				TurretTraverseSpeed = 8.3,
				TurretTraverseSound = "turret/turret_turn_loop_1.wav",
				
				TurretElevationSound = "turret/turret_turn_loop_1_manual.wav",
				TurretElevationSoundPitch = 100,
				TurretElevationSoundLevel = 60,
				TurretElevationSpeed = 2.8,
				
				MinTraverse = -180,
				MaxTraverse = 180,
				MinElevation = -10,
				MaxElevation = 20,
				
				PoseParameters = { -- turret pose parameter
					Yaw = {
						["turret_yaw"] = {
							Offset = 0,
							Invert = false,
						},
					},
					YawModuleName = "TurretRing",
					YawModuleID = 0,
					
					Pitch = {
						["spin_cannon"] = {
							Offset = 0,
							Invert = true,
						},
					},
					-- SteeringWheel = {
						-- ["steeringwheel"] = true,
					-- },
					-- Custom = function(vehicle,seat,ply,LocalAngles,ct,SlotID,SeatTab)
						
					-- end,
				},
				-- BoneManipulation = {
					-- SteeringWheel = {
						-- ["steeringwheel_bone"] = true,
					-- },
					-- Custom = function(vehicle,seat,ply)
					
					-- end,
				-- },
				
				ViewPort = {
					Attachment = "turret_machinegun",
					Pos = Vector(-20,40,0),
					Ang = Angle(),
					
					MinAng = Angle(-7,-7,-90),
					MaxAng = Angle(7,7,90),
					
					ModelAngOffset = Angle(0,180),
					
					Model = "models/gredwitch/viewports/viewport_gunner.mdl",
					ModelPosOffset = Vector(8,0,-0.25),
					-- Model = "models/gredwitch/viewports/viewport_driver_alt.mdl",
					-- ModelPosOffset = Vector(3.7,0,-0.6),
				},
			},
			NormalMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(-10,-30),
					["ValveBiped.Bip01_L_Calf"] = Angle(10,-30),
				},
				FirstPersonViewPos = Vector(3,-22,15),
				ThirdPersonViewPos = Vector(0,15,80),
				FirstPersonViewPosIsInside = true,
				
				ViewPort = {
					Attachment = "turret_machinegun",
					Pos = Vector(40,25,20),
					Ang = Angle(),
					
					MinAng = Angle(-7,-7,-90),
					MaxAng = Angle(7,7,90),
					
					ModelAngOffset = Angle(0,180),
					
					Model = "models/gredwitch/viewports/viewport_driver.mdl",
					ModelPosOffset = Vector(5.15,0,-0.25),
					-- Model = "models/gredwitch/viewports/viewport_driver_alt.mdl",
					-- ModelPosOffset = Vector(3.7,0,-0.6),
				},
			},
		},
		[1] = { -- Machinegunner
			ArcadeMode = {
				-- Attachment = ""
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(-10,-60),
					["ValveBiped.Bip01_L_Calf"] = Angle(10,-60),
				},
				-- NoFirstPersonCrosshair = true,
				FirstPersonViewPos = Vector(-12,-10,8),
				ThirdPersonViewPos = Vector(-30,0,80),
				FirstPersonViewPosIsInside = true,
				
				MuzzleDirection = Vector(0,0.5,0),
				MuzzleAttachment = "coaxial_machinegun",
				
				RequiresHatch = {
					[0] = true,
					[1] = true,
				},
				
				ViewPort = {
					-- Attachment = "",
					Pos = Vector(80,-10,60),
					Ang = Angle(),
					
					MinAng = Angle(-7,-7,-90),
					MaxAng = Angle(7,7,90),
					
					ModelAngOffset = Angle(0,180),
					
					Model = "models/gredwitch/viewports/viewport_driver.mdl",
					ModelPosOffset = Vector(5.15,0,-0.25),
					-- Model = "models/gredwitch/viewports/viewport_driver_alt.mdl",
					-- ModelPosOffset = Vector(3.7,0,-0.6),
				},
				
				Hatches = {
					{
						PoseParameters = {
							"hatch_07",
						},
						ViewPosOffset = Vector(0,0,5),
						PosOffset = Vector(0,0,25),
						AngOffset = Angle(0,0,0),
						PlayerBoneManipulation = {
							["ValveBiped.Bip01_R_Calf"] = Angle(0,10),
							["ValveBiped.Bip01_L_Calf"] = Angle(0,10),
							
							["ValveBiped.Bip01_R_Thigh"] = Angle(0,40),
							["ValveBiped.Bip01_L_Thigh"] = Angle(0,40),
							
							["ValveBiped.Bip01_R_Foot"] = Angle(0,-50),
							["ValveBiped.Bip01_L_Foot"] = Angle(0,-50),
						},
					},
				},
				
				-- Sight = {
					-- SightPosOffset = Vector(0,0,5),
					-- SightAngOffset = Angle(0,0,0),
					-- SightAttachment = "turret_machinegun",
					-- SightFOV = 40,
					-- Stabilizer = false,
					-- SightMaterial = "gredwitch/overlay_german_tanksight_01",
				-- },
				Primary = {
					{
						Type = "MG",
						ModuleID = 1,
						Caliber = "wac_base_7mm",
						ExactCaliber = "7.92",
						Sequential = false,
						Muzzles = {
							"coaxial_machinegun",
						},
						FireRate = 850,
						Sounds = {
							Reload = {
								"GRED_MG34_RELOAD",
							},
							Loop = {
								"GRED_MG34_LOOP",
							},
							LoopInside = {
								"GRED_MG34_LOOP_INSIDE",
							},
							Stop = {
								"GRED_MG_8MM_LASTSHOT_01",
								"GRED_MG_8MM_LASTSHOT_02",
								"GRED_MG_8MM_LASTSHOT_03",
							},
							StopInside = {
								"GRED_MG_8MM_LASTSHOT_INSIDE_01",
								"GRED_MG_8MM_LASTSHOT_INSIDE_02",
								"GRED_MG_8MM_LASTSHOT_INSIDE_03",
							},
						},
						Spread = 0.3,
						ReloadTime = 4,
						Ammo = 100,
						MuzzleFlash = "muzzleflash_mg42_3p",
						TracerColor = "green",
					},
					-- {
						-- Type = "Flamethrower",
						
						-- Muzzles = {
							-- "coaxial_machinegun",
						-- },
						
						-- ReloadTime = 4,
						-- Ammo = 100,
						
						-- Effect = "flamethrower_long",
						-- FlameRange = 1200,
						-- FlameRate = 0.05,
						-- RaySize = 20,
						-- FireBallSize = 60,
					-- },
				},
				
				PoseParameters = { -- turret pose parameter
					Yaw = {
						["gun_yaw"] = {
							Offset = 0,
							Invert = true,
							ModuleName = "MG",
							ModuleID = 1,
						},
					},
					Pitch = {
						["gun_pitch"] = {
							Offset = 6,
							Invert = true,
							ModuleName = "MG",
							ModuleID = 1,
						},
					},
				},
			},
		},
		[2] = { -- Gunner
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				Attachment = "turret",
				FirstPersonViewPos = Vector(0,0,5),
				
				Hatches = {
					{
						PoseParameters = {
							"hatch_06",
						},
						PosOffset = Vector(0,10,12),
						AngOffset = Angle(0,0,0),
						ViewPosOffset = Vector(-10,0,6),
						PlayerBoneManipulation = {
							["ValveBiped.Bip01_Spine"] = Angle(-35,-20,30),
							
							-- ["ValveBiped.Bip01_R_Calf"] = Angle(0,10),
							-- ["ValveBiped.Bip01_L_Calf"] = Angle(0,10),
							
							-- ["ValveBiped.Bip01_R_Thigh"] = Angle(0,40),
							-- ["ValveBiped.Bip01_L_Thigh"] = Angle(0,40),
							
							-- ["ValveBiped.Bip01_R_Foot"] = Angle(0,-50),
							-- ["ValveBiped.Bip01_L_Foot"] = Angle(0,-50),
						},
					},
				},
				
				ViewPort = {
					Attachment = "turret",
					Pos = Vector(40,25,20),
					Ang = Angle(),
					
					MinAng = Angle(-7,-7,-90),
					MaxAng = Angle(7,7,90),
					
					ModelAngOffset = Angle(0,180),
					
					Model = "models/gredwitch/viewports/viewport_driver.mdl",
					ModelPosOffset = Vector(5.15,0,-0.25),
					-- Model = "models/gredwitch/viewports/viewport_driver_alt.mdl",
					-- ModelPosOffset = Vector(3.7,0,-0.6),
				},
			},
		},
		[3] = { -- Loader
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				Attachment = "turret",
				IsLoader = 0, -- Seat ID 
				Hatches = {
					{
						PoseParameters = {
							"hatch_04"
						},
						PosOffset = Vector(0,-10,12),
						AngOffset = Angle(0,0,0),
						ViewPosOffset = Vector(10,0,6),
						
						PlayerBoneManipulation = {
							["ValveBiped.Bip01_Spine"] = Angle(35,-20,-30),
							
							-- ["ValveBiped.Bip01_R_Calf"] = Angle(0,10),
							-- ["ValveBiped.Bip01_L_Calf"] = Angle(0,10),
							
							-- ["ValveBiped.Bip01_R_Thigh"] = Angle(0,40),
							-- ["ValveBiped.Bip01_L_Thigh"] = Angle(0,40),
							
							-- ["ValveBiped.Bip01_R_Foot"] = Angle(0,-50),
							-- ["ValveBiped.Bip01_L_Foot"] = Angle(0,-50),
						},
					},
				},
				
				ViewPort = {
					Attachment = "turret",
					Pos = Vector(50,-25,20),
					Ang = Angle(),
					
					MinAng = Angle(-7,-7,-90),
					MaxAng = Angle(7,7,90),
					
					FreeView = true,
					ModelAngOffset = Angle(0,180),
					
					Model = "models/gredwitch/viewports/viewport_driver.mdl",
					ModelPosOffset = Vector(5.15,0,-0.25),
					-- Model = "models/gredwitch/viewports/viewport_driver_alt.mdl",
					-- ModelPosOffset = Vector(3.7,0,-0.6),
				},
			},
		},
		[4] = { -- Commander
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				FirstPersonViewPos = Vector(0,0,15),
				IsCommander = true,
				Attachment = "turret",
				Hatches = {
					{
						PoseParameters = {
							"hatch_01"
						},
						PosOffset = Vector(0,0,35),
						AngOffset = Angle(0,0,0),
						PlayerHullMins = Vector(),
						PlayerHullMaxs = Vector(),
						-- ViewPosOffset = Vector(0,0,0),
						PlayerBoneManipulation = {
							["ValveBiped.Bip01_Spine"] = Angle(0,0,0),
							
							["ValveBiped.Bip01_R_Calf"] = Angle(0,-90),
							["ValveBiped.Bip01_L_Calf"] = Angle(0,-90),
							
							-- ["ValveBiped.Bip01_R_Shoulder"] = Angle(0,-90),
							-- ["ValveBiped.Bip01_L_Shoulder"] = Angle(0,-90),
							
							["ValveBiped.Bip01_R_Thigh"] = Angle(5,100,0),
							["ValveBiped.Bip01_L_Thigh"] = Angle(-5,100,0),
							
							-- ["ValveBiped.Bip01_R_Foot"] = Angle(0,-50),
							-- ["ValveBiped.Bip01_L_Foot"] = Angle(0,-50),
						},
					},
				},
			},
		},
	},
	Armour = {
		GetArmourThickness = function(vehicle,tr)
			if tr.LocalHitPos.z > 71 then
				tr.TurretHit = true
				
				if tr.PitchSideDetection == GRED_TANK_TOP then
					tr.ArmourThicknessKE = 10
				else
					if tr.YawSideDetection == GRED_TANK_FRONT then
						tr.ArmourThicknessKE = 50
					else
						tr.ArmourThicknessKE = 30
					end
				end
			else
				if tr.PitchSideDetection == GRED_TANK_TOP then
					if tr.LocalHitPos.x > 80 then
						tr.ArmourThicknessKE = 20
					else
						tr.ArmourThicknessKE = 10
					end
				else
					if tr.YawSideDetection == GRED_TANK_FRONT then
						-- if tr.LocalHitPos.x > 100 then
							tr.ArmourThicknessKE = 50
						-- else
							-- tr.ArmourThicknessKE = 10
						-- end
					else
						tr.ArmourThicknessKE = 30
					end
				end
			end
			
			tr.ArmourThicknessKE = tr.ArmourThicknessKE or 10
			tr.ArmourThicknessCHEMICAL = tr.ArmourThicknessKE
			return tr
		end,
		
		Modules = {
			Ammo = {
				{
					Pos = Vector(18.546,-32.824,39.0573),
					Mins = Vector(-11,-8,-10),
					Maxs = Vector(11,3,3.5),
					ID = 0,
				},
				{
					Pos = Vector(18.546,37,39.0573),
					Mins = Vector(-11,-8,-10),
					Maxs = Vector(11,3,3.5),
					ID = 1,
				},
				{
					Pos = Vector(-26,-32.824,39.0573),
					Mins = Vector(-11,-8,-10),
					Maxs = Vector(11,3,3.5),
					ID = 2,
				},
				{
					Pos = Vector(-26,37,39.0573),
					Mins = Vector(-11,-8,-10),
					Maxs = Vector(11,3,3.5),
					ID = 3,
				},
			},
			
			Engine = {
				{
					Pos = Vector(-75,0,40),
					Mins = Vector(-25,-18,-19),
					Maxs = Vector(16,18,10),
					ID = 0,
				},
			},
			
			Transmission = {
				{
					Pos = Vector(80,0,30),
					Mins = Vector(-20,-10,-13),
					Maxs = Vector(22,10,15),
					ID = 0,
				},
				{
					Pos = Vector(55,0,30),
					Mins = Vector(-10,-8,-12),
					Maxs = Vector(5,8,9),
					ID = 0,
				},
				{
					Pos = Vector(40,0,30),
					Mins = Vector(-90,-1.5,-1.5),
					Maxs = Vector(5,1.5,1.5),
					ID = 0,
				},
				{
					Pos = Vector(105,0,30),
					Mins = Vector(-7,-40,-10),
					Maxs = Vector(10,40,5),
					ID = 0,
				},
			},
			
			TurretRing = {
				-- {
					-- Pos = Vector(0,0,72),
					-- Mins = Vector(-30,-30,-1),
					-- Maxs = Vector(30,30,1),
					-- ID = 0,
				-- },
				{
					Pos = Vector(30,30,3),
					Mins = Vector(-1,-60,-3),
					Maxs = Vector(1,1,1),
					Attachment = "turret",
					ID = 0,
				},
				{
					Pos = Vector(30,30,3),
					Mins = Vector(-60,-1,-3),
					Maxs = Vector(1,1,1),
					Attachment = "turret",
					ID = 0,
				},
				{
					Pos = Vector(-30,30,3),
					Mins = Vector(-1,-60,-3),
					Maxs = Vector(1,1,1),
					Attachment = "turret",
					ID = 0,
				},
				{
					Pos = Vector(-30,-30,3),
					Mins = Vector(-1,-1,-3),
					Maxs = Vector(60,1,1),
					Attachment = "turret",
					ID = 0,
				},
			},
			
			GunBreach = {
				{
					Pos = Vector(-55,15,-2),
					Mins = Vector(-10,-6,-5),
					Maxs = Vector(35,6,6),
					Attachment = "turret_machinegun",
					ID = 0,
				},
			},
			
			MG = {
				{
					Pos = Vector(-37,0,0),
					Mins = Vector(-10,-2,-2),
					Maxs = Vector(35,2,2),
					Attachment = "turret_machinegun",
					ID = 0,
				},
				{
					Pos = Vector(-37,0,0),
					Mins = Vector(-10,-2,-2),
					Maxs = Vector(35,2,2),
					Attachment = "coaxial_machinegun",
					ID = 1,
				},
			},
			Fuel = {
				{
					Pos = Vector(-15,-24,25),
					Mins = Vector(-10,-2,-5),
					Maxs = Vector(35,19,5),
					ID = 0,
				},
				{
					Pos = Vector(0,0,25),
					Mins = Vector(-10,-2,-5),
					Maxs = Vector(20,25,5),
					ID = 1,
				},
				{
					Pos = Vector(-15,7,25),
					Mins = Vector(-10,0,-5),
					Maxs = Vector(5,18,5),
					ID = 1,
				},
				{
					Pos = Vector(-31,-1,25),
					Mins = Vector(-10,0,-5),
					Maxs = Vector(5,26,5),
					ID = 2,
				},
			},
			LeftTrack = {
				{
					Pos = Vector(0,50,45),
					Mins = Vector(-115,-10,-2),
					Maxs = Vector(115,10,2),
					ID = 0,
				},
				{
					Pos = Vector(0,50,0),
					Mins = Vector(-115,-10,-2),
					Maxs = Vector(115,10,2),
					ID = 0,
				},
				{
					Pos = Vector(115,50,45),
					Mins = Vector(-2,-10,-45),
					Maxs = Vector(2,10,2),
					ID = 0,
				},
				{
					Pos = Vector(-115,50,45),
					Mins = Vector(-2,-10,-45),
					Maxs = Vector(2,10,2),
					ID = 0,
				},
			},
			RightTrack = {
				{
					Pos = Vector(0,-50,45),
					Mins = Vector(-115,-10,-2),
					Maxs = Vector(115,10,2),
					ID = 0,
				},
				{
					Pos = Vector(0,-50,0),
					Mins = Vector(-115,-10,-2),
					Maxs = Vector(115,10,2),
					ID = 0,
				},
				{
					Pos = Vector(115,-50,45),
					Mins = Vector(-2,-10,-45),
					Maxs = Vector(2,10,2),
					ID = 0,
				},
				{
					Pos = Vector(-115,-50,45),
					Mins = Vector(-2,-10,-45),
					Maxs = Vector(2,10,2),
					ID = 0,
				},
			},
		},
	},
	Tracks = {
		TrackMat = {
			["$basetexture"]				= "models/gredwitch/common/track_c",
			["$bumpmap"]					= "models/gredwitch/common/track_n",
			["$lightwarptexture"]			= "models/gredwitch/common/lightwarp",
			
			["$alphatest"] 					= "1",
			["$nocull"] 					= "1",
			
			["$phong"] 						= "1",
			["$phongboost"] 				= "3",
			["$phongexponent"] 				= "15",
			["$phongfresnelranges"] 		= "[0.3 1 4]",
			
			["$translate"] = "[0.0 0.0 0.0]",
			["Proxies"] = { 
				["TextureTransform"] = { 
					["translateVar"] = "$translate",
					["centerVar"]    = "$center",
					["resultVar"]    = "$basetexturetransform",
				}
			}
		},
		
		Smoother = 1,
		Divider = -59,
		LeftTrackMat = "models/gredwitch/common/track_l",
		RightTrackMat = "models/gredwitch/common/track_r",
		
		LeftTrackModel = "models/gredwitch/panzer_IV_F1/pzIV_F_track_l.mdl",
		RightTrackModel = "models/gredwitch/panzer_IV_F1/pzIV_F_track_r.mdl",
		
		SeparateTracks = true,
		
		LowTrackSound  = "tracksounds/tracks_speed_33_1.wav",
		MedTrackSound  = "tracksounds/tracks_speed_66_1.wav",
		HighTrackSound = "tracksounds/tracks_speed_99_1.wav",
		TrackSoundLevel = 85,
		TrackSoundVolume = 0.65,
		HandBrakePower = 200,
		
		TankSteer = {
			HasNeutralSteering = true,
			MaxTurn = 30,
			TurnTorqueCenter = 70,
			TurnTorqueCenterRate = 1,
			TurnForceMul = 0.05,
		},
	},
	ViewPorts = {
		{ -- Machinegunner - Right
			CamPos = Vector(55,-49.5,58),
			CamAng = Angle(0,-103,175),
			ViewPortPos = Vector(55,-45.5,58),
			ViewPortAng = Angle(0,13,-85),
			ViewPortHeight = 415,
			ViewPortWidth = 1000,
			NoDraw = {
				[2] = true,
				[3] = true,
				[4] = true,
			},
		},
		{ -- Driver - Left
			CamPos = Vector(65,48.4,58),
			CamAng = Angle(0,105,179.5),
			ViewPortPos = Vector(65,43.4,58),
			ViewPortAng = Angle(0,165,-89.5),
			ViewPortHeight = 415,
			ViewPortWidth = 1000,
			NoDraw = {
				[2] = true,
				[3] = true,
				[4] = true,
			},
		},
		{ -- Machinegunner
			CamPos = Vector(76,-15,58),
			CamAng = Angle(-12,0,180),
			ViewPortPos = Vector(78.42,-21.2,56.2),
			ViewPortAng = Angle(0,90,-102),
			ViewPortHeight = 415,
			ViewPortWidth = 1000,
			NoDraw = {
				[2] = true,
				[3] = true,
				[4] = true,
			},
			-- Paint = function(vehicle,ply)
				-- if vehicle.LocalPlayerActiveSeatID == 1 then
					-- local att = vehicle:GetAttachment(vehicle.LocalPlayerActiveSeat.MuzzleAttachment)
					-- trtab.start = att.Pos
					-- trtab.endpos = (att.Pos + att.Ang:Forward() * 10000)
					-- trtab.filter = vehicle.filterEntities
					-- local tr = util.TraceLine(trtab)
					-- scr = tr.HitPos:ToScreen()
					-- scr.x = scr.x > 415 and 415 or (scr.x < 0 and 0 or scr.x)
					-- scr.y = scr.y > 1000 and 1000 or (scr.y < 0 and 0 or scr.y)
					
					-- surface.SetDrawColor(255,255,255,255)
					-- gred.DrawCircle(scr.x,scr.y,19)
					-- gred.DrawCircle(scr.x,scr.y,2)
					-- surface.SetDrawColor(0,0,0,255)
					-- gred.DrawCircle(scr.x,scr.y,20)
					-- gred.DrawCircle(scr.x,scr.y,3)
				-- end
			-- end,
		},
		{ -- Driver
			CamPos = Vector(83,15,58),
			CamAng = Angle(-8,0,180),
			ViewPortPos = Vector(77.5,10,56),
			ViewPortAng = Angle(0,90,-98),
			ViewPortHeight = 420,
			ViewPortWidth = 1000,
			NoDraw = {
				[2] = true,
				[3] = true,
				[4] = true,
			},
		},
		{ -- Loader - front right
			Attachment = "turret",
			CamAtt = "turret",
			CamPos = Vector(11,-38,13.5),
			CamAng = Angle(-25,-87,177),
			ViewPortPos = Vector(11,-38,13.5),
			ViewPortAng = Angle(3,3,-115),
			ViewPortHeight = 700,
			ViewPortWidth = 1000,
			NoDraw = {
				[0] = true,
				[1] = true,
				[4] = true,--
			},
		},
		{ -- Loader - right
			Attachment = "turret",
			CamAtt = "turret",
			CamPos = Vector(-3,-37,17),
			CamAng = Angle(-1,-105,180),
			ViewPortPos = Vector(-8.2,-28.6,16.5),
			ViewPortAng = Angle(0,-15,-91),
			ViewPortHeight = 230,
			ViewPortWidth = 600,
			NoDraw = {
				[0] = true,
				[1] = true,
				[4] = true,
			},
		},
		{ -- Gunner - front left
			Attachment = "turret",
			CamAtt = "turret",
			CamPos = Vector(20,36,13.25),
			CamAng = Angle(-25,87,177),
			ViewPortPos = Vector(20,36,13.25),
			ViewPortAng = Angle(-2,173,-115),
			ViewPortHeight = 700,
			ViewPortWidth = 1000,
			NoDraw = {
				[0] = true,
				[1] = true,
				[4] = true,
			},
		},
		{ -- Gunner - left
			Attachment = "turret",
			CamAtt = "turret",
			CamPos = Vector(-2.3,37,16.6),
			CamAng = Angle(0,105,179),
			ViewPortPos = Vector(-2.3,30.4,16.6),
			ViewPortAng = Angle(0,-165,-91),
			ViewPortHeight = 230,
			ViewPortWidth = 600,
			NoDraw = {
				[0] = true,
				[1] = true,
				[4] = true,
			},
		},
		{ -- Gunner - sight
			Attachment = "turret",
			CamAtt = "turret_machinegun",
			CamPos = Vector(0,0,5),
			CamFov = 30,
			CamAng = Angle(0,0,180),
			ViewPortPos = Vector(7,17.25,16.6),
			ViewPortAng = Angle(0,90,-90),
			ViewPortHeight = 150,
			ViewPortWidth = 150,
			NoDraw = {
				[0] = true,
				[1] = true,
				[3] = true,
				[4] = true,
			},
			Paint = function(vehicle,ply)
				-- surface.SetDrawColor(255,255,255,255)
				-- local size = 4
				-- local s = 75 - size*0.5
				-- surface.DrawRect(s,s,size,size)
				
				-- surface.SetDrawColor(0,0,0,255)
				-- local size = 2
				-- local s = 75 - size*0.5
				-- surface.DrawRect(s,s,size,size)
				
				surface.SetDrawColor(0,0,0,100)
				surface.DrawRect(0,75,150,1)
				surface.DrawRect(74,1,1,150)
				-- surface.DrawRect(s,0,size,150)
			end,
		},
		{ -- Commander top front
			Attachment = "turret",
			CamAtt = "turret",
			CamPos = Vector(-8,0,35),
			CamAng = Angle(0,0,180),
			ViewPortPos = Vector(-12.2,-3.6,35),
			ViewPortAng = Angle(0,90,-90),
			ViewPortHeight = 300,
			ViewPortWidth = 700,
			NoDraw = {
				[0] = true,
				[1] = true,
				[2] = true,
				[3] = true,
			},
		},
		{ -- Commander top right
			Attachment = "turret",
			CamAtt = "turret",
			CamPos = Vector(-18.5,-15,35),
			CamAng = Angle(0,-72,180),
			ViewPortPos = Vector(-22.6,-10.9,35),
			ViewPortAng = Angle(0,18,-90),
			ViewPortHeight = 300,
			ViewPortWidth = 700,
			NoDraw = {
				[0] = true,
				[1] = true,
				[2] = true,
				[3] = true,
			},
		},
		{ -- Commander top left
			Attachment = "turret",
			CamAtt = "turret",
			CamPos = Vector(-18,14,35),
			CamAng = Angle(0,72,180),
			ViewPortPos = Vector(-15.9,8.6,35),
			ViewPortAng = Angle(0,162,-90),
			ViewPortHeight = 300,
			ViewPortWidth = 700,
			NoDraw = {
				[0] = true,
				[1] = true,
				[2] = true,
				[3] = true,
			},
		},
		{ -- Commander rear left
			Attachment = "turret",
			CamAtt = "turret",
			CamPos = Vector(-36,8.5,35),
			CamAng = Angle(0,126,180),
			ViewPortPos = Vector(-28.7,8.8,35),
			ViewPortAng = Angle(0,-126,-90),
			ViewPortHeight = 300,
			ViewPortWidth = 700,
			NoDraw = {
				[0] = true,
				[1] = true,
				[2] = true,
				[3] = true,
			},
		},
		{ -- Commander rear right
			Attachment = "turret",
			CamAtt = "turret",
			CamPos = Vector(-36,-7,35),
			CamAng = Angle(0,-162,180),
			ViewPortPos = Vector(-32.8,-3.2,35),
			ViewPortAng = Angle(0,-54,-90),
			ViewPortHeight = 300,
			ViewPortWidth = 700,
			NoDraw = {
				[0] = true,
				[1] = true,
				[2] = true,
				[3] = true,
			},
		},
	},
	Info = {
		Nation = "Germany",
		ProductionDate = "April 1941 - March 1942",
		NumberProduced = 487,
		Description = "The Panzerkampfwagen IV (PzKpfw IV), commonly known as the Panzer IV,\nwas a German medium tank developed in the late 1930s and used extensively during the Second World War.\nThis particular version has a short 75mm KwK 37 cannon, which was designed for infantry support.\n However, its powerful HEAT rounds can penetrate 100mm of armour at any distance, making it useful in tank vs. tank combat.\nThe only real difference between the Panzer IV Ausf. E and the F1 is its slightly thicker armour on the front part of the turret.",
		BattleRating = 2.3
	},
	DetailMapSupport = {
		["vehicle_body_camo"] = 1, -- number = default scale
		["vehicle_turret_camo"] = 1.5,
		["vehicle_gun_camo"] = 1.5,
	},
	
	SusData = PanzerIVSusData,
	
	OnCSTick = function(vehicle)
		if !IsValid(vehicle.RightTrack) or !IsValid(vehicle.LeftTrack) then return end
		vehicle.RightTrack:SetPoseParameter("spin_wr",vehicle.trackspin_r)
		vehicle.LeftTrack:SetPoseParameter("spin_wl",vehicle.trackspin_l)
		vehicle.RightTrack:InvalidateBoneCache()
		vehicle.LeftTrack:InvalidateBoneCache()
	end,
}

gred.simfphys["gred_simfphys_panzerivf1"].Seats[0].NormalMode.Hatches = gred.simfphys["gred_simfphys_panzerivf1"].Seats[0].ArcadeMode.Hatches -- we want the seat's normal mode to have the same hatches as in arcade mode, we are not copying the entire table because we're only taking the hatches
gred.simfphys["gred_simfphys_panzerivf1"].Seats[0].NormalMode.ViewPort = {
	Pos = Vector(80,15,60),
	Ang = Angle(),
	
	MinAng = Angle(-7,-7,-90),
	MaxAng = Angle(7,7,90),
	FreeView = true,
	
	ModelAngOffset = Angle(0,180),
	
	Model = "models/gredwitch/viewports/viewport_driver.mdl",
	ModelPosOffset = Vector(5.15,0,-0.25),
	-- Model = "models/gredwitch/viewports/viewport_driver_alt.mdl",
	-- ModelPosOffset = Vector(3.7,0,-0.6),
}

gred.simfphys["gred_simfphys_panzerivf1"].Seats[1].NormalMode = gred.simfphys["gred_simfphys_panzerivf1"].Seats[1].ArcadeMode -- the arcade is the same as the normal mode

gred.simfphys["gred_simfphys_panzerivf1"].Seats[2].NormalMode = table.FullCopy(gred.simfphys["gred_simfphys_panzerivf1"].Seats[0].ArcadeMode) -- we use table.FullCopy so we can change stuff
gred.simfphys["gred_simfphys_panzerivf1"].Seats[2].NormalMode.Hatches = gred.simfphys["gred_simfphys_panzerivf1"].Seats[2].ArcadeMode.Hatches -- we want the seat's normal mode to have the same hatches as in arcade mode
gred.simfphys["gred_simfphys_panzerivf1"].Seats[2].NormalMode.FirstPersonViewPosIsInside = true
gred.simfphys["gred_simfphys_panzerivf1"].Seats[2].NormalMode.FirstPersonViewPos = Vector(0,0,2.5)
gred.simfphys["gred_simfphys_panzerivf1"].Seats[2].NormalMode.ThirdPersonViewPos = Vector(20,-40,60)
gred.simfphys["gred_simfphys_panzerivf1"].Seats[2].NormalMode.ViewAttachment = nil
gred.simfphys["gred_simfphys_panzerivf1"].Seats[2].NormalMode.Attachment = "turret"
gred.simfphys["gred_simfphys_panzerivf1"].Seats[2].NormalMode.ViewPort = gred.simfphys["gred_simfphys_panzerivf1"].Seats[0].ArcadeMode.ViewPort

gred.simfphys["gred_simfphys_panzerivf1"].Seats[3].NormalMode = table.FullCopy(gred.simfphys["gred_simfphys_panzerivf1"].Seats[3].ArcadeMode) -- we use table.FullCopy so we can change stuff
gred.simfphys["gred_simfphys_panzerivf1"].Seats[3].NormalMode.IsLoader = 2 -- we change the seat we want to load in stuff because in normal mode the gunner is seat 2

gred.simfphys["gred_simfphys_panzerivf1"].Seats[4].NormalMode = gred.simfphys["gred_simfphys_panzerivf1"].Seats[4].ArcadeMode -- the arcade is the same as the normal mode



gred.simfphys["gred_simfphys_panzerivf2"] = table.FullCopy(gred.simfphys["gred_simfphys_panzerivf1"])

local StrTab = {
	"ArcadeMode",
	"NormalMode",
}
for i = 1,2 do
	gred.simfphys["gred_simfphys_panzerivf2"].Seats[i == 1 and 0 or 2][StrTab[i]].Primary[1].ShellTypes = {
		{
			Caliber = 75,
			ShellType = "HE",
			MuzzleVelocity = 550,
			Mass = 5.7,
			TracerColor = "red",
			LinearPenetration = 10,
			TNTEquivalent = 0.686,
			
		},
		{
			Caliber = 75,
			ShellType = "APCBC",
			MuzzleVelocity = 740,
			Mass = 6.8,
			TracerColor = "white",
			TNTEquivalent = 0.08,
			Normalization = 4,
			
		},
		{
			Caliber = 75,
			ShellType = "APCR",
			MuzzleVelocity = 919,
			Mass = 4.2,
			CoreMass = 15.45,
			ForceDragCoef = true,
			TracerColor = "white",
			
		},
		{
			Caliber = 75,
			ShellType = "HEAT",
			MuzzleVelocity = 450,
			Mass = 4.6,
			TracerColor = "white",
			TNTEquivalent = 0.8721,
			LinearPenetration = 100,
			
		},
		{
			Caliber = 75,
			ShellType = "Smoke",
			MuzzleVelocity = 423,
			Mass = 6.8,
			TracerColor = "",
		},
	}
	gred.simfphys["gred_simfphys_panzerivf2"].Seats[i == 1 and 0 or 2][StrTab[i]].Primary[1].MuzzleFlash = "gred_arti_muzzle_blast"
	gred.simfphys["gred_simfphys_panzerivf2"].Seats[i == 1 and 0 or 2][StrTab[i]].Primary[1].MaxAmmo = 87
end
for i = 5,#gred.simfphys["gred_simfphys_panzerivf2"].ViewPorts do
	gred.simfphys["gred_simfphys_panzerivf2"].ViewPorts[i].CamPos.z = gred.simfphys["gred_simfphys_panzerivf2"].ViewPorts[i].CamPos.z - 3
	gred.simfphys["gred_simfphys_panzerivf2"].ViewPorts[i].ViewPortPos.z = gred.simfphys["gred_simfphys_panzerivf2"].ViewPorts[i].ViewPortPos.z - 1.9
end
gred.simfphys["gred_simfphys_panzerivf2"].Info.NumberProduced = 175 -- + 24 F1s converted
gred.simfphys["gred_simfphys_panzerivf2"].Info.ProductionDate = "March 1942 - July 1942"
gred.simfphys["gred_simfphys_panzerivf2"].Info.Description = "The Panzerkampfwagen IV (PzKpfw IV), commonly known as the Panzer IV,\nwas a German medium tank developed in the late 1930s and used extensively during the Second World War.\nThis is the first Panzer IV that was equiped with the long 75mm KwK 40, making it very efficient in both tank vs. tank combat and infantry support."
gred.simfphys["gred_simfphys_panzerivf2"].Info.BattleRating = 3.3



gred.simfphys["gred_simfphys_panzerivd"] = table.FullCopy(gred.simfphys["gred_simfphys_panzerivf1"])

table.remove(gred.simfphys["gred_simfphys_panzerivd"].Seats[0].ArcadeMode.Primary[1].ShellTypes,3)
table.remove(gred.simfphys["gred_simfphys_panzerivd"].Seats[2].NormalMode.Primary[1].ShellTypes,3)

gred.simfphys["gred_simfphys_panzerivd"].Info.NumberProduced = 229
gred.simfphys["gred_simfphys_panzerivd"].Info.ProductionDate = "October 1939 - May 1941"
gred.simfphys["gred_simfphys_panzerivd"].Info.Description = "The Panzerkampfwagen IV (PzKpfw IV), commonly known as the Panzer IV,\nwas a German medium tank developed in the late 1930s and used extensively during the Second World War.\nThis particular version has a short 75mm KwK 37 cannon, which was designed for infantry support.\n The only real difference between the Panzer IV Ausf. C and the D is its slightly thicker armour that was increased from 15mm to 20mm."
gred.simfphys["gred_simfphys_panzerivd"].Info.BattleRating = 1.3

gred.simfphys["gred_simfphys_panzerivd"].Armour.GetArmourThickness = function(vehicle,tr)
	if tr.LocalHitPos.z > 71 then
		tr.TurretHit = true
		
		if tr.PitchSideDetection == GRED_TANK_TOP then
			tr.ArmourThicknessKE = 10
		else
			if tr.YawSideDetection == GRED_TANK_FRONT then
				tr.ArmourThicknessKE = 30
			else
				tr.ArmourThicknessKE = 20
			end
		end
	else
		if tr.PitchSideDetection == GRED_TANK_TOP then
			if tr.LocalHitPos.x > 80 then
				tr.ArmourThicknessKE = 12
			else
				tr.ArmourThicknessKE = 10
			end
		else
			if tr.YawSideDetection == GRED_TANK_FRONT then
				tr.ArmourThicknessKE = 30
			else
				tr.ArmourThicknessKE = 20
			end
		end
	end
	
	tr.ArmourThicknessKE = tr.ArmourThicknessKE or 10
	tr.ArmourThicknessCHEMICAL = tr.ArmourThicknessKE
	return tr
end
