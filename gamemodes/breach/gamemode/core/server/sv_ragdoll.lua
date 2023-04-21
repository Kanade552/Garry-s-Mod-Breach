
util.AddNetworkString("BR_CorpseInfo")

function CreatePlayerRagdoll(victim, attacker, dmgtype)
	if !IsValid(victim) or victim:IsSpectator() then return end

	local class = "prop_ragdoll"
	local use_173 = (victim:GetNClass() == ROLES.ROLE_SCP173)
	local former_ent = victim
	if use_173 then
		class = "prop_physics"
		if !IsValid(victim.entity173) then return end
		former_ent = victim.entity173
	end

	local rag = ents.Create(class)
	if !IsValid(rag) then return nil end

	rag:SetPos(former_ent:GetPos())
	rag:SetModel(former_ent:GetModel())
	rag:SetAngles(former_ent:GetAngles())
	rag:SetColor(former_ent:GetColor())

	rag:Spawn()
	rag:Activate()
	
	rag.Info = {}
	rag.Info.CorpseID = rag:GetCreationID()
	rag:SetNWInt("CorpseID", rag.Info.CorpseID)
	rag.Info.Victim = victim:Nick()
	rag.Info.NClass = victim:GetNClass()
	rag.Info.DamageType = dmgtype
	rag.Info.Time = CurTime()
	victim.corpse = rag

	if !use_173 then
		local group = COLLISION_GROUP_DEBRIS_TRIGGER
		rag:SetCollisionGroup(group)
		timer.Simple(1, function() if IsValid(rag) then rag:CollisionRulesChanged() end end)
		
		local num = rag:GetPhysicsObjectCount()-1
		local v = victim:GetVelocity() * 0.35
		
		for i=0, num do
			local bone = rag:GetPhysicsObjectNum(i)
			if IsValid(bone) then
				local bp, ba = victim:GetBonePosition(rag:TranslatePhysBoneToBone(i))
				if bp and ba then
					bone:SetPos(bp)
					bone:SetAngles(ba)
				end
				bone:SetVelocity(v * 1.4)
			end
		end
	end

	-- player death sound
	if victim.IncomingDeathSound and victim.IncomingDeathSound[1] > CurTime() then
		rag:EmitSound(victim.IncomingDeathSound[2])
	end

	if postround then return end

	timer.Simple(0.5, function()
		if IsValid(rag) then
			net.Start("BR_CorpseInfo")
				net.WriteEntity(rag)
				net.WriteTable(rag.Info)
			net.Broadcast()
		end
	end)
end

print("Gamemode loaded core/server/sv_ragdoll.lua")