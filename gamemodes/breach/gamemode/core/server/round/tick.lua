
local next_armor_update = 0
hook.Add("Tick", "RoundTick", function()
    HandleNTFSpawns()

    if next_armor_update < CurTime() then
        for k,v in pairs(player.GetAll()) do
            net.Start("BR_ArmorStatus")
                net.WriteBool(v.UsingArmor or false)
            net.Send(v)
        end
        next_armor_update = CurTime() + 1
    end

    WinCheck()
end)

print("Gamemode loaded core/server/round/tick.lua")