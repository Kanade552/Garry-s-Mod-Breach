
local zoom_mat = Material("vgui/zoom")

last996attack = 0
function GM:RenderScreenspaceEffects()
	local scrw = ScrW()
	local scrh = ScrH()
	local curtime = CurTime()
	local client = LocalPlayer()

	local i = {
		contrast = 1,
		colour = 1,
		brightness = 0,
		add_r = 0,
		add_g = 0,
		add_b = 0,
		clr_r = 0,
		clr_g = 0,
		clr_b = 0,
		bloommul = 0,
		vignette_alpha = 50
	}
	
	if client:Alive() and !debug_view_enabled then
		if curtime > 25 then
			last996attack = last996attack - 0.002
			if last996attack < 0 then
				last996attack = 0
			else
				DrawMotionBlur(1 - last996attack, 1, 0.05)
				DrawSharpen(last996attack, 2)
				i.contrast = last996attack
			end
	
			if curtime - last_capture_by_106 < 10 then
				DrawMotionBlur(0.2, 0.5, 0.05)
			end

			if InPD(client) then
				i.add_g = 0.02
				if client:GetNClass() == ROLES.ROLE_SCP106 then
					i.contrast = 6
				else
					i.contrast = 3
					i.vignette_alpha = 200
					DrawMotionBlur(0.4, 0.8, 0.01)
				end
			end
		end
	
		
		for k,v in pairs(LocalPlayer():GetWeapons()) do
			if istable(v.NVG) and v.NVGenabled and isfunction(v.NVG.effects) then
				v.NVG.effects(i)
			end
		end

		if f_started and client:GTeam() != TEAM_SCP then
			i.brightness = i.brightness + f_brightness
		end
		
		if client:Health() < 21 then
			i.colour = math.Clamp((client:Health() / client:GetMaxHealth()) * 5, 0, 2)
			DrawMotionBlur(0.27, 0.5, 0.01)
			DrawSharpen(1,2)
		end
	end
	
	if debug_view_enabled then
		i.contrast = 1.2
	end

	local tab = {
		["$pp_colour_addr"] = i.add_r,
		["$pp_colour_addg"] = i.add_g,
		["$pp_colour_addb"] = i.add_b,
		["$pp_colour_brightness"] = i.brightness,
		["$pp_colour_contrast"] = i.contrast,
		["$pp_colour_colour"] = i.colour,
		["$pp_colour_mulr"] = i.clr_r,
		["$pp_colour_mulg"] = i.clr_g,
		["$pp_colour_mulb"] = i.clr_b
	}
	DrawColorModify(tab)

	if i.vignette_alpha > 0 then
		surface.SetDrawColor(Color(0, 0, 0, i.vignette_alpha))
		surface.SetMaterial(zoom_mat)
		surface.DrawTexturedRectRotated(scrw/2, scrh/2 - 1, scrw, scrh, 0)
		surface.DrawTexturedRectRotated(scrw/2 - 1, scrh/2, scrw, scrh, 180)
		surface.DrawTexturedRectRotated(scrw/2 - 1, scrh/2 - 1, scrh, scrw, 90)
		surface.DrawTexturedRectRotated(scrw/2, scrh/2, scrh, scrw, -90)
	end
end

print("Gamemode loaded core/client/player/screen_effects.lua")