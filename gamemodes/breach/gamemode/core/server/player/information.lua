
local meta_player = FindMetaTable("Player")

util.AddNetworkString("UpdateAllPlayersInformation")
util.AddNetworkString("UpdatePlayersInformation")

function PlayerInfoOnAnotherPlayer(ply1, ply2)
    local send_team = ply2.br_team
    local send_class = ply2.br_class
    if send_team == TEAM_CHAOS and ply2.br_faketeam and ply2.br_fakeclass and ply1:GTeam() != TEAM_CHAOS then
        send_team = ply2.br_faketeam
        send_class = ply2.br_fakeclass
    end
    return send_team, send_class
end

function meta_player:UpdatePlayersAllInfo()
    local info = {}

    for k,ply in pairs(player.GetAll()) do
        local nteam, nclass = PlayerInfoOnAnotherPlayer(self, ply)
        table.ForceInsert(info, {ply, nteam, nclass})
    end

    net.Start("UpdateAllPlayersInformation")
        net.WriteTable(info)
    net.Send(self)
end

function UpdatePlayersAllInfo()
    for k,v in pairs(player.GetAll()) do
        v:UpdatePlayersAllInfo(ply)
    end
end

function meta_player:UpdatePlayersInfoOn(ply)
	local nteam, nclass = PlayerInfoOnAnotherPlayer(self, ply)
	net.Start("UpdatePlayersInformation")
		net.WriteEntity(ply)
		net.WriteInt(nteam, 8)
		net.WriteString(nclass)
	net.Send(self)
end

function UpdatePlayersInfoOn(ply)
    for k,v in pairs(player.GetAll()) do
        v:UpdatePlayersInfoOn(ply)
    end
end

print("Gamemode loaded core/server/player/information.lua")