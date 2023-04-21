AddCSLuaFile()

ENT.Type = "anim"
ENT.AmmoID = 0
ENT.AmmoType = "Pistol"
ENT.PName = "Pistol Ammo"
ENT.AmmoAmount = 1
ENT.MaxUses = 2
ENT.Model = Model("models/items/boxsrounds.mdl")

function ENT:Initialize()
	self:SetModel(self.Model)
	self.Entity:SetMoveType(MOVETYPE_NONE)
	self.Entity:SetSolid(SOLID_BBOX)
	if SERVER then
		self:SetUseType(SIMPLE_USE)
	end
	if self.ColorFix then
		self:SetColor(self.ColorFix)
	end
end

function ENT:Use(activator, caller)

end
