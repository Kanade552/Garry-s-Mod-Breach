AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_966")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Kanade"
SWEP.Purpose		= "Kill humans"
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/vinrax/props/keycard.mdl"
SWEP.WorldModel		= "models/vinrax/props/keycard.mdl"
SWEP.PrintName		= "SCP-966"
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

function SWEP:Deploy()
	self.Owner:DrawViewModel(false)
end

function SWEP:DrawWorldModel()
end

function SWEP:Initialize()
	self:SetHoldType("normal")
end

function SWEP:Reload()
end

SWEP.Sounds966 = {
	{"966/Echo1.ogg", 6.175},
	{"966/Echo2.ogg", 8.139},
	{"966/Echo2.ogg", 7.437},
	{"966/Idle1.ogg", 2.483},
	{"966/Idle2.ogg", 6.177},
	{"966/Idle3.ogg", 7.036},
}

SWEP.NextSwing = math.huge
SWEP.Attacking = false
SWEP.Next966Sound = 0
SWEP.Next966SpecialStop = 0
SWEP.Next966SpecialUse = 0
function SWEP:Think()
	-- slow down nearby players
	if self.Next966SpecialStop > CurTime() then
		local ourpos = self.Owner:GetPos()
		for k,v in pairs(player.GetAll()) do
			if v != self.Owner and v:Alive() and !v:IsSpectator() and v:GTeam() != TEAM_SCP then
				local dist = v:GetPos():Distance(ourpos)
				if dist < 300 then
					v.slowdown966a = math.Round((dist / 300) ^ 0.25, 2)
					--self.Owner:PrintMessage(HUD_PRINTCENTER, v.slowdown966a)
					--v:PrintMessage(HUD_PRINTCENTER, v.slowdown966a)
					v.slowdown966 = CurTime() + 5
				end
			end
		end
	end

	-- sounds that 966 makes
	if self.Next966Sound < CurTime() then
		local rsound = TableRandom(self.Sounds966)
		self.Owner:EmitSound(rsound[1], 65, 100, 0.6)
		self.Next966Sound = CurTime() + rsound[2] + math.Rand(2,3)
	end

	-- attacking
	if SERVER and self.NextSwing < CurTime() and self.Attacking then
		local ent = GetSCPAttackTraceEnt(self.Owner, 85)
		if IsValid(ent) then
			ent:TakeDamage(27, self.Owner, self.Owner)
			--if ent:IsPlayer() then
				self.Owner:EmitSound("damage_966.ogg")
			--end
		end

		self.NextSwing = math.huge
		self.Attacking = false
	end
end

SWEP.AttackDelay = 1.15
SWEP.NextAttackW = 0
function SWEP:PrimaryAttack()
	if not IsFirstTimePredicted() or self.NextAttackW > CurTime() then return end

	self.NextAttackW = CurTime() + self.AttackDelay

	-- attack animation, it can be a lil weird sometimes
	self.Owner:DoAnimationEvent(ACT_GMOD_GESTURE_RANGE_ZOMBIE)

	if SERVER then
		self.NextSwing = CurTime() + 0.5
		self.Attacking = true

		self.Owner:EmitSound("npc/vort/claw_swing1.wav")
	end
end

function SWEP:SecondaryAttack()
	if preparing or postround or not IsFirstTimePredicted() or self.Next966SpecialStop > CurTime() or self.Next966SpecialUse > CurTime() then return end

	self.Next966SpecialStop = CurTime() + 15
	self.Next966SpecialUse = CurTime() + 30
end

function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:DrawHUD()
	if disablehud then return end
	
	-- special
	local sp_text = ""
	local sp_text_color = Color(255, 255, 255, 50)

	if self.Next966SpecialStop > CurTime() then
		sp_text = "activated, ends in " .. math.Round(self.Next966SpecialStop - CurTime())
		sp_text_color = Color(17, 191, 84)
		
	elseif self.Next966SpecialUse > CurTime() then
		sp_text = "ended, next use in " .. math.Round(self.Next966SpecialUse - CurTime())
		sp_text_color = Color(145, 17, 62)
	else
		sp_text = "ready to activate"
	end

	draw.Text({
		text = "Special "..sp_text,
		pos = {ScrW() / 2, ScrH() - 50},
		font = "173font",
		color = sp_text_color,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})

	-- crosshair
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
		i.contrast = 2
		i.brightness = i.brightness
		i.clr_r = 0.5
		i.clr_g = 0.5
		i.clr_b = 2

		i.add_r = 0
		i.add_g = 0
		i.add_b = 0.1
		i.vignette_alpha = 200
	end,
	make_fog = function()
		render.FogStart(0)
		render.FogEnd(500)
		render.FogColor(0, 0, 1)
		render.FogMaxDensity(1)
		render.FogMode(MATERIAL_FOG_LINEAR)
		return true
	end
}
SWEP.NVGenabled	= true
