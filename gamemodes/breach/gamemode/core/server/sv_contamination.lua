
util.AddNetworkString("BR_CreateSmoke")
local button_doors_cont1 = NULL
local button_doors_cont2 = NULL
-- lua_run TestBlockRoom()
function TestBlockRoom()
	local button1_pos = Vector(3849, 1128, 53.000000)
	local button2_pos = Vector(3209, 1128, 53.000000)
	for k,v in pairs(ents.GetAll()) do
		if v:GetPos() == button1_pos then
			button_doors_cont1 = v
			button_doors_cont1.BreachButton = {}
			button_doors_cont1.BreachButton.usesounds = false
			button_doors_cont1.BreachButton.customdenymsg = "Room is contaminated!"
			button_doors_cont1.BreachButton.canactivate = function(pl, ent) return false end
			button_doors_cont1.BreachButton.clevel = 10
			button_doors_cont1.BreachButton.name = "Contaminated doors 1"

		elseif v:GetPos() == button2_pos then
			button_doors_cont2 = v
			button_doors_cont2.BreachButton = {}
			button_doors_cont2.BreachButton.usesounds = false
			button_doors_cont2.BreachButton.customdenymsg = "Room is contaminated!"
			button_doors_cont2.BreachButton.canactivate = function(pl, ent) return false end
			button_doors_cont2.BreachButton.clevel = 10
			button_doors_cont2.BreachButton.name = "Contaminated doors 2"
		end
		--if IsValid(button_doors_cont1) and IsValid(button_doors_cont2) then
		--	break
		--end
	end
	local gaspos1 = Vector(3208,1009,-45)
	local gaspos2 = Vector(3832,1167,142)
	table.ForceInsert(GAS_AREAS, {pos1 = gaspos1, pos2 = gaspos2, cont = true})
	
	PrintTable(GAS_AREAS)
	print(button_doors_cont1)
	print(button_doors_cont2)
	
	local gas_to_create = {
		Vector(3732.5439453125, 1086.2879638672, 5.03125),
		Vector(3621.2922363281, 1089.9815673828, 5.0312576293945),
		Vector(3494.8229980469, 1089.9968261719, 5.03125),
		Vector(3373.4855957031, 1089.3991699219, 5.0312576293945),
	}
	for k,v in pairs(gas_to_create) do
		SV_CreateSmoke(v, 8)
	end
	
	timer.Simple(8, UnlockContaminatedDoors)
end

hook.Add("Tick", "br_tick_contamination", function()
	if GAS_AREAS then
		for k,v in pairs(GAS_AREAS) do
			if v.cont then
				local door1_pos = Vector(3840.207275, 1118.968750, 54.846138)
				local door1_tr1 = util.TraceLine({start = door1_pos, endpos = Vector(3840.423340, 1057.031250, 90.844742), mask = MASK_SOLID})
				local door1_tr2 = util.TraceLine({start = door1_pos, endpos = Vector(3840.722656, 1057.031250, 20.871456), mask = MASK_SOLID})
				if (door1_tr1.Fraction == 1) and (door1_tr2.Fraction == 1) then
					ForceUse(button_doors_cont1, 1, 1)
				end
				local door2_pos = Vector(3198.953613, 1118.968750, 54.763931)
				local door2_tr1 = util.TraceLine({start = door2_pos, endpos = Vector(3199.379883, 1057.031250, 91.456055), mask = MASK_SOLID})
				local door2_tr2 = util.TraceLine({start = door2_pos, endpos = Vector(3200.014893, 1057.031250, 20.917458), mask = MASK_SOLID})
				if (door2_tr1.Fraction == 1) and (door2_tr2.Fraction == 1) then
					ForceUse(button_doors_cont2, 1, 1)
				end
			end
		end
	end
end)

function UnlockContaminatedDoors()
	if IsValid(button_doors_cont1) then
		print("u1")
		button_doors_cont1.BreachButton = nil
	end
	if IsValid(button_doors_cont2) then
		print("u2")
		button_doors_cont2.BreachButton = nil
	end
	for area_i,area in ipairs(GAS_AREAS) do
		if area.cont then
			table.remove(GAS_AREAS, area_i)
		end
	end
end

function SV_CreateSmoke(pos, length)
	net.Start("BR_CreateSmoke")
		net.WriteVector(pos)
		net.WriteInt(length, 16)
	net.Broadcast()
end

print("Gamemode loaded core/server/sv_contamination.lua")