
br_914_state = 0

function BR_Change914State(num)
	br_914_state = num
end

function Check914Button()
	return br_914_state
end

/*
function MAP_OpenGateA(ply)
	local rdc = ents.FindByName("remote_door_control_lever")[1]
	if IsValid(rdc) and rdc:GetKeyValues()["sequence"] == 2 then
		ply:PrintMessage(HUD_PRINTTALK, "Request to open the Gate A has been sent but it seems that the Remote Door Control system is disabled.")
		return false
	end

	local gatea = ents.FindByName("gatea_button")[1]
	gatea:Use(ply, ply, USE_ON, 1)
	return true
end
*/

function MAP_OnPrepStart()
	--ents.FindByName("Breach")[1]:Fire("SetValueTest", "True")
	--ents.FindByName("Breach_new")[1]:Fire("SetValueTest", "True")
	ents.FindByName("Breach_button")[1]:Fire("Press")
end

function MAP_OnRoundStart()
end

print("Gamemode loaded mapconfigs/br_site19/sv_functions.lua")