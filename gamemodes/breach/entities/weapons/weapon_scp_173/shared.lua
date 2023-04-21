
SWEP.Author			= "Kanade"

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

SWEP.Primary.Ammo			= "none"
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false

SWEP.SpecialDelay			= 30
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Automatic	= false

SWEP.AttackDelay			= 0.25
SWEP.ISSCP					= true
SWEP.droppable				= false
SWEP.CColor					= Color(255,255,255,120)
SWEP.SnapSound				= Sound("snap.wav")
SWEP.teams					= {TEAM_SCP}

SWEP.NextPos				= nil
SWEP.NextAng				= nil
SWEP.MaxTargets				= 3

function SWEP:Deploy()
	local ourSpeed = 1
	self.Owner:DrawViewModel(false)
	self.Owner:SetJumpPower(1)
	self.Owner:SetWalkSpeed(ourSpeed)
	self.Owner:SetRunSpeed(ourSpeed)
	self.Owner:SetMaxSpeed(ourSpeed)
	self.Owner:SetNoDraw(true)
	self.NextPos = nil
	self.NextAng = nil
	self.Targets = {}
	self.MoveDelay = 0
end
function SWEP:DrawWorldModel()
end
function SWEP:PrimaryAttack()
end
function SWEP:SecondaryAttack()
end
function SWEP:Holster()
	return true
end
function SWEP:Reload()
end

SWEP.MoveDelay = 0
function SWEP:Move(ply, mv)
	local buttons = mv:GetButtons()
	if mv:KeyDown(IN_FORWARD) then
		if SERVER then
			self:SetNextPos()
			self:MoveToNextPos(mv)
		end
	end
	if mv:KeyDown(IN_ATTACK) then
		if SERVER then
			self:DestroyGlass()
		end
	end
	return true
end

SWEP.NextDG = 0
function SWEP:DestroyGlass()
	if self.NextDG > CurTime() then return end
	
	local ent173 = self.Owner:GetNWEntity("entity173")
	if !IsValid(ent173) then return end
	if ent173:CanMove(self:GetPos()) then
		local ourpos = ent173:GetPos()
		local eyeangles = self.Owner:EyeAngles()
		local tr = self:ClearTrace({
			start = Vector(ourpos.x, ourpos.y, ourpos.z + 95),
			endpos = Vector(ourpos.x, ourpos.y, ourpos.z + 95) + eyeangles:Forward() * 100,
			mask = MASK_ALL
		})
		if IsValid(tr.Entity) then
			if tr.Entity:GetClass() == "func_breakable" then
				tr.Entity:TakeDamage(100, self.Owner, self.Owner)
			end
		end
		self.NextDG = CurTime() + 1.5
	else
		self.NextDG = CurTime() + 0.5
	end
end

function SWEP:SetNextPos()
	--if SERVER then
		local ent173 = self.Owner:GetNWEntity("entity173")
		if !IsValid(ent173) then return end
		local nextpostab = self:TraceNextPos(ent173)
		for k,v in pairs(nextpostab.hits) do
			if v.Hit then return end
		end
		self.NextPos = nextpostab.start.HitPos
		self.NextAng = Angle(0,self.Owner:EyeAngles().y,0)
		--self:SetNWVector("NextPos", self.NextPos)
	--end
end

function SWEP:ClearTrace(tr_structure)
	local new_tr = nil
	local ent173 = self.Owner:GetNWEntity("entity173")
	local filerEnts = {self.Owner}
	if IsValid(ent173) then
		table.ForceInsert(filerEnts, ent173)
	end
	for i=1, 10 do
		new_tr = util.TraceLine({
			start = tr_structure.start,
			endpos = tr_structure.endpos,
			mask = tr_structure.mask,
			filter = filerEnts
		})
		local ent = new_tr.Entity
		if IsValid(ent) == false or new_tr.Hit == false or new_tr.HitNonWorld == false or new_tr.HitSky then
			return new_tr
		end
		if ent:IsPlayer() then
			if ent:Alive() == false or ent:IsSpectator() or ent:GTeam() == TEAM_SCP then
				table.ForceInsert(filerEnts, ent)
			end
		else
			return new_tr
		end
	end
	
	return new_tr
end

SWEP.Targets = {}
SWEP.NextTarget = 0
function SWEP:TargetPlayer()
	if self.NextTarget > CurTime() then return end
	self.NextTarget = CurTime() + 0.5
	if table.Count(self.Targets) == self.MaxTargets then return end
	local ent173 = self.Owner:GetNWEntity("entity173")
	if IsValid(ent173) then
		local ourpos = ent173:GetPos()
		local eyeangles = self.Owner:EyeAngles()
		local filerEnts = {self.Owner, ent173}
		for i=1, 10 do
			local tr_target = util.TraceLine({
				start = Vector(ourpos.x, ourpos.y, ourpos.z + 95),
				endpos = Vector(ourpos.x, ourpos.y, ourpos.z + 95) + eyeangles:Forward() * 400,
				filter = filerEnts,
				mask = MASK_ALL
			})
			local ent = tr_target.Entity
			if IsValid(ent) == false or tr_target.Hit == false or tr_target.HitNonWorld == false or tr_target.HitSky then
				break
			end
			if ent:IsPlayer() and ent:Alive() and ent:GTeam() != TEAM_SPECTATOR and ent:GTeam() != TEAM_SCP then
				print(ent)
				table.ForceInsert(self.Targets, ent)
				break
			else
				table.ForceInsert(filerEnts, ent)
			end
		end
	end
