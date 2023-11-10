
local meta_player = FindMetaTable("Player")

function meta_player:SetupNormal()
    self:SetMoveType(MOVETYPE_WALK)
	self:UnSpectate()
	self:Spawn()

	self:GodDisable()
	self:SetNoDraw(false)
	self:SetNoTarget(false)

	self:SetupHands()

	self:RemoveAllAmmo()
	self:StripWeapons()

	self:UnIgnitePlayer()
	self:SetBloodColor(BLOOD_COLOR_RED)

	self.BaseStats = nil
	self.UsingArmor = nil
	self.canblink = true
	self.cant_drop_armor = false

	self:SetMaxSpeed(300)
end

function meta_player:ApplyRoleStats(role)
	self:SetNClass(role.name)
	self:SetGTeam(role.team)
	self.br_faketeam = role.disguised_team
	self.br_fakeclass = role.disguised_name

	self.cant_drop_armor = role.cant_drop_armor or false

	for k,v in pairs(role.weapons) do
		self:Give(v)
	end

	if istable(role.ammo) then
		for k,v in pairs(role.ammo) do
			self:GiveAmmo(v[2],v[1], false)
		end
	end

	self:SetHealth(role.health)
	self:SetMaxHealth(role.health)

	self:ApplyNewSpeeds(100 * role.walkspeed, 210 * role.runspeed, 180 * role.jumppower)
	
	if istable(role.models) then
		self:SetModel(TableRandom(role.models))
	elseif isstring(role.models) then
		self:SetModel(role.models)
	end

	self:Flashlight(false)
	self:AllowFlashlight(role.flashlight)

	if isstring(role.vest) then
		self:ApplyArmor(role.vest)
	end
	if istable(role.pmcolor) then
		self:SetPlayerColor(Vector(role.pmcolor.r / 255, role.pmcolor.g / 255, role.pmcolor.b / 255))
	end

	net.Start("RolesSelected")
	net.Send(self)

	self:SetupHands()
end

function meta_player:SetSecurityI1()
	local thebestone = nil
	local usechaos = false
	if math.random(1,6) == 6 then usechaos = true end

	for k,v in pairs(ALLCLASSES["security"]["roles"]) do
		if v.importancelevel == 1 then
			local skip = false
			if (usechaos and v.team == TEAM_GUARD) or (!usechaos and v.team == TEAM_CHAOS) then
                continue
            end
            
            local can = true
            if isfunction(v.customcheck) and v.customcheck(self) == false then
                can = false
            end

            local using = 0
            for _,pl in pairs(player.GetAll()) do
                if pl:GetNClass() == v.name then
                    using = using + 1
                end
            end

            if using >= v.max then can = false end
            if can and self:GetLevel() >= v.level then
                if thebestone != nil then
                    if thebestone.sorting < v.sorting then
                        thebestone = v
                    end
                else
                    thebestone = v
                end
            end
		end
	end

	if thebestone == nil then
		thebestone = ALLCLASSES["security"]["roles"][1]
	end
	
	self:SetupNormal()
	self:ApplyRoleStats(thebestone)
end

function meta_player:SetClassD()
	self:SetRoleBestFrom("classds")
end

function meta_player:SetResearcher()
	self:SetRoleBestFrom("research_staff")
end

function meta_player:SetStaff()
	self:SetRoleBestFrom("misc_staff")
end

function meta_player:SetRoleBestFrom(role)
	local thebestone = nil
	for k,v in pairs(ALLCLASSES[role]["roles"]) do
		local can = true
		if v.customcheck != nil and !v.customcheck(self) then
			can = false
		end

		local using = 0
		for _,pl in pairs(player.GetAll()) do
			if pl:GetNClass() == v.name then
				using = using + 1
			end
		end
		if using >= v.max then can = false end
		if can and self:GetLevel() >= v.level then
			if thebestone != nil then
				if thebestone.level < v.level then
					thebestone = v
				end
			else
				thebestone = v
			end
		end
	end
	if thebestone == nil then
		thebestone = ALLCLASSES[role]["roles"][1]
	end

	self:SetupNormal()
	self:ApplyRoleStats(thebestone)
end

print("Gamemode loaded core/server/sv_assign_player_ext.lua")