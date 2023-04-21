
util.AddNetworkString("ForcePlaySound")
net.Receive("ForcePlaySound", function(len)
	local sound = net.ReadString()
	surface.PlaySound(sound)
end)

util.AddNetworkString("RoundRestart")
net.Receive("RoundRestart", function(len, ply)
	if ply:IsSuperAdmin() then
		RoundRestart()
	end
end)

print("Gamemode loaded core/server/admin/_init.lua")