local DMW = DMW
local LocalPlayer = DMW.Classes.LocalPlayer

local function IsInside(x, y, ax, ay, bx, by, dx, dy) -- Stolen at BadRotations
    local bax = bx - ax
    local bay = by - ay
    local dax = dx - ax
    local day = dy - ay
    if ((x - ax) * bax + (y - ay) * bay <= 0.0) then
        return false
    end
    if ((x - bx) * bax + (y - by) * bay >= 0.0) then
        return false
    end
    if ((x - ax) * dax + (y - ay) * day <= 0.0) then
        return false
    end
    if ((x - dx) * dax + (y - dy) * day >= 0.0) then
        return false
    end
    return true
end

function LocalPlayer:GetEnemy(Yards, Facing)
    Facing = Facing or false
    if (not self.Target or self.Target.Dead) and self.Combat then
        for _, Unit in ipairs(DMW.Enemies) do
            if Unit.Distance <= Yards and (not Facing or Unit:Facing()) then
                return Unit
            end
        end
    end
    return nil
end

function LocalPlayer:AutoTarget(Yards, Facing)
    Facing = Facing or false
    if (not self.Target or self.Target.Dead) and self.Combat then
        for _, Unit in ipairs(DMW.Enemies) do
            if Unit.Distance <= Yards and (not Facing or Unit.Facing) then
                TargetUnit(Unit.Pointer)
                DMW.Player.Target = Unit
                return true
            end
        end
    end
end

function LocalPlayer:AutoTargetQuest(Yards, Facing)
    Facing = Facing or false
    if not self.Target or self.Target.Dead then
        for _, Unit in ipairs(DMW.Attackable) do
            if Unit.Distance <= Yards and (not Facing or Unit.Facing) and Unit.Quest and not Unit.Dead and not Unit.Target and not UnitIsTapDenied(Unit.Pointer) then
                TargetUnit(Unit.Pointer)
                DMW.Player.Target = Unit
                return true
            end
        end
    end
    return false
end

function LocalPlayer:AutoTargetAny(Yards, Facing)
    Facing = Facing or false
    if not self.Target or self.Target.Dead then
        for _, Unit in ipairs(DMW.Attackable) do
            if Unit.Distance <= Yards and (not Facing or Unit.Facing) and not Unit.Dead and not Unit.Target and not UnitIsTapDenied(Unit.Pointer) then
                TargetUnit(Unit.Pointer)
                DMW.Player.Target = Unit
                return true
            end
        end
    end
    return false
end

function LocalPlayer:AutoTargetMelee(Yards, Facing)
    Facing = Facing or false
    if not self.Target or self.Target.Dead or not self.Target.Facing or self.Target.Distance > Yards then
        for _, Unit in ipairs(DMW.Attackable) do
            if Unit.Distance <= Yards and (not Facing or Unit.Facing) and not Unit.Dead and not UnitIsUnit("target", Unit.Pointer) and not UnitIsTapDenied(Unit.Pointer) then
                TargetUnit(Unit.Pointer)
                DMW.Player.Target = Unit
                return true
            end
        end
    end
    return false
