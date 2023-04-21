
local width = 350
local role_width = width - 25

local last_armor_status = false
local draw_armor_info_til = 0
function BR_DrawHudPlayerInfo()
    local client = LocalPlayer()

	local height = 120

    local obs_target = client:GetObserverTarget()
    if client:IsSpectator() then
		if IsValid(obs_target) and obs_target:IsPlayer() then
        	client = obs_target
		else
			height = 30
		end
    end

	local x = 10
	local y = ScrH() - height - 10

    local client_team = client:GTeam()
	local wep = client:GetActiveWeapon()
	local show_ammo = (IsValid(wep) and wep.Clip1 and wep:Clip1() > -1)

	if !show_ammo and height > 30 then
		height = height - 32
		y = y + 32
	end

-- BACKGROUND
	local color = gteams.GetColor(client_team) or Color(29, 81, 56)
	if client_team == TEAM_CHAOS then
		color = Color(29, 81, 56)
	end
	draw.RoundedBox(0, x, y, width, height, Color(0,0,10,200))
	draw.RoundedBox(0, x, y, role_width - 70, 30, color)


-- CLASS
    local name = GetLangRole(client:GetNClass()) or "None"
	draw.TextShadow({
		text = name,
		pos = {role_width / 2 - 30, y + 14},
		font = "ClassName",
		color = Color(255,255,255),
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	}, 2, 255)


-- TIME
	draw.TextShadow({
		text = tostring(string.ToMinutesSeconds(cltime)),
		pos = {width - 68, y + 3},
		font = "TimeLeft",
		color = Color(255,255,255),
		xalign = TEXT_ALIGN_TOP,
		yalign = TEXT_ALIGN_TOP,
	}, 2, 255)

	if client:IsSpectator() then return end

-- HEALTH
	local health_percentage = math.Clamp(client:Health() / client:GetMaxHealth(), 0.06, 1)

	draw.RoundedBox(0, 25, y + 40, width - 30, 27, Color(50, 0, 0, 255))
	draw.RoundedBox(0, 25, y + 40, (width - 30) * health_percentage, 27, Color(200, 50, 50, 200))
	draw.TextShadow({
		text = client:Health(),
		pos = {width - 20, y + 40},
		font = "HealthAmmo",
		color = Color(255,255,255),
		xalign = TEXT_ALIGN_RIGHT,
		yalign = TEXT_ALIGN_RIGHT,
	}, 2, 255)


-- WEAPON INFORMATION
	if show_ammo then
		local ammo_percentage = math.Clamp(wep:Clip1(), 0, wep:GetMaxClip1()) / wep:GetMaxClip1()

		draw.RoundedBox(0, 25, y + 75, width - 30, 27, Color(20, 20, 5, 222))
		draw.RoundedBox(0, 25, y + 75, (width - 30) * ammo_percentage, 27, Color(205, 155, 0, 255))
		draw.TextShadow({
			text = wep:Clip1() .. " + ".. client:GetAmmoCount(wep:GetPrimaryAmmoType()),
			pos = {width - 20, y + 75},
			font = "HealthAmmo",
			color = Color(255,255,255),
			xalign = TEXT_ALIGN_RIGHT,
			yalign = TEXT_ALIGN_RIGHT,
		}, 2, 255)
	end

-- SPECIAL ACTION SOUNDS
	if client.next_sa_sound and client.next_sa_sound > CurTime() then
		draw.TextShadow({
			text = "Next sound use: " .. math.Round(client.next_sa_sound - CurTime()) .. "",
			pos = {ScrW() / 2, ScrH() / 2 + 150},
			font = "TimeLeft",
			color = Color(255,255,255, 100),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_TOP,
		}, 2, 255)
	end

-- VEST
	if last_armor_status != client.UsingArmor then
		if client.UsingArmor then
			draw_armor_info_til = CurTime() + 10
		end
	end
	last_armor_status = client.UsingArmor or false

	if client.UsingArmor and draw_armor_info_til > CurTime() then
		draw.TextShadow({
			text = 'You have a vest on, type "dropvest" in the chat to drop it',
			pos = {ScrW() / 2, ScrH() - 110},
			font = "BR_ArmorInfo",
			color = Color(255,255,255, 30),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_TOP,
		}, 2, 255)
	end
end

print("Gamemode loaded core/client/ui/hud_alive.lua")