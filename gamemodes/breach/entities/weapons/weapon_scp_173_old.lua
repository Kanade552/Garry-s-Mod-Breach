AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_173")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Kanade"
SWEP.Purpose		= "Kill people"
SWEP.Instructions	= "LMB to kill someone"

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/vinrax/props/keycard.mdl"
SWEP.WorldModel		= "models/vinrax/props/keycard.mdl"
SWEP.PrintName		= "SCP-173"
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
SWEP.CColor					= Color(0,255,0)
SWEP.SnapSound				= Sound("snap.wav")
SWEP.teams					= {TEAM_SCP}
SWEP.Primary.Ammo			= "none"
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false

SWEP.SpecialDelay			= 30
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Automatic	= false
SWEP.NextAttackW			= 0
 
function SWEP:Deploy()
	self.Owner:DrawViewModel(false)
	self.Owner:SetJumpPower(175)
	self.Owner:SetWalkSpeed(500)
	self.Owner:SetRunSpeed(500)
	self.Owner:SetMaxSpeed(500)
end
function SWEP:DrawWorldModel()
end
function SWEP:Initialize()
	self:SetHoldType("normal")
end

function SWEP:IsLookingAt(ply)
	local yes = ply:GetAimVector():Dot((self.Owner:GetPos() - ply:GetPos() + Vector(70)):GetNormalized())
	return (yes > 0.39)
end
 
function SWEP:IsPlayerVisible(ply)
	local ent173_ang = self:GetAngles()
	local pl_pos = ply:GetPos()
	local pl_posc = ply:WorldSpaceCenter()
	local fromPos = self:GetPos()

	local tr_up = util.TraceLine({
		start = Vector(fromPos.x,fromPos.y,fromPos.z + 45),
		endpos = Vector(pl_posc.x,pl_posc.y,pl_posc.z + 30),
		filter = {self, self.Owner}
	})
	local tr_down = util.TraceLine({
		start = Vector(fromPos.x,fromPos.y,fromPos.z - 45),
		endpos = Vector(pl_pos.x,pl_pos.y,pl_pos.z + 10),
		filter = {self, self.Owner}
	})
	local tr_center1 = util.TraceLine({
		start = fromPos + ent173_ang:Right() * 25,
		endpos = pl_posc,
		filter = {self, self.Owner}
	})
	local tr_center2 = util.TraceLine({
		start = fromPos - ent173_ang:Right() * 25,
		endpos = pl_posc,
		filter = {self, self.Owner}
	})
	--print(ply:Nick())
	--print("tr_up: " .. tostring(tr_up.Entity))
	--print("tr_down: " .. tostring(tr_down.Entity))
	--print("tr_center1: " .. tostring(tr_center1.Entity))
	--print("tr_center2: " .. tostring(tr_center2.Entity))
	if tr_up.Entity == ply then return true end
	if tr_down.Entity == ply then return true end
	if tr_center1.Entity == ply then return true end
	if tr_center2.Entity == ply then return true end
	return false
end

SWEP.DrawRed = 0
function SWEP:Think()
	if CLIENT then
		self.DrawRed = CurTime() + 0.1
	end
	if postround then return end
	local watching = 0
	for k,v in pairs(player.GetAll()) do
		for k,v in pairs(player.GetAll()) do
			if self:IsPlayerVisible(v) then
				v.seen173 = CurTime() + 10
			end
		end

		if IsValid(v) and v:GTeam() != TEAM_SPECTATOR and v:Alive() and v != self.Owner and v.canblink then
			local tr_eyes = util.TraceLine({
				start = v:EyePos() + v:EyeAngles():Forward() * 15,
				--start = v:LocalToWorld(v:OBBCenter()),
				--start = v:GetPos() + (self.Owner:EyeAngles():Forward() * 5000),
				endpos = self.Owner:EyePos(),
				--filter = v
			})
			local tr_center = util.TraceLine({
				start = v:LocalToWorld(v:OBBCenter()),
				endpos = self.Owner:LocalToWorld(self.Owner:OBBCenter()),
				filter = v
			})
			if tr_eyes.Entity == self.Owner or tr_center.Entity == self.Owner then
				--self.Owner:PrintMessage(HUD_PRINTTALK, tostring(tr_eyes.Entity) .. " : " .. tostring(tr_center.Entity) .. " : " .. tostring(tr_center.Entity))
				if self:IsLookingAt(v) and !(v.blink_start < CurTime() and v.blink_end > CurTime()) and v.blinded_by_173_til < CurTime() then
					watching = watching + 1
					--if self:GetPos():Distance(v:GetPos()) > 100 then
						--self.Owner:PrintMessage(HUD_PRINTTALK, v:Nick() .. " is looking at you")
					--end 
				end
			end
		end
	end
	if watching > 0 then
		self.Owner:Freeze(true)
	else
		self.Owner:Freeze(false)
	end
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
	if preparing or postround or not IsFirstTimePredicted() or self.NextAttackW > CurTime() then return end

	self.NextAttackW = CurTime() + self.AttackDelay

	if SERVER then
		local ent = nil
		local tr = util.TraceHull({
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 100),
			filter = self.Owner,
			mins = Vector(-10, -10, -10),
			maxs = Vector(10, 10, 10),
			mask = MASK_SHOT_HULL
		})
		ent = tr.Entity
		if IsValid(ent) then
			if ent:IsPlayer() then
				if ent:GTeam() == TEAM_SCP or ent:IsSpectator() then return end

				ent:Kill()
				self.Owner:AddExp(15, true)
				roundstats.snapped = roundstats.snapped + 1
				ent:EmitSound(self.SnapSound, 500, 100)
			else
				if ent:GetClass() == "func_breakable" then
					ent:TakeDamage(100, self.Owner, self.Owner)
				end
			end
		end
	end
