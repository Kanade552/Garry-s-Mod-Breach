local meta_player = FindMetaTable("Player")

function meta_player:Cough()
	if self.NextCough < CurTime() then
		self.LastCough = self.LastCough + 1
		if self.LastCough > 3 then self.LastCough = 1 end
		self:EmitSound("d9341/Cough"..self.LastCough..".ogg")
		--self.targetForSCPs = CurTime()
		self:SetNWFloat("targetForSCPs", CurTime())
		self.NextCough = CurTime() + 3
	end
end

function meta_player:GasmaskBreathe()
	if self.NextBreathe < CurTime() then
		self.LastBreathe = self.LastBreathe + 1
		if self.LastBreathe > 3 then self.LastBreathe = 1 end
		self:EmitSound("d9341/breath"..self.LastBreathe.."gas.ogg")
		self.NextBreathe = CurTime() + 2
	end
end

function meta_player:SetNClass(nclass)
	self.br_class = nclass
end

function meta_player:SetNEXP(nexp)
	return self:SetNWInt("NEXP", nexp)
end

function meta_player:SetNLevel(nlevel)
	return self:SetNWInt("NLevel", nlevel)
end

function meta_player:IgnitePlayer()
	if IsEntity(self.fire) then
		if IsValid(self.fire) then
			self.fire:Remove()
		end
	end
	self.fire = ents.Create("env_fire")
	if !self.fire or !self.fire:IsValid() then return false end

	self.fire:SetPos(self:GetPos())
	self.fire:SetKeyValue("health", "512")
	self.fire:SetKeyValue("firesize", "128")
	self.fire:SetKeyValue("fireattack", "0")
	self.fire:SetKeyValue("damagescale", "-1")
	self.fire:SetKeyValue("ignitionpoint", "1200")
	self.fire:Spawn()
	self.fire:Activate()
	self.fire:Fire("StartFire","",0)
	self.fire:SetParent(self)
end

function meta_player:UnIgnitePlayer()
	if IsEntity(self.fire) then
		if IsValid(self.fire) then
			self.fire:Remove()
		end
	end
end

function meta_player:DropWep(class, clip)
	local wep = ents.Create(class)
	if IsValid(wep) then
		wep:SetPos(self:GetPos())
		wep:Spawn()
		if isnumber(clip) then
			wep:SetClip1(clip)
		end
	end
end

function meta_player:FindClosest(tab, num)
	local allradiuses = {}
	for k,v in pairs(tab) do
		table.ForceInsert(allradiuses, {v:Distance(self:GetPos()), v})
	end
	table.sort(allradiuses, function(a, b) return a[1] < b[1] end)
	local rtab = {}
	for i=1, num do
		if i <= #allradiuses then
			table.ForceInsert(rtab, allradiuses[i])
		end
	end
	return rtab
end

function meta_player:GiveRandomWep(tab)
	local mainwep = TableRandom(tab)
	self:Give(mainwep)
	local getwep = self:GetWeapon(mainwep)
	if getwep.Primary == nil then
		print("ERROR: weapon: " .. mainwep)
		print(getwep)
		return
	end
	getwep:SetClip1(getwep.Primary.ClipSize)
	self:SelectWeapon(mainwep)
	self:GiveAmmo((getwep.Primary.ClipSize * 4), getwep.Primary.Ammo, false)
end

function meta_player:DeleteItems()
	for k,v in pairs(ents.FindInSphere(self:GetPos(), 150)) do
		if v:IsWeapon() and !IsValid(v.Owner) then
			v:Remove()
		end
	end
end

function meta_player:HandleSpeeds()
	local walk_speed = self.br_walk_speed
	local run_speed = self.br_run_speed
	local jump_power = self.br_jump_power

	local global_mul = 1

	-- armor speed decrease
	if self.UsingArmor then
		global_mul = 0.85
	end
	if self.slowdown966 > CurTime() then
		global_mul = global_mul * self.slowdown966a
	end

	self:SetWalkSpeed(walk_speed * global_mul)
	self:SetRunSpeed(run_speed * global_mul)
	self:SetJumpPower(jump_power * global_mul)
end

function meta_player:ApplyNewSpeeds(walk, run, jump)
	self.br_walk_speed = walk
	self.br_run_speed = run
	self.br_jump_power = jump
end

util.AddNetworkString("BR_ArmorStatus")
function meta_player:ApplyArmor(name)
	self.UsingArmor = name
	net.Start("BR_ArmorStatus")
		net.WriteBool(true)
	net.Send(self)
end

function meta_player:UnUseArmor()
	if self.UsingArmor == nil then return end

	local item = ents.Create(self.UsingArmor)
	if IsValid(item) then
		item:Spawn()
		item:SetPos(self:GetPos())
		self:EmitSound(Sound("npc/combine_soldier/zipline_clothing".. math.random(1, 2).. ".wav"))
	end

	net.Start("BR_ArmorStatus")
		net.WriteBool(false)
	net.Send(self)

	self.UsingArmor = nil
end

function meta_player:IsActivePlayer()
	return self.Active
end

function meta_player:SetRoleName(name)
	local rl = nil
	for k,v in pairs(ALLCLASSES) do
		for _,role in pairs(v.roles) do
			if role.name == name then
				rl = role
			end
		end
	end
	if rl != nil then
		self:ApplyRoleStats(rl)
	end
end

print("Gamemode loaded core/server/player/extensions.lua")