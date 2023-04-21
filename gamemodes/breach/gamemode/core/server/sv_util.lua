
function SpawnPointPos(spawn_tab)
	if istable(spawn_tab) then
		return TableRandom(spawn_tab)
	end
	return spawn_tab
end

function GetAlivePlayers()
	local plys = {}
	for k,v in pairs(player.GetAll()) do
		if !v:IsSpectator() and v:Alive() then
			table.ForceInsert(plys, v)
		end
	end
	return plys
end

function GetActivePlayers()
	local tab = {}
	for k,v in pairs(player.GetAll()) do
		if v.ActivePlayer then
			table.ForceInsert(tab, v)
		end
	end
	return tab
end

function GetNotActivePlayers()
	local tab = {}
	for k,v in pairs(player.GetAll()) do
		if !v.ActivePlayer then
			table.ForceInsert(tab, v)
		end
	end
	return tab
end

function GetRoleTable(all)
	local classds = 0
	local mtfs = 0
	local researchers = 0
	local staff = 0
	local scps = 0
	if all < 8 then
		scps = 1
		all = all - 1
	elseif all > 7 and all < 16 then
		scps = 2
		all = all - 2
	elseif all > 15 then
		scps = 3
		all = all - 3
	end
	--mtfs = math.Round(all * 0.299)
	local mtfmul = 0.3
	if all > 12 then
		mtfmul = 0.28
	elseif all > 22 then
		mtfmul = 0.26
	end
	mtfs = math.Round(all * mtfmul)
	all = all - mtfs
	researchers = math.floor(all * 0.38)
	all = all - researchers
	staff = math.floor(all * 0.3)
	all = all - staff
	classds = all
	--print(scps .. "," .. mtfs .. "," .. classds .. "," .. researchers .. "," .. chaosinsurgency)
	/*
	print("scps: " .. scps)
	print("mtfs: " .. mtfs)
	print("classds: " .. classds)
	print("researchers: " .. researchers)
	print("chaosinsurgency: " .. chaosinsurgency)
	*/
	return {scps, mtfs, classds, researchers, staff}
end

function GetRoleTableCustom(all, scps, p_sec, p_res, p_staff)
	local classds = 0
	local security = 0
	local researchers = 0
	local staff = 0
	all = all - scps
	security = math.Round(all * p_sec)
	all = all - security
	researchers = math.floor(all * p_res)
	all = all - researchers
	staff = math.floor(all * p_staff)
	all = all - staff
	classds = all
	return {scps, security, classds, researchers, staff}
end

function IsRoleMaxed(role)
	local using = 0
	for _,pl in pairs(player.GetAll()) do
		if pl:GetNClass() == role.name then
			using = using + 1
		end
	end
	return (using >= role.max)
end

function CheckPLAYER_SETUP()
	local si = 1
	for i=3, #PLAYER_SETUP do
		local v = PLAYER_SETUP[si]
		local num = v[1] + v[2] + v[3] + v[4]
		if i != num then
			print(tostring(si) .. " is not good: " .. tostring(num) .. "/" .. tostring(i))
		else
			print(tostring(si) .. " is good: " .. tostring(num) .. "/" .. tostring(i))
		end
		si = si + 1
	end
end

function uber_random(num)
	local power = 99999999
	local rnd = math.Round(math.random(1,power) % (num))
	return (rnd + 1)
end

function uber_random_table(tab)
	return tab[uber_random(#tab)]
end

print("Gamemode loaded core/server/sv_util.lua")