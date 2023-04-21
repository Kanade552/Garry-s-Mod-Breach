
function AssaultGamemode()
	local all_players = GetActivePlayers()
	local guards = {}
	for i=1, math.Round(#player.GetAll() / 2) do
		local rnd_player = TableRandom(all_players)
		table.ForceInsert(guards, rnd_player)
		table.RemoveByValue(all_players, rnd_player)
	end

	--guards
	for i,v in ipairs(guards) do
		v:SetupNormal()
		v:ApplyRoleStats(ALLCLASSES.support.roles[1])
		v:SetPos(SPAWN_GUARD[i])
		--print("spawning "..v:Nick().." as a guard")
	end

	--rest
	for i,v in ipairs(all_players) do
		v:SetupNormal()
		v:ApplyRoleStats(ALLCLASSES.support.roles[2])
		v:SetPos(SPAWN_CLASSD[i])
		--print("spawning "..v:Nick().." as a classd")
	end

	UpdatePlayersAllInfo()
end

function ZombieGamemode()
	local all = GetActivePlayers()
	local allspawns = {}
	table.Add(allspawns, SPAWN_GUARD)
	--table.Add(allspawns, SPAWN_OUTSIDE)
	table.Add(allspawns, SPAWN_SCIENT)
	table.Add(allspawns, SPAWN_CLASSD)
	for i=1, #all do
		local pl = TableRandom(all)
		local spawn = TableRandom(allspawns)
		pl:SetupNormal()
		pl:ApplyRoleStats(ALLCLASSES.security.roles[1])
		pl:SetPos(spawn)
		table.RemoveByValue(allspawns, spawn)
		table.RemoveByValue(all, pl)
	end

	UpdatePlayersAllInfo()
end

function InfectPeople()
	local all = GetActivePlayers()
	for i=1, math.Round(#all / 4) do
		local pl = TableRandom(all)
		pl:SetSCP0082()
		table.RemoveByValue(all, pl)
	end

	UpdatePlayersAllInfo()
end

function SpyGamemode()
	local all = GetActivePlayers()
	local allspawns = {}
	table.Add(allspawns, SPAWN_GUARD)
	--table.Add(allspawns, SPAWN_OUTSIDE)
	table.Add(allspawns, SPAWN_SCIENT)
	table.Add(allspawns, SPAWN_CLASSD)
	for i=1, (#GetActivePlayers() / 3) do
		local pl = TableRandom(all)
		local spawn = TableRandom(allspawns)
		pl:SetupNormal()
		pl:ApplyRoleStats(ALLCLASSES.support.roles[2])
		pl:SetPos(spawn)
		table.RemoveByValue(allspawns, spawn)
		table.RemoveByValue(all, pl)
	end
	for i,pl in ipairs(all) do
		local spawn = TableRandom(allspawns)
		pl:SetupNormal()
		pl:ApplyRoleStats(ALLCLASSES.security.roles[1])
		pl:SetPos(spawn)
		table.RemoveByValue(allspawns, spawn)
	end

	UpdatePlayersAllInfo()
end

normalround = {
	playersetup = function()
		--SetupPlayers(GetRoleTable(#GetActivePlayers()))
		SetupPlayers_new()
	end,
	name = "Containment breach",
	minplayers = 3,
	allowntfspawn = true,
	scp_delay = true,
	onroundstart = nil
}

ROUNDS = {
	assault = {
		playersetup = AssaultGamemode,
		name = "Assault",
		minplayers = 4,
		allowntfspawn = false,
		scp_delay = false,
		onroundstart = nil
	},
	/*
	spies = {
		playersetup = SpyGamemode,
		name = "Trouble in SCP Town",
		minplayers = 4,
		allowntfspawn = false,
		scp_delay = false,
		onroundstart = nil
	},
	*/
	multiplebreaches = {
		playersetup = function()
			local pnum = #GetActivePlayers()
			if pnum < 7 then
				SetupPlayers(GetRoleTableCustom(#GetActivePlayers(), 1, 0, 0, 0, 0))
			elseif pnum > 6 and pnum < 13 then
				SetupPlayers(GetRoleTableCustom(#GetActivePlayers(), 2, 0, 0, 0, 0))
			elseif pnum > 12 and pnum < 20 then
				SetupPlayers(GetRoleTableCustom(#GetActivePlayers(), 3, 0, 0, 0, 0))
			else
				SetupPlayers(GetRoleTableCustom(#GetActivePlayers(), 4, 0, 0, 0, 0))
			end
		end,
		name = "Multiple breaches",
		minplayers = 4,
		allowntfspawn = false,
		scp_delay = true,
		onroundstart = nil
	},
	zombieplague = {
		playersetup = ZombieGamemode,
		name = "Zombie Plague",
		minplayers = 6,
		allowntfspawn = false,
		scp_delay = false,
		onroundstart = InfectPeople
	}
}

print("Gamemode loaded core/server/round/special_rounds.lua")