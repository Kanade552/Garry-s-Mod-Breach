
local random_announcements = {
    {
        name = "RandomHorror1",
        condition = function() -- 2 minutes after round start
            return (!preparing and !postround)
        end,
        play_once = true,
        initial_delay = function() return math.random(100, 200) end,

        next_use = 0
    },
    {
        name = "Advice",
        condition = function() --  4 minutes after round start, mtfs alive
            return (!preparing and !postround and roundtype.allowntfspawn and ntfs_spawned and (CurTime() - last_ntf_spawn) > 100 and NumberOfNTFs() > 0)
        end,
        play_once = true,
        initial_delay = 30,

        next_use = 0
    }
}

BR_FoundationAnnouncements = {
    NTFSpawned = {"mtf/announc.ogg", 25.5},
    Contained173 = {"mtf/Announc173Contain.ogg", 7.25},

    Advice = {"mtf/announcafter1.ogg", 15.3},
    LiftToGateBLocked = {"mtf/announcafter2.ogg", 18.3},

    CameraScan_Straglers = {"mtf/announccamerafound1.ogg", 11.7},
    CameraScan_1ClassD = {"mtf/announccamerafound2.ogg", 10},
    CameraScan_NoFound = {"mtf/announccameranofound.ogg", 9.7},

    TeslaGate_Disabled = {"mtf/tesla1.ogg", 7},
    TeslaGate_Disabled2 = {"mtf/tesla2.ogg", 7.5},
    TeslaGate_Disabled3 = {"mtf/tesla3.ogg", 8.8},

    RandomHorror1 = {"scripted6.ogg", 12}
}

local foundation_announcements = {}
local next_foundation_announcement = 0

function FoundationAnnouncement(name)
    local tab = BR_FoundationAnnouncements[name]
    if tab then
        NewFoundationAnnouncement(tab[1], tab[2])
    end
end

function NewFoundationAnnouncement(sound_name, duration)
    table.ForceInsert(foundation_announcements, {sound_name, duration})
end

function TestAnnouncements()
    FoundationAnnouncement("Advice")
    NewFoundationAnnouncement("mtf/Announc173Contain.ogg", 7)
    FoundationAnnouncement("CameraScan_NoFound")
end

local next_check = 0
hook.Add("Tick", "BR_FoundationAnnouncements", function()
    if !gamestarted then return end

    if next_foundation_announcement < CurTime() and #foundation_announcements > 0 then
        BroadcastLua('surface.PlaySound("'..foundation_announcements[1][1]..'")')
        next_foundation_announcement = CurTime() + foundation_announcements[1][2] + 3
        table.remove(foundation_announcements, 1)
        
    -- random announcements
    elseif next_check < CurTime() then
        for k,v in pairs(random_announcements) do
            if v.used != true and v.next_use < CurTime() and v.condition() then
                if v.play_once then
                    v.used = true
                end
                if v.play_delay then
                    v.next_use = CurTime() + v.play_delay
                end
                FoundationAnnouncement(v.name)
            end
        end
        next_check = CurTime() + 1
    end
end)

hook.Add("BR_RoundPreparing", "BR_ResetRandomFoundationAnnouncements", function()
    next_check = CurTime() + 5

    for k,v in pairs(random_announcements) do
        v.used = false
        local delay = 30

        if isfunction(v.initial_delay) then
            delay = v.initial_delay()

        elseif isnumber(v.initial_delay) then
            delay = v.initial_delay
        end
        v.next_use = CurTime() + delay
    end
end)

print("Gamemode loaded core/server/round/foundation_announcements.lua")
