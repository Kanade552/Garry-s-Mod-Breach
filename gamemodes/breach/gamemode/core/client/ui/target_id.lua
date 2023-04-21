
net.Receive("BR_CorpseInfo", function(len)
	local ent = net.ReadEntity()
	local info = net.ReadTable()
	if IsValid(ent) then
		ent.Info = table.Copy(info)
	end
end)

function GM:HUDDrawTargetID()
	if disablehud or LocalPlayer():GetObserverMode() == OBS_MODE_IN_EYE then return end
	local client = LocalPlayer()
	local ourpos = client:GetPos()
	local eyepos = EyePos()

	local filterEnts = {client}
	for k,v in pairs(player.GetAll()) do
		if v.br_class == ROLES.ROLE_SCP173 and v != client then
			table.ForceInsert(filterEnts, v)
		end
	end

	local trace_tab = {
		start = eyepos,
		endpos = eyepos + EyeAngles():Forward() * 400,
		filter = filterEnts,
		mask = MASK_ALL
	}

	if client.br_class == ROLES.ROLE_SCP173 then
		table.ForceInsert(filterEnts, client:GetNWEntity("entity173"))
		trace_tab.start = Vector(ourpos.x, ourpos.y, ourpos.z + 95)
		trace_tab.endpos = Vector(ourpos.x, ourpos.y, ourpos.z + 95) + EyeAngles():Forward() * 400
	end
	
	local trace = util.TraceLine(trace_tab)

	if !trace.Hit or !trace.HitNonWorld then return end
	
	local text = language.class_unknown or "Unknown"
	local text2 = nil
	local font = "TargetID"
	local ply =  trace.Entity
	
	local clr = color_white
	local clr2 = color_white
	
	if ply.br_class == "breach_173ent" then
		local owner = ply:GetNWEntity("173Owner")
		if IsValid(owner) then
			ply = owner
		end
	end
		

	if ply:IsPlayer() then
		if !ply:Alive() or ply:IsSpectator() then return end

		-- should we hide the targetid of the scp 966?
		if ply:GetNClass() == ROLES.ROLE_SCP966 then
			local hide = true
			for k,v in pairs(client:GetWeapons()) do
				if istable(v.NVG) and v.NVGenabled then
					hide = false
				end
			end
			if client:GTeam() == TEAM_SCP then
				hide = false
			end
			if hide then return end
		end

		--if ply:GTeam() == TEAM_SCP then
			text = GetLangRole(ply.br_class)
			clr = gteams.GetColor(ply.br_team)
		--end

		if ply.br_team == TEAM_CHAOS then
			clr = Color(29, 81, 56)
		end
		
		-- ci spy stuff
		local frole = FindRole(ply.br_class)
		if istable(frole) and ply.br_team == TEAM_CHAOS then
			if LocalPlayer().br_team == TEAM_CHAOS or LocalPlayer().br_team == TEAM_CLASSD then
				clr = Color(29, 81, 56)
				text = frole.disguised_name .. " (Spy)"
			else
				if frole.disguised_color != nil then
					clr = frole.disguised_color
				end
				text = frole.disguised_name
			end
		end

	elseif istable(ply.Info) then
		local nclass = ply.Info.NClass
		local frole = FindRole(nclass)
		local role_color = Color(255,255,255,255)
		if frole then
			role_color = gteams.GetColor(frole.team)
			if frole.team == TEAM_CHAOS then
				clr = Color(29, 81, 56)
			end
		end

		if nclass == ROLES.ROLE_SCP173 then
			role_color = gteams.GetColor(TEAM_SCP)
		end

		text2 = ply.Info.Victim.."'s body  "
		clr2 = Color(255,255,255)

		text = nclass
		clr = role_color
	else
		return
	end
	
	if not text2 then
		text2 = ply:Nick() .. " (" .. ply:Health() .. "%)"
	end

	if !LocalPlayer():IsAlignedWith(ply) then
		clr2 = Color(237, 45, 45)
	end

	-- name and health
	local x = ScrW() / 2
	local y = ScrH() / 2 + 30
	draw.Text({
		text = text2,
		pos = {x, y},
		font = "TargetID",
		color = clr2,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	
	-- role
	draw.Text({
		text = text,
		pos = {x, y + 18},
		font = "TargetID",
		color = clr,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})

	/*
	-- enemy?
	draw.Text({
		text = text,
		pos = {x, y + 18},
		font = "TargetID",
		color = clr,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	*/
end

print("Gamemode loaded core/client/ui/target_id.lua")