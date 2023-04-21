
br_914_state = 0

function BR_Change914State(num)
	br_914_state = num
end

function Check914Button()
	return br_914_state
end

function MAP_OnPrepStart()
	--ents.FindByName("Breach")[1]:Fire("SetValueTest", "True")
	--ents.FindByName("Breach_new")[1]:Fire("SetValueTest", "True")
	ents.FindByName("Breach_button")[1]:Fire("Press")
end

function MAP_OnRoundStart()
end

print("Gamemode loaded mapconfigs/br_site19/sv_functions.lua")