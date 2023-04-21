
function WakeEntity(ent)
	local phys = ent:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:SetVelocity(Vector(0,0,25))
	end
end

local lastpocketd = 0
function GetPocketPos()
	if lastpocketd > #POS_POCKETD then
		lastpocketd = 0
	end
	lastpocketd = lastpocketd + 1
	return POS_POCKETD[lastpocketd]
end

function ForceUse(ent, on, int)
	for k,v in pairs(player.GetAll()) do
		if v:Alive() then
			ent:Use(v,v,on, int)
		end
	end
end

function OpenGateA()
	for k, v in pairs(ents.FindByClass("func_rot_button")) do
		if v:GetPos() == POS_GATEABUTTON then
			ForceUse(v, 1, 1)
		end
	end
end

print("Gamemode loaded core/server/round/map_related.lua")