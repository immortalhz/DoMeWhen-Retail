local DMW = DMW
local LocalPlayer = DMW.Classes.LocalPlayer

function LocalPlayer:New(Pointer)
    self.Pointer = Pointer
    self.CombatReach = 1.5
    self.BoundingRadius = UnitBoundingRadius(Pointer)
    self.Scale = ObjectDescriptor(Pointer, GetOffset("CGObjectData__Scale"), "float")
    self.PosX, self.PosY, self.PosZ = ObjectPosition(Pointer)
    self.GUID = ObjectGUID(Pointer)
    self.Class = select(2, UnitClass(Pointer)):gsub("%s+", "")
    self.Level = UnitLevel(Pointer)
    self.Distance = 0
    self.Combat = UnitAffectingCombat(self.Pointer) and DMW.Time or false
    self.CombatLeft = false
    self.EID = false
    self.NoControl = false
    self.Name = "LocalPlayer"
    self.Equipment = {}
    self.Professions = {}
    self.Items = {}
    self.Looting = false
    self.Instance = select(2, IsInInstance())
    DMW.Functions.AuraCache.Refresh(self.Pointer)
    self:UpdateVariables()
    -- self:UpdateProfessions()

    -- if self.Class == "WARRIOR" then
    --     self.OverpowerUnit = {}
    --     self.RevengeUnit = {}
    -- elseif self.Class == "SHAMAN" then
    --     self.Totems.Fire = {}
    --     self.Totems.Earth = {}
    --     self.Totems.Water = {}
    --     self.Totems.Air = {}
    -- end
    -- self.SwingMH = 0
    -- self.SwingOH = false

    -- DMW.Helpers.Swing.AddUnit(Pointer)

end

-- functio

function LocalPlayer:UpdateVariables()
    self.SpecID = DMW.Enums.ClassSpec[GetSpecializationInfo(GetSpecialization())] and DMW.Enums.ClassSpec[GetSpecializationInfo(GetSpecialization())][2] or "sub10"
    self:GetSpells()
    self:GetTalents()
    self:UpdateEquipment()
    self:GetItems()
    C_Timer.After(1, function() LocalPlayer:RefreshItems() end)
    self:GetTraits()
    self:GetCovenant()
    self:UpdatePower("Fill")
    DMW.Helpers.Queue.GetBindings()
end

function LocalPlayer:PlayerCastingCheck()
    if not UnitIsVisible("player") then return nil end
    local cast, channel, castTarget, channelTarget = UnitCastID(self.Pointer)
    -- print(UnitCastID("player"))
    if cast ~= 0 then
        -- if castTarget then
        --     self.
        return cast
    elseif channel ~= 0 then
        return channel
    end
    return false
end

