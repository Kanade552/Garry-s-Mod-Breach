
debug_view_enabled = false

concommand.Add("br2_debug_view", function()
    if LocalPlayer():IsSuperAdmin() then
        debug_view_enabled = !debug_view_enabled
    end
end)

print("Gamemode loaded core/client/player_actions/debug.lua")