
util.AddNetworkString("DropCurrentVest")

net.Receive("DropCurrentVest", function(len, ply)
	if ply:Alive() and !ply:IsSpectator() and ply:GTeam() != TEAM_SCP then
		if ply.UsingArmor == nil then
			ply:PrintMessage(HUD_PRINTTALK, "You don't have a vest on")
			return
		end
		/*
		if ply.cant_drop_armor then
			ply:PrintMessage(HUD_PRINTTALK, "Your role prevents you from dropping your vest")
			return
		end
		*/
		if !ply:IsOnGround() then
			ply:PrintMessage(HUD_PRINTTALK, "You must be on the ground to drop your vest")
			return
		end
		ply:UnUseArmor()
	end
end)

print("Gamemode loaded core/server/player_actions/drop_vest.lua")