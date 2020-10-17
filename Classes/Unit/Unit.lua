local DMW = DMW
local Unit = DMW.Classes.Unit
-- local LibCC = LibStub("LibClassicCasterinoDMW", true)
-- local DurationLib = LibStub("LibClassicDurationsDMW")
-- local HealComm = LibStub("DMWLibHealComm-4.0")
-- CLH = LibStub("LibCombatLogHealth-2.0")
-- CLH.RegisterCallback("DMW", "COMBAT_LOG_HEALTH", function(event, unit, eventType)
--     -- local health = CLH.UnitHealth(unit)
--     local health = CLH.UnitHealth(unit)
--     local Pointer = DMW.Tables.Misc.unit2pointerF(unit)
--     if Pointer then
--         if DMW.Units[Pointer] then
--             DMW.Units[Pointer]:UpdateHealth(true, health)
--         end
--     end
--     -- if DMWUnit then
--     --     DMWUnit.Health = CLH.UnitHealth(unit)
--     --     -- print(unit)
--     -- end
--     -- print(event, unit, health)
-- end)


function Unit:New(Pointer)
    self.Pointer = Pointer
    self.Name = not UnitIsUnit(Pointer, "player") and UnitName(Pointer) or "LocalPlayer"
    self.GUID = UnitGUID(Pointer)
    self.Player = UnitIsPlayer(Pointer)
    self.LoSCache = {}
    self.Friend = UnitIsFriend("player", self.Pointer)
    if self.Player then
        self.Class = select(2, UnitClass(Pointer)):gsub("%s+", "")
    end
    self.HealthMax = UnitHealthMax(self.Pointer)
    -- self.CombatReach = UnitCombatReach(Pointer)
    -- self.BoundingRadius = UnitBoundingRadius(Pointer)
    -- print(self.Name)
    -- local range = DMW.Player.CombatReach + self.CombatReach + 4/3
    -- self.MeleeRange = math.max(range, 5)
    -- self.Scale = ObjectDescriptor(Pointer, GetOffset("CGObjectData__Scale"), "float")
    self.PosX, self.PosY, self.PosZ = ObjectPosition(Pointer)
    if not self.Player then
        self.ObjectID = ObjectID(Pointer)
    end
    self:IsDummy()
    self:NoLoS()
    self.Level = UnitLevel(Pointer)
    -- self.DistanceAggro = self:AggroDistance()
    self.CreatureType = DMW.Enums.CreatureType[UnitCreatureTypeID(Pointer)]
    self.Classification = UnitClassification(Pointer)
    -- DMW.Functions.AuraCache.Refresh(Pointer, self.GUID)
    --DurationLib
    -- DurationLib.nameplateUnitMap[self.GUID] = Pointer
    -- DurationLib.nameplateUnitMapBackwards[Pointer] = self.GUID

    DMW.Tables.Misc.guid2pointer[self.GUID] = Pointer
    DMW.Tables.Misc.pointer2guid[Pointer] = self.GUID
    self.Cache = {}
    -- DMW.Helpers.Swing.AddUnit(Pointer)
    -- self.UnitName = GetUnitName(Pointer)
    --NoTouchChecks
    if DMW.Player.Instance then
        self:NoTouchDungeons()
    end
end

function Unit:CastingCheck()
    local cast, channel, castTarget, channelTarget = UnitCastID(self.Pointer)
    -- print(UnitCastID("player"))
    if cast ~= 0 then
        -- if castTarget then
        --     self.
        -- print(self.Name)
        if not self.Cast then
            self.Cast = "Cast"
            -- print("cast", cast)
            self:GetProperCastingInfo()
        end
        return
        -- return cast
    elseif channel ~= 0 then
        if not self.Cast then
            self.Cast = "Channel"
            -- print("cast", cast)
            self:GetProperCastingInfo()
        end
        return
    end
    self.Cast = nil
    self.Casting = nil
    return nil
end

