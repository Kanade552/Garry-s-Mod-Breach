AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_bluemedkit")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Kanade"
SWEP.Purpose		= "Heal yourself or other people"
SWEP.Instructions	= [[Primary - heal yourself
Secondary - heal others]]

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/mishka/models/blue_firstaidkit.mdl"
SWEP.WorldModel		= "models/mishka/models/firstaidkit.mdl"
--SWEP.ViewModel		= "models/vinrax/props/firstaidkit.mdl"
--SWEP.WorldModel		= "models/vinrax/props/firstaidkit.mdl"
SWEP.PrintName		= "Blue First Aid Kit"
SWEP.Slot			= 1
SWEP.SlotPos		= 1
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= true
SWEP.HoldType		= "pistol"
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false

SWEP.Uses					= 3
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
SWEP.WorldModelPositionOffset = Vector(7, -1.5, -2.9)
SWEP.WorldModelAngleOffset = Angle(-20, 180, 190)

SWEP.ModelScale = 0.75

function SWEP:Deploy()
	self:SetHoldType("pistol")
	self:SetModelScale(self.ModelScale, 0)
end

function SWEP:CalcViewModelView(vm, oldpos, oldang, pos, ang)
	if !IsValid(self.Owner) then return end
	local angs = self.Owner:EyeAngles()
	ang.pitch = -ang.pitch
	pos = pos + angs:Forward() * 25 + angs:Up() * -9
	vm:ManipulateBoneScale(0, Vector(self.ModelScale, self.ModelScale, self.ModelScale))
	return pos, ang + Angle(0, 180, 0)
end

function SWEP:DrawWorldModel()
	if CLIENT and LocalPlayer():IsSpectator() then
		return false
	end
	if !IsValid(self.Owner) then
		self:SetSkin(1)
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
		self.WM:SetSkin(1)
		self.WM:SetModelScale(self.ModelScale, 0)
		self.WM:DrawModel()
	end
end

function SWEP:Initialize()
	self:SetHoldType("pistol")
end

function SWEP:Think()
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
	if self.Owner:Health() / self.Owner:GetMaxHealth() <= 0.8 or self.Owner:IsOnFire() then
		self.Uses = self.Uses - 1
		if SERVER then
			self.Owner:SetHealth(self.Owner:GetMaxHealth())
			self.Owner:Extinguish()
			self.Owner:EmitSound("items/smallmedkit1.wav")
			if self.Uses < 1 then
				self.Owner:StripWeapon("item_bluemedkit")
			end
		end
	elseif CLIENT and IsFirstTimePredicted() then
		chat.AddText("You don't need healing yet")
	end
end

function SWEP:SecondaryAttack()
	if SERVER then
		local ent = self.Owner:GetEyeTrace().Entity
		if !ent:IsPlayer() or ent:GTeam() == TEAM_SCP or ent:IsSpectator() or ent:GetPos():Distance(self.Owner:GetPos()) > 95 then return end
		
		if (ent:Health() / ent:GetMaxHealth() <= 0.8) or self.Owner:IsOnFire() then
			ent:SetHealth(ent:GetMaxHealth())
			ent:Extinguish()
			ent:EmitSound("items/medshot4.wav")
			self.Uses = self.Uses - 1
			if self.Uses < 1 then
				self.Owner:StripWeapon("item_bluemedkit")
			end
		else
			self.Owner:PrintMessage(HUD_PRINTTALK, ent:Nick() .. " doesn't need healing yet")
		end
	end
end

function SWEP:CanPrimaryAttack()
end
