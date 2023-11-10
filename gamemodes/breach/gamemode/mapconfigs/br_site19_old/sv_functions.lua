
/*
function MAP_OpenGateA(ply)
	local rdc = ents.FindByName("door_lever_roomccont")[1]
	if IsValid(rdc) and rdc:GetKeyValues()["sequence"] == 2 then
		ply:PrintMessage(HUD_PRINTTALK, "Request to open the Gate A has been sent but it seems that the Remote Door Control system is disabled.")
		return false
	end

	local gatea = ents.FindByName("gate_a_enter")[1]
	gatea:Use(ply, ply, USE_ON, 1)
	return true
end
*/

function Check914Button()
	local pos_tab = {
		{
			st = Vector(1565.968750, -823.031616, 61.957233),
			en = Vector(1565.968750, -826.915161, 62.004955)
		},
		{
			st = Vector(1565.968750, -825.680786, 68.210999),
			en = Vector(1565.968750, -828.393799, 65.604767)
		},
		{
			st = Vector(1565.968750, -832.041626, 70.997414),
			en = Vector(1565.968750, -832.085083, 66.835930)
		},
		{
			st = Vector(1565.968750, -838.287720, 68.332352),
			en = Vector(1565.968750, -835.649292, 65.702744)
		},
		{
			st = Vector(1565.968750, -841.050415, 62.003887),
			en = Vector(1565.968750, -837.351990, 61.958420)
		},
	}
	
	for i,v in ipairs(pos_tab) do
		local tr = util.TraceLine({
			start = v.st,
			endpos = v.en,
			mask = CONTENTS_SOLID + CONTENTS_MOVEABLE + CONTENTS_OPAQUE
		})
		if tr.Hit then
			return i
		end
	end
	return 0
end

MAPCONFIG_POST_ROUNDSTART = function()
	local pos_melon = Vector(3577.797607, 1700.684692, 43.777897)
	for k,v in pairs(ents.FindInSphere(pos_melon, 60)) do
		if v:GetClass() == "prop_physics" then
			v:SetKeyValue("ExplodeDamage", 80)
			v:SetKeyValue("ExplodeRadius", 350)
			--print("Melon fixed!")
		end
	end
	for k,v in pairs(ents.GetAll()) do
		if v:GetName() == "lcz_door_1_8" then
			v:Remove()
		end
	end
end

function MAP_OnPrepStart()
	for k,v in pairs(ents.GetAll()) do
		if v:GetPos() == Vector(-3684, 2468, 50.250000)
		or v:GetPos() == Vector(-3612, 2468, 50.250000) then
			v:Remove()
		end
	end
	GATEB_DOOR1 = ents.Create("br_gate")
	if IsValid(GATEB_DOOR1) then
		GATEB_DOOR1:SetModel("models/foundation/containment/door01.mdl")
		GATEB_DOOR1:Spawn()
		GATEB_DOOR1:SetPos(GATEB_POS.door1_closed)
		--WakeEntity(GATEB_DOOR1)
	end
	GATEB_DOOR2 = ents.Create("br_gate")
	if IsValid(GATEB_DOOR2) then
		GATEB_DOOR2:SetModel("models/foundation/containment/door01.mdl")
		GATEB_DOOR2:Spawn()
		GATEB_DOOR2:SetPos(GATEB_POS.door2_closed)
		GATEB_DOOR2:SetAngles(Angle(0,180,0))
		--WakeEntity(GATEB_DOOR2)
	end

	timer.Create("OpenGateB", math.random(GetConVar("br_time_gateb_open_min"):GetInt(), GetConVar("br_time_gateb_open_max"):GetInt()), 1, function()
		if isfunction(GATEB_OPEN) then
			GATEB_OPEN()
		end
	end)
end

GATEB_OPEN = function()
	if IsValid(GATEB_DOOR1) and IsValid(GATEB_DOOR2) then
		GATEB_DOOR1:SetPos(GATEB_POS.door1_opened)
		GATEB_DOOR2:SetPos(GATEB_POS.door2_opened)
		--print("GATEB_DOOR1")
		--EmitSound("BigDoorOpen2.ogg", GATEB_DOOR1:GetPos(), GATEB_DOOR1:EntIndex(), CHAN_AUTO, 1, 100)
		GATEB_DOOR1:EmitSound("BigDoorOpen2.ogg", 100, 100, 1, CHAN_AUTO)
		BroadcastLua('surface.PlaySound("EndroomDoor.ogg")')
	end
end

GATEB_CLOSE = function()
	if IsValid(GATEB_DOOR1) and IsValid(GATEB_DOOR2) then
		GATEB_DOOR1:SetPos(GATEB_POS.door1_closed)
		GATEB_DOOR2:SetPos(GATEB_POS.door2_closed)
	end
end

print("Gamemode loaded mapconfigs/br_site19/sv_functions.lua")