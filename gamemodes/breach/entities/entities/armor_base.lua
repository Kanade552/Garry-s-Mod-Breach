AddCSLuaFile()

ENT.PrintName		= "Base Armor"
ENT.Author		    = "Kanade"
ENT.Type			= "anim"
ENT.Spawnable		= true
ENT.AdminSpawnable	= true
ENT.RenderGroup     = RENDERGROUP_OPAQUE
ENT.ArmorType       = ""
ENT.ForceColor 		= nil

function ENT:Initialize()
	self.Entity:SetModel("models/combine_vests/militaryvest.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_NONE)
	self.Entity:SetSolid(SOLID_BBOX)
	if SERVER then
		self:SetUseType(SIMPLE_USE)
	end
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	if self.ForceColor then
		self:SetColor(self.ForceColor)
	end
end

function ENT:Use(ply)
	if ply:IsSpectator() or ply:GTeam() == TEAM_SCP or !ply:Alive() then return end

	if ply.UsingArmor != nil then
		ply:PrintMessage(HUD_PRINTTALK, 'You already have a vest, type "dropvest" in the chat to drop it')
		return
	end

	if SERVER then
		ply:ApplyArmor(self.ArmorType)
		self:EmitSound(Sound("npc/combine_soldier/zipline_clothing".. math.random(1, 2).. ".wav"))
		ply:PrintMessage(HUD_PRINTTALK, 'You are now wearing an armor, type "dropvest" in the chat to drop it')
		self:Remove()
	end

	ply.UsingArmor = self.ArmorType
end

function ENT:Draw()
	self:DrawModel()

	local ply = LocalPlayer()
	if ply:GetPos():Distance(self:GetPos()) > 180 then
		return
	end

	if IsValid(self) then
		cam.Start2D()
			if DrawInfo != nil then
				DrawInfo(self:GetPos() + Vector(0,0,15), self.PrintName, Color(255,255,255))
			end
		cam.End2D()
	end
end

