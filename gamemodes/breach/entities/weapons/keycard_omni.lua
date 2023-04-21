SWEP.Base = "keycard_base"

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_keycardomni")
	SWEP.BounceWeaponIcon = false
end

SWEP.Instructions	= "If you hold it, you can open doors with every level"
SWEP.PrintName		= "Keycard Omni"
SWEP.clevel			= 5
SWEP.keycard_skin	= 5

function SWEP:GetBetterOne()
	return "keycard_omni"
end
