
function GetLangRole(rl)
	if language == nil then return rl end
	local rolef = nil
	for k,v in pairs(ROLES) do
		if rl == v then
			rolef = k
		end
	end
	if rolef != nil then
		return language.ROLES[rolef]
	else
		return rl
	end
end

function FindRole(role)
	for k,v in pairs(ALLCLASSES) do
		for k2,v2 in pairs(v.roles) do
			if v2.name == role then
				return v2
			end
		end
	end
	return nil
end

print("Gamemode loaded core/shared/util.lua")