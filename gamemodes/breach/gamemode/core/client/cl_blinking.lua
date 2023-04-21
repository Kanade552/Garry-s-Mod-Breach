
-- The new blinking system

br_next_blink = 0
br_blink_alpha = 0

local br_next_unblink = 0

local function DrawBlinking()
	local cl1 = br_next_blink - CurTime()
	local cl2 = CurTime() - br_next_unblink

	if cl1 > 0 and cl1 < 0.2 then
		br_blink_alpha = br_blink_alpha + 15

		if br_blink_alpha > 255 then
			br_blink_alpha = 255
			br_next_unblink = CurTime() + cvars.Number("br_time_blink", 0.15)
		end
	elseif cl2 > 0 then
		if cl2 < 0.2 then
			br_blink_alpha = br_blink_alpha - 15
		else
			br_blink_alpha = 0
		end
	end

	if br_blink_alpha > 0 and br_blink_alpha < 256 then
		draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0,0,0,br_blink_alpha))
	end

	--print(br_blink_alpha, cl1, cl2)
end
hook.Add("DrawOverlay", "OverlayBlinking", DrawBlinking)

print("Gamemode loaded core/client/cl_blinking.lua")