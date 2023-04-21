
util.AddNetworkString("RequestEscorting")

net.Receive("RequestEscorting", function(len, ply)
	if ply:GTeam() == TEAM_GUARD then
		CheckEscortMTF(ply)

	elseif ply:GTeam() == TEAM_CHAOS then
		CheckEscortChaos(ply)
	end
end)

function CheckEscortMTF(pl)
	if pl.nextescheck != nil then
		if pl.nextescheck > CurTime() then
			pl:PrintMessage(HUD_PRINTTALK, "Wait " .. math.Round(pl.nextescheck - CurTime()) .. " seconds.")
			return
		end
	end
	pl.nextescheck = CurTime() + 3
	if pl:GTeam() != TEAM_GUARD then return end
	local foundpl = nil
	local foundrs = {}
	for k,v in pairs(ents.FindInSphere(POS_ESCORT, 350)) do
		if v:IsPlayer() then
			if pl == v then
				foundpl = v
			elseif (v:GTeam() == TEAM_SCI or v:GTeam() == TEAM_STAFF) and v:Alive() then
				table.ForceInsert(foundrs, v)
			end
		end
	end
	if not IsValid(foundpl) then return end
	rsstr = ""
	for i,v in ipairs(foundrs) do
		if i == 1 then
			rsstr = v:Nick()
		elseif i == #foundrs then
			rsstr = rsstr .. " and " .. v:Nick()
		else
			rsstr = rsstr .. ", " .. v:Nick()
		end
	end
	if #foundrs == 0 then return end
	pl:AddFrags(#foundrs * 3)
	pl:AddExp((#foundrs * 425), true)
	local rtime = timer.TimeLeft("RoundTime")
	local exptoget = 700
	if rtime != nil then
		exptoget = GetConVar("br_time_round"):GetInt() - (CurTime() - rtime)
		exptoget = exptoget * 2.25
		exptoget = math.Round(math.Clamp(exptoget, 700, 10000))
	end
	for k,v in ipairs(foundrs) do
		--roundstats.rescaped = roundstats.rescaped + 1
		roundstats.rescorted = roundstats.rescorted + 1
		v:SetSpectator()
		v:AddFrags(10)
		v:AddExp(exptoget, true)
		v:PrintMessage(HUD_PRINTTALK, "You've been escorted by " .. pl:Nick())
		net.Start("OnEscaped")
			net.WriteInt(3,4)
		net.Send(v)
		WinCheck()
	end
	pl:PrintMessage(HUD_PRINTTALK, "You've successfully escorted: " .. rsstr)
end

function CheckEscortChaos(pl)
	if pl.nextescheck != nil then
		if pl.nextescheck > CurTime() then
			pl:PrintMessage(HUD_PRINTTALK, "Wait " .. math.Round(pl.nextescheck - CurTime()) .. " seconds.")
			return
		end
	end
	pl.nextescheck = CurTime() + 3
	if pl:GTeam() != TEAM_CHAOS then return end
	local foundpl = nil
	local foundds = {}
	for k,v in pairs(ents.FindInSphere(POS_ESCORT, 350)) do
		if v:IsPlayer() then
			if pl == v then
				foundpl = v
			elseif v:GTeam() == TEAM_CLASSD and v:Alive() then
				table.ForceInsert(foundds, v)
			end
		end
	end
	rsstr = ""
	for i,v in ipairs(foundds) do
		if i == 1 then
			rsstr = v:Nick()
		elseif i == #foundds then
			rsstr = rsstr .. " and " .. v:Nick()
		else
			rsstr = rsstr .. ", " .. v:Nick()
		end
	end
	if #foundds == 0 then return end
	pl:AddFrags(#foundds * 3)
	pl:AddExp((#foundds * 500), true)
	local rtime = timer.TimeLeft("RoundTime")
	local exptoget = 800
	if rtime != nil then
		exptoget = GetConVar("br_time_round"):GetInt() - (CurTime() - rtime)
		exptoget = exptoget * 2.5
		exptoget = math.Round(math.Clamp(exptoget, 800, 10000))
	end
	for k,v in ipairs(foundds) do
		roundstats.dcaptured = roundstats.dcaptured + 1
		v:SetSpectator()
		v:AddFrags(10)
		v:AddExp(exptoget, true)
		v:PrintMessage(HUD_PRINTTALK, "You've been captured by " .. pl:Nick())
		net.Start("OnEscaped")
			net.WriteInt(3,4)
		net.Send(v)
		WinCheck()
	end
	pl:PrintMessage(HUD_PRINTTALK, "You've successfully captured: " .. rsstr)
end

print("Gamemode loaded core/server/player_actions/escorting.lua")