function Unit:Update()
    if DMW.Player.Resting then
        self.NextUpdate = DMW.Time + (math.random(100, 1500) / 1000)
    else
        self.NextUpdate = DMW.Time + (math.random(300, 1500) / 10000)
    end
    self:UpdatePosition()
    -- if DMW.Tables.AuraUpdate[self.GUID] and self.Pointer ~= DMW.Player.Pointer then
    --     DMW.Functions.AuraCache.Refresh(self.Pointer, self.GUID)
    --     DMW.Tables.AuraUpdate[self.GUID] = nil
    -- end
    self.Distance = self:GetDistance()
    self:CastingCheck()
    -- if RealMobHealth_CreatureHealthCache and self.ObjectID > 0 and RealMobHealth_CreatureHealthCache[self.ObjectID .. "-" .. self.Level] then
    --     self.HealthMax = RealMobHealth_CreatureHealthCache[self.ObjectID .. "-" .. self.Level]
    --     self.RealHealth = true
    --     self.Health = self.HealthMax * (UnitHealth(self.Pointer) / 100)
    -- else

    --     if self.HealthMax ~= 100 then
    --         self.RealHealth = true
    --     else
    --         self.RealHealth = false
    --     end
        -- if not self.Health or not self.Predicted then

        -- local unit = DMW.Tables.Misc.pointer2unitFunc(self.Pointer)
        -- if self.UnitID == nil then
        -- end

        -- end
    -- end
    self.Health = UnitHealth(self.Pointer)
    self.HealthMax = UnitHealthMax(self.Pointer)
    self.HP = self.Health / self.HealthMax * 100
    self.HealthDeficit = self.HealthMax - self.Health
    self.Dead = UnitIsDeadOrGhost(self.Pointer) -- CalculateHP
    self.TTD = self:GetTTD()
    self.LoS = false
    if self.Distance < 50 and not self.Dead then
        self.LoS = self:LineOfSight()
    end
    -- if self.PredictHeal then self.PredictHeal = nil end
    -- if self.PredictTime then self.PredictTime = nil end
    self.CanAttack = UnitCanAttack("player", self.Pointer)
    self.Attackable = self.LoS and self.CanAttack or false
    self.ValidEnemy = self.Attackable and self.CreatureType ~= "Critter" and self:IsEnemy() or false
    self.Target = UnitTarget(self.Pointer)
    self.Moving = self:HasMovementFlag(DMW.Enums.MovementFlags.Moving)
    -- self.Facing = UnitIsFacing("Player", self.Pointer, 75)
    -- if not self.Quest or (DMW.Cache.QuestieCache.CacheTimer and DMW.Time > DMW.Cache.QuestieCache.CacheTimer) then
        self.Quest = self:IsQuest()
    -- end
    self.Trackable = self:IsTrackable()
    if self.Name == "Unknown" then
        self.Name = UnitName(self.Pointer)
    end

    -- if self.ValidEnemy and self:AuraByID(1020) then
    --     self.ValidEnemy = false
    -- end

    -- if HonorAssist ~= nil and self.Player and self.CanAttack then --DMW.Player.Instance == "pvp" and
    --     -- local dailyKillCount, totalKillCount = HonorAssist:GetPlayerDailyKillCount(self.Name)
	-- 	local timesKilledToday = HonorAssist:GetTotalKillsDailyDatabase(self.UnitName)
    --     local honorPercentLeft, realisticHonor = HonorAssist:GetPlayerEstimatedHonor(timesKilledToday, 1, self.Level, self.rankPVP)
    --     self.RealisticHonor = realisticHonor or nil
    -- end
    -- if self.DrawCleaveInfo then
    --     self:DrawCleave()
    -- end
    self.Mark = self:MarkCheck()
end

function Unit:UpdateHealth(predict, amount)
    -- print("new",UnitHealth(self.UnitID))
    -- print("def",_G.UnitHealth(self.UnitID))
    -- if predict then
    --     self.Predicted = true
    --     self.Health = amount
    --     -- print(self.Name, amount)--min(self.Health + amount, self.HealthMax)
    -- -- else
    -- --     self.Predicted = nil
    -- --     self.Health = UnitHealth(self.Pointer)
    -- end
end

