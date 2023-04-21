
SCPS = {
	{
        name = "SCP-173",
        func = function(ply)
            ply:SetSCP173()
        end
   },
	{
        name = "SCP-049",
        func = function(ply)
            ply:SetSCP049()
        end
   },
	{
        name = "SCP-106",
        func = function(ply)
            ply:SetSCP106()
        end
   },
	{
        name = "SCP-457",
        func = function(ply)
            ply:SetSCP457()
        end
   },
	{
		name = "SCP-966",
        func = function(ply)
            ply:SetSCP966()
        end
   }
}

local meta_player = FindMetaTable("Player")

function meta_player:SetupSCP(spawn_player)
	self:Flashlight(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
    if spawn_player then
	    self:Spawn()
        self:StripWeapons()
        self:RemoveAllAmmo()
    end

	--self:SetTeam(TEAM_SCP)
	self:SetGTeam(TEAM_SCP)
	self.WasTeam = TEAM_SCP

	self:SetArmor(0)
	self.cant_drop_armor = true

	self:SetupHands()
	self:SetNoDraw(false)
	self:AllowFlashlight(false)
	self:SetNoTarget(true)

	self.canblink = false
	self.BaseStats = nil
	self.UsingArmor = nil
	self.Active = true
end

function meta_player:SetSCP173()
    self:SetupSCP(true)

	self:SetNClass(ROLES.ROLE_SCP173)
	self:SetModel("models/breach173.mdl")
	self:SetHealth(5000)
	self:SetMaxHealth(5000)

	self:SetJumpPower(1)
	self:SetBloodColor(DONT_BLEED)
	
	--if IsValid(self.entity173) then
	--	self.entity173:Remove()
	--end
	
	if ShouldUseOld173() then
		self:Give("weapon_scp_173_old")
		self:SelectWeapon("weapon_scp_173_old")
		self:SetWalkSpeed(500)
		self:SetRunSpeed(500)
		self:SetMaxSpeed(500)
		self:SetMoveType(MOVETYPE_WALK)

		self:SetPos(SPAWN_173)
	else
		self:Give("weapon_scp_173")
		self:SelectWeapon("weapon_scp_173")
		self:SetWalkSpeed(1)
		self:SetRunSpeed(1)
		self:SetMaxSpeed(1)
		self:SetMoveType(MOVETYPE_NOCLIP)
	end
end

function meta_player:SetSCP106()
    self:SetupSCP(true)

	self:SetPos(SPAWN_106)

	self:SetNClass(ROLES.ROLE_SCP106)
	self:SetModel("models/vinrax/player/scp106_player.mdl")
	self:SetHealth(2500)
	self:SetMaxHealth(2500)

	self:SetWalkSpeed(180)
	self:SetRunSpeed(180)
	self:SetMaxSpeed(180)
	self:SetJumpPower(170)

	self:Give("weapon_scp_106")
	self:SelectWeapon("weapon_scp_106")
end

function meta_player:SetSCP049()
    self:SetupSCP(true)

	self:SetPos(SPAWN_049)
	self:SetNClass(ROLES.ROLE_SCP049)
	self:SetModel("models/vinrax/player/scp049_player.mdl")

	self:SetHealth(1650)
	self:SetMaxHealth(1650)

	self:SetWalkSpeed(180)
	self:SetRunSpeed(180)
	self:SetMaxSpeed(180)
	self:SetJumpPower(200)

	self:Give("weapon_scp_049")
	self:SelectWeapon("weapon_scp_049")
end

function meta_player:SetSCP457()
    self:SetupSCP(true)

	self:SetPos(SPAWN_457)
	self:SetNClass(ROLES.ROLE_SCP457)
	self:SetModel("models/player/corpse1.mdl")
	--self:SetMaterial("models/flesh", false)

	self:SetHealth(2200)
	self:SetMaxHealth(2200)

	self:SetWalkSpeed(180)
	self:SetRunSpeed(180)
	self:SetMaxSpeed(180)
	self:SetJumpPower(195)

	self:Give("weapon_scp_457")
	self:SelectWeapon("weapon_scp_457")
	
	self:IgnitePlayer()
end

function meta_player:SetSCP966()
    self:SetupSCP(true)

	self:SetPos(TableRandom(SPAWN_966))
	self:SetNClass(ROLES.ROLE_SCP966)
	self:SetModel("models/player/mishka/966_new.mdl")
	--self:SetMaterial("966black/966black", false)
	self:SetHealth(850)
	self:SetMaxHealth(850)
	
	self:SetWalkSpeed(170)
	self:SetRunSpeed(170)
	self:SetMaxSpeed(170)
	self:SetJumpPower(200)
	
	self:Give("weapon_scp_966")
	self:SelectWeapon("weapon_scp_966")

	self:SetNoDraw(true)
end

local zombie_infection_sounds = {
	"npc/zombie/zo_attack1.wav",
	"npc/zombie/zombie_pain2.wav",
	"npc/zombie/zombie_pain3.wav",
	"npc/zombie/zombie_pain4.wav",
	"npc/zombie/zombie_pain5.wav",
}

function meta_player:SetSCP0082()
    self:SetupSCP(false)

	self:SetModel("models/player/zombie_classic.mdl")
	self:SetHealth(850)
	self:SetMaxHealth(850)
	
	self:SetWalkSpeed(170)
	self:SetRunSpeed(170)
	self:SetMaxSpeed(170)
	self:SetJumpPower(200)
	self:SetNClass(ROLES.ROLE_SCP0082)

	WinCheck()

	net.Start("RolesSelected")
	net.Send(self)

	UpdatePlayersAllInfo()

	if table.Count(self:GetWeapons()) > 0 then
		local pos = self:GetPos()
		for k,v in pairs(self:GetWeapons()) do
			if v.droppable then
				self:DropWeapon(v, nil, Vector(0,0,0))
			end
		end
	end

	self:EmitSound(TableRandom(zombie_infection_sounds))

	self:Give("weapon_br_zombie_infect")
	self:SelectWeapon("weapon_br_zombie_infect")
end

function meta_player:SetSCP0492()
    self:SetupSCP(false)

	self:SetModel("models/player/zombie_classic.mdl")

	local hzom = math.Clamp(1000 - (#player.GetAll() * 14), 300, 800)
	self:SetHealth(hzom)
	self:SetMaxHealth(hzom)
	
	self:SetWalkSpeed(170)
	self:SetRunSpeed(170)
	self:SetMaxSpeed(170)
	self:SetJumpPower(200)

	self:SetNClass(ROLES.ROLE_SCP0492)

	WinCheck()

	net.Start("RolesSelected")
	net.Send(self)

	UpdatePlayersAllInfo()

	if table.Count(self:GetWeapons()) > 0 then
		local pos = self:GetPos()
		for k,v in pairs(self:GetWeapons()) do
			if v.droppable then
				self:DropWeapon(v, nil, Vector(0,0,0))
			end
		end
	end

	self:EmitSound(TableRandom(zombie_infection_sounds))

	self:Give("weapon_br_zombie")
	self:SelectWeapon("weapon_br_zombie")
end

local function is_valid_scp_target(ent)
	return (IsValid(ent) and (ent:GetClass() == "func_breakable" or (ent:IsPlayer() and ent:Alive() and !ent:IsSpectator() and ent:GTeam() != TEAM_SCP)))
end

function GetSCPAttackTraceEnt(ply, range)
	local tr_tab = {
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + (ply:GetAimVector() * range),
		filter = ply,
		mask = MASK_SHOT
	}
	local tr1 = util.TraceLine(tr_tab)
	tr_tab.mins = Vector(-10, -10, -10)
	tr_tab.maxs = Vector(10, 10, 10)
	tr_tab.mask = MASK_SHOT_HULL
	local tr2 = util.TraceHull(tr_tab)

	if is_valid_scp_target(tr1.Entity) then
		return tr1.Entity
		
	elseif is_valid_scp_target(tr2.Entity) then
		return tr2.Entity
	else
		return NULL
	end
end

print("Gamemode loaded core/server/sv_scps.lua")