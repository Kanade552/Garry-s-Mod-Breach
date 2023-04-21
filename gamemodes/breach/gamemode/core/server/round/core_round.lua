
function Round_Start()
    print("round: prepinit")

    round_duration = GetRoundTime()
    round_start_timestamp = CurTime()
    round_end_timestamp = CurTime() + round_duration

    preparing = false
    postround = false

    for k,v in pairs(player.GetAll()) do
        v:Freeze(false)
    end

    if roundtype != nil and isfunction(roundtype.onroundstart) then
        roundtype.onroundstart()
    end

    if isfunction(MAP_OnRoundStart) then
        MAP_OnRoundStart()
    end
    
    net.Start("RoundStart")
    net.Broadcast()
    
    next_ntf_spawn_check = GetNextNTFSpawn()
	print("Next NTF spawn in " .. tostring(next_ntf_spawn_check - CurTime()))

    print("round: prepgood")

    timer.Create("RoundTime", round_duration, 1, function()
        Round_Start_PostRound()
    end)
end

print("Gamemode loaded core/server/round/core_round.lua")