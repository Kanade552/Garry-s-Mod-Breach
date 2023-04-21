
local nextTimeUpdate = 0

function BR_RoundTimeLeft()
	return round_end_timestamp - CurTime()
end

function BR_RoundTimePercLeft()
	return BR_RoundTimeLeft() / round_duration
end

function BR_TimeLeft()
    if timer.Exists("PreparingTime") then
        return timer.TimeLeft("PreparingTime")

    elseif timer.Exists("RoundTime") then
        return timer.TimeLeft("RoundTime")

    elseif timer.Exists("PostTime") then
        return timer.TimeLeft("PostTime")
	end
    return 0
end

function BR_TimeUpdating()
	if nextTimeUpdate < CurTime() then
		local time_left = BR_TimeLeft()
		if time_left == nil then return end
		net.Start("UpdateTime")
			net.WriteInt(time_left, 16)
			net.WriteBool(preparing)
			net.WriteBool(postround)
			net.WriteBool(gamestarted)
		net.Broadcast()
		nextTimeUpdate = CurTime() + 1
	end
end
hook.Add("Tick", "BR_Hook_TimeUpdating", BR_TimeUpdating)

print("Gamemode loaded core/server/round/time.lua")