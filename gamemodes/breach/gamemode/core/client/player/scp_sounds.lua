
local next_check = 0

hook.Add("BR_RoundPreparing", "BR_SCPSoundsRStart", function()
    next_check = CurTime() + 1
    for k,v in pairs(player.GetAll()) do
        if v.scp_sound_started then
            v:StopSound(v.scp_sound_started)
        end
        v.scp_sound_started = false
        v.scp_sound_skip = nil
    end
end)

function CheckSCPSounds()
    local client = LocalPlayer()
    for k,v in pairs(player.GetAll()) do
        local alive = v:Alive() and !v:IsSpectator()


        if isstring(v.scp_sound_started) and (!alive or (v.scp_sound_skip and v.scp_sound_skip < CurTime())) then
            v:StopSound(v.scp_sound_started)
            v.scp_sound_started = false
        end

        if !isstring(v.scp_sound_started) and alive then
            local snd = nil
            local volume = 1
            local pitch = 100
            if v:GetNClass() == ROLES.ROLE_SCP457 then
                snd = "ambient/fire/fire_big_loop1.wav"
                if v == client then volume = 0.2 end
            end

            if v:GetNClass() == ROLES.ROLE_SCP106 then
                if v == client then volume = 0.4 end
                snd = "scps/scp106_breathing.ogg"
                pitch = math.Clamp(100 - (15 * ( 1 - (v:Health() / v:GetMaxHealth()) )), 75, 100)
                v.scp_sound_skip = CurTime() + 4
            end
            if snd then
                v:EmitSound(snd, 70, pitch, volume)
                v.scp_sound_started = snd
            end
        end
    end
end
hook.Add("Tick", "BR_SCPSoundsTick", CheckSCPSounds)

print("Gamemode loaded core/client/player/scp_sounds.lua")