function LocalPlayer:Update()
    self.PosX, self.PosY, self.PosZ = ObjectPosition(self.Pointer)
    --[[
        TODO: Time Check refresh
    ]]
    -- DMW.Functions.AuraCache.Refresh(self.Pointer, self.GUID)
    self.Health = UnitHealth(self.Pointer)
    self.HealthMax = UnitHealthMax(self.Pointer)
    self.HP = self.Health / self.HealthMax * 100
	self.Casting = self:PlayerCastingCheck()
    self.Power = UnitPower(self.Pointer)
    self.PowerMax = UnitPowerMax(self.Pointer)
    self.PowerDeficit = self.PowerMax - self.Power
    self.PowerPct = self.Power / self.PowerMax * 100
	-- if self.Casting and self.Casting == 8613 then
	-- 	local skinned = select(3,UnitCastID("player"))
	-- 	if DMW.Units[skinned] then
	-- 		DMW.Units[skinned]["JustSkinned"] = true
	-- 	end
	-- end
	self.Looting = self:HasFlag(DMW.Enums.UnitFlags.Looting)
    -- if self.Casting ~= nil then
    --     print(self.Casting)
    -- end
    -- print(self.Casti)

    -- self.CastingID, _, self.CastingDestination = UnitCastID("player")
    -- if self.CastingDestination and self.Casting then print(UnitName(self.CastingDestination)) end
    --         local castTime = select(4, GetSpellInfo(self.CastingID))
    --         if castTime then
    --             self.CastingEnd = DMW.Time + castTime/1000
    --         end
    --     end
    -- else
    --     self.CastingID = nil
    --     self.CastingEnd = nil
    --     self.CastingLeft = nil
    --     self.CastingDestination = nil
    --     self.Predicted = nil
    -- end
    -- if self.CastingEnd then
    --     self.CastingLeft = self.CastingEnd - DMW.Time
    --     -- print(self.CastingLeft)
    -- end
    -- if self.Power == nil then  end

    if not self.Combat and UnitAffectingCombat("player") then self.Combat = DMW.Time end
    -- if self.Class == "ROGUE" or self.Class == "DRUID" then
    --     self.ComboPoints = GetComboPoints("player", "target")
    --     self.ComboMax = 5 --UnitPowerMax(self.Pointer, 4)
    --     self.ComboDeficit = self.ComboMax - self.ComboPoints
    --     if self.TickTime and DMW.Time >= self.TickTime then
    --         self.TickTime = self.TickTime + 2
    --     end
    --     if self.TickTime then
    --         self.NextTick = self.TickTime - DMW.Time
    --     end
    -- end
    self.Instance = select(2, IsInInstance())
    if self.Instance ~= "none" then self.InstanceID = select(8, GetInstanceInfo()) else self.InstanceID = nil end
    -- if self.Instance == "party" or self.Instance == "pvp" then self.InstanceMap = GetInstanceInfo() end
    self.Moving = self:HasMovementFlag(DMW.Enums.MovementFlags.Moving)
    self.PetActive = UnitIsVisible("pet")
    self.InGroup = IsInGroup()
    self.CombatTime = self.Combat and (DMW.Time - self.Combat) or 0
    self.CombatLeftTime = self.CombatLeft and (DMW.Time - self.CombatLeft) or 0
    self.Resting = IsResting()
    -- if self.UpdateTotemsCacheCheck then
    --     self:UpdateTotemsCache()
    -- end
    -- if self.DOTed then
    --     local count = 0
    --     for spell in pairs(self.DOTed) do
    --         count = count + 1
    --         if DMW.Time > self.DOTed[spell] then
    --             self.DOTed[spell] = nil
    --         end
    --     end
    --     if count == 0 then
    --         self.DOTed = nil
    --     end
    -- end
    -- Swings
    -- if DMW.Tables.Swing.Units[self.Pointer] ~= nil then
    --     self.SwingMH = DMW.Tables.Swing.Units[self.Pointer].SwingMH
    --     self.SwingOH = DMW.Tables.Swing.Units[self.Pointer].SwingOH
    -- end
    if self.InstanceID == 2212 or self.InstanceID == 2213 then
        if not self.BadPotion then
            local shortestRange, badPot
            for _, GameObject in pairs(DMW.GameObjects) do
                if GameObject.ObjectID == 341342 or GameObject.ObjectID == 341362 then
                    print("Found bad note")
                    for _, Pot in pairs(DMW.GameObjects) do
                        if DMW.Enums.VisionsPots[Pot.ObjectID] then
                            local dist = GetDistanceBetweenObjects(GameObject.Pointer, Pot.Pointer)
                            if dist and (not shortestRange or shortestRange > dist) then
                                shortestRange = dist
                                badPot = Pot.ObjectID
                                print("badpot = ".. Pot.Name, "dist = " .. shortestRange)
                            end
                        end

                    end
                end
            end
            self.BadPotion = badPot
        end
    end
    if IsFlying() then self.Flying = true end
end

