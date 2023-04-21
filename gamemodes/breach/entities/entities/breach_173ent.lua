AddCSLuaFile()

ENT.PrintName		= "SCP-173"
ENT.Author		    = "Kanade"
ENT.Type			= "anim"
ENT.Spawnable		= true
ENT.AdminSpawnable	= true
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Owner = nil

function ENT:SetCurrentOwner(ply)
	self.Owner = ply
	self:SetNWEntity("173Owner", ply)
end

function ENT:GetCurrentOwner()
	return self.Owner
end

function ENT:OnTakeDamage(dmginfo)
	if IsValid(self.Owner) and self.Owner:IsPlayer() then
		self.Owner:TakeDamageInfo(dmginfo)
	else
		self:Remove()
	end
end

function ENT:Initialize()
	self.Entity:SetModel("models/breach173.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_FLY)
	self.Entity:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
end

function ENT:IsPlayerLooking(ply)
	local yes = ply:GetAimVector():Dot((self:GetPos() - ply:GetPos() + Vector(70)):GetNormalized())
	return (yes > 0.39)
end

function ENT:IsPlayerVisible(ply, fromPos)
	local ent173_ang = self:GetAngles()
	local pl_pos = ply:GetPos()
	local pl_posc = ply:WorldSpaceCenter()
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

function ENT:CanMove(pos)
	local cpos = nil
	if pos == self:GetPos() then
		cpos = self:WorldSpaceCenter()
	else
		cpos = pos
	end
	for k,v in pairs(ents.FindInSphere(pos, 1100)) do
		if v:IsPlayer()
		and v:Alive()
		and v:GTeam() != TEAM_SPECTATOR
		and v:GTeam() != TEAM_SCP
		and self:IsPlayerVisible(v, cpos)
		--and v:VisibleVec(pos)
		and !(v.blink_start < CurTime() and v.blink_end > CurTime())
		and self:IsPlayerLooking(v) then
			--print(v:Nick() .. " is looking - " .. CurTime())
			return false
		end
	end
	return true
end

ENT.Tries = 0
if SERVER then
	function ENT:Think()
		for k,v in pairs(player.GetAll()) do
			if self:IsPlayerVisible(v, self:GetPos()) then
				v.seen173 = CurTime() + 10
			end
		end
	end
end
