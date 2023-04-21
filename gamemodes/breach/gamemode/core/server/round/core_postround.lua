
function Round_Start_PostRound()
    --PrintMessage(HUD_PRINTTALK, "Time is over, Class Ds and SCPs didn't escape the facility in time. MTF wins!")
    postround = false
    postround = true
    -- send all round info
    
    /*
    net.Start("PostStart")
        net.WriteTable(roundstats)
        net.WriteString("end_time")
    net.Broadcast()
    
    timer.Create("PostTime", GetPostTime(), 1, function()
        RoundRestart()
    end)
    */
end

print("Gamemode loaded core/server/round/core_postround.lua")