function LocalPlayer:UpdatePower(arg, PowerType)
    if arg == "Fill" then
        if DMW.Enums.ClassPowerTypes[self.Class] then
            for _, powerName in ipairs(DMW.Enums.ClassPowerTypes[self.Class]) do
                -- print(powerName)
                local typeNum = DMW.Enums.PowerTypes[powerName][2]
                -- print(typeNum)
                self[powerName] = UnitPower(self.Pointer, typeNum)
                self[powerName .. "Max"] = UnitPowerMax(self.Pointer, typeNum)
                self[powerName .. "Deficit"] = self[powerName .. "Max"] - self[powerName]
                self[powerName .. "Pct"] = self[powerName] / self[powerName .. "Max"] * 100
            end
        end
        -- self.Power = UnitPower(self.Pointer, 0)
        -- self.PowerMax = UnitPowerMax(self.Pointer, 0)
        -- if self.SpecID ~= "LowLevel" then
        --     self.Shards = UnitPower(self.Pointer, 7)
        -- end
    else

        -- if PowerType == "SOUL_SHARDS" or PowerType == "MANA" then
        local typeNum = DMW.Enums.PowerTypesToCheck[PowerType][1]
        local powerName = DMW.Enums.PowerTypesToCheck[PowerType][2]
        if not self[powerName] then return end
        if arg == "Max" then
            self[powerName .. "Max"] = UnitPowerMax(self.Pointer, typeNum)
        elseif arg == "Current" then
            self[powerName] = UnitPower(self.Pointer, typeNum)
        end
        self[powerName .. "Deficit"] = self[powerName .. "Max"] - self[powerName]
        self[powerName .. "Pct"] = self[powerName] / self[powerName .. "Max"] * 100
        -- end
    end
    -- self.Power = UnitPower(self.Pointer)
    -- self.Power = self:PredictedPower()
    -- self.PowerMax = UnitPowerMax(self.Pointer)
    -- self.PowerDeficit = self.PowerMax - self.Power
    -- self.PowerPct = self.Power / self.PowerMax * 100
    -- self.PowerRegen = GetPowerRegen()
end

function LocalPlayer:NewTotem(spellID)
    if spellID ~= nil and DMW.Tables.Totems[spellID] ~= nil then
        local totem, element, duration, key, realName
        totem = DMW.Tables.Totems[spellID]
        element = totem["Element"]
        duration = totem["Duration"]
        realName = totem["SpellName"]
        key = totem["Key"]
        table.wipe(self.Totems[element])
        self.Totems[element].Name = key
        self.Totems[element].RealName = realName
        self.Totems[element].Expire = DMW.Time + duration --     -- print(self.Totems[element].Unit)
        --     -- print("new totem")

        --     -- print(self.Totems[element].Unit)
        --     -- print("new totem")
        C_Timer.After(1.2, function() DMW.Player:UpdateTotem(element) end)
    end
    -- local TotemSpells

end

function LocalPlayer:UpdateTotem(element)
    if element ~= nil then
        -- local element = DMW.Tables.Totems.Elements[slotID]
        if not self.Totems[element]["Updated"] then
            local totemLinked = self.Totems[element] -- print(totemLinked)

            -- print(totemLinked)
            if totemLinked and totemLinked.Name and totemLinked.Unit == nil then
                for k, v in pairs(DMW.Units) do
                    if v.Name:find(totemLinked.RealName) and ObjectCreator(v.Pointer) == self.Pointer then
                        totemLinked.Unit = v
                        totemLinked.Pointer = v.Pointer -- print("updated totem"..totemLinked.RealName)

                        -- print("updated totem"..totemLinked.RealName)
                        break
                        -- else
                        --     table.wipe(self.Totems[element])
                    end
                end
            end
            self.Totems[element]["Updated"] = true
            -- else
            --     table.wipe(self.Totems[element])
        end
    end
end

function LocalPlayer:UpdateTotemsCache()
    local count = 0
    for _, Element in pairs(self.Totems) do
        if Element.Name and not Element.Unit then
            count = count + 1
            for k, v in pairs(DMW.Units) do
                if v.Name:find(Element.RealName) and ObjectCreator(v.Pointer) == self.Pointer then
                    Element.Unit = v
                    Element.Pointer = v.Pointer -- print("updated totem")

                    -- print("updated totem")
                    break
                end
            end
        end
    end
    if count > 0 then self.UpdateTotemsCacheCheck = true end
