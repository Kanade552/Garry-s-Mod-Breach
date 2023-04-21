include("shared.lua")

function MapConfig_FOG()
    if MapConfig_ClientIsOutside() then
        render.FogStart(500)
        render.FogEnd(5000)
        render.FogColor(242, 237, 203)
        render.FogMaxDensity(1) 
        render.FogMode(MATERIAL_FOG_LINEAR)
        return true
    end
    
    render.FogStart(1)
    render.FogEnd(850)
    render.FogColor(0, 0, 0)
    render.FogMaxDensity(1)
    render.FogMode(MATERIAL_FOG_LINEAR)
    return true
end

print("Gamemode loaded mapconfigs/br_site19/cl_init.lua")