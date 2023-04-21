
function Get_SCP173_Weapon()
	if ShouldUseOld173() then
		return "weapon_scp_173_old"
	else
		return "weapon_scp_173"
	end
end

function ShouldUseOld173()
	return cvars.Bool("br_use_old_173", false)
end

print("Gamemode loaded core/shared/scp173.lua")