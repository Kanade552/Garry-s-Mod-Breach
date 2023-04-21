
local function HaveRadio(pl1, pl2)
	local r1 = pl1:GetWeapon("item_radio")
	local r2 = pl2:GetWeapon("item_radio")
	if !IsValid(r1) or !IsValid(r2) then return false end
	return (r1.Enabled and r2.Enabled and (r1.Channel == r2.Channel) and r1.Channel > 4)
end

function GM:PlayerCanHearPlayersVoice(listener, talker)
	if !talker:Alive() or !listener:Alive() or (talker:GTeam() == TEAM_SCP and listener:GTeam() != TEAM_SCP) then return false end

	if talker:GTeam() == TEAM_SCP and listener:GTeam() != TEAM_SCP then
		return false
	end
	if talker:IsSpectator() then
		return listener:IsSpectator()
	end

	if HaveRadio(listener, talker) then
		return true
	end

	return (talker:GetPos():Distance(listener:GetPos()) < 750), true
end

function GM:PlayerCanSeePlayersChat(text, teamOnly, listener, talker)
	if talker.Alive == nil or !talker:Alive() or !listener:Alive() then return true end

	if teamOnly and talker:GetPos():Distance(listener:GetPos()) < 750 then
		return (listener:GTeam() == talker:GTeam())
	end

	if talker:IsSpectator() then
		return listener:IsSpectator()
	end

	if HaveRadio(listener, talker) then
		return true
	end
	
	return (talker:GetPos():Distance(listener:GetPos()) < 750)
end

print("Gamemode loaded core/server/player/can_see_chat.lua")