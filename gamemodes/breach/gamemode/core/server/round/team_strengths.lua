
local team_name_tab = {
    "TEAM_CLASSD",
    "TEAM_GUARD",
    "TEAM_SCI",
    "TEAM_STAFF",
    "TEAM_SCP",
    "TEAM_CHAOS"
}

local alignment_name_tab = {
    "ALIGN_CHAOS",
    "ALIGN_SITE_STAFF",
    "ALIGN_SCPS"
}

function BR_RoundTeamRaport()
	local team_tab = {
		[TEAM_CLASSD] = 0,
		[TEAM_GUARD] = 0,
		[TEAM_SCI] = 0,
		[TEAM_STAFF] = 0,
		[TEAM_SCP] = 0,
		[TEAM_CHAOS] = 0
	}

	local player_count = 0

	for k,v in pairs(player.GetAll()) do
		local gteam = v:GTeam()
		if v:Alive() and gteam != TEAM_SPECTATOR and (v:LivenessIsGood() or v:IsBot()) then
			team_tab[gteam] = team_tab[gteam] + 1;
			player_count = player_count + 1
		end
	end

    return team_tab, player_count
end

function BR_RoundTeamStrengthsRaport()
	local team_tab, player_count = BR_RoundTeamRaport()
    local team_power_list = {
        ALIGN_CHAOS = (team_tab[TEAM_CLASSD] + team_tab[TEAM_CHAOS]) / player_count,
        ALIGN_SITE_STAFF = (team_tab[TEAM_GUARD] + team_tab[TEAM_SCI] + team_tab[TEAM_STAFF]) / player_count,
        ALIGN_SCPS = team_tab[TEAM_SCP] / player_count
    }

    return team_tab, player_count, team_power_list
end

function BR_DominantPower(team_tab, player_count, team_power_list)
    local dominant_force = team_power_list["ALIGN_SCPS"]
    local dominant_force_class = "ALIGN_SCPS"

    if team_power_list["ALIGN_SITE_STAFF"] > dominant_force then
        dominant_force = team_power_list["ALIGN_SITE_STAFF"]
        dominant_force_class = "ALIGN_SITE_STAFF"
    end

    -- highest priority
    if team_power_list["ALIGN_CHAOS"] > dominant_force then
        dominant_force = team_power_list["ALIGN_CHAOS"]
        dominant_force_class = "ALIGN_CHAOS"
    end

    return dominant_force, dominant_force_class
end

function BR_PrintRoundTeamStrengthsRaport()
    local team_tab, player_count, team_power_list = BR_RoundTeamStrengthsRaport()
    local team_tab_count = 0
    for k,v in pairs(team_tab) do
        team_tab_count = team_tab_count + v
    end

    local dominant_force, dominant_force_class = BR_DominantPower(team_tab, player_count, team_power_list)

    PrintTable(team_tab)
    print("")
    print("team_tab_count: ", team_tab_count)
    print("player_count: ", player_count)
    print("")
    print("----------------------------")
    print("")
    PrintTable(team_power_list)
    print("")
    print("chaos_power: ", team_power_list["ALIGN_CHAOS"])
    print("foundation_power: ", team_power_list["ALIGN_SITE_STAFF"])
    print("scp_power: ", team_power_list["ALIGN_SCPS"])
    print("")
    print("sanity_check: ", team_power_list["ALIGN_CHAOS"] + team_power_list["ALIGN_SITE_STAFF"] + team_power_list["ALIGN_SCPS"] .. " out of 1")
    print("")
    print("dominant_force: ", dominant_force_class)

    --print("dominating force: " .. alignment_name_tab[team_power_list[1]])
end

print("Gamemode loaded core/server/round/team_strengths.lua")