function Unit:UpdatePosition()
    -- local offset = self:HasMovementFlag(DMW.Enums.MovementFlags.Hover) and
    self.PosX, self.PosY, self.PosZ = ObjectPosition(self.Pointer)
end

function Unit:LineOfSight(OtherUnit)
    -- local losFlags = bit.bor(0x10, 0x100, 0x1)
    -- return true
    -- if DMW.Enums.LoS[self.ObjectID] then
    --     return true
    -- end
    if self.NoLoS or DMW.Enums.SkipChecks[self.ObjectID] then
        return true
    end
    OtherUnit = OtherUnit or DMW.Player
    if self.LoSCache.Result ~= nil and self.PosX == self.LoSCache.PosX and self.PosY == self.LoSCache.PosY and self.PosZ == self.LoSCache.PosZ and OtherUnit.PosX == self.LoSCache.OPosX and OtherUnit.PosY == self.LoSCache.OPosY and OtherUnit.PosZ == self.LoSCache.OPosZ then
        return self.LoSCache.Result
    end
    self.LoSCache.Result = TraceLine(self.PosX, self.PosY, self.PosZ + 2, OtherUnit.PosX, OtherUnit.PosY, OtherUnit.PosZ + 2, 0x100010) == nil
    self.LoSCache.PosX, self.LoSCache.PosY, self.LoSCache.PosZ = self.PosX, self.PosY, self.PosZ
    self.LoSCache.OPosX, self.LoSCache.OPosY, self.LoSCache.OPosZ = OtherUnit.PosX, OtherUnit.PosY, OtherUnit.PosZ
    return self.LoSCache.Result
end

function Unit:IsEnemy()
    return self:HasThreat() and not self.Dead and ((not self.Friend and not self:CCed()) or UnitIsUnit(self.Pointer, "target"))
end

function Unit:IsBoss()
    if self.Classification == "worldboss" or self.Classification == "rareelite" then
        return true
    elseif LibStub("LibBossIDs-1.0").BossIDs[self.ObjectID] then
        return true
    elseif DMW.Player.EID then
        for i = 1, 5 do
            if UnitIsUnit("boss" .. i, self.Pointer) then
                return true
            end
        end
    end
    return false
end

function Unit:HasThreat()
    if DMW.Enums.Threat[self.ObjectID] or DMW.Enums.SkipChecks[self.ObjectID] then
        return true
    elseif DMW.Enums.EnemyBlacklist[self.ObjectID] then
        return false
    elseif DMW.Player.Instance == "pvp" and (self.Player or UnitAffectingCombat(self.Pointer)) then
        return true
    elseif DMW.Player.Instance ~= "none" and UnitAffectingCombat(self.Pointer) then
        return true
    elseif DMW.Player.Instance == "none" and (self.Dummy or (UnitIsVisible("target") and UnitIsUnit(self.Pointer, "target"))) then
        return true
    end
    if not self.Player and self.Target and (UnitIsUnit(self.Target, "player") or UnitIsUnit(self.Target, "pet") or UnitInParty(self.Target) or UnitInRaid(self.Target) ~= nil) then
        return true
    end
    return false
end

function Unit:GetEnemies(Yards, TTD, RawDistance)
    local Table = {}
    local Count = 0
    TTD = TTD or 0
    for _, Unit in pairs(DMW.Enemies) do
        if RawDistance and self:RawDistance(Unit) <= Yards and Unit.TTD >= TTD then
            table.insert(Table, Unit)
            Count = Count + 1
        elseif self:GetDistance(Unit) <= Yards and Unit.TTD >= TTD then
            table.insert(Table, Unit)
            Count = Count + 1
        end
    end
    return Table, Count
end

function Unit:GetFriends(Yards, HP, RawDistance)
    local Table = {}
    local Count = 0
    -- local RawDist = RawDistance or false
    for _, v in pairs(DMW.Friends.Units) do
        if RawDistance and (not HP or v.HP < HP) and self:RawDistance(v) <= Yards then
            table.insert(Table, v)
            Count = Count + 1
        elseif (not HP or v.HP < HP) and self:GetDistance(v) <= Yards then
            table.insert(Table, v)
            Count = Count + 1
        end
    end
    return Table, Count
