
gteams = {}
gteams.Teams = {}

function gteams.SetUp(index, name, color)
	if isnumber(index) and isstring(name) and IsColor(color) then
		table.ForceInsert(gteams.Teams, {
			index = index,
			name = name,
			color = color,
			points = 0
		})
	else
		ErrorNoHalt("GTEAMS [ERROR] tried to setup invalid team!")
		print(debug.traceback())
	end
end

function gteams.GetColor(input)
    for k,v in pairs(gteams.Teams) do
        if (v.index == input) or (v.name == input) then
            return v.color
        end
    end
end

function gteams.GetScore(input)
    for k,v in pairs(gteams.Teams) do
        if (v.index == input) or (v.name == input) then
            return v.points
        end
    end
end

function gteams.SetScore(input, amount)
    for k,v in pairs(gteams.Teams) do
        if (v.index == input) or (v.name == input) then
            v.points = amount
            return
        end
    end
end

function gteams.AddScore(input, amount)
    for k,v in pairs(gteams.Teams) do
        if (v.index == input) or (v.name == input) then
            v.points = v.points + amount
            return
        end
    end
end

function gteams.Valid(input)
    for k,v in pairs(gteams.Teams) do
        if (v.index == input) or (v.name == input) then
            return true
        end
    end
	return false
end

local mply = FindMetaTable("Player")

function mply:IsSpectator()
	return self.br_team == TEAM_SPECTATOR
end

function mply:GTeam()
    return self.br_team or TEAM_SPECTATOR
end

function mply:GetGTeam()
    return self:GTeam()
end

function mply:SetGTeam(input)
    for k,v in pairs(gteams.Teams) do
        if (v.index == input) or (v.name == input) then
            self.br_team = v.index
            return
        end
    end

	ErrorNoHalt("GTEAMS [ERROR] Tried to set an invalid team!")
	print(debug.traceback())
end

function gteams.CheckTeams()
	print("GTEAMS: List")
	for k,v in pairs(gteams.Teams) do
		print(k .. " - " .. v.name .. "  index: " .. v.index .. "  color: rgb(" .. v.color.r .. "," .. v.color.g .. "," .. v.color.b .. ")")
	end
end

function gteams.CheckPlayers()
	print("GTEAMS: Players")
	for k,v in pairs(player.GetAll()) do
		local tname = v:GTeam()
		print(v:Nick() .. " - " .. tostring(tname))
	end
end

function gteams.GetPlayers(id)
	local tab = {}
	for k,v in pairs(player.GetAll()) do
		if v:GTeam() == id then
			table.ForceInsert(tab, v)
		end
	end
	return tab
end

function gteams.NumPlayers(input)
	local tab = {}
	if isnumber(input) then
		for k,v in pairs(player.GetAll()) do
			if v:GTeam() == input and v:Alive() then
				table.ForceInsert(tab, v)
			end
		end
	else
		ErrorNoHalt("GTEAMS [ERROR] Tried to get number of players not using an index!")
		print(debug.traceback())
	end
	return #tab
end

gteams.SetUp(0, "Not Set", Color(255,255,255))
gteams.SetUp(TEAM_SCP, "SCP Objects", Color(112, 15, 31))
gteams.SetUp(TEAM_GUARD, "Site Security", Color(0, 100, 255))
gteams.SetUp(TEAM_CLASSD, "Class D Personnel", Color(255, 130, 0))
gteams.SetUp(TEAM_SPECTATOR, "Spectators", Color(141, 186, 160))
gteams.SetUp(TEAM_SCI, "Research Staff", Color(66, 188, 244))
gteams.SetUp(TEAM_STAFF, "Misc Staff", Color(141, 58, 196))
gteams.SetUp(TEAM_CHAOS, "Chaos Insurgency", Color(0, 100, 255))

print("Gamemode loaded core/shared/gteams.lua")