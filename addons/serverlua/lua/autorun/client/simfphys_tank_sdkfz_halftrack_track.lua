local next_think = 0
local next_find = 0
local sdkfz_halftracks = {}



local function 	Sdkfz_halftracksGetAll()
	local sdkfz_halftracks_tanks = {}
	
	for i, ent in pairs( ents.FindByClass( "gmod_sent_vehicle_fphysics_base" ) ) do
		local class = ent:GetSpawn_List()
		
		if class == "sim_fphys_tank" then
			table.insert(sdkfz_halftracks_tanks, ent)
		end
	end
	
	return sdkfz_halftracks_tanks 
end




local function GetTrackPos( ent, div, smoother )
	local FT =  FrameTime()
	local spin_left = ent.trackspin_l and (-ent.trackspin_l / div) or 0
	local spin_right = ent.trackspin_r and (-ent.trackspin_r / div) or 0
	
	ent.sm_TrackDelta_L = ent.sm_TrackDelta_L and (ent.sm_TrackDelta_L + (spin_left - ent.sm_TrackDelta_L) * smoother) or 0
	ent.sm_TrackDelta_R = ent.sm_TrackDelta_R and (ent.sm_TrackDelta_R + (spin_right - ent.sm_TrackDelta_R) * smoother) or 0

	return {Left = ent.sm_TrackDelta_L,Right = ent.sm_TrackDelta_R}
	
end



local function UpdateSdkfz_halftrackScrollTexture( ent )
	local id = ent:EntIndex()

	if not ent.wheel_left_mat then
		ent.wheel_left_mat = CreateMaterial("sdkfz_halftrack_trackmat_"..id.."_left", "VertexLitGeneric", { ["$basetexture"] = "models/half_track_german/ht_track", ["$alphatest"] = "1", ["$translate"] = "[0.0 0.0 0.0]", ["Proxies"] = { ["TextureTransform"] = { ["translateVar"] = "$translate", ["centerVar"]    = "$center",["resultVar"]    = "$basetexturetransform", } } } )
	end

	if not ent.wheel_right_mat then
		ent.wheel_right_mat = CreateMaterial("sdkfz_halftrack_trackmat_"..id.."_right", "VertexLitGeneric", { ["$basetexture"] = "models/half_track_german/ht_track", ["$alphatest"] = "1", ["$translate"] = "[0.0 0.0 0.0]", ["Proxies"] = { ["TextureTransform"] = { ["translateVar"] = "$translate", ["centerVar"]    = "$center",["resultVar"]    = "$basetexturetransform", } } } )
	end
	
	
	local TrackPos = GetTrackPos( ent, 100, 0.5 )
	
	ent.wheel_left_mat:SetVector("$translate", Vector(0,TrackPos.Left,0) )
	ent.wheel_right_mat:SetVector("$translate", Vector(0,TrackPos.Right,0) )
	

	ent:SetSubMaterial( 2, "!sdkfz_halftrack_trackmat_"..id.."_left" ) 
	ent:SetSubMaterial( 3, "!sdkfz_halftrack_trackmat_"..id.."_right" )
end

local function UpdateTracks()
	if sdkfz_halftracks then
		for index, ent in pairs( sdkfz_halftracks ) do
			if IsValid( ent ) then
				UpdateSdkfz_halftrackScrollTexture( ent )
			else
				sdkfz_halftracks[index] = nil
			end
		end
	end
end

net.Receive( "sdkfz_halftrack_register_tank", function( length )
	local tank = net.ReadEntity()
	local type = net.ReadString()
	
	if not IsValid( tank ) then return end
	
	if type == "sdkfz_halftrack" then
		table.insert(sdkfz_halftracks, tank)		
	end
end)

net.Receive( "sdkfz_halftrack_update_tracks", function( length )
	local tank = net.ReadEntity()
	if not IsValid( tank ) then return end
	
	tank.trackspin_r = net.ReadFloat() 
	tank.trackspin_l = net.ReadFloat() 
	
end)

local NumCycl = 0
hook.Add( "Think", "sdkfz_halftrack_manage_tanks", function()
	local curtime = CurTime()
	
	if curtime > next_find then
		next_find = curtime + 30
		
		NumCycl = NumCycl + 1
		if NumCycl == 1 then
			sdkfz_halftracks = Sdkfz_halftracksGetAll()
			
		end
	end
	
	if curtime > next_think then
		next_think = curtime + 0.02
		
		UpdateTracks()
	end 
end)