end

function LocalPlayer:PredictedPower()
    if self.Casting then
        local SpellID = select(9, UnitCastingInfo("player"))
        if SpellID then
            local CostTable = GetSpellPowerCost(SpellID)
            if CostTable then
                for _, CostInfo in pairs(CostTable) do if CostInfo.cost > 0 then return (self.Power - CostInfo.cost) end end
            end
        end
    end
    return self.Power
end

local GCDSpell = 61304
function LocalPlayer:GCDRemain()
    if not self.CachedGCDTime or DMW.Time > self.CachedGCDTime then
    -- if self.Class == "DRUID" then
    --     if self:AuraByID(768,true) then GCDSpell = GCDList[self.Class].CAT else GCDSpell = GCDList[self.Class].NONE end
    -- else
    --     GCDSpell = GCDList[self.Class]
    -- end
        self.CachedGCDTime = DMW.Time
        local Start, CD = GetSpellCooldown(GCDSpell)
        if Start == 0 then
            self.CachedGCD = 0
        else
            self.CachedGCD = math.max(0, (Start + CD) - DMW.Time)
        end
    end
    return self.CachedGCD
end

function LocalPlayer:GCD()
    if self.Class == "ROGUE" or (self.Class == "DRUID" and self:AuraByID(768, true)) then
        return 1
    else
        return 1.5
    end
end

local sqCached, sqCachedTime
function LocalPlayer:SpellQueued()
    if not sqCached or DMW.Time - sqCachedTime > 0 then
        sqCached = false
        sqCachedTime = DMW.Time
        for _, spell in pairs(DMW.Player.Spells) do
            if spell.SpellID ~= 232698 and spell.SpellID ~= 6603 and IsCurrentSpell(spell.SpellID) then
                -- print("queued "..spell.Key)
                -- print(DMW.Time, 'sq Found')
                -- print(DMW.Player:GCDRemain(), " gcd")
                sqCached = spell.SpellName
                break
            end
        end
    end
    return sqCached
end

function LocalPlayer:CDs()
    if DMW.Settings.profile.HUD.CDs and DMW.Settings.profile.HUD.CDs == 3 then
        return false
    elseif DMW.Settings.profile.HUD.CDs and DMW.Settings.profile.HUD.CDs == 2 then
        return true
    elseif self.Target and self.Target:IsBoss() then
        return true
    end
    return false
end

function LocalPlayer:CritPct() return GetCritChance() end

function LocalPlayer:TTM()
    local PowerMissing = self.PowerMax - self.Power
    if PowerMissing > 0 then
        return PowerMissing / self.PowerRegen
    else
        return 0
    end
end

function LocalPlayer:Standing()
    if ObjectDescriptor("player", GetOffset("CGUnitData__AnimTier"), Types.Byte) == 0 then return true end
    return false
end

function LocalPlayer:Dispel(Spell)
    local AuraCache = DMW.Tables.AuraCache[self.GUID]
    if not AuraCache or not Spell then return false end
    local DispelTypes = {}
    for k, v in pairs(DMW.Enums.DispelSpells[Spell.SpellID]) do DispelTypes[v] = true end
    local Elapsed
    local Delay = DMW.Settings.profile.Friend.DispelDelay - 0.2 + (math.random(1, 4) / 10)
    local ReturnValue = false
    -- name, icon, count, debuffType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId
    local AuraReturn
    for _, Aura in pairs(AuraCache) do
        if Aura.Type == "HARMFUL" then
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

function LocalPlayer:HasFlag(Flag) return bit.band(ObjectDescriptor(self.Pointer, GetOffset("CGUnitData__Flags"), "int"), Flag) > 0 end