end

function Unit:HardCC()
    if DMW.Enums.HardCCUnits[self.ObjectID] then
        return true
    end
    local Settings = DMW.Settings.profile
    local StartTime, EndTime, SpellID, Type
    local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID = self:UnitCastingInfo()

    if name then
        StartTime = startTime / 1000
        SpellID = spellID
    else
        name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID = self:UnitChannelInfo()
        if name then
            StartTime = startTime / 1000
            SpellID = spellID
        end
    end
    if StartTime and SpellID and DMW.Enums.HardCCCasts[SpellID] then
        local Delay = Settings.Enemy.InterruptDelay
        if Delay < 0.1 then
            Delay = 0.1
        end
        if (DMW.Time - StartTime) > Delay then
            return true
        end
    end
    return false
end

function Unit:Interrupt()
    local InterruptTarget = DMW.Settings.profile.Enemy.InterruptTarget
    if DMW.Settings.profile.HUD.Interrupts == 3 or (InterruptTarget == 2 and not UnitIsUnit(self.Pointer, "target")) or
    (InterruptTarget == 3 and not UnitIsUnit(self.Pointer, "focus")) or
    (InterruptTarget == 4 and (not GetRaidTargetIndex(self.Pointer) or GetRaidTargetIndex(self.Pointer) ~= DMW.Settings.profile.Enemy.InterruptMark)) then
        return false
    end
    if not self:IsInterruptible() then return false end
    local checkInterrupts = false
    if DMW.Settings.profile.HUD.Interrupts == 2 then
        local name = self:CastName()
        for k in string.gmatch(DMW.Settings.profile.Enemy.InterruptSpellNames, "([^,]+)") do
            if strmatch(string.lower(name), string.lower(string.trim(k))) then
                checkInterrupts = true
                -- print("can interrupt")
                break
            end
        end
    elseif DMW.Settings.profile.HUD.Interrupts == 3 then
        local spellID = self:CastID()
        if DMW.Enums.InterruptWhiteList[spellID] then
            checkInterrupts = true
        end
    elseif DMW.Settings.profile.HUD.Interrupts == 1 then
        checkInterrupts = true
    end

    if checkInterrupts then
        -- local spellID = self:CastID()
        -- if DMW.Enums.InterruptBlacklist[spellID] and
        local Delay = DMW.Settings.profile.Enemy.InterruptDelay
        if (DMW.Time - self:CastStart()) >= Delay then
            return true
        end
    end
    return false
end

function Unit:Dispel(Spell)
    local AuraCache = DMW.Tables.AuraCache[self.Pointer]
    if not AuraCache or not Spell then
        return false
    end
    local DispelTypes = {}
    for _, v in pairs(DMW.Enums.DispelSpells[Spell.SpellID]) do
        DispelTypes[v] = true
    end
    local Elapsed
    local Delay = DMW.Settings.profile.Friend.DispelDelay - 0.2 + (math.random(1, 4) / 10)
    local ReturnValue = false
    --name, icon, count, debuffType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId
    local AuraReturn
    for _, Aura in pairs(AuraCache) do
        if (self.Friend and Aura.Type == "HARMFUL") or (not self.Friend and Aura.Type == "HELPFUL") then
            AuraReturn = Aura.AuraReturn
            Elapsed = AuraReturn[5] - (AuraReturn[6] - DMW.Time)
            if AuraReturn[4] and DispelTypes[AuraReturn[4]] and Elapsed > Delay then
                if DMW.Enums.NoDispel[AuraReturn[10]] then
                    ReturnValue = false
                    break
                elseif DMW.Enums.SpecialDispel[AuraReturn[10]] and DMW.Enums.SpecialDispel[AuraReturn[10]].Stacks then
                    if AuraReturn[3] >= DMW.Enums.SpecialDispel[AuraReturn[10]].Stacks then
                        ReturnValue = true
                    else
                        ReturnValue = false
                        break
                    end
                elseif DMW.Enums.SpecialDispel[AuraReturn[10]] and DMW.Enums.SpecialDispel[AuraReturn[10]].Range then
                    if select(2, self:GetFriends(DMW.Enums.SpecialDispel[AuraReturn[10]].Range)) < 2 then
                        ReturnValue = true
                    else
                        ReturnValue = false
                        break
                    end
                else
                    ReturnValue = true
                end
            end
        end
    end
    return ReturnValue
