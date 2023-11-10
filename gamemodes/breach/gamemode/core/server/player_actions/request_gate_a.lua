
util.AddNetworkString("RequestGateA")

net.Receive("RequestGateA", function(len, ply)
	RequestOpenGateA(ply)
end)

nextgateaopen = 0
function RequestOpenGateA(ply)
	if preparing or postround or ply:CLevelGlobal() < 4
	or !(ply:GTeam() == TEAM_GUARD or ply:GTeam() == TEAM_CHAOS)
	then return end

	if nextgateaopen > CurTime() then
		ply:PrintMessage(HUD_PRINTTALK, "You can request in " .. math.Round(nextgateaopen - CurTime()) .. " seconds")
		return
	end

	if MAP_OpenGateA(ply) then
		nextgateaopen = CurTime() + 30
	else
		nextgateaopen = CurTime() + 5
	end
end

print("Gamemode loaded core/server/player_actions/request_gate_a.lua")