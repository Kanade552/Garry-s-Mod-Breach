
include("debug.lua")
include("chat_actions.lua")
include("bindings.lua")
include("drop_vest.lua")

concommand.Add("br_roundrestart_cl", function(ply, cmd, args)
	if ply:IsSuperAdmin() then
		net.Start("RoundRestart")
		net.SendToServer()
	end
end)

disablehud = false
concommand.Add("br_disableallhud", function(ply, cmd, args)
	disablehud = !disablehud
end)

print("Gamemode loaded core/client/player_actions/_init.lua")