end
-- SortingEnemyScore = false,
-- SortingTarget = false,
-- SortingHighestHealth = false,
-- SortingLowestHealth = false,
-- SortingDebuffID = false,
-- SortingDebuffString = "",
-- SortingBuffID = false,
-- SortingBuffString = "",
-- SortingObjectIDs = false,
-- ObjectIDsString = "",
local function SortEnemies()
    local Enemies = DMW.Enemies
    local LowestHealth, HighestHealth, HealthNorm, EnemyScore, RaidTarget

    if #Enemies > 1 and (not DMW.Cache.EnemiesSorting or DMW.Cache.EnemiesSorting < DMW.Pulses) then
        if DMW.Settings.profile.Enemy.SortingEnemyScore then
            for _, v in pairs(Enemies) do
                if not LowestHealth or v.Health < LowestHealth then
                    LowestHealth = v.Health
                end
                if not HighestHealth or v.Health > HighestHealth then
                    HighestHealth = v.Health
                end
            end
            for _, v in pairs(Enemies) do
                HealthNorm = (10 - 1) / (HighestHealth - LowestHealth) * (v.Health - HighestHealth) + 10
                if HealthNorm ~= HealthNorm or tostring(HealthNorm) == tostring(0 / 0) then
                    HealthNorm = 0
                end
                EnemyScore = HealthNorm
                if v.TTD > 1.5 then
                    EnemyScore = EnemyScore + 5
                end
                RaidTarget = GetRaidTargetIndex(v.Pointer)
                if RaidTarget ~= nil then
                    EnemyScore = EnemyScore + RaidTarget * 3
                    if RaidTarget == 8 then
                        EnemyScore = EnemyScore + 5
                    end
                end
                v.EnemyScore = EnemyScore
            end
            table.sort(
                Enemies,
                function(x, y)
                    return x.EnemyScore > y.EnemyScore
                end
            )
        end
        if DMW.Settings.profile.Enemy.SortingHighestHealth then
            table.sort(
                Enemies,
                function(x, y)
                    return x.Health > y.Health
                end
            )
        elseif DMW.Settings.profile.Enemy.SortingLowestHealth then
            table.sort(
                Enemies,
                function(x, y)
                    return x.Health < y.Health
                end
            )
        end
        if DMW.Settings.profile.Enemy.SortingTarget and UnitIsVisible("target") then
            table.sort(
                Enemies,
                function(x)
                    if UnitIsUnit(x.Pointer, "target") then
                        -- print("target sort")
                        return true
                    else
                        return false
                    end
                end
            )
        end
        if DMW.Settings.profile.Enemy.SortingAuraID and DMW.Settings.profile.Enemy.SortingAuraIDString ~= "" then
            for k in string.gmatch(DMW.Settings.profile.Enemy.SortingAuraIDString, "([^,]+)") do
                table.sort(
                    Enemies,
                    function(x)
                        return x:AuraByID(k)
                    end
                )
            end
        end
        if DMW.Settings.profile.Enemy.SortingAuraName and DMW.Settings.profile.Enemy.SortingAuraNameString ~= "" then
            for k in string.gmatch(DMW.Settings.profile.Enemy.SortingAuraNameString, "([^,]+)") do
                table.sort(
                    Enemies,
                    function(x)
                        return x:AuraByName(k)
                    end
                )
            end
        end
        if DMW.Settings.profile.Enemy.SortingObjectIDs and DMW.Settings.profile.Enemy.SortingObjectIDsString ~= "" then
            for k in string.gmatch(DMW.Settings.profile.Enemy.SortingObjectIDsString, "([^,]+)") do
                table.sort(
                    Enemies,
                    function(x)
                        return x.ObjectID and k == x.ObjectID
                    end
                )
            end
        end

        DMW.Cache.EnemiesSorting = DMW.Pulses
    end
end

function LocalPlayer:GetEnemies(Yards)
    local Yards = Yards or 5
    if not DMW.Cache["EnemyCache"..Yards] or DMW.Cache["EnemyCache"..Yards].Update < DMW.Pulses then
        if DMW.Cache["EnemyCache"..Yards] then
            table.wipe(DMW.Cache["EnemyCache"..Yards])
        else
            DMW.Cache["EnemyCache"..Yards] = {}
        end
        SortEnemies()
        DMW.Cache["EnemyCache"..Yards].Update = DMW.Pulses
        local TableTemp = {}
        local CountTemp = 0
        if DMW.Settings.profile.HUD.Mode and DMW.Settings.profile.HUD.Mode == 2 then
            local Facing = (not DMW.Settings.profile.Enemy.AutoFace and self.Target and self.Target:Facing()) or true
            if self.Target and self.Target.ValidEnemy and self.Target.Distance <= Yards and Facing then
                table.insert(TableTemp, self.Target)
                CountTemp = 1
            end
            DMW.Cache["EnemyCache"..Yards].Table  = TableTemp
            DMW.Cache["EnemyCache"..Yards].Count  = CountTemp
            return TableTemp, CountTemp
        end
        for _, v in ipairs(DMW.Enemies) do
            local Facing = DMW.Settings.profile.Enemy.AutoFace or v:Facing()
            if v.Distance <= Yards and Facing then
                table.insert(TableTemp, v)
                CountTemp = CountTemp + 1
            end
        end
        DMW.Cache["EnemyCache"..Yards].Table  = TableTemp
        DMW.Cache["EnemyCache"..Yards].Count  = CountTemp
        return TableTemp, CountTemp
    else
        return DMW.Cache["EnemyCache"..Yards].Table, DMW.Cache["EnemyCache"..Yards].Count
    end
end

function LocalPlayer:GetAttackable(Yards)
    local Table = {}
    local Count = 0
    for _, v in ipairs(DMW.Attackable) do
        if v.Distance <= Yards then
            table.insert(Table, v)
            Count = Count + 1
        end
    end
    return Table, Count
end

