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
	if !activator:Alive() or activator:IsSpectator() or activator:GTeam() == TEAM_SCP then return end

	local gotawep = false
	for k,v in pairs(activator:GetWeapons()) do
		if v.Primary != nil and v.Primary.Ammo == self.AmmoType then
			gotawep = true
		end
	end
	if gotawep == false then
		return
	end

	if activator.MaxUses != nil then
		if self.AmmoID > #activator.MaxUses then
			for i=1, self.AmmoID do
				if activator.MaxUses[i] == nil then
					if i == self.AmmoID then
						table.ForceInsert(activator.MaxUses, 1)
						activator:GiveAmmo(self.AmmoAmount, self.AmmoType, false)
						self:Remove()
					else
						table.ForceInsert(activator.MaxUses, 0)
					end
				end
			end
		else
			if activator.MaxUses[self.AmmoID] >= self.MaxUses then
				activator:PrintMessage(HUD_PRINTCENTER, "You cannot pick-up more ammo")
				return
			else
				activator.MaxUses[self.AmmoID] = activator.MaxUses[self.AmmoID] + 1
				activator:GiveAmmo(self.AmmoAmount, self.AmmoType, false)
				self:Remove()
			end
		end
	else
		activator.MaxUses = {}
		if self.AmmoID != 1 then
			for i=1, self.AmmoID do
				if i == self.AmmoID then
					table.ForceInsert(activator.MaxUses, 1)
				else
					table.ForceInsert(activator.MaxUses, 0)
				end
			end
		else
			table.ForceInsert(activator.MaxUses, 1)
		end
		activator:GiveAmmo(self.AmmoAmount, self.AmmoType, false)
		self:Remove()
	end
end


function ENT:Draw()
	self:DrawModel()
	if IsValid(self) and DrawInfo and LocalPlayer():GetPos():Distance(self:GetPos()) < 100 then
		cam.Start2D()
			DrawInfo(self:GetPos() + Vector(0,0,15), self.PName, Color(255,255,255))
		cam.End2D()
	end
end

