local DMW = DMW
local Buff = DMW.Classes.Buff
local Debuff = DMW.Classes.Debuff

function Buff:New(SpellID, BaseDuration)
    self.SpellID = SpellID
    self.SpellName = GetSpellInfo(self.SpellID)
    if SpellID == 294027 then
        self.SpellName = "AvengingWrathAutocrit"
    end
    self.BaseDuration = BaseDuration
end

function Debuff:New(SpellID, BaseDuration)
    self.SpellID = SpellID
    self.SpellName = GetSpellInfo(self.SpellID)
    self.BaseDuration = BaseDuration
end

function Buff:Exist(Unit, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or false
    Unit = Unit or DMW.Player
    return self:Query(Unit, OnlyPlayer) ~= nil
end

function Debuff:Exist(Unit, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or true
    Unit = Unit or DMW.Player.Target
    return self:Query(Unit, OnlyPlayer) ~= nil
end

function Buff:Remain(Unit, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or false
    Unit = Unit or DMW.Player
    local EndTime = select(6, self:Query(Unit, OnlyPlayer))
    if EndTime then
        if EndTime == 0 then
            return 999
        end
        return (EndTime - DMW.Time)
    end
    return 0
end

function Debuff:Remain(Unit, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or true
    Unit = Unit or DMW.Player.Target
    local EndTime = select(6, self:Query(Unit, OnlyPlayer))
    if EndTime then
        if EndTime == 0 then
            return 999
        end
        return (EndTime - DMW.Time)
    end
    return 0
end

function Buff:Duration(Unit, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or false
    Unit = Unit or DMW.Player
    local Duration = select(5, self:Query(Unit, OnlyPlayer))
    if Duration then
        return Duration
    end
    return 0
end

function Debuff:Duration(Unit, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or true
    Unit = Unit or DMW.Player.Target
    local Duration = select(5, self:Query(Unit, OnlyPlayer))
    if Duration then
        return Duration
    end
    return 0
end

function Buff:Elapsed(Unit, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or false
    Unit = Unit or DMW.Player
    local EndTime = select(6, self:Query(Unit, OnlyPlayer))
    local Duration = select(5, self:Query(Unit, OnlyPlayer))
    if EndTime and Duration then
        if EndTime == 0 then
            return 999
        end
        return DMW.Time - (EndTime - Duration)
    end
    return 0
end

function Debuff:Elapsed(Unit, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or true
    Unit = Unit or DMW.Player.Target
    local EndTime = select(6, self:Query(Unit, OnlyPlayer))
    local Duration = select(5, self:Query(Unit, OnlyPlayer))
    if EndTime and Duration then
        if EndTime == 0 then
            return 999
        end
        return DMW.Time - (EndTime - Duration)
    end
    return 0
end

function Buff:Refresh(Unit, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or false
    Unit = Unit or DMW.Player
    local Remain = self:Remain(Unit, OnlyPlayer)
    if Remain > 0 then
        local Duration = self.BaseDuration or self:Duration(Unit)
        return Remain < (Duration * 0.3)
    end
    return true
end

function Debuff:Refresh(Unit, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or true
    Unit = Unit or DMW.Player.Target
    local Remain = self:Remain(Unit, OnlyPlayer)
    if Remain > 0 then
        local Duration = self.BaseDuration or self:Duration(Unit)
        return Remain < (Duration * 0.3)
    end
    return true
end

function Buff:Stacks(Unit, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or false
    Unit = Unit or DMW.Player
    local Stacks = select(3, self:Query(Unit, OnlyPlayer))
    if Stacks then
        return Stacks
    end
    return 0
end

function Debuff:Stacks(Unit, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or true
    Unit = Unit or DMW.Player.Target
    local Stacks = select(3, self:Query(Unit, OnlyPlayer))
    if Stacks then
        return Stacks
    end
    return 0
end

function Buff:Count(Table)
    local Count = 0
    Table = Table or DMW.Player:GetFriends(40)
    for _, Unit in pairs(Table) do
        if self:Exist(Unit) then
            Count = Count + 1
        end
    end
    return Count
end

function Debuff:Count(Table)
    local Count = 0
    Table = Table or DMW.Player:GetEnemies(40)
    for _, Unit in pairs(Table) do
        if self:Exist(Unit) then
            Count = Count + 1
        end
    end
    return Count
end

function Buff:Lowest(Table)
    Table = Table or DMW.Player:GetFriends(40)
    local LowestSec, LowestUnit
    for _, Unit in ipairs(Table) do
        if not LowestSec or self:Remain(Unit) < LowestSec then
            LowestSec = self:Remain(Unit)
            LowestUnit = Unit
        end
    end
    return LowestUnit, LowestSec
end

function Debuff:Lowest(Table)
    Table = Table or DMW.Player:GetEnemies(40)
    local LowestSec, LowestUnit
    for _, Unit in ipairs(Table) do
        if self:Exist(Unit) and (not LowestSec or self:Remain(Unit) < LowestSec) then
            LowestSec = self:Remain(Unit)
            LowestUnit = Unit
        end
    end
    return LowestUnit, LowestSec
end

function Debuff:Multiplier(Unit)
    if self.SpellID == 703 then
        return Unit.BleedMultiplierGarrote or 1
    elseif self.SpellID == 1943 then
        return Unit.BleedMultiplierRupture or 1
    end
end

function Debuff:Exsanguinated(Unit)
    if self.SpellID == 703 then
        return Unit.ExsanguinatedGarrote or false
    elseif self.SpellID == 1943 then
        return Unit.ExsanguinatedRupture or false
    end
end

function Debuff:SSBuffed(Unit)
    if self.SpellID == 703 then
        return Unit.GarroteSSBuffed or false
    end
end
