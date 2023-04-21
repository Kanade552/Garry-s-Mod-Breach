
function DropCurrentVest()
	if LocalPlayer():Alive() and !LocalPlayer():IsSpectator() then
		net.Start("DropCurrentVest")
		net.SendToServer()
	end
end

concommand.Add("br_dropvest", function(ply, cmd, args)
	DropCurrentVest()
end)

print("Gamemode loaded core/client/player_actions/drop_vest.lua")