
local meta_player = FindMetaTable("Player")

function meta_player:SaveExp()
	self:SetPData("breach_exp", self:GetExp())
end

function meta_player:SaveLevel()
	self:SetPData("breach_level", self:GetLevel())
end

function BR_CalculateNeededExp(lvl)
    return 1000 + (2500 * lvl)
end

function meta_player:AddExp(amount)
	amount = math.Round(amount * GetConVar("br_expscale"):GetInt())

	if self.GetNEXP and self.SetNEXP then
		self:SetNEXP(self:GetNEXP() + amount)

		local xp = self:GetNEXP()
		local lvl = self:GetNLevel()
        local nlvl = lvl + 1
        local nexp = BR_CalculateNeededExp(nlvl)

        if xp >= nexp then
            self:AddLevel(1)
            self:SetNEXP(xp - nexp)
            self:SaveLevel()
            PrintMessage(HUD_PRINTTALK, self:Nick() .. " reached level "..nlvl.."! Congratulations!")
        end

		self:SetPData("breach_exp", self:GetExp())
	else
		if self.SetNEXP then
			self:SetNEXP(0)
		else
			ErrorNoHalt("Cannot set the exp, SetNEXP invalid")
		end
	end
end

function meta_player:AddLevel(amount)
	if self.GetNLevel and self.SetNLevel then
		self:SetNLevel(self:GetNLevel() + amount)
		self:SetPData("breach_level", self:GetNLevel())
	else
		if self.SetNLevel then
			self:SetNLevel(0)
		else
			ErrorNoHalt("Cannot set the exp, SetNLevel invalid")
		end
	end
end

function meta_player:ResetLevelAndEXP()
    self:SetNLevel(0)
    self:SetNEXP(0)
    self:SaveExp()
    self:SaveLevel()
end

print("Gamemode loaded core/server/player/leveling.lua")
