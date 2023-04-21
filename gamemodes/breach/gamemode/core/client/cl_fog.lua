
function MakeFOG()
	if debug_view_enabled then return false end

	for k,v in pairs(LocalPlayer():GetWeapons()) do
		if v.NVG and v.NVGenabled and isfunction(v.NVG.make_fog) then
            v.NVG.make_fog()
            return true
		end
	end

	if MapConfig_FOG then
		return MapConfig_FOG()
	end
	return false
end

hook.Add("SetupWorldFog", "force_fog", function()
	MakeFOG()
	return true
end)

hook.Add("SetupSkyboxFog", "force_fog_skybox", function()
	MakeFOG()
	return true
end)

print("Gamemode loaded core/client/cl_fog.lua")