
net.Receive("UpdateAllPlayersInformation", function(len)
	local role_table = net.ReadTable()

	for k,v in pairs(role_table) do
		if IsValid(v[1]) and v[1]:IsPlayer() then
			v[1].br_team = v[2]
			v[1].br_class = v[3]
		end
	end
end)

net.Receive("UpdatePlayersInformation", function(len)
	local ply = net.ReadEntity()
	local nteam = net.ReadInt(8)
	local nclass = net.ReadString()

	ply.br_team = nteam
	ply.br_class = nclass
end)

print("Gamemode loaded core/client/player/information.lua")