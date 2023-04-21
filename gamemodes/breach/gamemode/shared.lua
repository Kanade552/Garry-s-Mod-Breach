
GM.Name 	= "Breach"
GM.Author 	= "Kanade"
GM.Email 	= ""
GM.Website 	= ""

function GM:Initialize()
	self.BaseClass.Initialize(self)
end

/*
DeriveGamemode("sandbox")

if CLIENT then
	RunConsoleCommand("cl_showhints", "0")
else
	RunConsoleCommand("sbox_noclip", "0")
	RunConsoleCommand("sbox_godmode", "0")
	RunConsoleCommand("physgun_limited", "0")
	RunConsoleCommand("sbox_playershurtplayers", "1")
	RunConsoleCommand("sbox_maxprops", "1000")
	RunConsoleCommand("sbox_maxragdolls", "1000")
	RunConsoleCommand("sbox_maxvehicles", "1000")
	RunConsoleCommand("sbox_maxeffects", "1000")
	RunConsoleCommand("sbox_maxballoons", "1000")
	RunConsoleCommand("sbox_maxcameras", "1000")
	RunConsoleCommand("sbox_maxnpcs", "1000")
	RunConsoleCommand("sbox_maxsents", "1000")
	RunConsoleCommand("sbox_maxdynamite", "1000")
	RunConsoleCommand("sbox_maxlamps", "1000")
	RunConsoleCommand("sbox_maxlights", "1000")
	RunConsoleCommand("sbox_maxwheels", "1000")
	RunConsoleCommand("sbox_maxthrusters", "1000")
	RunConsoleCommand("sbox_maxhoverballs", "1000")
	RunConsoleCommand("sbox_maxbuttons", "1000")
	RunConsoleCommand("sbox_maxemitters", "1000")
	RunConsoleCommand("sbox_weapons", "0")
	RunConsoleCommand("sbox_bonemanip_npc", "0")
	RunConsoleCommand("sbox_bonemanip_player", "0")
	RunConsoleCommand("sbox_bonemanip_misc", "0")
	RunConsoleCommand("sbox_persist", "")
end
*/

team.SetUp(1, "Default", Color(255, 255, 0))
/*
team.SetUp(TEAM_SCP, "SCPs", Color(237, 28, 63))
team.SetUp(TEAM_GUARD, "MTF Guards", Color(0, 100, 255))
team.SetUp(TEAM_CLASSD, "Class Ds", Color(255, 130, 0))
team.SetUp(TEAM_SPECTATOR, "Spectators", Color(141, 186, 160))
team.SetUp(TEAM_SCI, "Scientists", Color(66, 188, 244))
team.SetUp(TEAM_CHAOS, "Chaos Insurgency", Color(0, 100, 255))
*/

function TableRandom(tbl)
	return tbl[math.random(#tbl)]
end

function GM:Move(ply, mv)
	local wep = ply:GetActiveWeapon()
	if IsValid(wep) and isfunction(wep.Move) then
		return wep:Move(ply, mv)
	end
	return false
end

function GM:PlayerFootstep(ply, pos, foot, sound, volume, rf)
	return true
end

/*
hook.Add("ShouldCollide", "173ShouldCollide", function(ent1, ent2)
	--if (IsValid(ent1) and IsValid(ent2) and ent1:IsPlayer() and ent2:IsPlayer()) then return false end
	--return true
	if ent1:IsPlayer() and ent2:IsPlayer() then
		if IsValid(ent1:GetActiveWeapon()) then
			if ent1:GetActiveWeapon():GetClass() == Get_SCP173_Weapon() then
				return false
			end
		end
	end
	return true
end)
*/

print("Gamemode loaded shared.lua")