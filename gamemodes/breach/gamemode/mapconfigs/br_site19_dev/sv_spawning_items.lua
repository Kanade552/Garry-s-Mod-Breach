
function SpawnAllItems()
	simple_item_spawn(SPAWN_FIREPROOFARMOR, "armor_fireproof", true)
	simple_item_spawn(SPAWN_ARMORS, "armor_bulletproof", true)
	
	for k,v in pairs(SPAWN_PISTOLS) do
		if math.random(1,3) != 2 then
			--print("SPAWNED A PISTOL")
			local pist = "weapon_mtf_usp"
			if math.random(1,4) == 3 then pist = "weapon_mtf_deagle" end
			local wep = ents.Create(pist)
			if IsValid(wep) then
				wep:Spawn()
				wep:SetPos(v)
				wep.SavedAmmo = wep.Primary.ClipSize
				WakeEntity(wep)
			end
		end
	end
	
	for k,v in pairs(SPAWN_GPISTOLS) do
		local pist = "weapon_mtf_usp"
		if math.random(1,4) == 3 then pist = "weapon_mtf_deagle" end
		local wep = ents.Create(pist)
		if IsValid(wep) then
			wep:Spawn()
			wep:SetPos(v)
			wep.SavedAmmo = wep.Primary.ClipSize
			WakeEntity(wep)
		end
	end
	
	for k,v in pairs(SPAWN_SMGS) do
		local wep = ents.Create(TableRandom({"weapon_mtf_p90", "weapon_mtf_tmp", "weapon_mtf_ump45"}))
		if IsValid(wep) then
			wep:Spawn()
			wep:SetPos(v)
			wep.SavedAmmo = wep.Primary.ClipSize
			WakeEntity(wep)
		end
	end

	for k,v in pairs(SPAWN_SHOTGUNS) do
		local wep = ents.Create(TableRandom({"weapon_chaos_m3s90", "weapon_chaos_xm1014"}))
		if IsValid(wep) then
			wep:Spawn()
			wep:SetPos(v)
			wep.SavedAmmo = wep.Primary.ClipSize
			WakeEntity(wep)
		end
	end

	for k,v in pairs(SPAWN_SNIPER_RIFLES) do
		local wep = ents.Create("weapon_chaos_sg550")
		if IsValid(wep) then
			wep:Spawn()
			wep:SetPos(v)
			wep.SavedAmmo = wep.Primary.ClipSize
			WakeEntity(wep)
		end
	end

	for k,v in pairs(SPAWN_RIFLES) do
		local wep = ents.Create(TableRandom({"weapon_chaos_ak47", "weapon_chaos_famas"}))
		if IsValid(wep) then
			wep:Spawn()
			wep:SetPos(v)
			wep.SavedAmmo = wep.Primary.ClipSize
			WakeEntity(wep)
		end
	end
	
	simple_item_spawn(SPAWN_AMMO_RIFLE, "item_rifleammo")
	simple_item_spawn(SPAWN_AMMO_SMG, "item_smgammo")
	simple_item_spawn(SPAWN_AMMO_SHOTGUN, "item_shotgunammo")
	simple_item_spawn(SPAWN_AMMO_PISTOL, "item_pistolammo")
	simple_item_spawn(SPAWN_KEYCARD2, "keycard_level2")
	simple_item_spawn(SPAWN_KEYCARD3, "keycard_level3")
	simple_item_spawn(SPAWN_KEYCARD4, "keycard_level4")
	
	local resps_items = table.Copy(SPAWN_MISCITEMS)
	local resps_melee = table.Copy(SPAWN_MELEEWEPS)
	local resps_medkits = table.Copy(SPAWN_MEDKITS)
	
	for i=1, 4 do 
		local item = ents.Create("item_medkit")
		if IsValid(item) then
			local spawn_pos = TableRandom(resps_medkits)
			item:Spawn()
			item:SetPos(spawn_pos)
			table.RemoveByValue(resps_medkits, spawn_pos)
		end
	end
	
	for k, spawn_group in pairs(resps_items) do
		for k2, item_class in pairs(spawn_group.items) do
			local item = ents.Create(item_class)
			if IsValid(item) then
				local spawn_pos = TableRandom(spawn_group.spawns)
				item:Spawn()
				item:SetPos(spawn_pos)
				table.RemoveByValue(spawn_group.spawns, spawn_pos)
			end
		end
	end
	
	for k,v in pairs(resps_melee) do
		local spawn_pos = TableRandom(v)
		local item = ents.Create("weapon_crowbar")
		if IsValid(item) then
			item:Spawn()
			item:SetPos(spawn_pos)
		end
	end
end

print("Gamemode loaded mapconfigs/br_site19/sv_spawning_items.lua")
