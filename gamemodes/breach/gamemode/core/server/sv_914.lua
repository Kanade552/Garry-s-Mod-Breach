
buttonstatus = 0
lasttime914b = 0
function Use914B(activator, ent)
	if CurTime() < lasttime914b then return end
	lasttime914b = CurTime() + 1.3
	ForceUse(ent, 1, 1)
end

lasttime914 = 0
function Use914(ent)
	local b914status = Check914Button()
	print("b914status: " .. tostring(b914status))

	if b914status == 0 or CurTime() < lasttime914 then return end

	buttonstatus = b914status
	lasttime914 = CurTime() + 20
	ForceUse(ent, 0, 1)
    
	local pos = ENTER914
	local pos2 = EXIT914
	timer.Create("914Use", 4, 1, function()
		for k,v in pairs(ents.GetAll()) do
			if InSCP914Enter(v) and (v.betterone != nil or v.GetBetterOne != nil) then
				local useb
				if v.betterone then useb = v.betterone end
				if v.GetBetterOne then useb = v:GetBetterOne() end

                if useb then
                    local betteritem = ents.Create(useb)
                    if IsValid(betteritem) then
                        betteritem:SetPos(pos2)
                        betteritem:Spawn()
                        WakeEntity(betteritem)
                        v:Remove()
                    end
                end
			end
		end
	end)
end

print("Gamemode loaded core/server/sv_914.lua")