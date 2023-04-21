
function BR_DrawHudStartInfo()
    local client = LocalPlayer()
    local our_role = client:GetNClass()

    for k,v in pairs(ROLES) do
        if v == our_role then
            our_role = k
        end
    end

    for k,v in pairs(language.starttexts) do
        if k == our_role then
            our_role = v
            break
        end
    end

    local align = 32
    local tcolor = gteams.GetColor(client:GTeam())
    if client:GTeam() == TEAM_CHAOS then
        tcolor = Color(29, 81, 56)
    end
    
    if our_role[1] != nil then
        draw.TextShadow({
            text = our_role[1],
            pos = {ScrW() / 2, ScrH() / 15},
            font = "ImpactBig",
            color = tcolor,
            xalign = TEXT_ALIGN_CENTER,
            yalign = TEXT_ALIGN_CENTER,
       }, 2, 255)
    end

    for i,txt in ipairs(our_role[2]) do
        draw.TextShadow({
            text = txt,
            pos = {ScrW() / 2, ScrH() / 15 + 10 + (align * i)},
            font = "ImpactSmall",
            color = Color(255,255,255),
            xalign = TEXT_ALIGN_CENTER,
            yalign = TEXT_ALIGN_CENTER,
       }, 2, 255)
    end
    
    if roundtype != nil then
        draw.TextShadow({
            text = language.roundtype,
            pos = {ScrW() / 2, ScrH() - 25},
            font = "BR_RoundTypeInfo1",
            color = Color(255, 255, 255),
            xalign = TEXT_ALIGN_RIGHT,
            yalign = TEXT_ALIGN_CENTER,
       }, 2, 255)

       draw.TextShadow({
           text = roundtype,
           pos = {ScrW() / 2, ScrH() - 25},
           font = "BR_RoundTypeInfo2",
           color = Color(255, 130, 0),
           xalign = TEXT_ALIGN_LEFT,
           yalign = TEXT_ALIGN_CENTER,
      }, 2, 255)
    end
end

function BR_DrawHudRoundInfo()
	if player.GetCount() < MINPLAYERS then
        if !gamestarted then
            draw.TextShadow({
                text = "Not enough players to start the round",
                pos = {ScrW() / 2, ScrH() / 15},
                font = "ImpactBig",
                color = Color(3,211,252),
                xalign = TEXT_ALIGN_CENTER,
                yalign = TEXT_ALIGN_CENTER,
            }, 2, 255)

            draw.TextShadow({
                text = "Waiting for "..MINPLAYERS - player.GetCount().." more players to join the server",
                pos = {ScrW() / 2, ScrH() / 15 + 45},
                font = "ImpactSmall",
                color = Color(255,255,255),
                xalign = TEXT_ALIGN_CENTER,
                yalign = TEXT_ALIGN_CENTER,
            }, 2, 255)
        end
	
	elseif !gamestarted then
		draw.TextShadow({
			text = "Game is starting",
			pos = {ScrW() / 2, ScrH() / 15},
			font = "ImpactBig",
			color = Color(3, 252, 44),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
		}, 2, 255)

		draw.TextShadow({
			text = "Wait for the round to start",
			pos = {ScrW() / 2, ScrH() / 15 + 45},
			font = "ImpactSmall",
			color = Color(255,255,255),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
		}, 2, 255)
	end
end

print("Gamemode loaded core/client/ui/hud_start.lua")