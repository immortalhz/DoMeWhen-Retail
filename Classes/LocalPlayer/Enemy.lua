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
            if Unit.Distance <= Yards and (not Facing or Unit.Facing) then
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

function LocalPlayer:GetEnemies(Yards)
    local Yards = Yards or 5
    if not DMW.Cache["EnemyCache"..Yards] or DMW.Pulses > DMW.Cache["EnemyCache"..Yards].Update then
        DMW.Cache["EnemyCache"..Yards] = {}
        DMW.Cache["EnemyCache"..Yards].Update = DMW.Pulses
        local TableTemp = {}
        local CountTemp = 0
        if DMW.Settings.profile.HUD.Mode and DMW.Settings.profile.HUD.Mode == 2 then
            if self.Target and self.Target.ValidEnemy and self.Target.Distance <= Yards then
                table.insert(TableTemp, self.Target)
                CountTemp = 1
            end
            DMW.Cache["EnemyCache"..Yards].Table  = TableTemp
            DMW.Cache["EnemyCache"..Yards].Count  = CountTemp
            return TableTemp, CountTemp
        end
        for _, v in ipairs(DMW.Enemies) do
            if v.Distance <= Yards then
                table.insert(TableTemp, v)
                CountTemp = CountTemp + 1
            end
        end
        DMW.Cache["EnemyCache"..Yards].Table  = TableTemp
        DMW.Cache["EnemyCache"..Yards].Count  = CountTemp
        return TableTemp, CountTemp
    else
        DMW.Cache["EnemyCache"..Yards].Update = DMW.Pulses
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

function LocalPlayer:GetEnemiesRect(Length, Width, TTD)
    local Count = 0
    local Table, TableCount = self:GetEnemies(Length)
    if TableCount > 0 then
        TTD = TTD or 0
        local Facing = ObjectFacing(self.Pointer)
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

function LocalPlayer:GetEnemiesCone(Length, Angle, TTD)
    local Count = 0
    local Table, TableCount = self:GetEnemies(Length)
    if TableCount > 0 then
        TTD = TTD or 0
        local Facing = ObjectFacing(self.Pointer)
        for _, Unit in pairs(Table) do
            if Unit.TTD >= TTD and UnitIsFacing(self.Pointer, Unit.Pointer, Angle / 2) then
                Count = Count + 1
            end
        end
    end
    return Count
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