function LocalPlayer:GetEnemiesRect(Length, Width, TTD, Facing)
    local Count = 0
    local Table, TableCount = self:GetEnemies(Length)
    if TableCount > 0 then
        TTD = TTD or 0
        local Facing = not Facing and ObjectFacing(self.Pointer) or Facing
        local nlX, nlY, nlZ = GetPositionFromPosition(self.PosX, self.PosY, self.PosZ, Width / 2, Facing + math.rad(90), 0)
        local nrX, nrY, nrZ = GetPositionFromPosition(self.PosX, self.PosY, self.PosZ, Width / 2, Facing + math.rad(270), 0)
        local frX, frY, frZ = GetPositionFromPosition(nrX, nrY, nrZ, Length, Facing, 0)
        for _, Unit in pairs(Table) do
            if IsInside(Unit.PosX, Unit.PosY, nlX, nlY, nrX, nrY, frX, frY) and Unit.TTD >= TTD then
                Count = Count + 1
            end
        end
    end
    return Count
end

function LocalPlayer:GetBestEnemiesRect(Length, Width, TTD)
    local facing, bestAngle, bestAngleUnitsHit = 0.1, 0, 0
    while facing <= 6.2 do
      local unitsInRect = self:GetEnemiesRect(Length, Width, TTD, facing)
      if unitsInRect > bestAngleUnitsHit then
        bestAngleUnitsHit = unitsInRect
        bestAngle = facing
      end
      facing = facing + 0.05
    end
    return bestAngle, bestAngleUnitsHit
end

function LocalPlayer:GetEnemiesCone(Length, Angle, TTD, AngleFacing)
    local Count = 0
    local Table, TableCount = self:GetEnemies(Length)
    if TableCount > 0 then
        TTD = TTD or false
        local AngleFacing = AngleFacing or ObjectFacing("player")
        for _, Unit in pairs(Table) do
            if not TTD or Unit.TTD >= TTD then
                -- if AngleFacing ~= nil then

                    local angleToUnit = GetAnglesBetweenObjects("player", Unit.Pointer)--math.rad(math.atan2(Unit.PosY - self.PosY, Unit.PosX - self.PosX))
                    local angle = (AngleFacing > angleToUnit and AngleFacing - angleToUnit) or angleToUnit - AngleFacing
                    if math.deg(angle) < Angle/2 then
                        Count = Count + 1
                    end
                -- else
                --     if UnitIsFacing(self.Pointer, Unit.Pointer, Angle / 2) then
                --         Count = Count + 1
                --     end
                -- end

            end
        end
    end
    return Count
end

function LocalPlayer:GetEnemiesConeTable(Length, Angle, TTD, AngleFacing)
    local Count = 0
    local Table, TableCount = self:GetEnemies(Length)
    local Table2 = {}
    if TableCount > 0 then
        TTD = TTD or false
        local AngleFacing = AngleFacing or ObjectFacing("player")
        for _, Unit in pairs(Table) do
            if not TTD or Unit.TTD >= TTD then
                -- if AngleFacing ~= nil then
                    local angleToUnit = GetAnglesBetweenObjects("player", Unit.Pointer)--math.rad(math.atan2(Unit.PosY - self.PosY, Unit.PosX - self.PosX))
                    local angle = (AngleFacing > angleToUnit and AngleFacing - angleToUnit) or angleToUnit - AngleFacing
                    if math.deg(angle) < Angle/2 then
                        Count = Count + 1
                        table.insert(Table2, Unit)
                    end
                -- else
                --     if UnitIsFacing(self.Pointer, Unit.Pointer, Angle / 2) then
                --         Count = Count + 1
                --     end
                -- end
            end
        end
    end
    return Table2, Count
end

function LocalPlayer:GetBestEnemiesCone(Length, Angle, TTD)
    local facing, bestAngle, bestAngleUnitsHit = 0.1, 0, 0
    local currentCount = self:GetEnemiesCone(Length, Angle, TTD)
    while facing <= 2 * math.pi do
      local unitsInRect = self:GetEnemiesCone(Length, Angle, TTD, facing)
      if unitsInRect > bestAngleUnitsHit then
        bestAngleUnitsHit = unitsInRect
        bestAngle = facing
      end
      facing = facing + 0.05
    end
    return bestAngle, bestAngleUnitsHit
end

function LocalPlayer:IsTankingAoE(Radius, ThreatSituation)
    local Radius = Radius or 8
    local EnemyList = self:GetEnemies(Radius)
	for _, Unit in ipairs(EnemyList) do
		if Unit:IsTanking(ThreatSituation) then
			return true
		end
	end
	return false
end

function LocalPlayer:notTankingAoE(Radius, ThreatSituation)
    local Radius = Radius or 8
    local EnemyList = self:GetEnemies(Radius)
	for _, Unit in ipairs(EnemyList) do
		if not Unit:IsTanking(ThreatSituation) then
			return true
		end
	end
	return false
end
