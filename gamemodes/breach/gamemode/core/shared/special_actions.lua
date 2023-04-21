
SPECIAL_ACTIONS = {
    {
        text = "Request Gate A Open",
        concommand = "br_sa_mtf_request_gatea_open",
        cl_action = function()
            net.Start("RequestGateA")
            net.SendToServer()
        end,
        sv_action = function(ply)
        end,
        condition = function(ply) return ply:CLevelGlobal() >= 4 and (ply:GTeam() == TEAM_GUARD or ply:GTeam() == TEAM_CHAOS) end
    },
    {
        text = "Close Gate B",
        concommand = "br_sa_mtf_request_gateb_close",
        cl_action = function() end,
        sv_action = function(ply) end,
        condition = function(ply) return ply:CLevelGlobal() >= 4 end
    },
    
    {
        group = "sa_mtf_other",
        text = "Request Escorting",
        concommand = "br_sa_mtf_request_escorting",
        cl_action = function()
            net.Start("RequestEscorting")
            net.SendToServer()
        end,
        sv_action = function(ply)
        end,
        condition = function(ply) return ply:CLevelGlobal() >= 3 and (ply:GTeam() == TEAM_GUARD or ply:GTeam() == TEAM_CHAOS) end
    },
}

SPECIAL_ACTIONS_SOUNDS = {
    br_sa_mtf_sound_lost = {
        {"sa_sounds/mtf/targetlost1.ogg", 4.1},
        {"sa_sounds/mtf/targetlost2.ogg", 4.28},
        {"sa_sounds/mtf/targetlost3.ogg", 6.4}
    },
    br_sa_mtf_sound_terminated = {
        {"sa_sounds/mtf/targetterminated1.ogg", 2.7},
        {"sa_sounds/mtf/targetterminated2.ogg", 2.5},
        {"sa_sounds/mtf/targetterminated3.ogg", 4.7},
        {"sa_sounds/mtf/targetterminated4.ogg", 4.8}
    },
    br_sa_mtf_sound_stop = {
        {"sa_sounds/mtf/stop2.ogg", 1},
        {"sa_sounds/mtf/stop3.ogg", 1},
        {"sa_sounds/mtf/stop4.ogg", 1.15},
        {"sa_sounds/mtf/stop5.ogg", 1.4},
        {"sa_sounds/mtf/stop6.ogg", 1}
    },
    br_sa_mtf_sound_classd = {
        {"sa_sounds/mtf/classd1.ogg", 2.5},
        {"sa_sounds/mtf/classd2.ogg", 4.15},
        {"sa_sounds/mtf/classd3.ogg", 4},
        {"sa_sounds/mtf/classd4.ogg", 3}
    },
    br_sa_mtf_sound_searching = {
        {"sa_sounds/mtf/searching1.ogg", 1.5},
        {"sa_sounds/mtf/searching2.ogg", 1.5},
        {"sa_sounds/mtf/searching3.ogg", 2.2},
        {"sa_sounds/mtf/searching4.ogg", 1},
        {"sa_sounds/mtf/searching5.ogg", 1.5},
        {"sa_sounds/mtf/searching6.ogg", 1.8}
    },
    br_sa_mtf_sound_random = {
        {"sa_sounds/mtf/random1.ogg", 7.5},
        {"sa_sounds/mtf/random2.ogg", 5.3},
        {"sa_sounds/mtf/random3.ogg", 4.6},
        {"sa_sounds/mtf/random4.ogg", 5}
    },
    br_sa_mtf_sound_radiobeep = {
        {"sa_sounds/mtf/beep.ogg", 1}
    },
    br_sa_mtf_sound_spotted049 = {
        {"sa_sounds/mtf/spotted_049_1.ogg", 3.9},
        {"sa_sounds/mtf/spotted_049_2.ogg", 3.7},
        {"sa_sounds/mtf/spotted_049_3.ogg", 3.9},
        {"sa_sounds/mtf/spotted_049_4.ogg", 3.5},
        {"sa_sounds/mtf/spotted_049_5.ogg", 1.7}
    },
    br_sa_mtf_sound_spotted106 = {
        {"sa_sounds/mtf/spotted_106_1.ogg", 3.2},
        {"sa_sounds/mtf/spotted_106_2.ogg", 3.7},
        {"sa_sounds/mtf/spotted_106_3.ogg", 3.7}
    },
    br_sa_mtf_sound_spotted173 = {
        {"sa_sounds/mtf/spotted_173_1.ogg", 2.4},
        {"sa_sounds/mtf/spotted_173_2.ogg", 2}
    },
    br_sa_mtf_sound_scp0492_spotted = {
        {"sa_sounds/mtf/player0492_1.ogg", 5}
    },
    br_sa_mtf_sound_scp0492_terminated = {
        {"sa_sounds/mtf/player0492_2.ogg", 4}
    },

    br_sa_scp049_spotted = {
        {"sa_sounds/scp049/spotted1.ogg", 4},
        {"sa_sounds/scp049/spotted2.ogg", 2.2},
        {"sa_sounds/scp049/spotted3.ogg", 2.1},
        {"sa_sounds/scp049/spotted4.ogg", 3.7},
        {"sa_sounds/scp049/spotted5.ogg", 1.7},
        {"sa_sounds/scp049/spotted6.ogg", 1.4},
        {"sa_sounds/scp049/spotted7.ogg", 1.6},
        {"sa_sounds/scp049/spotted8.ogg", 4.8}
    },
    br_sa_scp049_searching = {
        {"sa_sounds/scp049/searching1.ogg", 2.2},
        {"sa_sounds/scp049/searching2.ogg", 4},
        {"sa_sounds/scp049/searching3.ogg", 2},
        {"sa_sounds/scp049/searching4.ogg", 5.7},
        {"sa_sounds/scp049/searching5.ogg", 3.5},
        {"sa_sounds/scp049/searching6.ogg", 2.5},
        {"sa_sounds/scp049/searching7.ogg", 12.9}
    },
    br_sa_scp049_disease = {
        {"sa_sounds/scp049/disease1.ogg", 9.3},
        {"sa_sounds/scp049/disease2.ogg", 6},
    },
    br_sa_scp049_cure_most_effective = {
        {"sa_sounds/scp049/cure_most_effective.ogg", 4.8},
    },
    br_sa_scp049_stop_resisting = {
        {"sa_sounds/scp049/stop_resisting.ogg", 3.7},
    }
}

