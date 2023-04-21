
include("team_strengths.lua")
include("core_preparing.lua")
include("core_round.lua")
include("core_postround.lua")
include("map_related.lua")
include("spawning_items.lua")
include("spawning_support.lua")
include("special_rounds.lua")
include("win_check.lua")
include("tick.lua")
include("time.lua")
include("liveness_score.lua")
include("foundation_announcements.lua")

function PlayCommotionSound()
	if istable(round_commotionsounds) then
		local rnd_sound = TableRandom(round_commotionsounds)
		if isstring(rnd_sound) == false then
			print("Couldnt find a commotion sound, removing the timer.")
			timer.Remove("PlayCommotionSounds")
			return
		end
		--lua_run_cl PlayAmbientSound("breach2/intro/Commotion/Commotion1.ogg", 600, 600)
		--print("playing a commotion sound: " .. rnd_sound)
		BroadcastLua('surface.PlaySound("' .. rnd_sound .. '")')
		--BroadcastLua('PlayAmbientSound("'..rnd_sound..'", 600, 600)')
		table.RemoveByValue(round_commotionsounds, rnd_sound)
		
		timer.Create("PlayCommotionSounds", math.random(8,14), 1, PlayCommotionSound)
	end
end

function CheckStart()
	if ngst > CurTime() then return end
	MINPLAYERS = MINPLAYERS or 2
	
	if gamestarted == false and #GetActivePlayers() >= MINPLAYERS then
		RoundRestart()
	end
	if gamestarted then
		BroadcastLua('gamestarted = true')
	end
end

function RoundRestart()
	Round_PrepStart()
end

function StopRound()
	timer.Stop("PreparingTime")
	timer.Stop("RoundTime")
	timer.Stop("PostTime")
	timer.Stop("GateOpen")
	timer.Stop("PlayerInfo")
	timer.Stop("PlayCommotionSounds")
end

timer.Create("EXPTimer", 120, 0, function()
	for k,v in pairs(player.GetAll()) do
		if IsValid(v) and v.AddExp != nil then
			v:AddExp(100, true)
		end
	end
end)

print("Gamemode loaded core/server/round/_init.lua")