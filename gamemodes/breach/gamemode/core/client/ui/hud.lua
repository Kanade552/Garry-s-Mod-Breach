
local hide = {
	CHudHealth = true,
	CHudBattery = true,
	CHudAmmo = true,
	CHudSecondaryAmmo = true,
	CHudDeathNotice = true
	--CHudWeaponSelection = true,
	--CHudWeapon = true
}

function GM:DrawDeathNotice(x, y)
end

hook.Add("HUDShouldDraw", "HideHUD", function(name)
	if hide[name] then return false end
end)

hook.Add("HUDPaint", "Breach_DrawHUD", function()
	if !LocalPlayer():Alive() or disablehud then return end
	
	BR_DrawHudGasmask()

	if LocalPlayer():IsSpectator() then
		BR_DrawHudSpect()
	end

	if debug_view_enabled then
		BR_DrawHudDebug()
	end

	BR_DrawHudRoundInfo()

	if gamestarted and draw_end_info_till > CurTime() then
		BR_DrawHudStartInfo()
	end

	BR_DrawHudEnd()
	BR_DrawHudPlayerInfo()
end)

print("Gamemode loaded core/client/ui/hud.lua")