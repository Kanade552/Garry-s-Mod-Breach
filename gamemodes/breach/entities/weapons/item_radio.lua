AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_radio")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Kanade"
SWEP.Purpose		= "Communicate"
SWEP.Instructions	= "If you hold it, your chat messages and voice chat will be global with others that have the radio"

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/mishka/models/radio.mdl"
SWEP.WorldModel		= "models/mishka/models/radio.mdl"
SWEP.PrintName		= "Radio"
SWEP.Slot			= 1
SWEP.SlotPos		= 1
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.HoldType		= "pistol"
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false

SWEP.droppable				= true
SWEP.teams					= {TEAM_GUARD, TEAM_CLASSD, TEAM_SCI, TEAM_CHAOS, TEAM_STAFF}

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Ammo			=  "none"
SWEP.Primary.Automatic		= false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Ammo			=  "none"
SWEP.Secondary.Automatic	=  false

SWEP.BoneAttachment = "ValveBiped.Bip01_R_Hand"
SWEP.WorldModelPositionOffset = Vector(5, -2, -10)
SWEP.WorldModelAngleOffset = Angle(-90, 180, 230)

SWEP.Channel = 1
SWEP.Enabled = false
SWEP.NextChange = 0
SWEP.IsPlayingFor = nil

function SWEP:Deploy()
	self:SetHoldType("pistol")
	self.Owner:DrawViewModel(false)
end

function SWEP:DrawWorldModel()
	if CLIENT and LocalPlayer():IsSpectator() then
		return false
	end
	if !IsValid(self.Owner) then
		self:DrawModel()
	else
		if !IsValid(self.WM) then
			self.WM = ClientsideModel(self.WorldModel)
			self.WM:SetNoDraw(true)
		end

		local boneid = self.Owner:LookupBone(self.BoneAttachment)
		if not boneid then
			return
		end

		local matrix = self.Owner:GetBoneMatrix(boneid)
		if not matrix then
			return
		end

		local newpos, newang = LocalToWorld(self.WorldModelPositionOffset, self.WorldModelAngleOffset, matrix:GetTranslation(), matrix:GetAngles())

		self.WM:SetPos(newpos)
		self.WM:SetAngles(newang)
		self.WM:SetupBones()
		self.WM:DrawModel()
	end
end


function SWEP:Initialize()
	self:SetHoldType("pistol")
end

function SWEP:PlaySound(name, volume, looping)
	if CLIENT then
		--print("Starting playing a sound " .. name .. " with volume: " .. tostring(volume) .. " and looping is: " .. tostring(looping))
		sound.PlayFile(name, "mono noblock", function(station, errorID, errorName)
			if IsValid(station) then
				station:SetPos(LocalPlayer():GetPos())
				station:SetVolume(volume)
				if looping then
					station:EnableLooping(looping)
					station:SetTime(360)
				end
				station:Play()
				LocalPlayer().channel = station
			else
				print("station not found")
				print(errorID, errorName)
			end
		end)
	end
end

function SWEP:RemoveSounds()
	if CLIENT then
		if LocalPlayer().channel != nil then
			LocalPlayer().channel:EnableLooping(false)
			LocalPlayer().channel:Stop()
			LocalPlayer().channel = nil
		end
	end
end

function SWEP:StopSounds()
	if CLIENT then
		if LocalPlayer().channel != nil then
			--LocalPlayer().channel:EnableLooping(false)
			LocalPlayer().channel:SetVolume(0)
			--LocalPlayer().channel = nil
		end
	end
end

