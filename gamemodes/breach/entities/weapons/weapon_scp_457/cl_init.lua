
include("shared.lua")

SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_457")
SWEP.BounceWeaponIcon = false

function SWEP:DrawWorldModel()
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:DrawHUD()
	if disablehud then return end

	local sp_text = ""
	local sp_text_color = Color(17, 145, 66)
	local next_sp_attack = self:GetNWInt("NextSpecial", 0)

	if next_sp_attack > CurTime() then
		sp_text = "ready to use in " .. math.Round(next_sp_attack - CurTime())
		sp_text_color = Color(145, 17, 62)
	else
		sp_text = "ready to use"
	end
	
	draw.Text({
		text = "Special "..sp_text,
		pos = {ScrW() / 2, ScrH() - 50},
		font = "173font",
		color = sp_text_color,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})

	surface.SetDrawColor(255, 255, 255, 255)
	
	local x = ScrW() / 2.0
	local y = ScrH() / 2.0
	local gap = 3
	local length = gap + 4
	surface.DrawLine(x - length, y, x - gap, y)
	surface.DrawLine(x + length, y, x + gap, y)
	surface.DrawLine(x, y - length, x, y - gap)
	surface.DrawLine(x, y + length, x, y + gap)
end

SWEP.NVG = {
	effects = function(i)
		i.contrast = 2
		i.brightness = i.brightness - 0.15
		i.clr_r = 1
		i.clr_g = 0.5
		i.clr_b = 0.5

		i.add_r = 0.1
		i.add_g = 0
		i.add_b = 0
		i.vignette_alpha = 100
	end,
	make_fog = function()
		render.FogStart(0)
		render.FogEnd(600)
		render.FogColor(1, 0, 0)
		render.FogMaxDensity(1)
		render.FogMode(MATERIAL_FOG_LINEAR)
		return true
	end
}
SWEP.NVGenabled	= true
