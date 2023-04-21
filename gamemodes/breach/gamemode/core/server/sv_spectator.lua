local meta_player = FindMetaTable("Player")

hook.Add("KeyPress", "keypress_spectating", function(ply, key)
	if ply:Team() != TEAM_SPECTATOR then return end
    
	if key == IN_ATTACK then
		ply:SpectatePlayerLeft()

	elseif key == IN_ATTACK2 then
		ply:SpectatePlayerRight()

	elseif key == IN_RELOAD then
		ply:ChangeSpecMode()
	end
end)

function meta_player:SpectatePlayerRight()
	local spect_mode = self:GetObserverMode()
	if !self:Alive() or (spect_mode != OBS_MODE_IN_EYE and spect_mode != OBS_MODE_CHASE) then return end

	self:SetNoDraw(true)

	local allply = GetAlivePlayers()
	local count = table.Count(allply)
	--if count == 1 then return end

	self.SpecPly = (self.SpecPly or 0) + 1
	if self.SpecPly > count then
		self.SpecPly = 1
	end
	for i=1, count do
		if i == self.SpecPly then
			self:SpectateEntity(allply[i])
		end
	end
end

function meta_player:SpectatePlayerLeft()
	local spect_mode = self:GetObserverMode()
	if !self:Alive() or (spect_mode != OBS_MODE_IN_EYE and spect_mode != OBS_MODE_CHASE) then return end

	self:SetNoDraw(true)

	local allply = GetAlivePlayers()
	local count = table.Count(allply)
	--if count == 1 then return end

	self.SpecPly = (self.SpecPly or 0) - 1
	if self.SpecPly < 1 then
		self.SpecPly = count
	end
	for i=1, count do
		if i == self.SpecPly then
			self:SpectateEntity(allply[i])
		end
	end
end

function meta_player:ChangeSpecMode()
	if !self:Alive() or self:Team() != TEAM_SPECTATOR then return end

	self:SetNoDraw(true)

	local spect_mode = self:GetObserverMode()
	local allply = #GetAlivePlayers()
	if allply < 2 then
		self:Spectate(OBS_MODE_ROAMING)
		return
	end
	
	if spect_mode == OBS_MODE_IN_EYE then
		self:Spectate(OBS_MODE_CHASE)
		self:SpectatePlayerLeft()

	elseif spect_mode == OBS_MODE_CHASE then
		self:Spectate(OBS_MODE_ROAMING)

	elseif spect_mode == OBS_MODE_ROAMING then
		self:Spectate(OBS_MODE_IN_EYE)
		self:SpectatePlayerLeft()
	else
		self:Spectate(OBS_MODE_ROAMING)
	end
end

function meta_player:SetSpectator()
	self:Spectate(OBS_MODE_ROAMING)
	self:SetTeam(TEAM_SPECTATOR)
	self:SetGTeam(TEAM_SPECTATOR)

	self:AllowFlashlight(false)
	if self:FlashlightIsOn() then
		self:Flashlight(false)
	end

	self:StripWeapons()
	self:RemoveAllAmmo()

	self:SetNClass(ROLES.ROLE_SPEC)
	self:SetNoDraw(true)
	self:SetNoTarget(true)
	self:UnIgnitePlayer()

	self.Active = true
	self.canblink = false
	self.handsmodel = nil
	self.BaseStats = nil
	self.UsingArmor = nil
	
	UpdatePlayersAllInfo()

	--print("adding " .. self:Nick() .. " to spectators")
end

print("Gamemode loaded core/server/sv_spectator.lua")