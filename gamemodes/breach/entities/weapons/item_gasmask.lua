AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_gasmask")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Kanade"
SWEP.Purpose		= "Find a way to go"

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/mishka/models/gasmask.mdl"
SWEP.WorldModel		= "models/mishka/models/gasmask.mdl"
SWEP.PrintName		= "Gasmask"
SWEP.Slot			= 1
SWEP.SlotPos		= 1
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.HoldType		= "pistol"
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false

SWEP.droppable				= true
SWEP.teams					= {TEAM_GUARD, TEAM_CLASSD, TEAM_SCI, TEAM_CHAOS, TEAM_STAFF}

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Ammo			=  "none"
SWEP.Primary.Automatic		= false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Ammo			=  "none"
SWEP.Secondary.Automatic	=  false

SWEP.BoneAttachment = "ValveBiped.Bip01_R_Hand"
SWEP.WorldModelPositionOffset = Vector(3, -4, 0)
SWEP.WorldModelAngleOffset = Angle(60, 180, 180)

function SWEP:Deploy()
	self.Owner:DrawViewModel(false)
end

function SWEP:DrawWorldModel()
	if CLIENT and LocalPlayer():IsSpectator() or self.GasMaskOn then
		return false
	end

	if !IsValid(self.Owner) then
		self:DrawModel()
	else
		if !IsValid(self.WM) then
			self.WM = ClientsideModel(self.WorldModel)
			self.WM:SetNoDraw(true)
		end

		local boneid = self.Owner:LookupBone(self.BoneAttachment)
		if not boneid then
			return
		end

		local matrix = self.Owner:GetBoneMatrix(boneid)
		if not matrix then
			return
		end

		local newpos, newang = LocalToWorld(self.WorldModelPositionOffset, self.WorldModelAngleOffset, matrix:GetTranslation(), matrix:GetAngles())

		self.WM:SetPos(newpos)
		self.WM:SetAngles(newang)
		self.WM:SetupBones()
		self.WM:DrawModel()
	end
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self:SetSkin(1)
end

function SWEP:Reload()
end

SWEP.GasMaskOn = false
SWEP.NextChange = 0
function SWEP:PrimaryAttack()
	if self.NextChange < CurTime() then
		self.GasMaskOn = !self.GasMaskOn
		self.NextChange = CurTime() + 0.5

		if self.GasMaskOn then
			self.HoldType = "normal"
		else
			self.HoldType = "pistol"
		end

		self:SetHoldType(self.HoldType)

		if CLIENT then
			surface.PlaySound('pickitem2.ogg')
		end
	end
end

function SWEP:OnDrop()
	self.GasMaskOn = false
	self.HoldType = "pistol"
	self:SetHoldType(self.HoldType)
end

function SWEP:OnRemove()
end

function SWEP:Holster()
	return true
end

function SWEP:SecondaryAttack()
end

function SWEP:CanPrimaryAttack()
end

function SWEP:DrawHUD()
	if self.GasMaskOn == false then
		draw.Text({
			text = "Click LMB to put on the gasmask",
			pos = {ScrW() / 2, ScrH() - 20},
			font = "RadioFont",
			color = color_white,
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
		})
	end
end
