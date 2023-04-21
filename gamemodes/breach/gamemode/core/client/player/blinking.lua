
net.Receive("PlayerBlink", function(len)
	br_next_blink = CurTime() + 0.1
end)

print("Gamemode loaded core/client/player/blinking.lua")