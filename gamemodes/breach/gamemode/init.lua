
-- Client files
AddCSLuaFile("shared.lua")
AddCSLuaFile("core/shared/enums.lua")
AddCSLuaFile("core/shared/language.lua")
AddCSLuaFile("core/shared/util.lua")
AddCSLuaFile("core/shared/gteams.lua")
AddCSLuaFile("core/shared/classes.lua")
AddCSLuaFile("core/shared/map_related.lua")
AddCSLuaFile("core/shared/scp173.lua")
AddCSLuaFile("core/shared/player_ext.lua")
AddCSLuaFile("core/shared/scale_damage.lua")
AddCSLuaFile("core/shared/special_actions.lua")

	AddCSLuaFile("core/client/player/blinking.lua")
	AddCSLuaFile("core/client/player/footsteps.lua")
	AddCSLuaFile("core/client/player/information.lua")
	AddCSLuaFile("core/client/player/screen_effects.lua")
	AddCSLuaFile("core/client/player/death.lua")
	AddCSLuaFile("core/client/player/scp_sounds.lua")
AddCSLuaFile("core/client/player/_init.lua")

	AddCSLuaFile("core/client/player_actions/debug.lua")
	AddCSLuaFile("core/client/player_actions/chat_actions.lua")
	AddCSLuaFile("core/client/player_actions/bindings.lua")
	AddCSLuaFile("core/client/player_actions/drop_vest.lua")
	AddCSLuaFile("core/client/player_actions/escorting.lua")
	AddCSLuaFile("core/client/player_actions/request_gate_a.lua")
AddCSLuaFile("core/client/player_actions/_init.lua")

	AddCSLuaFile("core/client/ui/fonts.lua")
	AddCSLuaFile("core/client/ui/halos.lua")
	AddCSLuaFile("core/client/ui/hud_util.lua")
	AddCSLuaFile("core/client/ui/hud_debug.lua")
	AddCSLuaFile("core/client/ui/hud_gasmask.lua")
	AddCSLuaFile("core/client/ui/hud_start.lua")
	AddCSLuaFile("core/client/ui/hud_end.lua")
	AddCSLuaFile("core/client/ui/hud_spect.lua")
	AddCSLuaFile("core/client/ui/hud_alive.lua")
	AddCSLuaFile("core/client/ui/hud.lua")
	AddCSLuaFile("core/client/ui/menu_class.lua")
	AddCSLuaFile("core/client/ui/menu_mtf.lua")
	AddCSLuaFile("core/client/ui/menu_scoreboard.lua")
	AddCSLuaFile("core/client/ui/target_id.lua")
AddCSLuaFile("core/client/ui/_init.lua")

AddCSLuaFile("core/client/cl_blinking.lua")
AddCSLuaFile("core/client/cl_fog.lua")
AddCSLuaFile("core/client/cl_id.lua")
AddCSLuaFile("core/client/cl_map_related.lua")
AddCSLuaFile("core/client/cl_networking.lua")
AddCSLuaFile("core/client/cl_round.lua")
AddCSLuaFile("core/client/cl_sounds.lua")
AddCSLuaFile("core/client/cl_tick.lua")
AddCSLuaFile("core/client/cl_time.lua")
AddCSLuaFile("mapconfigs/" .. game.GetMap() .. "/shared.lua")
AddCSLuaFile("mapconfigs/" .. game.GetMap() .. "/cl_init.lua")

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

-- Server files
include("shared.lua")
include("core/server/sv_cvars.lua")
include("core/server/sv_util.lua")

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


include("core/server/admin/_init.lua")
include("core/server/assigning/_init.lua")
include("core/server/player/_init.lua")
include("core/server/player_actions/_init.lua")
include("core/server/round/_init.lua")

include("core/server/sv_914.lua")
include("core/server/sv_blinking.lua")
include("core/server/sv_commands_override.lua")
include("core/server/sv_contamination.lua")
include("core/server/sv_kill_rewards.lua")
include("core/server/sv_networking.lua")
include("core/server/sv_ragdoll.lua")
include("core/server/sv_resources.lua")
include("core/server/sv_spectator.lua")
include("mapconfigs/" .. game.GetMap() .. "/init.lua")

-- Variables
gamestarted = false
preparing = false
postround = false
roundcount = 0
MAPBUTTONS = table.Copy(BUTTONS)

function GM:ShutDown()
	for k,v in pairs(player.GetAll()) do
		v:SaveExp()
		v:SaveLevel()
	end
end

function GM:OnEntityCreated(ent)
	ent:SetShouldPlayPickupSound(false)
end

function PlayerNTFSound(sound, ply)
	if (ply:GTeam() == TEAM_GUARD or ply:GTeam() == TEAM_CHAOS) and ply:Alive() then
		if ply.lastsound == nil then ply.lastsound = 0 end
		if ply.lastsound > CurTime() then
			ply:PrintMessage(HUD_PRINTTALK, "You must wait " .. math.Round(ply.lastsound - CurTime()) .. " seconds to do this.")
			return
		end
		--ply:EmitSound("Beep.ogg", 500, 100, 1)
		ply.lastsound = CurTime() + 3
		--timer.Create("SoundDelay"..ply:SteamID64() .. "s", 1, 1, function()
			ply:EmitSound(sound, 450, 100, 1)
		--end)
	end
end

print("Gamemode loaded init.lua")