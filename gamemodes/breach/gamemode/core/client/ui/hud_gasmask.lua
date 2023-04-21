
local mat_gasmask = Material("breach/gasmask_overlay.png")
local mask_brightness = 100

function BR_DrawHudGasmask()
    local client = LocalPlayer()
    local wep = client:GetWeapon("item_gasmask")
    
    if IsValid(wep) and wep.GasMaskOn then
        surface.SetDrawColor(mask_brightness, mask_brightness, mask_brightness, 255)
        surface.SetMaterial(mat_gasmask)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    end
end

print("Gamemode loaded core/client/ui/hud_gasmask.lua")