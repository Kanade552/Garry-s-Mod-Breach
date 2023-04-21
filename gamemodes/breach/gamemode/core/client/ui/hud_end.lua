
endmessages = {
	end_time = {
		main = language.lang_round_end_main,
		txt = language.lang_end_time,
		clr = color_white
	},
	end_noonewon = {
		main = language.lang_round_end_main,
		txt = language.lang_end_noonewon,
		clr = color_white
	},
	end_align_chaos = {
		main = language.lang_round_end_main,
		txt = language.lang_end_align_chaos,
		clr = gteams.GetColor(TEAM_CHAOS)
	},
	end_align_site_staff = {
		main = language.lang_round_end_main,
		txt = language.lang_end_align_site_staff,
		clr = gteams.GetColor(TEAM_GUARD)
	},
	end_align_scps = {
		main = language.lang_round_end_main,
		txt = language.lang_end_align_scps,
		clr = gteams.GetColor(TEAM_SCP)
	},
}

function BR_DrawHudEnd()
	if isstring(drawendmsg) then
		local end_message = endmessages[drawendmsg]
        
		if end_message then
			draw_end_info_till = 0
			draw.TextShadow({
				text = end_message.main,
				pos = {15, 15},
				font = "BR_EndInformation2",
				color = Color(0, 255, 0),
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_TOP,
			}, 2, 255)

			draw.TextShadow({
				text = end_message.txt,
				pos = {20, 65},
				font = "BR_EndInformation3",
				color = end_message.clr,
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_TOP,
			}, 2, 255)

			for i,txt in ipairs(endinformation) do
				draw.TextShadow({
					text = txt,
					pos = {15, 125 + (40 * i)},
					font = "BR_EndInformation",
					color = color_white,
					xalign = TEXT_ALIGN_LEFT,
					yalign = TEXT_ALIGN_TOP,
				}, 2, 255)
			end
		else
			drawendmsg = nil
		end
	else
		if isnumber(shoulddrawescape) then
			if CurTime() > lastescapegot then
				shoulddrawescape = nil
			end

			if language.escapemessages[shoulddrawescape] then
				local tab = language.escapemessages[shoulddrawescape]
				draw.TextShadow({
					text = tab.main,
					pos = {ScrW() / 2, ScrH() / 15},
					font = "ImpactBig",
					color = tab.clr,
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
				}, 2, 255)

				draw.TextShadow({
					text = string.Replace(tab.txt, "{t}", string.ToMinutesSecondsMilliseconds(esctime)),
					pos = {ScrW() / 2, ScrH() / 15 + 45},
					font = "ImpactSmall",
					color = Color(255,255,255),
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
				}, 2, 255)

				draw.TextShadow({
					text = tab.txt2,
					pos = {ScrW() / 2, ScrH() / 15 + 75},
					font = "ImpactSmall",
					color = Color(255,255,255),
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
				}, 2, 255)
			end
		end
	end
end

print("Gamemode loaded core/client/ui/hud_end.lua")