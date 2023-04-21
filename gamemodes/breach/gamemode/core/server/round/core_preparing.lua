
round_num = 0

function Round_PrepStart()
	print("round: starting")
	preparing = true
	postround = false

	ntfs_spawned = false

	timer.Destroy("PreparingTime")
	timer.Destroy("RoundTime")
	timer.Destroy("PostTime")
	timer.Destroy("GateOpen")
	timer.Destroy("PlayerInfo")
	timer.Destroy("NTFEnterTime")
	timer.Destroy("PlayCommotionSounds")

	if timer.Exists("CheckEscape") == false then
		timer.Create("CheckEscape", 1, 0, CheckEscape)
	end

	game.CleanUpMap()
	round_commotionsounds = table.Copy(COMMOTIONSOUNDS)
	nextgateaopen = 0
	spawnedntfs = 0
	roundstats = {
		descaped = 0,
		rescaped = 0,
		sescaped = 0,
		dcaptured = 0,
		rescorted = 0,
		deaths = 0,
		teleported = 0,
		snapped = 0,
		zombies = 0,
	}
	print("round: mapcleaned")
	MAPBUTTONS = table.Copy(BUTTONS)
	CacheButtons()

	for k,v in pairs(player.GetAll()) do
		v:Freeze(false)
		v.MaxUses = nil
		v.blinkedby173 = false
		v.usedeyedrops = false
		v.isescaping = false
		v.br_faketeam = nil
		v.br_fakeclass = nil
		v:SetupLiveness()
	end

	hook.Call("BR_RoundPreparing")

	print("round: playersconfigured")
	--PrintMessage(HUD_PRINTTALK, "Prepare, round will start in ".. GetPrepTime() .." seconds")
	
	round_num = round_num + 1

	nextspecialround = nil
	--CloseSCPDoors()
	-- lua_run nextspecialround = spies
	local foundr = GetConVar("br_specialround_forcenext"):GetString()
	if foundr != nil then
		if foundr != "none" then
			print("Found a round from command: " .. foundr)
			nextspecialround = foundr
			RunConsoleCommand("br_specialround_forcenext", "none")
		else
			print("Couldn't find any round from command, setting to normal (" .. foundr .. ")")
			nextspecialround = nil
		end
	end
	if nextspecialround != nil then
		if ROUNDS[nextspecialround] != nil then
			print("Found round: " .. ROUNDS[nextspecialround].name)
			roundtype = ROUNDS[nextspecialround]
		else
			print("Couldn't find any round with name " .. nextspecialround .. ", setting to normal")
			roundtype = normalround
		end
	else
		if math.random(1, 100) <= math.Clamp(GetConVar("br_specialround_percentage"):GetInt(), 1, 100) and round_num > 2 then
			local roundstouse = {}
			for k,v in pairs(ROUNDS) do
				if v.minplayers <= #GetActivePlayers() then
					table.ForceInsert(roundstouse, v)
				end
			end
			roundtype = TableRandom(roundstouse)
		else
			roundtype = normalround
		end
	end
	if roundtype == nil then
		roundtype = normalround
	end
	
	roundtype.playersetup()
	--SetupPlayers(GetRoleTable(#GetActivePlayers()))
	
	if isfunction(MAPCONFIG_POST_ROUNDSTART) then
		MAPCONFIG_POST_ROUNDSTART()
	end
	
	net.Start("UpdateRoundType")
		net.WriteString(roundtype.name)
		--net.WriteString("Containment Breach")
	net.Broadcast()
	gamestarted = true
	
	SpawnAllItems()
	--SpawnNTFS()
	
	net.Start("PrepStart")
	net.Broadcast()
	
	timer.Create("PlayCommotionSounds", 78, 1, function()
		print("starting to play commotion sounds")
		PlayCommotionSound()
	end)

    if isfunction(MAP_OnPrepStart) then
        MAP_OnPrepStart()
    end
	
	print("round: started successfully")
	timer.Create("PreparingTime", GetPrepTime(), 1, function()
		Round_Start()
	end)
end

print("Gamemode loaded core/server/round/core_preparing.lua")