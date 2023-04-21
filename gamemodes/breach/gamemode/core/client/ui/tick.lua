
hook.Add("Tick", "BR_CLIENT_UI_TICK", function()
	local hide = true
	if LocalPlayer().GTeam == nil then return end
	if LocalPlayer():GTeam() == TEAM_SCP then
		hide = false
	end
	for k,v in pairs(LocalPlayer():GetWeapons()) do
		if istable(v.NVG) then
			if v.NVGenabled then
				hide = false
			end
		end
	end
	for k,v in pairs(player.GetAll()) do
		if v.GetNClass == nil then return end
		if v:GetNClass() == ROLES.ROLE_SCP966 then
			v:SetNoDraw(hide)
		end
	end
end)

print("Gamemode loaded core/client/ui/tick.lua")