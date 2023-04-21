
function simple_item_spawn(spawn_tab, spawn_class, wake)
	for k,v in pairs(spawn_tab) do
		local spawn_pos = v
		if istable(v) then
			spawn_pos = TableRandom(v)
		end

		local spawned_item = ents.Create(spawn_class)
		if IsValid(spawned_item) then
			spawned_item:Spawn()
			spawned_item:SetPos(spawn_pos)
			if wake then
				WakeEntity(spawned_item)
			end
		end
	end
end

-- actual spawning items moved to mapconfig

print("Gamemode loaded core/server/round/spawning_items.lua")