end

function SWEP:Holster()
	self.Owner:SetWalkSpeed(1)
	self.Owner:SetRunSpeed(1)
	self.Owner:SetJumpPower(1)
	return true
end

SWEP.NextSpecial = 0
function SWEP:SecondaryAttack()
	local time = 5
	if self.NextSpecial > CurTime() then return end

	self.NextSpecial = CurTime() + self.SpecialDelay

	if CLIENT then
		surface.PlaySound("Horror2.ogg")
	end
	local findents = ents.FindInSphere(self.Owner:GetPos(), 600)
	local foundplayers = {}
	for k,v in pairs(findents) do
		if v:IsPlayer() and v:GTeam() != TEAM_SCP and v:GTeam() != TEAM_SPECTATOR and v:Alive() and v.usedeyedrops == false then
			table.ForceInsert(foundplayers, v)
		end
	end
	if #foundplayers > 0 then
		local fixednicks = "Blinded: "
		if CLIENT then return end
		local numi = 0
		for k,v in pairs(foundplayers) do
			numi = numi + 1
			
			if numi == 1 then
				fixednicks = fixednicks .. v:Nick()
			elseif numi == #foundplayers then
				fixednicks = fixednicks .. " and " .. v:Nick()
			else
				fixednicks = fixednicks .. ", " .. v:Nick()
			end
			v:SendLua('surface.PlaySound("Horror2.ogg")')
			net.Start("PlayerBlink")
				net.WriteFloat(time)
			net.Send(v)
			v.blinded_by_173_til = CurTime() + time
		end
		self.Owner:PrintMessage(HUD_PRINTTALK, fixednicks)
	end
end

function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:DrawHUD()
	if disablehud then return end
	local specialstatus = ""
	local showtext = ""
	local showtextlook = "Noone is looking"
	local lookcolor = Color(0,255,0)
	local showcolor = Color(17, 145, 66)
	if self.NextSpecial > CurTime() then
		specialstatus = "ready to use in " .. math.Round(self.NextSpecial - CurTime())
		showcolor = Color(145, 17, 62)
	else
		specialstatus = "ready to use"
	end
	showtext = "Special " .. specialstatus
	if self.DrawRed < CurTime() then
		self.CColor = Color(255,0,0)
		showtextlook = "Someone is looking"
		lookcolor = Color(145, 17, 62)
	else
		self.CColor = Color(0,255,0)
	end
	
	draw.Text({
		text = showtext,
		pos = {ScrW() / 2, ScrH() - 75},
		font = "173font",
		color = showcolor,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	
	draw.Text({
		text = showtextlook,
		pos = {ScrW() / 2, ScrH() - 50},
		font = "173font",
		color = lookcolor,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	
	local x = ScrW() / 2.0
	local y = ScrH() / 2.0

	local scale = 0.3
	surface.SetDrawColor(self.CColor.r, self.CColor.g, self.CColor.b, 255)
	
	local gap = 5
	local length = gap + 20 * scale
	surface.DrawLine(x - length, y, x - gap, y)
	surface.DrawLine(x + length, y, x + gap, y)
	surface.DrawLine(x, y - length, x, y - gap)
	surface.DrawLine(x, y + length, x, y + gap)
end
