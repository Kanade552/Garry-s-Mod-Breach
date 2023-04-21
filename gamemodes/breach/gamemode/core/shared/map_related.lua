
function InPD(ply)
	if POCKETDIMENSION == nil then return false end
	for k,v in pairs(POCKETDIMENSION) do
		local pos1 = v.pos1
		local pos2 = v.pos2
		OrderVectors(pos1, pos2)
		if ply:GetPos():WithinAABox(pos1, pos2) then
			return true
		end
	end
	return false
end

function InGas(ply)
	if GAS_AREAS == nil then return false end
	for k,v in pairs(GAS_AREAS) do
		local pos1 = v.pos1
		local pos2 = v.pos2
		OrderVectors(pos1, pos2)
		if ply:GetPos():WithinAABox(pos1, pos2) then
			return true
		end
	end
	return false
end

function InSCP914Enter(ent)
	local pos1 = ENTER914[1]
	local pos2 = ENTER914[2]
	OrderVectors(pos1, pos2)
	return ent:GetPos():WithinAABox(pos1, pos2)
end

print("Gamemode loaded core/shared/map_related.lua")