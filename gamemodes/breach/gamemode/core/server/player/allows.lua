
function GM:PlayerSpray(sprayer)
	return (InPD(sprayer) or sprayer:GetGTeam() == TEAM_SPECTATOR)
end

function GM:CanPlayerSuicide(ply)
	return false
end

print("Gamemode loaded core/server/player/allows.lua")