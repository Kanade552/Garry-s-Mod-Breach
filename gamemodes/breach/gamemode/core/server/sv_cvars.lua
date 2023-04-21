
function gm_addcvar(name, value, helptext)
    if !ConVarExists(name) then
        value = value or "0"
        CreateConVar(name, value, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, helptext)
    end
end

gm_addcvar("br_time_preparing", "45", "Preparing time")
gm_addcvar("br_time_round", "900", "Round time")
gm_addcvar("br_time_postround", "20", "Postround time")

gm_addcvar("br_time_gateb_open_min", "252", "Min time to open the gate b")
gm_addcvar("br_time_gateb_open_max", "684", "Max time to open the gate b")

gm_addcvar("br_time_ntfenter_delay_min", "90", "Min time for the NTF to come")
gm_addcvar("br_time_ntfenter_delay_max", "180", "Max time for the NTF to come")

gm_addcvar("br_time_blink", "0.15", "Blink duration")
gm_addcvar("br_time_blinkdelay", "4", "Delay between blinks")

gm_addcvar("br_specialround_percentage", "12", "Chance of a special round happening")
gm_addcvar("br_specialround_forcenext", "none", "Force the next special round")

gm_addcvar("br_scoreboardranks", "0", "Show admin ranks on the scoreboard")
gm_addcvar("br_expscale", "1", "EXP Scale")
gm_addcvar("br_force_roles", "none", "Force a role table")

gm_addcvar("br_use_old_173", "0", "Use the old scp173?")

gm_addcvar("br2_debug_print_doors", "0", "Print door positions")
gm_addcvar("br2_debug_stop_first_sounds", "0", "Stop first sounds")


function GetPrepTime()
	return GetConVar("br_time_preparing"):GetInt()
end

function GetRoundTime()
	return GetConVar("br_time_round"):GetInt()
end

function GetPostTime()
	return GetConVar("br_time_postround"):GetInt()
end

function GetGateOpenTime()
	return GetConVar("br_time_gateopen"):GetInt()
end

print("Gamemode loaded core/server/sv_cvars.lua")