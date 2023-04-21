
util.AddNetworkString("RequestGateA")

net.Receive("RequestGateA", function(len, ply)
	RequestOpenGateA(ply)
end)

nextgateaopen = 0
function RequestOpenGateA(ply)
	if preparing or postround or ply:CLevelGlobal() < 4 then return end
	
	if !(ply:GTeam() == TEAM_GUARD or ply:GTeam() == TEAM_CHAOS) then return end
	if nextgateaopen > CurTime() then
		ply:PrintMessage(HUD_PRINTTALK, "You cannot open Gate A now, you must wait " .. math.Round(nextgateaopen - CurTime()) .. " seconds")
		return
	end
	local gatea = nil
	local rdc = nil
	for id,ent in pairs(ents.FindByClass("func_rot_button")) do
		for k,v in pairs(MAPBUTTONS) do
			if (v["pos"] == ent:GetPos()) and (v["name"] == "Remote Door Control") then
				rdc = ent
				rdc:Use(ply, ply, USE_ON, 1)
			end
		end
	end
	for id,ent in pairs(ents.FindByClass("func_button")) do
		for k,v in pairs(BUTTONS) do
			if (v["pos"] == ent:GetPos()) and (v["name"] == "Gate A") then
				gatea = ent
			end
		end
	end
	if IsValid(gatea) then
		nextgateaopen = CurTime() + 20
		timer.Simple(2, function()
			if IsValid(gatea) then
				gatea:Use(ply, ply, USE_ON, 1)
			end
		end)
	end
end

print("Gamemode loaded core/server/player_actions/request_gate_a.lua")