function FindSpecialAction(cc)
    for k,v in pairs(SPECIAL_ACTIONS) do
        if v.concommand == cc then
            return v
        end
    end
    return nil
end

if SERVER then
    util.AddNetworkString("br_sa_action")

    net.Receive("br_sa_action", function(len, ply)
        local cc = net.ReadString()
        local sa = FindSpecialAction(cc)
        if sa and sa.condition(ply) then
            sa.sv_action(ply)
        end
    end)
end

local function special_action_sound(ply, cc_name)
    if SPECIAL_ACTIONS_SOUNDS[cc_name] then
        local sas = table.Copy(SPECIAL_ACTIONS_SOUNDS[cc_name])
        -- dont play the same sound over and over
        if ply.last_sa_sound and #sas > 1 then
            for i,v in ipairs(sas) do
                if v[1] == ply.last_sa_sound[1] then
                    table.remove(sas, i)
                    break
                end
            end
            table.RemoveByValue(sas, ply.last_sa_sound)
        end
        local snd_table = TableRandom(sas)
        ply.last_sa_sound = snd_table

        if ply.next_sa_sound < CurTime() then
            ply:EmitSound(snd_table[1], 450, 100, 1)
            ply.next_sa_sound = CurTime() + snd_table[2] + 0.8
            net.Start("br_sa_action")
                net.WriteInt(snd_table[2], 16)
            net.Send(ply)
        end
    end
end

local function add_sa_sound(group, name, cc_name, cond)
    table.ForceInsert(SPECIAL_ACTIONS, {
        group = group,
        text = name,
        concommand = cc_name,
        cl_action = function() end,
        sv_action = function(ply)
            special_action_sound(ply, cc_name)
        end,
        condition = cond
    })
end