end

function Unit:PredictPosition(Time)
    local MoveDistance = GetUnitSpeed(self.Pointer) * Time
    if MoveDistance > 0 then
        local X, Y, Z = self.PosX, self.PosY, self.PosZ
        local Angle = ObjectFacing(self.Pointer)
        local UnitTargetDist = 0
        if self.Target then
            local TX, TY, TZ = ObjectPosition(self.Target)
            local TSpeed = GetUnitSpeed(self.Target)
            if TSpeed > 0 then
                local TMoveDistance = TSpeed * Time
                local TAngle = ObjectFacing(self.Target)
                TX = TX + cos(TAngle) * TMoveDistance
                TY = TY + sin(TAngle) * TMoveDistance
            end
            UnitTargetDist = sqrt(((TX - X) ^ 2) + ((TY - Y) ^ 2) + ((TZ - Z) ^ 2)) - ((self.CombatReach or 0) + (UnitCombatReach(self.Target) or 0))
            if UnitTargetDist < MoveDistance then
                MoveDistance = UnitTargetDist
            end
            Angle = rad(atan2(TY - Y, TX - X))
            if Angle < 0 then
                Angle = rad(360 + atan2(TY - Y, TX - X))
            end
        end
        X = X + cos(Angle) * MoveDistance
        Y = Y + cos(Angle) * MoveDistance
        return X, Y, Z
    end
    return self.X, self.Y, self.Z
end

