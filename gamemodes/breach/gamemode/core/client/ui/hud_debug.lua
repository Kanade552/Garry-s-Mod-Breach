
local function draw_debug_info(spawn_tab, text, color)
	if spawn_tab == nil then return end

	if istable(spawn_tab) then
		if istable(spawn_tab.spawns) then
			draw_debug_info(spawn_tab.spawns, text, color)
			return
		end
		for k,v in pairs(spawn_tab) do
			draw_debug_info(v, text, color)
		end
	else
		DrawInfo(spawn_tab, text, color)
	end
end

function BR_DrawHudDebug()
	cam.Start3D()
		for id, ply in pairs(player.GetAll()) do
			if ply:GetNClass() == ROLES.ROLE_SCP966 then
				ply:DrawModel()
			end
		end
	cam.End3D()
	
	if POS_914B_BUTTON != nil and isstring(buttonstatus) then
		if LocalPlayer():GetPos():Distance(POS_914B_BUTTON) < 200 then
			DrawInfo(POS_914B_BUTTON, buttonstatus, Color(255,255,255))
		end
	end
	
	for k,v in pairs(player.GetAll()) do
		if v.GetNClass == nil then return end
		if v:GetNClass() == ROLES.ROLE_SCP457 then
			local dlight = DynamicLight(v:EntIndex())
			if (dlight) then
				dlight.pos = v:GetShootPos()
				dlight.r = 165
				dlight.g = 100
				dlight.b = 10
				dlight.brightness = 1
				dlight.Decay = 1000
				dlight.Size = 256
				dlight.DieTime = CurTime() + 100
			end
		end
	end

	/*
	if GAS_AREAS != nil then
		cam.Start3D()
			for k,v in pairs(GAS_AREAS) do
				DrawRectInfo(v.pos1, v.pos2, Color(0,150,100,100))
			end
		cam.End3D()
	end
	for k,v in pairs(GAS_AREAS) do
		DrawInfo((v.pos1 + v.pos2) / 2, "GAS_AREA", Color(255,255,255))
	end
	if EVENT_GAS_LEAK != nil then
		cam.Start3D()
			for k,v in pairs(EVENT_GAS_LEAK) do
				DrawRectInfo(v.pos1, v.pos2, Color(255,255,0,10))
			end
		cam.End3D()
	end
	for k,v in pairs(EVENT_GAS_LEAK) do
		DrawInfo((v.pos1 + v.pos2) / 2, "EVENT_GAS_LEAK", Color(255,255,255))
	end
	*/

	draw_debug_info(SPAWN_KEYCARD2, "Keycard 2", Color(255,255,0))
	draw_debug_info(SPAWN_KEYCARD3, "Keycard 3", Color(255,120,0))
	draw_debug_info(SPAWN_KEYCARD4, "Keycard 4", Color(255,0,0))
	
	draw_debug_info(SPAWN_MEDKITS, "SPAWN_MEDKITS", Color(200,200,150))
	draw_debug_info(SPAWN_MISCITEMS, "SPAWN_MISCITEMS", Color(200,200,150))
	draw_debug_info(SPAWN_MELEEWEPS, "SPAWN_MELEEWEPS", Color(200,0,150))

	draw_debug_info(SPAWN_AMMO_PISTOL, "SPAWN_AMMO_PISTOL", Color(200,200,150))
	draw_debug_info(SPAWN_AMMO_RIFLE, "SPAWN_AMMO_RIFLE", Color(200,200,150))
	draw_debug_info(SPAWN_AMMO_SHOTGUN, "SPAWN_AMMO_SHOTGUN", Color(200,200,150))
	draw_debug_info(SPAWN_AMMO_SMG, "SPAWN_AMMO_SMG", Color(200,200,150))

	draw_debug_info(SPAWN_SMGS, "SPAWN_SMGS", Color(255,255,255))
	draw_debug_info(SPAWN_RIFLES, "SPAWN_RIFLES", Color(0,255,255))
	draw_debug_info(SPAWN_PISTOLS, "SPAWN_PISTOLS", Color(0,255,255))
	draw_debug_info(SPAWN_GPISTOLS, "SPAWN_GPISTOLS", Color(0,255,255))
	draw_debug_info(SPAWN_SHOTGUNS, "SPAWN_SHOTGUNS", Color(0,255,255))
	draw_debug_info(SPAWN_SNIPER_RIFLES, "SPAWN_SNIPER_RIFLES", Color(0,255,255))

	draw_debug_info(SPAWN_ARMORS, "SPAWN_ARMORS", Color(255,255,255))
	draw_debug_info(SPAWN_FIREPROOFARMOR, "SPAWN_FIREPROOFARMOR", Color(255,255,255))

	draw_debug_info(ENTER914, "ENTER914", Color(100,200,100))
	draw_debug_info(EXIT914, "EXIT914", Color(100,200,100))
	draw_debug_info(POS_914BUTTON, "POS_914BUTTON", Color(100,200,100))
	draw_debug_info(POS_914B_BUTTON, "POS_914B_BUTTON", Color(100,200,100))

	draw_debug_info(PD_EXITS, "PD_EXITS", Color(200,255,200))
	draw_debug_info(PD_GOODEXIT, "PD_GOODEXIT", Color(200,255,200))
	draw_debug_info(PD_BADEXIT, "PD_BADEXIT", Color(200,255,200))

	draw_debug_info(SPAWN_173, "SPAWN_173", Color(200,200,100))
	draw_debug_info(SPAWN_106, "SPAWN_106", Color(200,200,100))
	draw_debug_info(SPAWN_049, "SPAWN_049", Color(200,200,100))
	draw_debug_info(SPAWN_457, "SPAWN_457", Color(200,200,100))
	draw_debug_info(SPAWN_966, "SPAWN_966", Color(200,200,100))

	draw_debug_info(SPAWN_CLASSD, "SPAWN_CLASSD", Color(200,200,150))
	draw_debug_info(SPAWN_GUARD, "SPAWN_GUARD", Color(200,200,150))
	draw_debug_info(SPAWN_CHAOSINS, "SPAWN_CHAOSINS", Color(200,200,150))
	draw_debug_info(SPAWN_OUTSIDE, "SPAWN_OUTSIDE", Color(200,200,150))
	draw_debug_info(SPAWN_SCIENT, "SPAWN_SCIENT", Color(200,200,150))

	if istable(POCKETDIMENSION) then
		cam.Start3D()
			for k,v in pairs(POCKETDIMENSION) do
				DrawRectInfo(v.pos1, v.pos2, Color(100,120,100,100))
			end
		cam.End3D()
	end
	
	
	/*
	if istable(BUTTONS) then
		for k,v in pairs(BUTTONS) do
			local text = v.name
			if v.clevel then
				text = text .. " (" .. v.clevel .. ")"
			end
			if istable(v.pos) then
				for k2,v2 in pairs(v.pos) do
					DrawInfo(v2, text, Color(0,255,50))
				end
			else
				DrawInfo(v.pos, text, Color(0,255,50))
			end
		end
	end
	*/
end

print("Gamemode loaded core/client/ui/hud_debug.lua")