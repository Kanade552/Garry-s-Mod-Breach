
local next_halo_check = 0
local players_to_highlight = {}
hook.Add("PreDrawHalos", "Halo173", function()
	if SERVER then return end
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()
	if IsValid(wep) then
		if isfunction(wep.PreDrawHalos) then
			wep:PreDrawHalos()
		end
	end
	if ply:GTeam() == TEAM_SCP then
		for i,v in pairs(players_to_highlight) do
			local pl = v[1]
			if CurTime() - v[2] > 10 then
				table.RemoveByValue(players_to_highlight, v)
				print("Removed " .. tostring(v[1]) .. " from players_to_highlight")
			elseif IsValid(pl) == false or pl:Alive() == false or pl:GTeam() == TEAM_SCP or pl:IsSpectator() then
				table.RemoveByValue(players_to_highlight, v)
				print("Removed " .. tostring(v[1]) .. " from players_to_highlight")
			end
		end
		if next_halo_check < CurTime() then
			next_halo_check = CurTime() + 2
			for k,v in pairs(player.GetAll()) do
				local tfscps = v:GetNWFloat("targetForSCPs", nil)
				if tfscps != nil then
					if CurTime() - tfscps < 11 then
						local found_pl = false
						for k2,v2 in pairs(players_to_highlight) do
							if v2[1] == v then
								found_pl = true
							end
						end
						if found_pl == false then
							print("Added " .. tostring(v) .. " to players_to_highlight")
							table.ForceInsert(players_to_highlight, {v, tfscps})
						end
					end
				end
			end
		end
		local tab_fixed = {}
		for k,v in pairs(players_to_highlight) do
			table.ForceInsert(tab_fixed, v[1])
		end
		halo.Add(tab_fixed, Color(255,0,0), 4, 4, 4, true, true)
	end
end)

print("Gamemode loaded core/client/ui/halos.lua")