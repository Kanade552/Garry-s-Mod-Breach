AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_457")
	SWEP.BounceWeaponIcon = false
end

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

local function cleanup()
	if IsValid(self.fire457) then
		self.fire457:Remove()
	end
	if self.Owner:IsPlayer() and self.Owner:GetNClass() != ROLES.ROLE_SCP457 then
		self.Owner:UnIgnitePlayer()
	end
end

function SWEP:OnRemove()
	if SERVER then
		cleanup()
	end
end

function SWEP:Holster()
	if SERVER then
		cleanup()
	end
	return true
end

function SWEP:Deploy()
	self.Owner:DrawViewModel(false)
end

function SWEP:DrawWorldModel()
end

function SWEP:Initialize()
	self:SetHoldType("normal")
	self:SetNWInt("NextSpecial", 0)
end

function SWEP:Think()
	if self.NextCheck < CurTime() then
		self.Owner:IgnitePlayer()
		self.NextCheck = CurTime() + 10
	end

	for k,v in pairs(ents.FindInSphere(self.Owner:GetPos(), 130)) do
		if v:IsPlayer() and !v:IsSpectator() and v:GTeam() != TEAM_SCP and v:Team() != TEAM_SCP and v:Alive() then
			v:Ignite(6,270)
			if self.Owner.nextexp < CurTime() then
				self.Owner:AddExp(1)
				self.Owner.nextexp = CurTime() + 1
			end
		end
	end
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
	if CLIENT or preparing or postround or not IsFirstTimePredicted() then return end
	
	local ent = self.Owner:GetEyeTrace().Entity
	if ent:GetClass() == "func_breakable" and ent:GetPos():Distance(self.Owner:GetPos()) < 125 then
		ent:TakeDamage(1000, self.Owner, self.Owner)
	end
end

function SWEP:CreateFire()
	if preparing then return false end

	local tr = util.TraceLine({
		start = self.Owner:GetPos(),
		endpos = self.Owner:GetPos() + Angle(90,0,0):Forward() * 100
	})
	if tr.HitSky or tr.Hit == false or tr.HitWorld == false or self.Owner:GetPos():Distance(tr.HitPos) > 300 then return false end
	
	if SERVER then
		if IsValid(self.fire457) then
			self.fire457:Remove()
		end
		
		sound.Play("ambient/fire/ignite.wav", tr.HitPos, 72, 100)

		self.fire457 = ents.Create("env_fire")
		if !self.fire457 or !self.fire457:IsValid() then return false end

		self.fire457:SetPos(tr.HitPos)
		self.fire457:SetKeyValue("health", "512")
		self.fire457:SetKeyValue("firesize", "128")
		self.fire457:SetKeyValue("fireattack", "1")
		self.fire457:SetKeyValue("damagescale", "16")
		self.fire457:SetKeyValue("ignitionpoint", "0")
		self.fire457:Spawn()
		self.fire457:Activate()
		self.fire457:Fire("StartFire","",0)
		self.fire457.owner = self.Owner
		self.fire457.scpFire = true
		
		self:SetNWInt("NextSpecial", CurTime() + self.SpecialDelay)
	end
	return true
end

SWEP.NextSpecial = 0
function SWEP:SecondaryAttack()
	if SERVER and self:GetNWInt("NextSpecial") <= CurTime() and self:CreateFire() then
		self:CreateFire()
	end
end

function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:DrawHUD()
	if disablehud then return end

	local sp_text = ""
	local sp_text_color = Color(17, 145, 66)
	local next_sp_attack = self:GetNWInt("NextSpecial", 0)

	if next_sp_attack > CurTime() then
		sp_text = "ready to use in " .. math.Round(next_sp_attack - CurTime())
		sp_text_color = Color(145, 17, 62)
	else
		sp_text = "ready to use"
	end
	
	draw.Text({
		text = "Special "..sp_text,
		pos = {ScrW() / 2, ScrH() - 50},
		font = "173font",
		color = sp_text_color,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})

	surface.SetDrawColor(255, 255, 255, 255)
	
	local x = ScrW() / 2.0
	local y = ScrH() / 2.0
	local gap = 3
	local length = gap + 4
	surface.DrawLine(x - length, y, x - gap, y)
	surface.DrawLine(x + length, y, x + gap, y)
	surface.DrawLine(x, y - length, x, y - gap)
	surface.DrawLine(x, y + length, x, y + gap)
end

SWEP.NVG = {
	effects = function(i)
		i.contrast = 2
		i.brightness = i.brightness - 0.15
		i.clr_r = 1
		i.clr_g = 0.5
		i.clr_b = 0.5

		i.add_r = 0.1
		i.add_g = 0
		i.add_b = 0
		i.vignette_alpha = 100
	end,
	make_fog = function()
		render.FogStart(0)
		render.FogEnd(600)
		render.FogColor(1, 0, 0)
		render.FogMaxDensity(1)
		render.FogMode(MATERIAL_FOG_LINEAR)
		return true
	end
}
SWEP.NVGenabled	= true
