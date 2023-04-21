AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_nvg")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Kanade"
SWEP.Purpose		= ""

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/mishka/models/nvg.mdl"
SWEP.WorldModel		= "models/mishka/models/nvg.mdl"
SWEP.PrintName		= "NVG"
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
SWEP.WorldModelPositionOffset = Vector(5, -2, 0)
SWEP.WorldModelAngleOffset = Angle(0, 180, 230)

function SWEP:Deploy()
	self.Owner:DrawViewModel(false)
end

function SWEP:DrawWorldModel()
	if CLIENT and LocalPlayer():IsSpectator() or self.NVGenabled then
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

function SWEP:Think()
end

function SWEP:Reload()
end

SWEP.NVGenabled	= false
SWEP.NVG = {
	effects = function(i)
		i.contrast = 1.75
		i.clr_g = 1
		i.add_g = 0.2
		i.vignette_alpha = 255
		i.brightness = -0.2

		if MapConfig_ClientIsOutside() then
			i.brightness = 1
		end

		--         Darken, Multiply, SizeX, SizeY, Passes, ColorMultiply, Red, Green, Blue
		DrawBloom(0,      0.1,        1,     1,     1,      1,            1,   1,     1)
		--DrawSharpen(1,1)
		--DrawToyTown(5, ScrH()/2)
		
		local dlight = DynamicLight(LocalPlayer():EntIndex())
		if (dlight) then
			dlight.pos = LocalPlayer():GetShootPos()
			dlight.r = 0
			dlight.g = 25
			dlight.b = 0
			dlight.brightness = 2
			dlight.Decay = 1000
			dlight.Size = 400
			dlight.DieTime = CurTime() + 0.1
		end
		
		
	end,
	make_fog = function()
		render.FogStart(1)
		render.FogEnd(1300)
		render.FogColor(0, 6, 0)
		render.FogMaxDensity(1)
		render.FogMode(MATERIAL_FOG_LINEAR)
		return true
	end
}

SWEP.NextChange = 0
function SWEP:PrimaryAttack()
	if self.NextChange < CurTime() then
		self.NVGenabled = !self.NVGenabled
		self.NextChange = CurTime() + 0.5

		if self.NVGenabled then
			self.HoldType = "normal"
		else
			self.HoldType = "pistol"
		end

		self:SetHoldType(self.HoldType)

		if CLIENT then
			surface.PlaySound('pickitem2.ogg')
			next_966_check = 0
		end
	end
end

function SWEP:OnDrop()
	self.NVGenabled = false
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
	if self.NVGenabled == false then
		draw.Text({
			text = "Click LMB to put on the NVG",
			--pos = {rx + 52, ry * 1.79},
			pos = {ScrW() / 2, ScrH() - 20},
			font = "RadioFont",
			color = color_white,
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
		})
	end
end
