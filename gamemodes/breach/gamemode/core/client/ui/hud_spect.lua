
local sw = 400
local sh = 35

function BR_DrawHudSpect()
    local client = LocalPlayer()
    local obs_target = client:GetObserverTarget()

    if IsValid(obs_target) and obs_target:IsPlayer() then
        local sx =  ScrW() / 2 - (sw / 2)

        draw.RoundedBox(0, sx, 0, sw, sh, Color(15,15,15,200))
        draw.TextShadow({
            text = "Spectating: "..string.sub(obs_target:Nick(), 1, 17),
            pos = {sx + sw / 2, 15},
            font = "HealthAmmo",
            color = Color(255,255,255),
            xalign = TEXT_ALIGN_CENTER,
            yalign = TEXT_ALIGN_CENTER,
       }, 2, 255)
    end
end

print("Gamemode loaded core/client/ui/hud_spect.lua")