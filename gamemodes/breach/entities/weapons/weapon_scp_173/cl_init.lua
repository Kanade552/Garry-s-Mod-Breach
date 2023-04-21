include("shared.lua")

SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_173")
SWEP.BounceWeaponIcon = false

function SWEP:CalcView(ply, pos, ang, fov)
	local newPos = pos
	
	local ent173 = self.Owner:GetNWEntity("entity173")
	if IsValid(ent173) then
		local ent173_pos = ent173:GetPos()
		newPos = Vector(ent173_pos.x, ent173_pos.y, ent173_pos.z + 95)
	end
	
	return newPos, ang, fov
end

/*
function SWEP:CalcView(ply, pos, ang, fov)
	local newPos = pos
	--pos.z = pos.z + 35
	--pos.z = tr_up.HitPos
	local ent173 = self.Owner:GetNWEntity("entity173")
	local ply_pos = LocalPlayer():GetPos()
	local ply_eyepos = LocalPlayer():EyePos()
	local ply_eyeangles = LocalPlayer():EyeAngles()
	local tr_up = util.TraceHull({
		start = ply_pos,
		endpos = ply_pos + Angle(-90,0,0):Forward() * 95,
		filter = {LocalPlayer(), ent173},
		mins = Vector(-10, -10, -10),
		maxs = Vector(10, 10, 10),
		mask = MASK_SOLID
	})
	
	local tr_lf = util.TraceHull({
		start = ply_eyepos,
		endpos = ply_eyepos + ply_eyeangles:Right() * 25,
		filter = {LocalPlayer(), ent173},
		mins = Vector(-10, -10, -10),
		maxs = Vector(10, 10, 10),
		mask = MASK_SOLID
	})
	local tr_fr = util.TraceHull({
		start = tr_lf.HitPos,
		endpos = tr_lf.HitPos - Angle(0,ply_eyeangles.y,0):Forward() * 60,
		filter = {LocalPlayer(), ent173},
		mins = Vector(-10, -10, -10),
		maxs = Vector(10, 10, 10),
		mask = MASK_SOLID
	})
	newPos.z = tr_up.HitPos.z - 5
	--local fr = (LocalPlayer():EyeAngles():Forward() * 75)
	newPos.x = tr_fr.HitPos.x
	newPos.y = tr_fr.HitPos.y
	return newPos, ang, fov
end
*/

local function LookupBindingSafe(str, exact)
	local binding = input.LookupBinding(str, exact)
	if binding == nil then return '"' .. str .. '" not set' end
	return string.upper(binding)
end

function SWEP:DrawHUD()
	if disablehud then return end

	local ent173 = self.Owner:GetNWEntity("entity173")
	if IsValid(ent173) then
		cam.Start3D()
			render.SetColorMaterial()
			
			self.CColor = Color(0,255,25,120)
			local nextpostab = self:TraceNextPos(ent173)
			for k,v in pairs(nextpostab.hits) do
				if v.Hit then
					self.CColor = Color(200,0,0,120)
				end
			end

			/*
			local i = 1
			for k,v in pairs(nextpostab.hits) do
				render.DrawSphere(v.HitPos, 1, 12, 12, Color(255,255,255,255))
				i = i + 1
			end
			
			local num = 60
			for i=1,num do
				render.DrawLine(nextpostab.pos + Angle(0,i*(360/num),0):Forward() * 20, nextpostab.pos + Angle(0,(i+1)*(360/num),0):Forward() * 20, self.CColor, false)
			end
			*/
			
			local ourpos = ent173:GetPos()
			local eyeangles = self.Owner:EyeAngles()
			local tr = util.TraceLine({
				start = Vector(ourpos.x, ourpos.y, ourpos.z + 95),
				endpos = Vector(ourpos.x, ourpos.y, ourpos.z + 95) + eyeangles:Forward() * 4000,
				filter = {self.Owner, ent173},
				mask = MASK_ALL
			})
			
			if self.Owner:KeyDown(IN_SPEED) or self.Owner:KeyDown(IN_FORWARD) then
				render.SetMaterial(material_173_1)
				local dir = vector_up
				if (nextpostab.start.HitPos.z - ourpos.z) > 100 then
					dir = Vector(0,0,-1)
				end
				render.DrawQuadEasy(nextpostab.start.HitPos, dir, 150, 150, self.CColor, 0)
				render.DrawBeam(nextpostab.start.HitPos, nextpostab.start.HitPos + Vector(0, 0, 200), 80, 0.5, 1, self.CColor)
				
				if tr.HitNormal.z == -1 then
					render.DrawQuadEasy(tr.HitPos, Vector(0,0,-1), 150, 150, self.CColor, 0)
					render.DrawBeam(tr.HitPos, tr.HitPos + Vector(0, 0, -200), 80, 0.5, 1, self.CColor)
				end
			end
			/*
			if self.NextPos != nil then
				local ourColor = Color(255,0,0,255)
				render.SetMaterial(material_173_1)
				render.DrawQuadEasy(self.NextPos, vector_up, 150, 150, ourColor, 0)
				render.DrawBeam(self.NextPos, self.NextPos + Vector(0, 0, 200), 80, 0.5, 1, ourColor)
			end
			*/
		cam.End3D()
	end
	
	local actionTexts = {
		{IN_ATTACK, "Breaking windows ("..LookupBindingSafe("+attack", true)..")"},
		{IN_SPEED, "Showing position ("..LookupBindingSafe("+speed", true)..")"},
		{IN_FORWARD, "Moving ("..LookupBindingSafe("+forward", true)..")"},
	}
	
	for i,v in ipairs(actionTexts) do
		local clr = Color(255,0,0)
		if self.Owner:KeyDown(v[1]) then
			clr = Color(0,255,0)
		end
		draw.Text({
			text = v[2],
			pos = {10, (25 * i) - 20},
			font = "173font",
			color = clr,
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_TOP,
		})
	end
	
	local x = ScrW() / 2.0
	local y = ScrH() / 2.0
	
	--surface.SetDrawColor(self.CColor.r, self.CColor.g, self.CColor.b, self.CColor.a)
	surface.SetDrawColor(255, 255, 255, 255)
	draw.NoTexture()
	draw.Circle(x, y, 2, 30, 360)
end

function SWEP:PreDrawHalos()
	local ent173 = self.Owner:GetNWEntity("entity173")
	if IsValid(ent173) then
		local ourpos = ent173:GetPos()
		local eyeangles = self.Owner:EyeAngles()
		local tr_halo = util.TraceLine({
			start = Vector(ourpos.x, ourpos.y, ourpos.z + 95),
			endpos = Vector(ourpos.x, ourpos.y, ourpos.z + 95) + eyeangles:Forward() * 400,
			filter = {self.Owner, ent173},
			mask = MASK_ALL
		})
		local ent = tr_halo.Entity
		local skip_ent = false
		local targets = table.Copy(self.Targets)
		for k,v in pairs(self.Targets) do
			if v == ent then
				skip_ent = true
			end
		end
		if IsValid(ent) then
			--chat.AddText('"' .. tostring(ent:GetClass()) .. '"')
			if ent:IsPlayer() and ent:Alive() and ent:GTeam() != TEAM_SPECTATOR and ent:GTeam() != TEAM_SCP then
				if skip_ent then
					table.RemoveByValue(targets, ent)
					halo.Add({ent}, Color(255,150,0), 5, 5, 5, true, false)
				else
					halo.Add({ent}, Color(255,255,0), 5, 5, 5, true, false)
				end
			end
		end
		
		halo.Add(targets, Color(255,0,0), 5, 5, 5, true, false)
	end
end

