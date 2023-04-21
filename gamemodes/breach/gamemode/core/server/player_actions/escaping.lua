
function CheckEscape()
	for k_exit, v_exit in pairs(PD_EXITS) do
		for k_ent, v_ent in pairs(ents.FindInSphere(v_exit, 100)) do
			if v_ent:IsPlayer() and v_ent:Alive() and !v_ent:IsSpectator() then
				if v_ent:GetNClass() == ROLES.ROLE_SCP106 then
					--v_ent:SetPos()
					continue
				end

				local rand = math.random(1, 100)
				if rand < 6 then
					local attacker = NULL
					local inflictor = NULL
					local scps_found = {}
					for k_106,v_106 in pairs(player.GetAll()) do
						if v_106:GetNClass() == ROLES.ROLE_SCP106 and v_106:Alive() and v_ent.last106 == v_106 then
							table.ForceInsert(scps_found, v_106)
						end
					end
					if #scps_found > 0  then
						attacker = scps_found[1]
						inflictor = scps_found[1]:GetActiveWeapon()
						scps_found[1]:AddExp(45, true)
					end
					v_ent:TakeDamage(v_ent:Health() + 10, attacker, inflictor)

				elseif rand < 37 then
					v_ent:SetPos(TableRandom(PD_GOODEXIT))
					v_ent:EmitSound("PocketDimension/Exit.ogg", 75, 100, 0.7)

				else
					v_ent:SetPos(TableRandom(PD_BADEXIT))
					if math.random(1,2) == 1 then
						v_ent:SendLua('surface.PlaySound("Laugh.ogg")')
					end
				end
			end
		end
	end

	for _,p in pairs(POS_GATEA) do
		for k,v in pairs(ents.FindInSphere(p, 200)) do
			if v:IsPlayer() then
				if !v:Alive() or v.isescaping then continue end
				if v:GTeam() == TEAM_CLASSD or v:GTeam() == TEAM_SCI or v:GTeam() == TEAM_STAFF or v:GTeam() == TEAM_SCP then
					if v:GTeam() == TEAM_SCI or v:GTeam() == TEAM_STAFF then
						roundstats.rescaped = roundstats.rescaped + 1
						local rtime = timer.TimeLeft("RoundTime")
						local exptoget = 300
						if rtime != nil then
							exptoget = GetConVar("br_time_round"):GetInt() - (CurTime() - rtime)
							exptoget = exptoget * 1.8
							exptoget = math.Round(math.Clamp(exptoget, 300, 10000))
						end

						net.Start("OnEscaped")
							net.WriteInt(1,4)
						net.Send(v)

						v:AddFrags(5)
						v:AddExp(exptoget, true)
						v:GodEnable()
						v:Freeze(true)
						v.canblink = false
						v.isescaping = true

						timer.Create("EscapeWait" .. v:SteamID64(), 2, 1, function()
							v:Freeze(false)
							v:GodDisable()
							v:SetSpectator()
							WinCheck()
							v.isescaping = false
						end)
						--v:PrintMessage(HUD_PRINTTALK, "You escaped! Try to get escorted by MTF next time to get bonus points.")
					elseif v:GTeam() == TEAM_CLASSD then
						roundstats.descaped = roundstats.descaped + 1
						local rtime = timer.TimeLeft("RoundTime")
						local exptoget = 500
						if rtime != nil then
							exptoget = GetConVar("br_time_round"):GetInt() - (CurTime() - rtime)
							exptoget = exptoget * 2
							exptoget = math.Round(math.Clamp(exptoget, 500, 10000))
						end

						net.Start("OnEscaped")
							net.WriteInt(2,4)
						net.Send(v)

						v:AddFrags(5)
						v:AddExp(exptoget, true)
						v:GodEnable()
						v:Freeze(true)
						v.canblink = false
						v.isescaping = true
						timer.Create("EscapeWait" .. v:SteamID64(), 2, 1, function()
							v:Freeze(false)
							v:GodDisable()
							v:SetSpectator()
							WinCheck()
							v.isescaping = false
						end)
						--v:PrintMessage(HUD_PRINTTALK, "You escaped! Try to get escorted by Chaos Insurgency Soldiers next time to get bonus points.")
					elseif v:GTeam() == TEAM_SCP then
						roundstats.sescaped = roundstats.sescaped + 1
						local rtime = timer.TimeLeft("RoundTime")
						local exptoget = 425
						if rtime != nil then
							exptoget = GetConVar("br_time_round"):GetInt() - (CurTime() - rtime)
							exptoget = exptoget * 1.9
							exptoget = math.Round(math.Clamp(exptoget, 425, 10000))
						end
						
						net.Start("OnEscaped")
							net.WriteInt(4,4)
						net.Send(v)

						v:AddFrags(5)
						v:AddExp(exptoget, true)
						v:GodEnable()
						v:Freeze(true)
						v.canblink = false
						v.isescaping = true
						timer.Create("EscapeWait" .. v:SteamID64(), 2, 1, function()
							v:Freeze(false)
							v:GodDisable()
							v:SetSpectator()
							WinCheck()
							v.isescaping = false
						end)
					end
				end
			end
		end
	end
end
timer.Create("CheckEscape", 1, 0, CheckEscape)

print("Gamemode loaded core/server/player_actions/escaping.lua")