SWEP.LastSound = 0
function SWEP:CheckSounds()
	if CLIENT then
		local r = "sound/radio/"
		if self.Channel == 1 then
			self:PlaySound(r .. "radioalarm.ogg", 1, true)
			self.IsLooping = true
		elseif self.Channel == 2 then
			self:PlaySound(r .. "radioalarm2.ogg", 1, false)
			self.NextSoundCheck = CurTime() + 12
			self.IsLooping = false
		elseif self.Channel == 3 then
			self.LastSound = self.LastSound + 1
			if self.LastSound == 0 then
				self.NextSoundCheck = CurTime() + 24
			elseif self.LastSound == 1 then
				self.NextSoundCheck = CurTime() + 15
			elseif self.LastSound == 2 then
				self.NextSoundCheck = CurTime() + 21
			elseif self.LastSound == 3 then
				self.NextSoundCheck = CurTime() + 25
			elseif self.LastSound == 4 then
				self.NextSoundCheck = CurTime() + 28
			elseif self.LastSound == 5 then
				self.NextSoundCheck = CurTime() + 35
			elseif self.LastSound == 6 then
				self.NextSoundCheck = CurTime() + 46
			elseif self.LastSound == 7 then
				self.NextSoundCheck = CurTime() + 20
			elseif self.LastSound == 8 then
				self.NextSoundCheck = CurTime() + 24
			elseif self.LastSound == 9 then
				self.LastSound = 0
				self.NextSoundCheck = CurTime() + 24
			end
			local sound = "scpradio" .. self.LastSound
			self:PlaySound(r .. sound .. ".ogg", 1, false)
			self.IsLooping = false
		elseif self.Channel == 4 then
			if #RADIO4SOUNDS > 0 then
				if math.random(1,4) == 4 then
					local rndtbl = TableRandom(RADIO4SOUNDS)
					--print("playing " .. rndtbl[1])
					self:PlaySound(r .. rndtbl[1] .. ".ogg", 1, false)
					self.NextSoundCheck = CurTime() + rndtbl[2] + 5
					self.IsLooping = false
					table.RemoveByValue(RADIO4SOUNDS, rndtbl)
				else
					--print("waiting 5 secs")
					self.NextSoundCheck = CurTime() + 5
					self.IsLooping = false
				end
			else
				self.IsLooping = true
			end
		end
	end
end

SWEP.IsLooping = false
SWEP.NextSoundCheck = 0
function SWEP:Think()
	if SERVER then return end
	if self.Enabled and self.IsLooping == false and self.NextSoundCheck < CurTime() then
		self:CheckSounds()
	end
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
	if self.NextChange > CurTime() then return end
	self.Channel = self.Channel + 1
	if self.Channel > 9 then
		self.Channel = 1
	end
	self.IsLooping = false
	self:RemoveSounds()
	if self.Enabled then
		self:CheckSounds()
	end
	self.NextChange = CurTime() + 0.1
end

function SWEP:OnRemove()
	if CLIENT then
		self.IsLooping = false
		self:StopSounds()
		self.Enabled = false
	end
end

function SWEP:Holster()
	--if CLIENT then
	--	self.IsLooping = false
	--	self:StopSounds()
	--	self.Enabled = false
	--end
	return true
end

function SWEP:SecondaryAttack()
	if self.NextChange > CurTime() then return end
	self.Enabled = !self.Enabled
	self.NextChange = CurTime() + 0.1
	if CLIENT then
		if self.Enabled then
			--self:CheckSounds()
			if IsValid(LocalPlayer().channel) then
				LocalPlayer().channel:SetVolume(1)
			end
		else
			self:StopSounds()
		end
	end
	--self.Owner.RadioEnabled = self.Enabled
	--print(self.NextChange)
	--print(self.Owner:Nick() .. " " .. tostring(self.Enabled))
end

function SWEP:CanPrimaryAttack()
end

local ourMat = Material("breach/RadioHUD.png")
function SWEP:DrawHUD()
	if LocalPlayer() != self.Owner then return end
	local rw = math.Clamp(ScrW(), 1, 1920) / 7.6
	local rh = (rw * 2) * 1.1
	local size_mul = math.Clamp(ScrH() / 1080, 0.1, 1)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(ourMat)
	surface.DrawTexturedRect(ScrW() - rw, ScrH() - rh + 1, rw, rh)

	if self.Enabled then
		draw.Text({
			text = self.Channel,
			pos = {ScrW() - rw + (174 * size_mul), ScrH() - rh + (390 * size_mul)},
			font = "BR2_RadioFont_1",
			color = Color(0,0,0,250),
			xalign = TEXT_ALIGN_RIGHT,
			yalign = TEXT_ALIGN_TOP,
		})
		draw.Text({
			text = "CHN",
			pos = {ScrW() - rw + (150 * size_mul), ScrH() - rh + (394 * size_mul)},
			font = "BR2_RadioFont_2",
			color = Color(0,0,0,250),
			xalign = TEXT_ALIGN_RIGHT,
			yalign = TEXT_ALIGN_TOP,
		})
		draw.Text({
			text = "100%",
			pos = {ScrW() - rw + (66 * size_mul), ScrH() - rh + (438 * size_mul)},
			font = "BR2_RadioFont_3",
			color = Color(0,0,0,250),
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_BOTTOM,
		})
	end
end



