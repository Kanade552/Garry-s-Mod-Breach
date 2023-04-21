
include("extensions.lua")
include("scps.lua")

function SetupPlayers_new()
	for k,v in pairs(player.GetAll()) do
		v:SetSpectator()
	end

	local allpl = player.GetAll()
	local num_of_players = math.Clamp(#allpl, 1, #Breach_Default_Role_List)
	local our_role_list = {}
	for i=1, num_of_players do
		local role = Breach_Default_Role_List[i]
		if our_role_list[role] == nil then our_role_list[role] = 0 end
		our_role_list[role] = our_role_list[role] + 1
	end
	local players_to_use = {}
	for i=1, num_of_players do
		--local pl_to_use = TableRandom(allpl)
		local pl_to_use = uber_random_table(allpl)
		table.ForceInsert(players_to_use, pl_to_use)
		table.RemoveByValue(allpl, pl_to_use)
	end
	local security_spawns = table.Copy(SPAWN_GUARD)
	local research_spawns = table.Copy(SPAWN_SCIENT)
	local chaosins_spawns = table.Copy(SPAWN_CHAOSINS)
	local classds_spawns = table.Copy(SPAWN_CLASSD)
	local spc_tab = table.Copy(SCPS)
	for k,v in pairs(players_to_use) do
		if our_role_list[ROLE_LIST_SECURITY] != nil and our_role_list[ROLE_LIST_SECURITY] > 0 then
			our_role_list[ROLE_LIST_SECURITY] = our_role_list[ROLE_LIST_SECURITY] - 1
			local security_roles = ALLCLASSES["security"]["roles"]
			local best_role_to_use = security_roles[1]
			for k2,role in pairs(security_roles) do
				local can = true
				if isfunction(role.customcheck) then
					if role.customcheck(v) == false then
						can = false
					end
				end
				if can then
					if IsRoleMaxed(role) == false and v:GetLevel() >= role.level and role.level > best_role_to_use.level then
						if role.players_min != nil then
							if num_of_players >= role.players_min then
								--print("1 "..role.name.."("..role.level..")".." better than "..best_role_to_use.name.."("..best_role_to_use.level..")")
								best_role_to_use = role
							end
						else
							--print("2 "..role.name.."("..role.level..")".." better than "..best_role_to_use.name.."("..best_role_to_use.level..")")
							best_role_to_use = role
						end
					--else
						--print("nop "..role.name.." IsRoleMaxed:"..tostring(IsRoleMaxed(role)).." levels1:"..tostring(v:GetLevel() >= role.level).." levels2:"..tostring(role.level > best_role_to_use.level))
					end
				end
			end
			local spawn = TableRandom(security_spawns)
			v:SetupNormal()
			v:ApplyRoleStats(best_role_to_use)
			v:SetPos(spawn)
			table.RemoveByValue(security_spawns, spawn)
			
		elseif our_role_list[ROLE_LIST_CLASSDS] != nil and our_role_list[ROLE_LIST_CLASSDS] > 0 then
			our_role_list[ROLE_LIST_CLASSDS] = our_role_list[ROLE_LIST_CLASSDS] - 1
			v:SetRoleBestFrom("classds")
			local spawn = TableRandom(classds_spawns)
			v:SetPos(spawn)
			table.RemoveByValue(classds_spawns, spawn)

		elseif our_role_list[ROLE_LIST_RESEARCH_STAFF] != nil and our_role_list[ROLE_LIST_RESEARCH_STAFF] > 0 then
			our_role_list[ROLE_LIST_RESEARCH_STAFF] = our_role_list[ROLE_LIST_RESEARCH_STAFF] - 1
			v:SetRoleBestFrom("research_staff")
			local spawn = TableRandom(research_spawns)
			v:SetPos(spawn)
			table.RemoveByValue(research_spawns, spawn)

		elseif our_role_list[ROLE_LIST_MISC_STAFF] != nil and our_role_list[ROLE_LIST_MISC_STAFF] > 0 then
			our_role_list[ROLE_LIST_MISC_STAFF] = our_role_list[ROLE_LIST_MISC_STAFF] - 1
			v:SetRoleBestFrom("misc_staff")
			local spawn = TableRandom(research_spawns)
			v:SetPos(spawn)
			table.RemoveByValue(research_spawns, spawn)

		elseif our_role_list[ROLE_LIST_CHAOSINS] != nil and our_role_list[ROLE_LIST_CHAOSINS] > 0 then
			our_role_list[ROLE_LIST_CHAOSINS] = our_role_list[ROLE_LIST_CHAOSINS] - 1
			v:SetRoleBestFrom("chaosins")
			local spawns_table = chaosins_spawns
			local ci_role = FindRole(v:GetNClass())
			if ci_role and ci_role.disguised_spawn and ci_role.disguised_spawn == "research_spawns" then
				spawns_table = research_spawns
			end
			local spawn = TableRandom(spawns_table)
			v:SetPos(spawn)
			table.RemoveByValue(spawns_table, spawn)

		elseif our_role_list[ROLE_LIST_SCPS] != nil and our_role_list[ROLE_LIST_SCPS] > 0 then
			our_role_list[ROLE_LIST_SCPS] = our_role_list[ROLE_LIST_SCPS] - 1
			if #spc_tab < 1 then
				spc_tab = table.Copy(SCPS)
			end
			local scp = TableRandom(spc_tab)
			scp["func"](v)
			table.RemoveByValue(spc_tab, scp)
		end
	end

	UpdatePlayersAllInfo()
end

function SetupPlayers(pltab)
	local allply = GetActivePlayers()
	
	-- SCPS
	local spctab = table.Copy(SCPS)
	for i=1, pltab[1] do
		if #spctab < 1 then
			spctab = table.Copy(SCPS)
			--print("not enough scps, copying another table")
		end
		local pl = TableRandom(allply)
		if IsValid(pl) == false then return end
		local scp = TableRandom(spctab)
		scp["func"](pl)
		print("assigning " .. pl:Nick() .. " to scps")
		table.RemoveByValue(spctab, scp)
		table.RemoveByValue(allply, pl)
	end
	
	-- Class D Personnel
	local dspawns = table.Copy(SPAWN_CLASSD)
	for i=1, pltab[3] do
		if #dspawns > 0 then
			local pl = TableRandom(allply)
			if IsValid(pl) == false then return end
			local spawn = TableRandom(dspawns)
			pl:SetupNormal()
			pl:SetClassD()
			pl:SetPos(spawn)
			print("assigning " .. pl:Nick() .. " to classds")
			table.RemoveByValue(dspawns, spawn)
			table.RemoveByValue(allply, pl)
		end
	end
	
	-- Researcher Staff
	local resspawns = table.Copy(SPAWN_SCIENT)
	for i=1, pltab[4] do
		if #resspawns > 0 then
			local pl = TableRandom(allply)
			if IsValid(pl) == false then return end
			local spawn = TableRandom(resspawns)
			pl:SetupNormal()
			pl:SetResearcher()
			pl:SetPos(spawn)
			print("assigning " .. pl:Nick() .. " to researchers")
			table.RemoveByValue(resspawns, spawn)
			table.RemoveByValue(allply, pl)
		end
	end
	-- Misc Staff
	for i=1, pltab[5] do
		if #resspawns > 0 then
			local pl = TableRandom(allply)
			if IsValid(pl) == false then return end
			local spawn = TableRandom(resspawns)
			pl:SetupNormal()
			pl:SetStaff()
			pl:SetPos(spawn)
			print("assigning " .. pl:Nick() .. " to misc staff")
			table.RemoveByValue(resspawns, spawn)
			table.RemoveByValue(allply, pl)
		end
	end
	
	-- Security
	local security = ALLCLASSES["security"]["roles"]
	local snum = pltab[2]
	local securityspawns = table.Copy(SPAWN_GUARD)
	
	local i4 = math.floor(snum / 8)
	
	local i4roles = {}
	local i4players = {}
	local i3roles = {}
	local i3players = {}
	local i2roles = {}
	local i2players = {}
	for k,v in pairs(security) do
		if v.importancelevel == 4 then
			table.ForceInsert(i4roles, v)
		elseif v.importancelevel == 3 then
			table.ForceInsert(i3roles, v)
		elseif v.importancelevel == 2 then
			table.ForceInsert(i2roles, v)
		end
	end
	
	for _,pl in pairs(allply) do
		for k,v in pairs(security) do
			if v.importancelevel > 1 then
				local can = true
				if v.customcheck != nil then
					if v.customcheck(pl) == false then
						can = false
					end
				end
				if can then
					if pl:GetLevel() >= v.level then
						if v.importancelevel == 2 then
							table.ForceInsert(i2players, pl)
						elseif v.importancelevel == 3 then
							table.ForceInsert(i3players, pl)
						else
							table.ForceInsert(i4players, pl)
						end
					end
				end
			end
		end
	end
	
	if i4 >= 1 then
		if #i4roles > 0 and #i4players > 0 then
			local pl = TableRandom(i4players)
			local spawn = TableRandom(securityspawns)
			pl:SetupNormal()
			pl:ApplyRoleStats(TableRandom(i4roles))
			table.RemoveByValue(i4players, pl)
			table.RemoveByValue(i3players, pl)
			table.RemoveByValue(i2players, pl)
			pl:SetPos(spawn)
			print("assigning " .. pl:Nick() .. " to security i4")
			table.RemoveByValue(securityspawns, spawn)
			table.RemoveByValue(allply, pl)
		end
	end

	if #i3roles > 0 and #i3players > 0 then
		local pl = TableRandom(i3players)
		local spawn = TableRandom(securityspawns)
		pl:SetupNormal()
		pl:ApplyRoleStats(TableRandom(i3roles))
		table.RemoveByValue(i4players, pl)
		table.RemoveByValue(i3players, pl)
		table.RemoveByValue(i2players, pl)
		pl:SetPos(spawn)
		print("assigning " .. pl:Nick() .. " to security i3")
		table.RemoveByValue(securityspawns, spawn)
		table.RemoveByValue(allply, pl)
	end
	
	if #i2roles > 0 and #i2players > 0 then
		local pl = TableRandom(i2players)
		local spawn = TableRandom(securityspawns)
		pl:SetupNormal()
		pl:ApplyRoleStats(TableRandom(i2roles))
		pl:SetPos(spawn)
		table.RemoveByValue(i4players, pl)
		table.RemoveByValue(i3players, pl)
		table.RemoveByValue(i2players, pl)
		print("assigning " .. pl:Nick() .. " to security i2")
		table.RemoveByValue(securityspawns, spawn)
		table.RemoveByValue(allply, pl)
	end
	
	for k,v in pairs(allply) do
		local spawn = TableRandom(securityspawns)
		v:SetupNormal()
		v:SetSecurityI1()
		v:SetPos(spawn)
		print("assigning " .. v:Nick() .. " to security i1")
		table.RemoveByValue(securityspawns, spawn)
	end

	UpdatePlayersAllInfo()

	net.Start("RolesSelected")
	net.Broadcast()
end

print("Gamemode loaded core/server/assigning/_init.lua")