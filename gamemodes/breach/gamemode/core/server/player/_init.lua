
include("information.lua")
include("allows.lua")
include("can_see_chat.lua")
include("death.lua")
include("extensions.lua")
include("pickups.lua")
include("spawn.lua")
include("tick.lua")
include("use.lua")
include("leveling.lua")

function GM:GetFallDamage(ply, speed)
	return (speed / 5)
end

function GM:PlayerDisconnected(ply)
	if (player.GetCount() - 1) < MINPLAYERS then
		BroadcastLua('gamestarted = false')
		gamestarted = false
	end

	ply:SaveExp()
	ply:SaveLevel()
	WinCheck()
end

print("Gamemode loaded core/server/player/_init.lua")