
util.AddNetworkString("BR_LocalPlayerDied")

local human_death_sounds = {
	Sound("player/death1.wav"),
	Sound("player/death2.wav"),
	Sound("player/death3.wav"),
	Sound("player/death4.wav"),
	Sound("player/death5.wav"),
	Sound("player/death6.wav"),
	Sound("vo/npc/male01/pain07.wav"),
	Sound("vo/npc/male01/pain08.wav"),
	Sound("vo/npc/male01/pain09.wav"),
	Sound("vo/npc/male01/pain04.wav"),
	Sound("vo/npc/Barney/ba_pain06.wav"),
	Sound("vo/npc/Barney/ba_pain07.wav"),
	Sound("vo/npc/Barney/ba_pain09.wav"),
	Sound("vo/npc/Barney/ba_ohshit03.wav"), --heh
	Sound("vo/npc/Barney/ba_no01.wav"),
	Sound("vo/npc/male01/no02.wav"),
	Sound("hostage/hpain/hpain1.wav"),
	Sound("hostage/hpain/hpain2.wav"),
	Sound("hostage/hpain/hpain3.wav"),
	Sound("hostage/hpain/hpain4.wav"),
	Sound("hostage/hpain/hpain5.wav"),
	Sound("hostage/hpain/hpain6.wav")
}

local function new_death_sound(ply, attacker, dmginfo)
	local death_sound = nil
	local nclass = ply:GetNClass()
	if ply:GTeam() == TEAM_SCP then
		if nclass == ROLES.ROLE_SCP173 and IsValid(attacker) and attacker:IsPlayer() and IsPlayerNTF(attacker) then
			NewFoundationAnnouncement("mtf/Announc173Contain.ogg", 7)
		end
	else
		death_sound = TableRandom(human_death_sounds)
	end

	if death_sound then
		ply.IncomingDeathSound = {CurTime() + 2, death_sound}
	end
end

function GM:PlayerDeathSound()
	return true
end

function GM:DoPlayerDeath(ply, attacker, dmginfo)
	new_death_sound(ply, attacker, dmginfo)

	CreatePlayerRagdoll(ply, attacker, dmginfo:GetDamageType())

	ply:AddDeaths(1)

	net.Start("BR_LocalPlayerDied")
	net.Send(ply)

	if ply:FlashlightIsOn() then
		ply:Flashlight(false)
	end

	WinCheck()
end

function GM:PlayerDeathThink(ply)
	if ply:IsFrozen() then ply:Freeze(false) end

	if ply:IsBot()
	or ((ply:KeyPressed(IN_ATTACK) or ply:KeyPressed(IN_ATTACK2) or ply:KeyPressed(IN_JUMP)) and ply.NextSpawnTime < CurTime()) then
		ply:Spawn()
		ply:SetSpectator()
	end
end

function GM:PlayerDeath(victim, inflictor, attacker)
	if victim:HasWeapon("weapon_scp_173") then
		victim:StripWeapon("weapon_scp_173")
	end

	-- death sound

	victim:SetWalkSpeed(200)
	victim:SetRunSpeed(200)
	victim:SetJumpPower(200)
	victim:SetViewEntity(victim)
	
	if victim:IsFrozen() then
		victim:Freeze(false)
	end

	victim.NextSpawnTime = CurTime() + 5

	if attacker:IsPlayer() then
		print("[KILL] " .. attacker:Nick() .. " [" .. attacker:GetNClass() .. "] killed " .. victim:Nick() .. " [" .. victim:GetNClass() .. "]")
	end

	victim:SetNClass(ROLES.ROLE_SPEC)

	if attacker != victim and postround == false and attacker:IsPlayer() then
        local reward_tab = kill_rewards[attacker:GTeam()]
        if reward_tab then
            victim:PrintMessage(HUD_PRINTTALK, reward_tab["death_msg"] .. attacker:Nick())
			local reward_info_tab = reward_tab["rewards"]
            if istable(reward_info_tab) then
				reward_info_tab = reward_info_tab[victim:GTeam()]
                attacker:PrintMessage(HUD_PRINTTALK, reward_info_tab["msg"])
                attacker:AddFrags(reward_info_tab["points"])
            else
                attacker:PrintMessage(HUD_PRINTTALK, reward_tab["msg"])
                attacker:AddFrags(reward_tab["points"])
            end
        end
	end

	if roundstats then
		roundstats.deaths = roundstats.deaths + 1
	end
	victim:SetTeam(TEAM_SPECTATOR)
	--victim:UnUseArmor()
    
	if table.Count(victim:GetWeapons()) > 0 then
		for k,v in pairs(victim:GetWeapons()) do
			if v.droppable then
				local wep = ents.Create(v:GetClass())
				if IsValid(wep) then
					wep:SetPos(victim:GetPos())
					wep:Spawn()
                    
					if v:GetPrimaryAmmoType() > 0 then
						wep.SavedAmmo = v:Clip1()
					end
				end
			end
		end
	end
end

print("Gamemode loaded core/server/player/death.lua")