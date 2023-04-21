AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_106")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Kanade"
SWEP.Purpose		= "Destroy"
SWEP.Instructions	= "LMB to hit something"

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/vinrax/props/keycard.mdl"
SWEP.WorldModel		= "models/vinrax/props/keycard.mdl"
SWEP.PrintName		= "SCP-106"
SWEP.Slot			= 0
SWEP.SlotPos		= 0
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.HoldType		= "normal"
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false

SWEP.AttackDelay			= 0.25
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
SWEP.NextAttackW			= 0

function SWEP:Deploy()
	self.Owner:DrawViewModel(false)
end

function SWEP:DrawWorldModel()
end

function SWEP:Initialize()
	self:SetHoldType("normal")
end

function SWEP:Think()
end

function SWEP:Reload()
end

SWEP.NextLaugh = 0

function SWEP:PrimaryAttack()
	if preparing or postround or not IsFirstTimePredicted() or self.NextAttackW > CurTime() then return end

	self.NextAttackW = CurTime() + self.AttackDelay

	if SERVER then
		local ent = GetSCPAttackTraceEnt(self.Owner, 90)
		if !IsValid(ent) then return end

		if ent:IsPlayer() then
			if ent:IsSpectator() or !ent:Alive() or ent:GTeam() == TEAM_SCP then return end
			if InPD(ent) then
				ent:TakeDamage(100, self.Owner, self.Owner)
			end

			local pos = GetPocketPos()
			if pos then
				roundstats.teleported = roundstats.teleported + 1
				self.Owner:SetHealth(self.Owner:Health() + 100)

				ent:SetPos(pos)
				ent.last106 = self.Owner

				if self.NextLaugh < CurTime() then
					self.Owner:EmitSound("Laugh.ogg")
					self.NextLaugh = CurTime() + 5
				end

				net.Start("CapturedBy106")
				net.Send(ent)

				self.Owner:AddExp(100, true)
			end
		else
			ent:TakeDamage(100, self.Owner, self.Owner)
		end
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:DrawHUD()
	if disablehud then return end
	
	if self.NextAttackW > CurTime() then
		surface.SetDrawColor(255, 0, 0, 200)
	else
		surface.SetDrawColor(0, 255, 0, 200)
	end
	
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
	end,
	make_fog = function()
		render.FogStart(0)
		render.FogEnd(700)
		render.FogColor(0, 1, 0)
		render.FogMaxDensity(1)
		render.FogMode(MATERIAL_FOG_LINEAR)
		return true
	end
}
SWEP.NVGenabled	= true