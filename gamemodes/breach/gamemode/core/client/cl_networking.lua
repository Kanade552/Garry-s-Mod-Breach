
net.Receive("BR_ArmorStatus", function(len)
	local status = net.ReadBool()
	LocalPlayer().UsingArmor = status
end)

last_capture_by_106 = 0
net.Receive("CapturedBy106", function(len)
	surface.PlaySound("PocketDimension/Enter.ogg")
	last_capture_by_106 = CurTime()
end)

local smokeparticles = {
	Model("particle/particle_smokegrenade"),
	Model("particle/particle_noisesphere")
}

net.Receive("BR_CreateSmoke", function(len)
	local smoke_pos = net.ReadVector()
	local smoke_time = net.ReadInt(16)
	local em = ParticleEmitter(smoke_pos)

	for i=1, 20 do
		--local prpos = VectorRand() * 300
		--prpos.z = prpos.z + 32
		local p = em:Add(TableRandom(smokeparticles), smoke_pos)
		if p then
			local gray = 10
			p:SetColor(gray, gray, gray)
			p:SetStartAlpha(255)
			p:SetEndAlpha(200)
			p:SetVelocity(VectorRand() * math.Rand(900, 1300))
			p:SetLifeTime(0)

			p:SetDieTime(smoke_time)

			p:SetStartSize(40)
			p:SetEndSize(8)
			p:SetRoll(math.random(-180, 180))
			p:SetRollDelta(math.Rand(-0.1, 0.1))
			p:SetAirResistance(600)

			p:SetCollide(true)
			p:SetBounce(0.4)

			p:SetLighting(false)
		end
	end

	em:Finish()
end)

timefromround = 0
net.Receive("OnEscaped", function(len)
	local nri = net.ReadInt(4)
	shoulddrawescape = nri
	esctime = CurTime() - timefromround
	lastescapegot = CurTime() + 20
	StartEndSound()
	--SlowFadeBlink(5)
end)

/*
EntsToHighlight = {{}, 0}
net.Receive("173HLentities", function(len)
	EntsToHighlight = {
		{net.ReadEntity()},
		CurTime()
	}
	PrintTable(EntsToHighlight)
end)
*/

print("Gamemode loaded core/client/cl_networking.lua")