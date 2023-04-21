
gamestarted = false

net.Receive("UpdateRoundType", function(len)
	gamestarted = true
	roundtype = net.ReadString()
	print("Current roundtype: " .. roundtype)
end)

net.Receive("RolesSelected", function(len)
	draw_end_info_till = CurTime() + 25
end)

net.Receive("PrepStart", function(len)
	chat.AddText(language.preparing)

	drawendmsg = nil
	timefromround = CurTime() + 10

	timer.Destroy("SoundsOnRoundStart")
	timer.Create("SoundsOnRoundStart", 1, 1, SoundsOnRoundStart)

	f_started = false
	RADIO4SOUNDS = table.Copy(RADIO4SOUNDSHC)
	--SAVEDIDS = {}

	hook.Call("BR_RoundPreparing")
end)

net.Receive("RoundStart", function(len)
	chat.AddText(language.round)
	drawendmsg = nil
end)

local function rep_end_text(lang_id, amount)
	local num = 2
	if amount == 1 then
		num = 1
	end
	return string.Replace(language[lang_id][num], "{num}", tostring(amount))
end

endinformation = {}
net.Receive("PostStart", function(len)
	local infos = net.ReadTable()
	local win = net.ReadString()

	print("round end", win)

	endinformation = {
		rep_end_text("lang_pldied", infos.deaths),
		rep_end_text("lang_descaped", infos.descaped),
		rep_end_text("lang_sescaped", infos.sescaped),
		rep_end_text("lang_rescaped", infos.rescaped),
		rep_end_text("lang_dcaptured", infos.dcaptured),
		rep_end_text("lang_rescorted", infos.rescorted),
		rep_end_text("lang_teleported", infos.teleported),
		rep_end_text("lang_snapped", infos.snapped),
		rep_end_text("lang_zombies", infos.zombies)
	}
	
	drawendmsg = win
end)

print("Gamemode loaded core/client/cl_round.lua")