
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
	simple_item_spawn(SPAWN_GMEDKITS, "item_medkit")
	
	local resps_items = table.Copy(SPAWN_MISCITEMS)
	local resps_melee = table.Copy(SPAWN_MELEEWEPS)
	local resps_medkits = table.Copy(SPAWN_MEDKITS)
	
	for i=1, 2 do 
		local item = ents.Create("item_medkit")
		if IsValid(item) then
			local spawn4 = TableRandom(resps_medkits)
			item:Spawn()
			item:SetPos(spawn4)
			table.RemoveByValue(resps_medkits, spawn4)
		end
	end
	
	local item = ents.Create("item_radio")
	if IsValid(item) then
		local spawn4 = TableRandom(resps_items)
		item:Spawn()
		item:SetPos(spawn4)
		table.RemoveByValue(resps_items, spawn4)
	end
	
	local item = ents.Create("item_eyedrops")
	if IsValid(item) then
		local spawn4 = TableRandom(resps_items)
		item:Spawn()
		item:SetPos(spawn4)
		table.RemoveByValue(resps_items, spawn4)
	end
	
	for i=1, 2 do 
		local item = ents.Create("item_nvg")
		if IsValid(item) then
			local spawn4 = TableRandom(resps_items)
			item:Spawn()
			item:SetPos(spawn4)
			table.RemoveByValue(resps_items, spawn4)
		end
	end
	
	for i=1, 2 do
		local item	= ents.Create("item_gasmask")
		if IsValid(item) then
			local spawn4 = TableRandom(resps_items)
			item:Spawn()
			item:SetPos(spawn4)
			table.RemoveByValue(resps_items, spawn4)
		end
	end
	
	for k,v in pairs(resps_melee) do
		local rnd_spawn = TableRandom(v)
		local item = ents.Create("weapon_crowbar")
		if IsValid(item) then
			item:Spawn()
			item:SetPos(rnd_spawn)
		end
	end
end

print("Gamemode loaded mapconfigs/br_site19/sv_spawning_items.lua")
