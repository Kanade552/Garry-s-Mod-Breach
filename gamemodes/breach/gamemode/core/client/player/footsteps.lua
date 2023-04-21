
function HandleFootsteps()
	for k,v in pairs(player.GetAll()) do
		local vel = math.Round(v:GetVelocity():Length())
		if v:GTeam() != TEAM_SPECTATOR and v:GetMoveType() != 8 and v:GetMoveType() != 10 and v:GetMoveType() != 0 and vel > 25 and v:IsOnGround() then
			v.nextstep = v.nextstep or 0
			if v.nextstep > CurTime() or v:GetNClass() == ROLES.ROLE_SCP966 then continue end

			local fvel = math.Clamp(1 - (vel / 100) / 3, 0.18, 2)
			v.nextstep = CurTime() + fvel

			local tr = util.TraceLine({
				start = v:GetPos(),
				endpos = v:GetPos() + Angle(90,0,0):Forward() * 10000
			})
		
			local volume = 0.9
			local running = false
			local sound = ""
			volume = volume * ((vel / 100) / 3)
			
			if vel < 80 then
				volume = volume * 0.7
			elseif vel > 150 then
				volume = volume * 1.3
				running = true
			end
			
			local soundLevel = 70
			if InPD(v) or v:GetNClass() == ROLES.ROLE_SCP106 then
				sound = "steps/steppd"..math.random(1,3)..".mp3"
			elseif tr.MatType == MAT_DIRT or tr.MatType == MAT_GRASS then
				volume = volume * 0.35
				sound = "steps/StepForest"..math.random(1,3)..".mp3"
			else
				if IsPlayerNTF(v) or v:GetNClass() == ROLES.ROLE_SCP049 then
					sound = "steps/HeavyStep"..math.random(1,3)..".ogg"
					soundLevel = soundLevel * 1.2
				else
					local str = ""
					if tr.MatType == MAT_METAL then
						str = "Metal"
					end

					if running then
						volume = volume * 0.55
						sound = "steps/Run"..str..math.random(1,8)..".mp3"
					else
						volume = volume * 0.7
						sound = "steps/Step"..str..math.random(1,8)..".mp3"
					end
				end
			end
			
			local wep = v:GetActiveWeapon()
			if IsValid(wep) and wep:GetClass() == "weapon_scp_173_old" then
				sound = "173sound"..math.random(1,3)..".ogg"
				v.nextstep = CurTime() + math.random(2,3)
			end

			if v.UsingArmor then
				volume = volume * 1.2
				soundLevel = soundLevel * 1.15
			end

			EmitSound(sound, v:GetPos(), v:EntIndex(), CHAN_AUTO, math.Clamp(volume, 0, 1), soundLevel)
		end
	end
end
hook.Add("Tick", "client_handle_footsteps", HandleFootsteps)

print("Gamemode loaded core/client/player/footsteps.lua")