
ngst = 0

function GM:PlayerInitialSpawn(ply)
	ply:SetCanZoom(false)
	ply:SetNoDraw(true)

	ply.Active = false
	ply.freshspawn = true
	ply.ActivePlayer = true
	ply.nextDamageInPD = 0
	ply.nextDamageInGas = 0
	ply.LastCough = 0
	ply.NextCough = 0
	ply.LastBreathe = 0
	ply.NextBreathe = 0
	ply.NextSpawnTime = 0
	ply.nextexp = 0
	ply.slowdown966 = 0
	ply.slowdown966a = 0
	ply.next_sa_sound = 0

	ply.br_walk_speed = 100
	ply.br_run_speed = 100
	ply.br_jump_power = 100

	ply.liveness_score = 100

	-- Blinking system's variables
	ply.blink_start = 0
	ply.blink_end = 0
	ply.seen173 = 0
	ply.eyedrops_til = 0
	ply.blinded_by_173_til = 0

	ply:SetNEXP(tonumber(ply:GetPData("breach_exp", 0)))
	ply:SetNLevel(tonumber(ply:GetPData("breach_level", 0)))

	ply.br_team = 1
	ply.br_faketeam = nil
	ply.br_fakeclass = nil

	ply.cant_drop_armor = false

	ngst = CurTime() + 2
	timer.Simple(3, CheckStart)
end

function GM:PlayerAuthed(ply, steamid, uniqueid)
	timer.Simple(1, UpdatePlayersAllInfo)
end

function GM:PlayerSpawn(ply)
	--ply:SetupHands()
	ply:SetTeam(1)
	ply:SetNoCollideWithTeammates(true)
	ply:SetCustomCollisionCheck(true)
	ply:SetGravity(1)
	ply.seen173 = 0
	--ply:SetCustomCollisionCheck(true)
	
	if ply.freshspawn then
		ply:SetSpectator()
		ply.freshspawn = false
	end
	--ply:SetupHands()
end

function GM:PlayerSetHandsModel(ply, ent)
	local simplemodel = player_manager.TranslateToPlayerModelName(ply:GetModel())
	local info = player_manager.TranslatePlayerHands(simplemodel)
	if info then
		if ply.handsmodel != nil then
			info = ply.handsmodel
		end
		ent:SetModel(info.model)
		ent:SetSkin(info.skin)
		ent:SetBodyGroups(info.body)
	end
end

print("Gamemode loaded core/server/player/spawn.lua")