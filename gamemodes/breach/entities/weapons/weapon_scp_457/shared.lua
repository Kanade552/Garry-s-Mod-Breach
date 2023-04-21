
SWEP.Author			= "Kanade"
SWEP.Purpose		= "Burn"
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/vinrax/props/keycard.mdl"
SWEP.WorldModel		= "models/vinrax/props/keycard.mdl"
SWEP.PrintName		= "SCP-457"
SWEP.Slot			= 0
SWEP.SlotPos		= 0
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.HoldType		= "normal"
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false

SWEP.ISSCP = true
SWEP.droppable				= false
SWEP.teams					= {TEAM_SCP}
SWEP.Primary.Ammo			= "none"
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false

SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.NextCheck				= 0
SWEP.SpecialDelay			= 4

function SWEP:CleanUp()
	if IsValid(self.fire457) then
		self.fire457:Remove()
	end
	if IsValid(self.Owner) and self.Owner:IsPlayer() and (self.Owner:GetNClass() != ROLES.ROLE_SCP457 or !self.Owner:Alive() or self.Owner:IsSpectator()) then
		self.Owner:UnIgnitePlayer()
	end
end

function SWEP:Holster()
	if SERVER then
		self:CleanUp()
	end
	return true
end

function SWEP:Deploy()
	self.Owner:DrawViewModel(false)
end

function SWEP:Initialize()
	self:SetHoldType("normal")
	self:SetNWInt("NextSpecial", 0)
end

function SWEP:Reload()
end
