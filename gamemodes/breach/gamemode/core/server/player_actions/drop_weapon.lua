
util.AddNetworkString("DropWeapon")

net.Receive("DropWeapon", function(len, ply)
	local wep = ply:GetActiveWeapon()
	if ply:IsSpectator() then return end
	if IsValid(wep) and wep != nil and IsValid(ply) then
		local atype = wep:GetPrimaryAmmoType()
		if atype > 0 then
			wep.SavedAmmo = wep:Clip1()
		end
		
		if wep.GetClass == nil or wep.droppable == false then return end
		
		ply:DropWeapon(wep)
		ply:ConCommand("lastinv")
	end
end)

print("Gamemode loaded core/server/player_actions/drop_weapon.lua")