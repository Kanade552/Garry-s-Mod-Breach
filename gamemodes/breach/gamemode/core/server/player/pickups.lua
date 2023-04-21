
function GM:PlayerCanPickupWeapon(ply, wep)
	--print("pickup " .. ply:Nick() .. " - " .. wep:GetClass())
	--if ply.lastwcheck == nil then ply.lastwcheck = 0 end
	--if ply.lastwcheck > CurTime() then return end
	--ply.lastwcheck = CurTime() + 0.5

	if wep.IDK != nil then
		for k,v in pairs(ply:GetWeapons()) do
			if wep.Slot == v.Slot then
				return false
			end
		end
	end
	if wep.clevel != nil then
		for k,v in pairs(ply:GetWeapons()) do
			if v.clevel then
				return false
			end
		end
	end
	if ply:GTeam() == TEAM_SCP then
		if not wep.ISSCP then
			return false
		else
			if wep.ISSCP then
				return true
			else
				return false
			end
		end
	end
	if ply:GTeam() != TEAM_SPECTATOR then
		if wep.teams then
			local canuse = false
			for k,v in pairs(wep.teams) do
				if v == ply:GTeam() then
					canuse = true
				end
			end
			if canuse == false then
				return false
			end
		end
		for k,v in pairs(ply:GetWeapons()) do
			if v:GetClass() == wep:GetClass() then
				return false
			end
		end
		ply.gettingammo = wep.SavedAmmo
		return true
	else
		return false
	end
end

function GM:PlayerCanPickupItem(ply, item)
	return (ply:GTeam() != TEAM_SPECTATOR)
end

function GM:AllowPlayerPickup(ply, ent)
	return (ply:GTeam() != TEAM_SPECTATOR)
end

print("Gamemode loaded core/server/player/pickups.lua")