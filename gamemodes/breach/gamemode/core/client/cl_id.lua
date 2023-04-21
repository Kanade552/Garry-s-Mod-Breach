
/*
SAVEDIDS = {}
lastidcheck = 0
function AddToIDS(ply)
	if lastidcheck > CurTime() then return end
	local sid = nil
	local wep = ply:GetActiveWeapon()
	if ply:GTeam() == TEAM_SCP then
		sid = ply:GetNClass()
	else
		if IsValid(wep) then
			if wep:GetClass() == "br_id" then
				sid = ply:GetNClass()
			end
		end
	end
	if sid == ROLES.ROLE_CHAOSSPY then
		if (LocalPlayer():GTeam() == TEAM_SCI) or (LocalPlayer():GTeam() == TEAM_GUARD) then
			sid = ROLES.ROLE_MTFGUARD
		end
	end
	for k,v in pairs(SAVEDIDS) do
		if v.pl == ply then
			if v.id == sid then
				lastidcheck = CurTime() + 0.5
				return
			end
		end
	end
	table.ForceInsert(SAVEDIDS, {pl = ply, id = sid})
	
	-- messaging
	if sid == nil then
		sid = "unknown id"
	else
		sid = "id: " .. sid
	end
	local sname = "Added new id: " .. ply:Nick() .. " with " .. sid
	print(sname)
	lastidcheck = CurTime() + 0.7
end
*/

print("Gamemode loaded core/client/cl_id.lua")