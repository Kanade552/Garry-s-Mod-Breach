
function GetNextNTFSpawn()
	return CurTime() + math.random(GetConVar("br_time_ntfenter_delay_min"):GetInt(), GetConVar("br_time_ntfenter_delay_max"):GetInt())
end

function NumberOfNTFs()
	local num = 0
	for k,v in pairs(player.GetAll()) do
		if v:Alive() and !v:IsSpectator() and IsPlayerNTF(v) then
			num = num + 1
		end
	end
	return num
end

ntfs_spawned = false
last_ntf_spawn = 0
next_ntf_spawn_check = 0
function HandleNTFSpawns()
	if preparing or postround or !gamestarted or next_ntf_spawn_check > CurTime() or roundtype.allowntfspawn == false then return end

	local active_spectators = 0
	for k,v in pairs(gteams.GetPlayers(TEAM_SPECTATOR)) do
		if v.ActivePlayer then
			active_spectators = active_spectators + 1
		end
	end

	if active_spectators > 1 then
		local spawned, type = SpawnNTFS()
		if spawned then
			next_ntf_spawn_check = GetNextNTFSpawn()
			print("Next NTF spawn in " .. tostring(next_ntf_spawn_check - CurTime()))
		
			if type == 1 then
				PrintMessage(HUD_PRINTTALK, "Mobile Task Forces have entered the facility.")
				FoundationAnnouncement("NTFSpawned")
				last_ntf_spawn = CurTime()
				ntfs_spawned = true
			end

			UpdatePlayersAllInfo()
		end
	end
end

function SpawnNTFS(force_type)
	if roundtype.allowntfspawn == false then return false, 0 end

	local usablesupport = {}
	local activeplayers = {}
	for k,v in pairs(player.GetAll()) do
		if v.ActivePlayer and (!v:Alive() or v:IsSpectator()) then
			table.ForceInsert(activeplayers, v)
		end
	end
	for k,v in pairs(ALLCLASSES["support"]["roles"]) do
		table.ForceInsert(usablesupport, {
			role = v,
			list = {}
		})
	end
	for _,rl in pairs(usablesupport) do
		for k,v in pairs(activeplayers) do
			if rl.role.level <= v:GetLevel() then
				local can = true
				if rl.role.customcheck != nil and !rl.role.customcheck(v) then
					can = false
				end
				if can then
					table.ForceInsert(rl.list, v)
				end
			end
		end
	end

	local usechaos = false

	if isnumber(force_type) then
		usechaos = (force_type == 2)
	else
		local team_tab, player_count, team_power_list = BR_RoundTeamStrengthsRaport()
		local dominant_force, dominant_force_class = BR_DominantPower(team_tab, player_count, team_power_list)
		
		usechaos = (dominant_force_class != "ALIGN_CHAOS" and dominant_force >= 0.5 and math.random(1,100) < 85)
	end

	print("usechaos? ", usechaos)

	if usechaos then
		local chaosnum = 0
		for _,rl in pairs(usablesupport) do
			if rl.role.team == TEAM_CHAOS then
				chaosnum = chaosnum + #rl.list
			end
		end
		if chaosnum > 1 then
			local cinum = 0
			for _,rl in pairs(usablesupport) do
				if rl.role.team == TEAM_CHAOS then
					for k,v in pairs(rl.list) do
						if cinum > 4 then return true, 2 end
						cinum = cinum + 1
						v:SetupNormal()
						v:ApplyRoleStats(rl.role)
						v:SetPos(SPAWN_OUTSIDE[cinum])
					end
				end
			end
			return true, 2
		end
	end

	--PrintTable(usablesupport)

	local used = 1
	for _,rl in pairs(usablesupport) do
		if rl.role.team == TEAM_GUARD then
			for k,v in pairs(rl.list) do
				if used > 4 then return true, 1 end
				used = used + 1
				v:SetupNormal()
				v:ApplyRoleStats(rl.role)
				v:SetPos(SPAWN_OUTSIDE[used])
			end
		end
	end

	return true, 1
end

print("Gamemode loaded core/server/round/spawning_support.lua")