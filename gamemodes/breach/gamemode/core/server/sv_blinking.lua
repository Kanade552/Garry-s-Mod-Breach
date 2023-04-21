
function OnUseEyedrops(ply)
	if ply.eyedrops_til > CurTime() then
		ply:PrintMessage(HUD_PRINTTALK, "Don't use them that fast!")
		return
	end
	ply:StripWeapon("item_eyedrops")
	ply:PrintMessage(HUD_PRINTTALK, "Used eyedrops, you will not be blinking for 10 seconds")
	ply.eyedrops_til = CurTime() + 10

	timer.Create("Unuseeyedrops" .. ply:SteamID64(), 10, 1, function()
		ply:PrintMessage(HUD_PRINTTALK, "You will be blinking now")
	end)
end

local next_blinks = 0
hook.Add("Tick", "BlinkTimer", function()
	if next_blinks > CurTime() then return end
	next_blinks = CurTime() + GetConVar("br_time_blinkdelay"):GetInt()

	local blink_duration = GetConVar("br_time_blink"):GetFloat() or 0.15

	for k,v in pairs(player.GetAll()) do
		if v:Alive() and !v:IsSpectator() and v.blinded_by_173_til < CurTime() and v.eyedrops_til < CurTime() and v.seen173 > CurTime() then
			net.Start("PlayerBlink")
			net.Send(v)

			v.blink_start = CurTime() + 0.1 + 0.14
			v.blink_end = v.blink_start + blink_duration - 0.05
		end
	end
end)

print("Gamemode loaded core/server/sv_blinking.lua")