sa_group_names = {
    sa_mtf_sound_generic = "Sounds - Generic",
    sa_mtf_sound_scp = "Sounds - SCP",
    sa_mtf_other = "Other"
}

local function add_team_sound(group, name, cc_name, teams)
    add_sa_sound(group, name, cc_name, function(ply) return ply:CLevelGlobal() >= 2 and table.HasValue(teams, ply:GTeam()) end)
end
add_team_sound("sa_mtf_sound_generic", "Sound: Target Lost",        "br_sa_mtf_sound_lost",                 {TEAM_GUARD})
add_team_sound("sa_mtf_sound_generic", "Sound: Stop!",              "br_sa_mtf_sound_stop",                 {TEAM_GUARD})
add_team_sound("sa_mtf_sound_generic", "Sound: Class D Found",      "br_sa_mtf_sound_classd",               {TEAM_GUARD})
add_team_sound("sa_mtf_sound_generic", "Sound: Searching",          "br_sa_mtf_sound_searching",            {TEAM_GUARD})
add_team_sound("sa_mtf_sound_generic", "Sound: Random",             "br_sa_mtf_sound_random",               {TEAM_GUARD})
add_team_sound("sa_mtf_sound_generic", "Sound: Radio Beep",         "br_sa_mtf_sound_radiobeep",            {TEAM_GUARD})
add_team_sound("sa_mtf_sound_scp", "Sound: Spotted 049",            "br_sa_mtf_sound_spotted049",           {TEAM_GUARD})
add_team_sound("sa_mtf_sound_scp", "Sound: Spotted 106",            "br_sa_mtf_sound_spotted106",           {TEAM_GUARD})
add_team_sound("sa_mtf_sound_scp", "Sound: Spotted 173",            "br_sa_mtf_sound_spotted173",           {TEAM_GUARD})
add_team_sound("sa_mtf_sound_scp", "Sound: Spotted 049-2",          "br_sa_mtf_sound_scp0492_spotted",      {TEAM_GUARD})
add_team_sound("sa_mtf_sound_scp", "Sound: Terminated 049-2",       "br_sa_mtf_sound_scp0492_terminated",   {TEAM_GUARD})

add_sa_sound("null", "Sound: Spotted",          "br_sa_scp049_spotted",             function(ply) return ply:GetNClass() == ROLES.ROLE_SCP049 end)
add_sa_sound("null", "Sound: Searching",        "br_sa_scp049_searching",           function(ply) return ply:GetNClass() == ROLES.ROLE_SCP049 end)
add_sa_sound("null", "Sound: Disease",          "br_sa_scp049_disease",             function(ply) return ply:GetNClass() == ROLES.ROLE_SCP049 end)
add_sa_sound("null", "Sound: Cure",             "br_sa_scp049_cure_most_effective", function(ply) return ply:GetNClass() == ROLES.ROLE_SCP049 end)
add_sa_sound("null", "Sound: Stop Resisting",   "br_sa_scp049_stop_resisting",      function(ply) return ply:GetNClass() == ROLES.ROLE_SCP049 end)

/*
add_team_sound("Sound: XXXXX",     "YYYY",                {ZZZZZ})
add_team_sound("Sound: XXXXX",     "YYYY",                {ZZZZZ})
add_team_sound("Sound: XXXXX",     "YYYY",                {ZZZZZ})
add_team_sound("Sound: XXXXX",     "YYYY",                {ZZZZZ})
*/

if CLIENT then
    net.Receive("br_sa_action", function()
        local len = net.ReadInt(16)
        LocalPlayer().next_sa_sound = CurTime() + len + 1
    end)

    for k,v in pairs(SPECIAL_ACTIONS) do
        if v.concommand then
            concommand.Add(v.concommand, function()
                RunSpecialAction(v)
            end)
        end
    end

    function RunSpecialAction(sa)
        if sa.condition(LocalPlayer()) then
            sa.cl_action()
            if isfunction(sa.sv_action) then
                net.Start("br_sa_action")
                    net.WriteString(sa.concommand)
                net.SendToServer()
            end
        end
    end
end

print("Gamemode loaded core/shared/special_actions.lua")