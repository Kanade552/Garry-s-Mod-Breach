
local meta_player = FindMetaTable("Player")

function meta_player:IsAlignedWith(ply)
	if self.br_team == ply.br_team then return true end

	if (self.br_team == TEAM_CLASSD or self.br_team == TEAM_CHAOS) then
		return (ply.br_team == TEAM_CLASSD or ply.br_team == TEAM_CHAOS)
	end

	if (self.br_team == TEAM_GUARD or self.br_team == TEAM_SCI or self.br_team == TEAM_STAFF) then
		return (ply.br_team == TEAM_GUARD or ply.br_team == TEAM_SCI or ply.br_team == TEAM_STAFF)
	end

	return false
end

function meta_player:GetGTeam()
	return self.br_team
end

function meta_player:GTeam()
	return self:GetGTeam()
end

function meta_player:GetNClass()
	return self.br_class
end

function meta_player:NClass()
	return self:GetNClass()
end

function meta_player:CLevelGlobal()
	local biggest = 0
	for k,wep in pairs(self:GetWeapons()) do
		if IsValid(wep) and wep.clevel and wep.clevel > biggest then
			biggest =  wep.clevel
		end
	end
	return biggest
end

function meta_player:CLevel()
	local wep = self:GetActiveWeapon()
	if IsValid(wep) and wep.clevel then
		return wep.clevel
	end
	return 0
end 

function meta_player:GetNEXP()
	return self:GetNWInt("NEXP", 0)
end

function meta_player:GetNLevel()
	return self:GetNWInt("NLevel", 0)
end

function meta_player:GetExp()
	return self:GetNEXP()
end

function meta_player:GetLevel()
	return self:GetNLevel()
end

print("Gamemode loaded core/shared/player_ext.lua")