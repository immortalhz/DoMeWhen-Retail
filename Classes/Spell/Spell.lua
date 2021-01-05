local DMW = DMW
local Spell = DMW.Classes.Spell

function Spell:New(SpellID, CastType)
    self.SpellID = SpellID
    self.SpellCache = {GetSpellInfo(self.SpellID)}
    self.SpellName = self.SpellCache[1]
    self.BaseCD = GetSpellBaseCooldown(self.SpellID) / 1000
    self.BaseGCD = select(2, GetSpellBaseCooldown(self.SpellID)) / 1000
    self.MinRange = self.SpellCache[5] or 0
    self.MaxRange = self.SpellCache[6] or 0
    self.CastType = CastType or "Normal" -- Ground, Normal, Pet ect.
    self.IsHarmful = IsHarmfulSpell(self.SpellName) or false
    self.IsHelpful = IsHelpfulSpell(self.SpellName) or false
    self.LastCastTime = 0
    self.LastBotTarget = "player"
    self.IsAvailable = IsPlayerSpell(self.SpellID) or IsSpellKnown(self.SpellID, true)
    -- if self.IsAvailable then self.CooldownInfo = {GetSpellCooldown(self.SpellID)} end
    local costTable = GetSpellPowerCost(self.SpellID)
    for _, costInfo in pairs(costTable) do if costInfo.costPerSec > 0 then self.CastType = "Channel" end end
end

-- Check if the spell is in the Spell Learned Cache.
function Spell:IsLearned()
    return self.Available or false
end

function Spell:TargetRangeCheck()
    if DMW.Player.Target then
        if self.MinRange ~= 0 and DMW.Player.Target.Distance <= self.MinRange then
            return false
        elseif self.MaxRange ~= 0 and DMW.Player.Target.Distance >= self.MaxRange then
            return false
        end
        return true
    end
    return false
end

function Spell:Count() return GetSpellCount(self.SpellID) end

function Spell:Cost(PowerType)
    local CostTable
    local PowerType = PowerType or UnitPowerType("player")
    CostTable = GetSpellPowerCost(self.SpellName)
    if CostTable then for _, costInfo in pairs(CostTable) do if costInfo.cost > 0 then return costInfo.cost end end end
    return 0
end

function Spell:CD()
    -- print(self.Key)
    if DMW.Pulses == self.CDUpdate then
        return self.CDCache
    end
    self.CDUpdate = DMW.Pulses
    local LocStart, LocDuration = GetSpellLossOfControlCooldown(self.SpellName)
    local Start, CD = GetSpellCooldown(self.SpellName)
    if not Start then
        Start, CD = GetSpellCooldown(self.SpellID)
    end
	if LocStart and (LocStart + LocDuration) > (Start + CD) then
		Start = LocStart
		CD = LocDuration
	end
    local FinalCD = 0
    if Start > 0 and CD > 0 then
        FinalCD = Start + CD - DMW.Time
    else
        self.CDCache = 0
        return 0
    end
    FinalCD = FinalCD
    if FinalCD < 0 then FinalCD = 0 end
    self.CDCache = FinalCD
    return FinalCD
end

local overrideAvailable = {
    ["DeathSweep"] = true,
    ["Annihilation"] = true,
    ["VoidBolt"] = true,
	["HeartStrike"] = true,
	["Thrash"] = true,
	["WildCharge"] = true
    -- ["BloodBath"] = true,
    -- ["CrushingBlow"] = true,
    -- ["RagingBlow"] = true,
    -- ["Bloodthirst"] = true
}
function Spell:IsAvailableF()
    if overrideAvailable[self.Key] then return true end
    return self.IsAvailable
end

function Spell:CDUp()
    if self.BaseGCD > 0 then
        return DMW.Player:GCDRemain() == 0 and self:CD() == 0
    else
        return self:CD() == 0
    end
end

function Spell:CDDown() return self:CD() ~= 0 end

function Spell:IsInRange(Range)
    local Range = Range or 5
    local table, count = DMW.Player:GetEnemies(Range)
    return count and count >= 1
end

function Spell:IsCastable(Range, AoESpell, Unit)
    if Range then
        if Range == "Melee" then Range = 5 end
        -- local CastUnit = Unit or DMW.Player.Target
        return self:IsAvailableF() and self:CDUp() and self:IsInRange(Range)
    else
        --local Range = self.MaxRange > 0 and self.MaxRange or 5

        return self:IsAvailableF() and self:CDUp()
    end
end

function Spell:IsReady(Range)
    return self:IsCastable(Range) and self:Usable() -- and (self.BaseGCD == 0 or not DMW.Player:SpellQueued())
