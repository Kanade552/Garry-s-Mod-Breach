
local next_wincheck = 0

function end_round(why, wintype)
	print("Ending round because " .. why)
	PrintMessage(HUD_PRINTCONSOLE, "Ending round because " .. why)
	StopRound()

	preparing = false
	postround = true
	-- send infos
	
	net.Start("PostStart")
		net.WriteTable(roundstats)
		net.WriteString(wintype)
	net.Broadcast()

	timer.Create("PostTime", GetPostTime(), 1, function()
		RoundRestart()
	end)
end

function WinCheck()
	if next_wincheck > CurTime() or player.GetCount() < 2 or preparing or postround or !gamestarted then return end
	next_wincheck = CurTime() + 1 + math.Rand(1,2)
	
	/*
	local team_tab = {
		[TEAM_CLASSD] = 0,
		[TEAM_GUARD] = 0,
		[TEAM_SCI] = 0,
		[TEAM_STAFF] = 0,
		[TEAM_SCP] = 0,
		[TEAM_CHAOS] = 0
	}

	local player_count = 0

	for k,v in pairs(player.GetAll()) do
		local gteam = v:GTeam()
		if v:Alive() and gteam != TEAM_SPECTATOR and v:LivenessIsGood() then
			team_tab[gteam] = team_tab[gteam] + 1;
			player_count = player_count + 1
		end
	end
	*/

	local team_tab, player_count, team_power_list = BR_RoundTeamStrengthsRaport()
	local dominant_force, dominant_force_class = BR_DominantPower(team_tab, player_count, team_power_list)
	local time_left = BR_RoundTimePercLeft()

	Entity(1):PrintMessage(HUD_PRINTCENTER, tostring(dominant_force) .. " - " .. tostring((1 - time_left) / 2.5))

	if player_count == 0 then
		-- no one won
		end_round("no one won", "end_noonewon")

	elseif (time_left < 0.6 and (ntfs_spawned or time_left <= 0) and dominant_force > 0.98 - ((1 - time_left) / 2.5)) or ((ntfs_spawned or time_left <= 0) and dominant_force == 1) then
		-- dominant force won
		end_round("dominant force", "end_"..string.lower(dominant_force_class))
		print("end_"..string.lower(dominant_force_class))

	elseif time_left <= 0 then
		end_round("time reached", "end_time")
	end
end

function WinCheck_old()
	if player.GetCount() < 2 or preparing or postround or !gamestarted then return end
	
	local ds = gteams.NumPlayers(TEAM_CLASSD)
	local mtfs = gteams.NumPlayers(TEAM_GUARD)
	local res = gteams.NumPlayers(TEAM_SCI)
	local staff = gteams.NumPlayers(TEAM_STAFF)
	local scps = gteams.NumPlayers(TEAM_SCP)
	local chaos = gteams.NumPlayers(TEAM_CHAOS)
	local all = table.Count(GetAlivePlayers())
	print("wincheck! ds:", ds, "mtfs:", mtfs, "res:", res, "staff:", staff, "scps:", scps, "chaos:", chaos, "all:", all)
	
	local why = "idk"
	local wintype = 2
	
	local endround = true
	if all == 0 then
		why = "everybody is dead"
		wintype = 3
	elseif scps == all then
		why = "there are only scps"
	elseif mtfs == all then
		why = "there are only mtfs"
	elseif res == all then
		why = "there are only researchers"
	elseif staff == all then
		why = "there is only staff"
	elseif ds == all then
		why = "there are only class ds"
	elseif chaos == all then
		why = "there are only chaos insurgency members"
	elseif ((mtfs + res) == all) or ((mtfs + staff) == all) or ((res + staff) == all) or ((mtfs + res + staff) == all) then
		why = "there is only staff"
	elseif (chaos + ds) == all then
		why = "there are only chaos insurgency members and class ds"
	else
		endround = false
	end

	if endround then
		print("Ending round because " .. why)
		PrintMessage(HUD_PRINTCONSOLE, "Ending round because " .. why)
		StopRound()

		preparing = false
		postround = true
		-- send infos
		
		net.Start("PostStart")
			net.WriteTable(roundstats)
			net.WriteInt(wintype, 4)
		net.Broadcast()

		timer.Create("PostTime", GetPostTime(), 1, function()
			RoundRestart()
		end)
	end
end

hook.Add("Tick", "BR_WinCheckTick", WinCheck)

print("Gamemode loaded core/server/round/win_check.lua")