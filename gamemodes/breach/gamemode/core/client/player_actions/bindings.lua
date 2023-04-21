
function RemoveLocalRadio(ply)
	if ply.channel != nil then
		ply.channel:EnableLooping( false )
		ply.channel:Stop()
		ply.channel = nil
	end
end

local thirdperson_stage = 0

function GM:PlayerBindPress(ply, bind, pressed)
	local menu_cont = string.find(bind, "+menu_context")

	if pressed and string.find(bind, "+menu") and !menu_cont then
		net.Start("DropWeapon")
		net.SendToServer()

		RemoveLocalRadio(ply)
		return true

	elseif pressed and string.find(bind, "gm_showteam") then
		OpenClassMenu()
		return true

	elseif pressed and menu_cont then
		if thirdperson_stage == 0 then
			RunConsoleCommand("thirdperson_ots")
			RunConsoleCommand("thirdperson_ots_crosshair", "0")
			thirdperson_stage = 1

		elseif thirdperson_stage == 1 then
			RunConsoleCommand("thirdperson_ots_swap")
			thirdperson_stage = 2

		elseif thirdperson_stage == 2 then
			RunConsoleCommand("thirdperson_ots_swap")
			RunConsoleCommand("thirdperson_ots")
			thirdperson_stage = 0
		end
	end
end

print("Gamemode loaded core/client/player_actions/bindings.lua")