
function BreachPlayerTick()
	for k,v in pairs(player.GetAll()) do
		local awep = v:GetActiveWeapon()
		local valid_awep = IsValid(awep)

		--173
		if IsValid(v.entity173) and (!valid_awep or (valid_awep and awep:GetClass() != "weapon_scp_173")) then
			v.entity173:Remove()
		end

		/*
		--Spectator Check
		if (v:GetMoveType() != MOVETYPE_WALK and v:GetNClass() != ROLES.ROLE_SCP173) and (v:GTeam() != TEAM_SPECTATOR or v:GetNoDraw() == false) then
			print("SPEC FIXED: " .. v:Nick() .. "!")
			v:SetSpectator()
		end
		*/

		--Spectate
		if v:IsSpectator() then
			local target = v:GetObserverTarget()
			if IsValid(target) and target:IsPlayer() and target:IsSpectator() then
				v:SpectatePlayerLeft()
			end
			continue
		end
        
		--if v.targetForSCPs == nil then v.targetForSCPs = 0 end
		if v:Alive() and v:GTeam() != TEAM_SPECTATOR and v:GTeam() != TEAM_SCP then
			if InPD(v) and v.nextDamageInPD < CurTime() then
				v.nextDamageInPD = CurTime() + 2
				v:TakeDamage(2, v, v)
			end

			v:HandleSpeeds()

			local gasmask = v:GetWeapon("item_gasmask")
			local gasmask_on = (gasmask and gasmask.GasMaskOn)

			if gasmask_on then
				if v.NextCough < CurTime() then
					v:GasmaskBreathe()
				end
				continue
			end

			if InGas(v) and v.nextDamageInGas < CurTime() then
				v.nextDamageInGas = CurTime() + 0.35
				v:SetHealth(v:Health() - 1)
				if v:Health() < 1 then
					v:Kill()
				end
				v:Cough()
			end
		end
	end
end
hook.Add("Tick", "BreachPlayerTickHook", BreachPlayerTick)

print("Gamemode loaded core/server/player/tick.lua")