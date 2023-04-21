
local next_heart_beat_sound = 0
local function HeartBeatSounds()
    if next_heart_beat_sound > CurTime() then return end
    next_heart_beat_sound = CurTime() + 2.5

    local client = LocalPlayer()
	if client:Alive() and !client:IsSpectator() and client:Health() < 21 then
		client:EmitSound("heartbeat.ogg")
	end
end

next_966_check = 0

local function check_966(client)
    local nvg = client:GetWeapon("item_nvg")
    local has_nvg = (nvg:IsValid() and nvg.NVGenabled)
    local is_scp = client:GTeam() == TEAM_SCP

    for k,v in pairs(player.GetAll()) do
        if v:HasWeapon("weapon_scp_966") then
            v:SetNoDraw(!has_nvg and v != LocalPlayer() and !is_scp)
        end
    end
    next_966_check = CurTime() + 5
end

local function ClientTick()
    local client = LocalPlayer()
    if !client or !client.Alive then return end

    if next_966_check < CurTime() then
        check_966(client)
    end

    HeartBeatSounds()
end
hook.Add("Tick", "client_tick_hook", ClientTick)

print("Gamemode loaded core/client/cl_tick.lua")