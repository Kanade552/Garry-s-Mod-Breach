
hook.Add("OnPlayerChat", "CheckChatFunctions", function(ply, strText, bTeam, bDead)
	if string.lower(strText) == "dropvest" and ply == LocalPlayer() then
		DropCurrentVest()
		return true
	end
end)

print("Gamemode loaded core/client/player_actions/chat_actions.lua")