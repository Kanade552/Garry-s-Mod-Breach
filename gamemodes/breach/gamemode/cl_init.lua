
draw_end_info_till = -1000
drawendmsg = nil
buttonstatus = "rough"

include("shared.lua")
include("core/shared/enums.lua")
include("core/shared/language.lua")
include("core/shared/util.lua")
include("core/shared/gteams.lua")
include("core/shared/classes.lua")
include("core/shared/map_related.lua")
include("core/shared/scp173.lua")
include("core/shared/player_ext.lua")
include("core/shared/scale_damage.lua")
include("core/shared/special_actions.lua")

include("core/client/player/_init.lua")
include("core/client/player_actions/_init.lua")
include("core/client/ui/_init.lua")
include("core/client/cl_blinking.lua")
include("core/client/cl_fog.lua")
include("core/client/cl_id.lua")
include("core/client/cl_map_related.lua")
include("core/client/cl_round.lua")
include("core/client/cl_sounds.lua")
include("core/client/cl_time.lua")
include("core/client/cl_networking.lua")
include("core/client/cl_tick.lua")

include("mapconfigs/" .. game.GetMap() .. "/cl_init.lua")

RADIO4SOUNDSHC = {
	{"chatter1", 39},
	{"chatter2", 72},
	{"chatter4", 12},
	{"franklin1", 8},
	{"franklin2", 13},
	{"franklin3", 12},
	{"franklin4", 19},
	{"ohgod", 25}
}
RADIO4SOUNDS = table.Copy(RADIO4SOUNDSHC)

material_173_1 = CreateMaterial("blinkGlow7", "UnlitGeneric", {
	["$basetexture"] = "particle/particle_glow_05",
	["$basetexturetransform"] = "center .5 .5 scale 1 1 rotate 0 translate 0 0",
	["$additive"] = 1,
	["$translucent"] = 1,
	["$vertexcolor"] = 1,
	["$vertexalpha"] = 1,
	["$ignorez"] = 0
})

function GM:ShouldDrawLocalPlayer(ply)
	local wep = ply:GetActiveWeapon()
	if ply:Alive() and IsValid(wep) and wep:GetClass() == "weapon_scp_173_old" then
		return true
	end
	return false
end

function RemovePlayerRadio(ply)
	if ply.channel != nil then
		ply.channel:EnableLooping(false)
		ply.channel:Stop()
		ply.channel = nil
	end
end

print("Gamemode loaded cl_init.lua")