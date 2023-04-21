
local meta_player = FindMetaTable("Player")

function meta_player:SetupLiveness()
    self.liveness_moves = {}
    self.setupLiveness = true
end

function meta_player:DistanceMoved()
    local dist = 0
    for i=2, #self.liveness_moves do
        dist = dist + self.liveness_moves[i]:Distance(self.liveness_moves[i - 1])
    end
    return dist
end

function meta_player:LivenessIsGood()
    -- recently done something
    if self.recent_liveness_action_til > CurTime() then return true end
    -- recently moved not enough
    if #self.liveness_moves > 8 and self:DistanceMoved() < 1700 then return false end
    -- not proven to be inactive
    return true
end

local next_check = 0
hook.Add("Tick", "BR_LivenessScoreCalculations", function()
    if next_check > CurTime() then return end
    next_check = CurTime() + 3

    for k,v in pairs(player.GetAll()) do
        if v:Alive() and !v:IsSpectator() then
            if not v.setupLiveness then
                v:SetupLiveness()
            end
            table.ForceInsert(v.liveness_moves, v:GetPos())
            if #v.liveness_moves > 25 then
                table.remove(v.liveness_moves, 1)
            end

            --v:PrintMessage(HUD_PRINTCENTER, tostring(v:DistanceMoved()) .. " / isgood? " .. tostring(v:LivenessIsGood()))
        end
    end
end)

local function liveness_action(ply)
    if IsValid(ply) and ply:Alive() and ply:IsPlayer() then
        ply.recent_liveness_action_til = CurTime() + 30
    end
end

hook.Add("PlayerCanPickupWeapon", "BR_LivenessAction_PickingUpWeapons", function(ply)
    liveness_action(ply)
end)

hook.Add("PlayerDeath", "BR_LivenessAction_Kill", function(victim, inflictor, attacker)
    if attacker:IsPlayer() and victim != attacker then
        liveness_action(victim)
    end
end)

hook.Add("BR_RoundPreparing", "BR_LivenessSetup_Preparing", function()
	for k,v in pairs(player.GetAll()) do
		v:SetupLiveness()
	end
end)

print("Gamemode loaded core/server/round/liveness_score.lua")