end

function Spell:Charges() return GetSpellCharges(self.SpellID) end

function Spell:ChargesFrac()
    local Charges, MaxCharges, Start, Duration
    Charges, MaxCharges, Start, Duration = GetSpellCharges(self.SpellID)
    if Charges ~= MaxCharges then
        return Charges + (1 - (Start + Duration - DMW.Time) / Duration)
    else
        return Charges
    end
end

function Spell:RechargeTime()
    local Charges, MaxCharges, Start, Duration
    Charges, MaxCharges, Start, Duration = GetSpellCharges(self.SpellName)
    if Charges ~= MaxCharges then
        return Start + Duration - DMW.Time
    else
        return 0
    end
end

function Spell:FullRechargeTime()
    local Charges, MaxCharges, Start, Duration
    Charges, MaxCharges, Start, Duration = GetSpellCharges(self.SpellName)
    if Charges ~= MaxCharges then
        local ChargesFracRemain = MaxCharges - (Charges + (1 - (Start + Duration - DMW.Time) / Duration))
        return ChargesFracRemain * Duration
    else
        return 0
    end
end

function Spell:CastTime() return select(4, GetSpellInfo(self.SpellName)) / 1000 end

function Spell:Known()
    -- if Rank then
    --     return IsSpellKnown(self.Ranks[Rank])
    -- end
    return GetSpellInfo(self.SpellName)
end

local UsableSpells = {
    ["Swiftmend"] = true,
    ["Execute"] = true,
    ["VoidBolt"] = true,
    ["HammerOfWrath"] = true,
    ["Consecration"] = true,
    -- ["Bloodthirst"] = true,
    -- ["RagingBlow"] = true
}

function Spell:Usable()
    -- print(self?)
    if UsableSpells[self.Key] then return true end
    return IsUsableSpell(self.SpellID)
end

function Spell:Pool(Time)
    local _, noMana = IsUsableSpell(self.SpellID)
    -- if Time then
    --power/regen < time
    -- end
    return noMana
end

function Spell:Delay(Unit)
    -- print(self:TimeSinceLastCast(), Unit.Pointer, self.LastBotTarget)
    -- if self.LastBotTarget ~= Unit.Pointer then print("false") end
    if self:LastTimeCastEnd() >= 0.4 or self.LastBotTarget ~= Unit.Pointer then return true end
end

function Spell:CastBestConeFriend(Length, Angle, MinHit, HP)
	if not self:IsReady() then
		return false
    end
    MinHit = MinHit or 1
    HP = HP or 100
    local Table, TableCount = DMW.Player:GetFriends(Length, HP)
    if TableCount < MinHit then
        return false
    end
	local PX, PY, PZ = DMW.Player.PosX, DMW.Player.PosY, DMW.Player.PosZ
    local ConeTable = {}
    local X, Y, Z, AngleToUnit
    for _, Unit in pairs(Table) do
        if Unit.HP <= HP then
            X, Y, Z = Unit.PosX, Unit.PosY, Unit.PosZ
            AngleToUnit = rad(atan2(Y - PY, X - PX))
            if AngleToUnit < 0 then
                AngleToUnit = rad(360 + atan2(Y - PY, X - PX))
            end
            tinsert(ConeTable, AngleToUnit)
        end
	end
    local Facing, BestAngle, MostHit, Units = 0, 0, 0, 0
    local AngleToUnit, AngleDifference, ShortestAngle, FinalAngle
	while Facing <= 6.2 do
		Units = 0
		for i = 1, #ConeTable do
			AngleToUnit = ConeTable[i]
			AngleDifference = Facing > AngleToUnit and Facing - AngleToUnit or AngleToUnit - Facing
			ShortestAngle = AngleDifference < math.pi and AngleDifference or math.pi * 2 - AngleDifference
			FinalAngle = ShortestAngle * 180 / math.pi
			if FinalAngle < Angle / 2 then
				Units = Units + 1
			end
		end
		if Units > MostHit then
			MostHit = Units
			BestAngle = Facing
		end
		Facing = Facing + 0.05
	end
    if MostHit >= MinHit then
        local CurrentFacing = ObjectFacing("player")
		local mouselookActive = false
		if IsMouselooking() then
			mouselookActive = true
			MouselookStop()
			TurnOrActionStop()
			MoveAndSteerStop()
		end
		FaceDirection(BestAngle, true)
		CastSpellByName(self.SpellName)
		FaceDirection(CurrentFacing)
		if mouselookActive then
			MouselookStart()
		end
		C_Timer.After(0.1, function()
			FaceDirection(ObjectFacing("player"), true)
        end)
		return true
	end
	return false
end
