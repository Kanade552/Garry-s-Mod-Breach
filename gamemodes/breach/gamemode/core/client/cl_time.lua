
cltime = 0

net.Receive("UpdateTime", function(len)
	cltime = net.ReadInt(16)
	preparing = net.ReadBool()
	postround = net.ReadBool()
	gamestarted = net.ReadBool()
end)

print("Gamemode loaded core/client/cl_time.lua")