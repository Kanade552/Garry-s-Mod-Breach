
AddCSLuaFile("shared.lua")
include("shared.lua")

function SWEP:OnRemove()
	self:CleanUp()
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

function SWEP:PrimaryAttack()
    if preparing or postround or not IsFirstTimePredicted() then return end

	local ent = self.Owner:GetEyeTrace().Entity
	if ent:GetClass() == "func_breakable" and ent:GetPos():Distance(self.Owner:GetPos()) < 125 then
		ent:TakeDamage(1000, self.Owner, self.Owner)
	end
end

function SWEP:CreateFire()
	local tr = util.TraceLine({
		start = self.Owner:GetPos(),
		endpos = self.Owner:GetPos() + Angle(90,0,0):Forward() * 100
	})
	if tr.HitSky or tr.Hit == false or tr.HitWorld == false or self.Owner:GetPos():Distance(tr.HitPos) > 300 then return end
	
    if IsValid(self.fire457) then
        self.fire457:Remove()
    end
    
    sound.Play("ambient/fire/mtov_flame2.wav", tr.HitPos, 72, 100)

    self.fire457 = ents.Create("env_fire")
    if !self.fire457 or !self.fire457:IsValid() then return end

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

SWEP.NextSpecial = 0
function SWEP:SecondaryAttack()
    if preparing or postround or not IsFirstTimePredicted() then return end
    
	if self:GetNWInt("NextSpecial") <= CurTime() and self:CreateFire() then
		self:CreateFire()
	end
end
