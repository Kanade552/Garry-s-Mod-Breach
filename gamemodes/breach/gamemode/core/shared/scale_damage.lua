
function GM:EntityTakeDamage(target, dmginfo)
	if target:IsPlayer() and target:Alive() then
		-- burning damage
		if dmginfo:IsDamageType(DMG_BURN) or dmginfo:IsDamageType(DMG_SLOWBURN) then
			if target:GTeam() == TEAM_SCP then
				dmginfo:SetDamage(0)
				return true

			elseif target.UsingArmor == "armor_fireproof" then
				dmginfo:ScaleDamage(0.60)
			end

		-- tesla gate
		elseif target.br_class == ROLES.ROLE_SCP106 and (dmginfo:IsDamageType(DMG_DISSOLVE) or dmginfo:IsDamageType(DMG_SHOCK)) then
			dmginfo:ScaleDamage(3)
			local pos = GetPocketPos()
			if pos then
				sound.Play("scps/decay.ogg", target:GetPos(), 100, 100, 1)
				target:EmitSound("scps/decay.ogg")
				target:SendLua('surface.PlaySound("tesla_shock.ogg")')
				target:SetPos(pos)
			end
		end
	end
end

function GM:ScalePlayerDamage(ply, hitgroup, dmginfo)
	local attacker = dmginfo:GetAttacker()
	local dmg_mul = 1
	local armor_mul = 1
	if attacker != ply and attacker:IsPlayer() then
		if ply.UsingArmor != nil and dmginfo:IsDamageType(DMG_BULLET) and ply.UsingArmor == "armor_bulletproof" then
			armor_mul = 0.80
		end
		local att_team = attacker:GTeam()
		local vic_team = ply:GTeam()
		if !postround then
			if ((att_team == TEAM_GUARD or att_team == TEAM_SCI or att_team == TEAM_STAFF) and
			   (vic_team == TEAM_GUARD or vic_team == TEAM_SCI or vic_team == TEAM_STAFF))
			   or
			   (att_team == TEAM_CLASSD or att_team == TEAM_CHAOS) and
			   (vic_team == TEAM_CLASSD or vic_team == TEAM_CHAOS)
			   or
			   (att_team == TEAM_SCP and vic_team == TEAM_CLASSD)
			then
				return true
			end
			if SERVER then
				attacker:AddExp(math.Round(dmginfo:GetDamage() / 4))
			end
		end
	end
	
	if (hitgroup == HITGROUP_HEAD) then
		dmg_mul = 1.5
	elseif (hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM) then
		dmg_mul = 0.9
	elseif (hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG) then
		dmg_mul = 0.8
	elseif (hitgroup == HITGROUP_GEAR) then
		dmg_mul = 0
	end

	if SERVER then
		dmg_mul = dmg_mul * armor_mul
		dmginfo:ScaleDamage(dmg_mul)
	end
end

print("Gamemode loaded core/shared/scale_damage.lua")