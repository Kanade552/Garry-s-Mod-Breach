AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function SWEP:CanWeMoveTo(pos)
	local ent173 = self.Owner.entity173
	if IsValid(ent173) then
		return (ent173:CanMove(pos) and ent173:CanMove(self:GetPos()))
	end
end

SWEP.NextMove = 0
SWEP.NextMoveSound = 1
SWEP.MoveSoundEvery = 3
function SWEP:MoveToNextPos(mv)
	if SERVER then
		local ent173 = self.Owner.entity173

		if self.NextMove > CurTime() or !IsValid(ent173) or self.NextPos == nil or (ent173:GetPos():Distance(self.NextPos) < 10) then return end
		if self.NextPos != nil and IsValid(self.Owner) and IsValid(ent173) then
			local canWeMove = self:CanWeMoveTo(self.NextPos)

			if canWeMove == true then
				mv:SetOrigin(self.NextPos)
				if self.NextAng != nil then
					ent173:SetAngles(Angle(0, self.Owner:EyeAngles().y, 0))
				end
				if self.NextMoveSound == self.MoveSoundEvery then
					self.Owner:EmitSound("173sound"..math.random(1,3)..".ogg", 300, 100, 1)
					self.NextMoveSound = 0
				end

				local target = nil

				local all_targets = ents.FindInSphere(self.NextPos, 250)
				local all_possible_targets = {}

				for i=1, table.Count(all_targets) do
					local rnd_target = TableRandom(all_targets)
					table.ForceInsert(all_possible_targets, rnd_target)
					table.RemoveByValue(all_targets, rnd_target)
				end

				for k,v in pairs(all_possible_targets) do
					if v != self.Owner and v:IsPlayer() and v:Alive() and v:Team() != TEAM_SCP and !v:IsSpectator() and ent173:IsPlayerVisible(v, self.NextPos) then
						--self.Owner:PrintMessage(HUD_PRINTTALK, v:Nick() .. tostring(dist))
						local dist = self.NextPos:Distance(v:GetPos())
						v.lastScare = v.lastScare or CurTime()

						if dist < 75 then
							if target == nil then
								target = v
							else
								v:SendLua('surface.PlaySound("horror/Horror'..math.random(1,2)..'.ogg")')
							end
						elseif v.lastScare < CurTime() then
							if dist < 125 then
								v:SendLua('surface.PlaySound("horror/Horror3.ogg")')
							else
								v:SendLua('surface.PlaySound("horror/Horror0.ogg")')
							end
						end

						v.lastScare = v.lastScare + 4
					end
				end

				self.NextMoveSound = self.NextMoveSound + 1

				if target and IsValid(target) then
					mv:SetOrigin(target:GetPos() - target:EyeAngles():Forward() * 15)
					ent173:SetAngles(Angle(0, target:EyeAngles().y, 0))
					target:TakeDamage(5000, self.Owner, self.Entity)
					self.Owner:EmitSound(self.SnapSound, 75, 100, 1)

					self.NextMove = CurTime() + 3

					return true
				end

				self.NextMove = CurTime() + 0.8
				return true
			end
		end
	end
	return false
end

function SWEP:HandleUse()
	if IsValid(self.Owner.entity173) and self.Owner.entity173:CanMove(self:GetPos()) == false then
		return
	end

	local tr_front = self:FrontTraceLine()
	if tr_front != nil then
		for k,v in pairs(ents.FindInSphere(tr_front.HitPos, 30)) do
			if v:GetClass() == "func_button" or v:GetClass() == "func_rot_button" then
				if ShouldPlayerUse(self.Owner, v) then
					v:Use(self.Owner, self.Owner, USE_TOGGLE, 1)
				end
				return
			end
		end
	end
end
