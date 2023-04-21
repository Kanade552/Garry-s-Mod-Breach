/*
soundstoloop = {
	{
		pos = Vector(2725.010010, -192, 128),
		ent = "prop_dynamic",
		len = 5,
		sound = "camera.ogg"
	},
	{
		pos = Vector(2725.010010, 1088, 128),
		ent = "prop_dynamic",
		len = 5,
		sound = "camera.ogg"
	}
}

foundsoundents = {}

function FindSoundEnts()
	for k,v in pairs(soundstoloop) do
		for k2,ent in pairs(ents.FindInSphere(v.pos, 1)) do
			if ent:GetClass() == v.ent then
				table.ForceInsert(foundsoundents, {
					ent = ent,
					sound = v.sound,
					len = v.len,
					nextplay = 0
				})
			end
		end
	end
	print("Found " .. #foundsoundents .. " sound entities")
end

FindSoundEnts()

function UpdateSounds()
	for k,v in pairs(foundsoundents) do
		if v.nextplay < CurTime() then
			if IsValid(v.ent) then
				v.ent:EmitSound(v.sound, 75, 100, 1, CHAN_STATIC)
				v.nextplay = CurTime() + v.len
			else
				FindSoundEnts()
			end
		end
	end
end
hook.Add("Tick", "UpdateSounds", UpdateSounds)

function LoopSoundsStart()
	for k,v in pairs(foundsoundents) do
		--CreateSound(v.pos, v.sound, CPASAttenuationFilter)
		v.ent:EmitSound(v.sound, 75, 100, 1, CHAN_STATIC)
		v.nextplay = CurTime() + v.len
	end
end

LoopSoundsStart()
*/
function SoundsOnRoundStart()
	if !cvars.Bool("br2_debug_stop_first_sounds", true) then
		surface.PlaySound("Alarm2.ogg")
	end
end

function StartOutisdeSounds()
	surface.PlaySound("Satiate Strings.ogg")
end

function StartEndSound()
	surface.PlaySound("Mandeville.ogg")
end