end

function SWEP:ClearTargets()
	self.Targets = {}
end

SWEP.entIsAttacking = false

function SWEP:Think()
	self:Check173()
	/*
	for k,v in pairs(self.Targets) do
		if IsValid(v) == false then
			table.RemoveByValue(self.Targets, v)
		else
			if v:GetPos():Distance(self.Owner:GetPos()) > 800 or v:Alive() == false or v:IsSpectator() or v:GTeam() == TEAM_SCP then
				if CLIENT then
					chat.AddText(Color(255,0,0), "Target " .. v:Nick() .. " lost...")
				end
				table.RemoveByValue(self.Targets, v)
			end
		end
	end
	*/
	if CLIENT then
		if IsValid(self.Owner:GetNWEntity("entity173")) then
			self.entIsAttacking = self.Owner:GetNWEntity("entity173"):GetNWBool("IsAttacking")
		end
	else
		self.Owner:SetNoDraw(true)
		if IsValid(self.Owner.entity173) then
			self.Owner.entity173:SetPos(self.Owner:GetPos())
		end
	end
	self:NextThink(CurTime() + 0.5)
end

function SWEP:Check173()
	if SERVER then
		if IsValid(self.Owner.entity173) == false then
			local try_ent = ents.Create("breach_173ent")
			if !IsValid(try_ent) then return end
			self.Owner:SetPos(SPAWN_173)
			self.Owner:SetEyeAngles(Angle(0, 90, 0))
			self.Owner.entity173 = try_ent
			self.Owner.entity173:SetCurrentOwner(self.Owner)
			self.Owner.entity173:SetModel("models/breach173.mdl")
			self.Owner.entity173:SetPos(self.Owner:GetPos())
			self.Owner.entity173:SetAngles(Angle(0, 90, 0))
			self.Owner.entity173:Spawn()
			self.Owner:SetNWEntity("entity173", self.Owner.entity173)
			print("173 created")
		end
	end
end

function SWEP:FrontTraceLine()
	local ent173 = self.Owner:GetNWEntity("entity173")
	if IsValid(ent173) then
		local ourpos = ent173:GetPos()
		local eyeangles = self.Owner:EyeAngles()
		local tr_front = util.TraceLine({
			start = Vector(ourpos.x, ourpos.y, ourpos.z + 95),
			endpos = Vector(ourpos.x, ourpos.y, ourpos.z + 95) + eyeangles:Forward() * 70,
			filter = {self.Owner, ent173},
			mask = MASK_ALL
		})
		return tr_front
	end
	return nil
end

function SWEP:TraceNextPos(ent173)
	local ourpos = ent173:GetPos()
	local eyeangles = self.Owner:EyeAngles()
	local smask = MASK_ALL
	local filters = {self.Owner, ent173}
	local tr_start = util.TraceLine({
		start = Vector(ourpos.x, ourpos.y, ourpos.z + 95),
		endpos = Vector(ourpos.x, ourpos.y, ourpos.z + 95) + eyeangles:Forward() * 420,
		filter = filters,
		mask = smask
	})
	local tr = util.TraceLine({
		start = tr_start.HitPos,
		endpos = tr_start.HitPos - Angle(-90,0,0):Forward() * 2000,
		filter = filters
	})
	local hittab = {}
	local size1 = 20
	local size2 = 100
	local emask = MASK_ALL
	local angle_up = Angle(-90,0,0):Forward() * size2 + Angle(0, eyeangles.y, 0):Forward() * 10
	local angle_up2 = Angle(-90,0,0):Forward() * 50 + Angle(0, eyeangles.y, 0):Forward() * 20
	hittab.tr1 = util.TraceLine({start = tr.HitPos, 	endpos = tr.HitPos + Angle(-10, eyeangles.y - 90, 0):Forward() * size1, 	mask = emask})
	hittab.tr2 = util.TraceLine({start = tr.HitPos, 	endpos = tr.HitPos + Angle(-10, eyeangles.y + 90, 0):Forward() * size1, 	mask = emask})
	hittab.tr1_up1 = util.TraceLine({start = hittab.tr1.HitPos, 	endpos = hittab.tr1.HitPos + angle_up, 		mask = emask})
	hittab.tr2_up1 = util.TraceLine({start = hittab.tr2.HitPos, 	endpos = hittab.tr2.HitPos + angle_up, 		mask = emask})
	hittab.tr1_up2 = util.TraceLine({start = hittab.tr1.HitPos, 	endpos = hittab.tr1.HitPos + angle_up2, 	mask = emask})
	hittab.tr2_up2 = util.TraceLine({start = hittab.tr2.HitPos, 	endpos = hittab.tr2.HitPos + angle_up2, 	mask = emask})
	return {start = tr, hits = hittab}
end

SWEP.NVG = {
	effects = function(i)
		i.contrast = 1.7
		i.brightness = i.brightness - 0.15
		i.clr_r = 0.1
		i.clr_g = 1
		i.clr_b = 0.1
		i.add_r = 0
		i.add_g = 0.1
		i.add_b = 0
		i.vignette_alpha = 200
	end,
	make_fog = function()
		render.FogStart(0)
		render.FogEnd(600)
		render.FogColor(0, 1, 0)
		render.FogMaxDensity(1)
		render.FogMode(MATERIAL_FOG_LINEAR)
		return true
	end
}
SWEP.NVGenabled	= true