function Unit:AuraByID(SpellID, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or false
    local SpellName = GetSpellInfo(SpellID)
    if DMW.Tables.AuraCache[self.Pointer] ~= nil and DMW.Tables.AuraCache[self.Pointer][SpellName] ~= nil and (not OnlyPlayer or DMW.Tables.AuraCache[self.Pointer][SpellName]["player"] ~= nil) then
        local AuraReturn
        if OnlyPlayer then
            AuraReturn = DMW.Tables.AuraCache[self.Pointer][SpellName]["player"].AuraReturn
        else
            AuraReturn = DMW.Tables.AuraCache[self.Pointer][SpellName].AuraReturn
        end
        return unpack(AuraReturn)
    end
    return false
end

function Unit:AuraByIDStacks(SpellID, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or false
    local SpellName = GetSpellInfo(SpellID)
    if DMW.Tables.AuraCache[self.Pointer] ~= nil and DMW.Tables.AuraCache[self.Pointer][SpellName] ~= nil and (not OnlyPlayer or DMW.Tables.AuraCache[self.Pointer][SpellName]["player"] ~= nil) then
        local AuraReturn
        if OnlyPlayer then
            AuraReturn = DMW.Tables.AuraCache[self.Pointer][SpellName]["player"].AuraReturn
        else
            AuraReturn = DMW.Tables.AuraCache[self.Pointer][SpellName].AuraReturn
        end
        return AuraReturn[3]
    end
    return 0
end

function Unit:AuraByName(SpellName, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or false
    local SpellName = SpellName
    if DMW.Tables.AuraCache[self.GUID] ~= nil and DMW.Tables.AuraCache[self.GUID][SpellName] ~= nil and (not OnlyPlayer or DMW.Tables.AuraCache[self.GUID][SpellName]["player"] ~= nil) then
        local AuraReturn
        if OnlyPlayer then
            AuraReturn = DMW.Tables.AuraCache[self.GUID][SpellName]["player"].AuraReturn
        else
            AuraReturn = DMW.Tables.AuraCache[self.GUID][SpellName].AuraReturn
        end
        return unpack(AuraReturn)
    end
    return nil
end

function Unit:AuraByNameStacks(SpellName, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or false
    local SpellName = SpellName
    if DMW.Tables.AuraCache[self.GUID] ~= nil and DMW.Tables.AuraCache[self.GUID][SpellName] ~= nil and (not OnlyPlayer or DMW.Tables.AuraCache[self.GUID][SpellName]["player"] ~= nil) then
        local AuraReturn
        if OnlyPlayer then
            AuraReturn = DMW.Tables.AuraCache[self.GUID][SpellName]["player"].AuraReturn
        else
            AuraReturn = DMW.Tables.AuraCache[self.GUID][SpellName].AuraReturn
        end
        return AuraReturn[3]
    end
    return nil
end

function Unit:CCed()
    for SpellID, _ in pairs(DMW.Enums.CCBuffs) do
        if self:AuraByID(SpellID) then
            return true
        end
    end
    return false
end

function Unit:IsQuest()
    -- if IsQuestObject(self.Pointer) then print(self.Name) end
    if not self.QuestCached or (DMW.Cache.QuestieCache.CacheTimer and self.Cache.QuestTime < DMW.Cache.QuestieCache.CacheTimer) then
        self.QuestCached = IsQuestObject(self.Pointer) or DMW.Helpers.QuestieHelper.isQuestieUnit(self.Pointer, self.GUID)
        self.Cache.QuestTime = DMW.Time

    end
    return self.QuestCached
end

-- function Unit:IsQuest()
--     if self.ObjectID and [self.ObjectID]

--     end
--     return self.QuestCached
-- end

-- function Unit:CastingInfo()
--     -- print(LibCC:UnitCastingInfo(self.Pointer))
--     return UnitCastingInfo(self.Pointer)
-- end

-- function Unit:ChannelInfo()
--     return UnitChannelInfo(self.Pointer)
-- end

function Unit:IsTrackable()
    if DMW.Settings.profile.Tracker.TrackUnits ~= nil and DMW.Settings.profile.Tracker.TrackUnits ~= "" and not self.Player then
        for k in string.gmatch(DMW.Settings.profile.Tracker.TrackUnits, "([^,]+)") do
            if strmatch(string.lower(self.Name), string.lower(string.trim(k))) then
                return true
            end
        end
    elseif self.Player and (DMW.Settings.profile.Tracker.TrackPlayersAny and DMW.Player.Pointer ~= self.Pointer) or (DMW.Settings.profile.Tracker.TrackPlayersEnemy and UnitCanAttack("player", self.Pointer)) then
        return true
    elseif self.Player and DMW.Settings.profile.Tracker.TrackPlayers ~= nil and DMW.Settings.profile.Tracker.TrackPlayers ~= "" then
        for k in string.gmatch(DMW.Settings.profile.Tracker.TrackPlayers, "([^,]+)") do
            if strmatch(string.lower(self.Name), string.lower(string.trim(k))) then
                return true
            end
        end
    end
    return false
end

function Unit:PowerPct()
    local Power = UnitPower(self.Pointer)
    local PowerMax = UnitPowerMax(self.Pointer)
    return Power / PowerMax * 100
end

function Unit:HasFlag(Flag)
    return bit.band(ObjectDescriptor(self.Pointer, GetOffset("CGUnitData__Flags"), "int"), Flag) > 0
end

function Unit:HasDynamicFlag(Flag)
    return bit.band(ObjectDescriptor(self.Pointer, GetOffset("CGUnitData__DynamicFlags"), "int"), Flag) > 0
end

function Unit:HasFlag2(Flag)
    return bit.band(ObjectDescriptor(self.Pointer, GetOffset("CGUnitData__Flags2"), "int"), Flag) > 0
end


function Unit:IsFeared()
    return self:HasFlag(DMW.Enums.UnitFlags.Feared)
end

function Unit:HasNPCFlag(Flag)
    if not self.NPCFlags then
        self.NPCFlags = ObjectDescriptor(self.Pointer, GetOffset("CGUnitData__NPCFlags"), "int")
    end
    return bit.band(self.NPCFlags, Flag) > 0
end

function Unit:HasMovementFlag(Flag)
    local SelfFlag = UnitMovementFlags(self.Pointer)
    if SelfFlag then
        return bit.band(UnitMovementFlags(self.Pointer), Flag) > 0
    end
    return false
end

function Unit:CanBeFeared()
    local table = DMW.Enums.FearImmuneBuffs
    for i = 1, #table do
        if self:AuraByID(table[i]) then
            return false
        end
    end
    return self.Attackable and self:IsEnemy()
end

-- function Unit:HealAmountIn(time, personal)
--     local Time = DMW.Time + time
--     if personal then
--         local total = HealComm:GetOthersHealAmount(self.GUID, 1, Time)
--         -- if total ~= nil then
--         --     -- print("total", HealComm:GetOthersHealAmount(self.GUID, 1, time))
--         -- end
--         return total or 0
--     end
--     local total = HealComm:GetHealAmount(self.GUID, 1, Time)
--     -- if total ~= nil then
--     --     -- print("total", HealComm:GetHealAmount(self.GUID, 1, time))
--     -- end
--     -- print("total", HealComm:GetHealAmount(self.GUID, 1, time))
--     return total or 0
-- end

function Unit:GetSwing(hand)
    return DMW.Helpers.Swing.GetSwing(self.Pointer, hand)
end

function Unit:IsDummy()
    if self.Dummy == nil then
        if DMW.Enums.DummyList[self.ObjectID] then
            self.Dummy = true
        else
            self.Dummy = false
        end
    else
        return self.Dummy
    end
end

function Unit:NoLoS()
    if self.NoLos == nil then
        if DMW.Enums.LoS[self.ObjectID] then
            self.NoLoS = true
        else
            self.NoLoS = false
        end
    else
        return self.NoLoS
    end
end

-- function Unit:IsExecutable()
--     if DMW.Player.Target and (DMW.Player.Buffs.SuddenDeathBuff:Exist() or DMW.Player.Target.HP < 20) then
--         return true
--     elseif self.HP < 20 and (not DMW.Player.Target or DMW.Player.Target.HP > 20) then

--         if UnitExists("target") then
--             local OldTarget = DMW.Player.Target.Pointer
--             TargetUnit(self.Pointer)
--             DMW.Player.Target = self
--             DMW.Player.Spells.Execute:Cast(self)
--             C_Timer.After(0.5, function() if not UnitIsUnit("target", OldTarget) then TargetUnit(OldTarget) end end)
--             return true
--         else
--             TargetUnit(self.Pointer)
--             DMW.Player.Target = self
--             DMW.Player.Spells.Execute:Cast(self)
--             return true
--         end
--     end
--     return false
-- end

function Unit:MarkCheck()
    if not self.MarkCached or (DMW.Cache.CacheMarkTimer and self.MarkCachedPulse < DMW.Cache.CacheMarkTimer) then
        self.MarkCached = GetRaidTargetIndex(self.Pointer) or 0
        self.MarkCachedPulse = DMW.Pulses
    end
    return self.MarkCached
end

function Unit:Facing()
    -- if IsHackEnabled("alwaysfacing") then return true end
    if self.FacingCheck == nil or (self.CacheFacingPulse and self.CacheFacingPulse < DMW.Pulses) then
        self.FacingCheck = UnitIsFacing("player", self.Pointer)--, 75)
        self.CacheFacingPulse = DMW.Pulses
    end
    return self.FacingCheck
end

function Unit:Reachable(Distance)
    local distanceMax = Distance or 40
    return self.Distance <= distanceMax and self.LoS
end


function Unit:NoTouchDungeons()
    if DMW.Player.Instance == "party" then
        if DMW.Enums.DoNotTouchListDungeons[DMW.Player.InstanceID] ~= nil then
            local instance = DMW.Enums.DoNotTouchListDungeons[DMW.Player.InstanceID]
            if instance[self.ObjectID] ~= nil then
                if instance[self.ObjectID].Buff ~= nil then
                    self.NoTouchCheck = "Buff"
                elseif instance[self.ObjectID].NoBuff ~= nil then
                    self.NoTouchCheck = "No Buff"
                else
                    self.NoTouchCheck = "None"
                end
            end
        end
    end
end

