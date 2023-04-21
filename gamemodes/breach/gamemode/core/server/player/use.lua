
function CacheButtons()
	local num_cached = 0
	local cbuttons = table.Copy(MAPBUTTONS)

	for k,v in pairs(cbuttons) do
		v.found_entity = false
	end

	for _,ent in pairs(ents.GetAll()) do
		local ent_pos = ent:GetPos()
		for k,button in pairs(cbuttons) do
			local matching_pos = false
			if isstring(button["pos"]) then
				matching_pos = (button["pos"] == ent:GetName())
			elseif istable(button["pos"]) then
				for k2,v in pairs(button["pos"]) do
					if ent_pos == v or ent_pos:Distance(v) < 2 then
						matching_pos = true
					end
				end
			else
				matching_pos = (ent_pos == button["pos"] or ent_pos:Distance(button["pos"]) < 2)
			end

			if matching_pos then
				ent.BreachButton = {}
				ent.BreachButton.usesounds = button["usesounds"]
				ent.BreachButton.customdenymsg = button["customdenymsg"]
				ent.BreachButton.canactivate = button["canactivate"]
				ent.BreachButton.clevel = button["clevel"]
				ent.BreachButton.name = button["name"]
				num_cached = num_cached + 1
				button.found_entity = true
			end
		end
	end

	for k,v in pairs(cbuttons) do
		if v.found_entity == false then
			print("Button was not cached! " .. v.name)
		end
	end
	print("cached "..num_cached.."/"..#MAPBUTTONS.." buttons")
end

/*
function ShouldPlayerUse(ply, ent)
	if !istable(ent.BreachButton) then return false end
	if isfunction(ent.BreachButton.canactivate) and !ent.BreachButton.canactivate(ply, ent) then

	end
end
*/

function ShouldPlayerUse(ply, ent)
	if istable(ent.BreachButton) then
		if ent.BreachButton.canactivate != nil then
			local canactivate = ent.BreachButton.canactivate(ply, ent)
			if canactivate then
				if ent.BreachButton.usesounds then
					ply:EmitSound("KeycardUse1.ogg")
				end
				ply.lastuse = CurTime() + 1
				--ply:PrintMessage(HUD_PRINTCENTER, "Access granted to " .. ent.BreachButton["name"])
				ply:PrintMessage(HUD_PRINTCENTER, "Access granted")
				return true
			else
				if ent.BreachButton.usesounds then
					ply:EmitSound("KeycardUse2.ogg")
				end
				ply.lastuse = CurTime() + 1
				if ent.BreachButton.customdenymsg then
					ply:PrintMessage(HUD_PRINTCENTER, ent.BreachButton.customdenymsg)
				else
					ply:PrintMessage(HUD_PRINTCENTER, "Access denied")
				end
				return false
			end
		end
		if ent.BreachButton.clevel != nil then
			local ply_clevel = ply:CLevel()
			if ply_clevel >= ent.BreachButton.clevel then
				if ent.BreachButton.usesounds then
					ply:EmitSound("KeycardUse1.ogg")
				end
				ply.lastuse = CurTime() + 1
				ply:PrintMessage(HUD_PRINTCENTER, "Access granted")
				return true
			else
				if ent.BreachButton.usesounds and ply_clevel > 0 then
					ply:EmitSound("KeycardUse2.ogg")
				end
				ply.lastuse = CurTime() + 1
				ply:PrintMessage(HUD_PRINTCENTER, "You need a keycard with clearance level ".. ent.BreachButton.clevel .." to open this door.")
				return false
			end
		end
	end
	return true
end

function GM:PlayerUse(ply, ent)
	if cvars.Bool("br2_debug_print_doors") then
		local pos = ent:GetPos()
		local str = "Vector("..pos.x..", "..pos.y..", "..pos.z..")"
		if isstring(ent:GetName()) then
			print(str .. "     " .. ent:GetName())
		else	
			print(str)
		end
	end
	
	ply.lastuse = ply.lastuse or 0
	if ply:IsSpectator() or ply.lastuse > CurTime() then return false end
	
	local wep = ply:GetActiveWeapon()
	if IsValid(wep) and isfunction(wep.HandleUse) then
		wep:HandleUse()
		ply.lastuse = CurTime() + 1
		return false
	end
	
	return ShouldPlayerUse(ply, ent)
end

print("Gamemode loaded core/server/player/use.lua")