function LocalPlayer:AuraByID(SpellID, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or false
    local SpellName = GetSpellInfo(SpellID)
    if DMW.Tables.AuraCache[self.Pointer] ~= nil and DMW.Tables.AuraCache[self.Pointer][SpellName] ~= nil and
        (not OnlyPlayer or DMW.Tables.AuraCache[self.Pointer][SpellName]["player"] ~= nil) then
        local AuraReturn
        if OnlyPlayer then
            AuraReturn = DMW.Tables.AuraCache[self.Pointer][SpellName]["player"].AuraReturn
        else
            AuraReturn = DMW.Tables.AuraCache[self.Pointer][SpellName].AuraReturn
        end
        return unpack(AuraReturn)
    end
    return nil
end

function LocalPlayer:StacksByID(SpellID, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or false
    local SpellName = GetSpellInfo(SpellID)
    if DMW.Tables.AuraCache[self.Pointer] ~= nil and DMW.Tables.AuraCache[self.Pointer][SpellName] ~= nil and
        (not OnlyPlayer or DMW.Tables.AuraCache[self.Pointer][SpellName]["player"] ~= nil) then
        local Stacks
        if OnlyPlayer then
            Stacks = DMW.Tables.AuraCache[self.Pointer][SpellName]["player"].AuraReturn[3]
        else
            Stacks = DMW.Tables.AuraCache[self.Pointer][SpellName].AuraReturn[3]
        end
        return Stacks
    end
    return 0
end

function LocalPlayer:AuraByName(SpellName, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or false
    local SpellName = SpellName
    if DMW.Tables.AuraCache[self.Pointer] ~= nil and DMW.Tables.AuraCache[self.Pointer][SpellName] ~= nil and
        (not OnlyPlayer or DMW.Tables.AuraCache[self.Pointer][SpellName]["player"] ~= nil) then
        local AuraReturn
        if OnlyPlayer then
            AuraReturn = DMW.Tables.AuraCache[self.Pointer][SpellName]["player"].AuraReturn
        else
            AuraReturn = DMW.Tables.AuraCache[self.Pointer][SpellName].AuraReturn
        end
        return unpack(AuraReturn)
    end
    return nil
end

function LocalPlayer:HasMovementFlag(Flag)
    local SelfFlag = UnitMovementFlags(self.Pointer)
    if SelfFlag then return bit.band(UnitMovementFlags(self.Pointer), Flag) > 0 end
    return false
end

function LocalPlayer:GetFreeBagSlots()
    local Slots = 0
    for i = 0, 4, 1 do Slots = Slots + GetContainerNumFreeSlots(i) end
    return Slots
end

function LocalPlayer:GetSwing(hand) return DMW.Helpers.Swing.GetSwing(self.Pointer, hand) end

function LocalPlayer:HasHeroism() for k in ipairs(DMW.Enums.HeroismBuff) do if LocalPlayer:AuraByID(k) then return true end end end

local function ComputeRuneCooldown(Slot, BypassRecovery)
    -- Get rune cooldown infos
    local CDTime, CDValue = GetRuneCooldown(Slot)
    -- Return 0 if the rune isn't in CD.
    if CDTime == 0 then return 0 end
    -- Compute the CD.
    local CD = CDTime + CDValue - DMW.Time -- Return the Rune CD

    -- Return the Rune CD
    return CD > 0 and CD or 0
end

-- rune
function LocalPlayer:Rune()
    local Count = 0
    for i = 1, 6 do if ComputeRuneCooldown(i) == 0 then Count = Count + 1 end end
    return Count
end

-- rune.time_to_x
function LocalPlayer:RuneTimeToX(Value)
    if type(Value) ~= "number" then error("Value must be a number.") end
    if Value < 1 or Value > 6 then error("Value must be a number between 1 and 6.") end
    local Runes = {}
    for i = 1, 6 do Runes[i] = ComputeRuneCooldown(i) end
    table.sort(Runes, function(a, b) return a < b end)
    local Count = 1
    for _, CD in pairs(Runes) do
        if Count == Value then return CD end
        Count = Count + 1
    end
end

function LocalPlayer:UpdateMarkCache() DMW.Cache.CacheMarkTimer = DMW.Pulses end

-- crit_chance
function LocalPlayer:CritChancePct() return GetCritChance() end

-- haste
function LocalPlayer:HastePct() return GetHaste() end

function LocalPlayer:SpellHaste() return 1 / (1 + (self:HastePct() / 100)) end

-- mastery
function LocalPlayer:MasteryPct() return GetMasteryEffect() end

-- versatility
function LocalPlayer:VersatilityDmgPct()
    return GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE)
end

local GCD_OneSecond = {
    ["Feral"] = true, -- Feral
    ["Assassination"] = true, -- Assassination
    ["Outlaw"] = true, -- Outlaw
    ["Subtlety"] = true, -- Subtlety
    ["Brewmaster"] = true, -- Brewmaster
    ["Windwalker"] = true -- Windwalker
}

function LocalPlayer:GCD()
    if GCD_OneSecond[self.SpecID] then
        return 1
    else
        local GCD_Value = 1.5 / (1 + self:HastePct() / 100)
        return (GCD_Value > 0.75 and GCD_Value) or 0.75
    end
end

function LocalPlayer:TraitActive(TraitName)
    if self.Traits and self.Traits[TraitName] and self.Traits[TraitName] > 0 then
        return true
    else
        return false
    end
end

function LocalPlayer:TraitRank(TraitName)
    if self.Traits[TraitName]  then
        return self.Traits[TraitName]
    else
        return 0
    end
end

function LocalPlayer:EssenceMajor(Name)
    -- if #self.Essences.Major == 1 then
    --     if self.Essences.Major[1].Name == Name then
    --         return true
    --     end
    -- end
    return false
end

function LocalPlayer:InterruptsMode()
    return DMW.Settings.profile.HUD.Interrupts
end

function LocalPlayer:UseTrinket(TrinketID)
    if DMW.Player.Equipment[13] == TrinketID then
        RunMacroText("/use 13")
    elseif DMW.Player.Equipment[14] == TrinketID then
        RunMacroText("/use 14")
    end
end

function LocalPlayer:IsCCed(Effect)
    --C_LossOfControl.GetActiveLossOfControlData
    local eventIndex = C_LossOfControl.GetNumEvents()
    while (eventIndex > 0) do
        local _,_,text = C_LossOfControl.GetEventInfo(eventIndex)
        if (text == LOSS_OF_CONTROL_DISPLAY_FEAR or text == LOSS_OF_CONTROL_DISPLAY_ROOT or text == LOSS_OF_CONTROL_DISPLAY_SNARE or text == LOSS_OF_CONTROL_DISPLAY_STUN) then
            return Effect == "Fear"
        end
        eventIndex = eventIndex - 1
    end
end

function LocalPlayer:DumpSpells()
	for _, Unit in pairs(DMW.Units) do
		if Unit:IsCasting() and not Unit.Player then
			WriteFile("CastsDump.txt", Unit.Name.." (".. Unit.ObjectID ..") is casting "..Unit:CastIdName().."("..Unit:CastIdCheck()..")\n", true)
		end
	end
end

function LocalPlayer:TargetOverride()
	if not self.Target or not self.Target.ObjectID then print("Error, no Target found"); return end
	local losCheck = self.Target.LoS
	local threatCheck = self.Target:IsEnemy()
	local string = "ID = "..self.Target.ObjectID..", Name = "..self.Target.Name .. ", Dist = "..self.Target.Distance
	if not losCheck then
		string = string .. " LoS Failed "
	end
	if not threatCheck then
		string = string .. " Enemy Check Failed"
	end
	print(string)
	WriteFile("LosThreatChecks.txt", string.."\n", true)
    DMW.Enums.LoS[self.Target.ObjectID] = true
	DMW.Enums.Threat[self.Target.ObjectID] = true
	-- DMW.Enums.MeleeForced[self.Target.ObjectID] = true
end

function LocalPlayer:Conduit(Name)
	if self.Conduits[Name] then return true end
	return false
end

function LocalPlayer:Soulbind(Name)
	if self.Soulbind == Name then return true end
	return false
end
