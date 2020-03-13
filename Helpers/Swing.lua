local DMW = DMW
local swingTimerFrame
local checkbuff
local resetMeleeList = {
    1464, 8820, 11604, 11605, -- Slam
    78, 284, 285, 1608, 11564, 11565, 11566, 11567, 25286, -- Heroic Strike
    845, 7369, 11608, 11609, 20569, -- Cleave
    2973, 14260, 14261, 14262, 14263, 14264, 14265, 14266, -- Raptor Strike
    6807, 6808, 6809, 8972, 9745, 9880, 9881, -- Maul
    20549 -- War Stomp
}

DMW.Helpers.Swing = {}
DMW.Tables.Swing = {}
DMW.Tables.Swing.Units = {}
-- hooksecurefunc(DMW, "Remove", function(pointer)
--     if Swing.Units[pointer] then
--         Swing.Units[pointer] = nil
--         print("removed swingunit")
--     end
-- end)
-- DMW.Tables.Swing.Reset = {['WARRIOR'] = {["Cleave"] = true, ["Heroic Strike"] = true, ["Slam"] = true}, ['DRUID'] = {["Maul"] = true}}
-- ======================--=================================================-- ======================--=================================================
DMW.Helpers.Swing.AddUnit = function(Pointer, player) -- Pointer
    if DMW.Tables.Swing.Units[Pointer] == nil then
        DMW.Tables.Swing.Units[Pointer] = {}
        local Unit = DMW.Tables.Swing.Units[Pointer]
        local mainSpeed, offSpeed = UnitAttackSpeed(Pointer)
        local rangeSpeed = UnitRangedDamage(Pointer)
        offSpeed = offSpeed or 0
        Unit.mainSpeed, Unit.offSpeed = mainSpeed, offSpeed
        Unit.offSwingOffset, Unit.offSwingOffset = 0,0
        Unit.swingDurationMain, Unit.swingDurationOff, Unit.swingDurationRange = mainSpeed, offSpeed, rangeSpeed
    end
end

DMW.Helpers.Swing.resetMH = function(Pointer)
    local Unit = DMW.Tables.Swing.Units[Pointer]
    -- local timeLeft = (Unit.mainLand and Unit.mainLand - DMW.Time) or 0
    -- print(DMW.Time)
    if DMW.Player.Pointer == Pointer then
        DMW.Player.SwingDump = nil
    end
    Unit.lastSwingMain = DMW.Time
    Unit.swingDurationMain = Unit.mainSpeed
    Unit.mainSwingOffset = 0
    Unit.mainForced = nil
    Unit.TimeCache = nil
    Unit.mainLand = DMW.Time + Unit.mainSpeed

end

DMW.Helpers.Swing.resetOH = function(Pointer)
    local Unit = DMW.Tables.Swing.Units[Pointer]
    Unit.lastSwingOff = DMW.Time
    Unit.swingDurationOff = Unit.offSpeed
    Unit.offSwingOffsetSwingOffset = 0
    Unit.offLand = DMW.Time + Unit.offSpeed
end


-- hand = main, off, ranged
DMW.Helpers.Swing.GetSwing = function(unitPointer, hand)
    if DMW.Tables.Swing.Units[unitPointer] == nil then
        return nil
    else
        local Unit = DMW.Tables.Swing.Units[unitPointer]
        if hand == "main" then
            if Unit.lastSwingMain then
                -- local timeLeft = (Unit.mainForced ~= nil and Unit.mainForced - GetTime()) or (Unit.lastSwingMain + Unit.swingDurationMain - Unit.mainSwingOffset - GetTime())
                local timeLeft = (Unit.mainLand - DMW.Time)
                if timeLeft < 0 then timeLeft = 0 end
                return timeLeft, Unit.swingDurationMain
            else
                return math.huge, Unit.swingDurationMain
            end
        elseif hand == "off" then
            if Unit.lastSwingOff then
                local timeLeft = (Unit.offLand - DMW.Time)
                if timeLeft < 0 then timeLeft = 0 end
                return timeLeft, Unit.swingDurationOff
            else
                return math.huge, swingDurationOff
            end
        elseif hand == "ranged" then
            if Unit.lastSwingRange then
                local timeLeft = (Unit.rangeLand - DMW.Time)
                if timeLeft < 0 then timeLeft = 0 end
                return timeLeft, Unit.swingDurationRange
            else
                return math.huge, Unit.swingDurationRange
            end
        end
    end
end

local function swingTimerCLEUCheck(ts, event, _, sourceGUID, _, _, _, destGUID, _, _, _, ...)
    local sourcePointer = DMW.Tables.Misc.guid2pointer[sourceGUID]
    local destPointer = DMW.Tables.Misc.guid2pointer[destGUID]
    if DMW.Tables.Swing.Units[sourcePointer] ~= nil then
        if event == "SWING_DAMAGE" or event == "SWING_MISSED" then
            local Unit = DMW.Tables.Swing.Units[sourcePointer]
            local isOffHand = select(event == "SWING_DAMAGE" and 10 or 2, ...)
            -- print(DMW.Helpers.Swing.GetSwing(DMW.Player.Pointer, "main"))
            -- local currentTime = GetTime()
            -- if Unit == nil then print(Unit) end
            Unit.mainSpeed, Unit.offSpeed = UnitAttackSpeed(sourcePointer)
            Unit.offSpeed = Unit.offSpeed or 0
            if not isOffHand then
                DMW.Helpers.Swing.resetMH(sourcePointer)
                -- event = "SWING_TIMER_START"
                -- timer:CancelTimer(mainTimer)
                -- mainTimer = timer:ScheduleTimerFixed(swingEnd, mainSpeed, "main")
            elseif isOffHand then
                DMW.Helpers.Swing.resetOH(sourcePointer)
                -- event = "SWING_TIMER_START"
                -- timer:CancelTimer(offTimer)
                -- offTimer = timer:ScheduleTimerFixed(swingEnd, offSpeed, "off")
            end
            -- WeakAuras.ScanEvents(event)
        end
    end
    if DMW.Tables.Swing.Units[destPointer] ~= nil and (select(1, ...) == "PARRY" or select(4, ...) == "PARRY") then
        local Unit = DMW.Tables.Swing.Units[destPointer]
        if Unit.lastSwingMain then
            local timeLeft = DMW.Helpers.Swing.GetSwing(destPointer, "main")
            if (timeLeft > 0.6 * Unit.swingDurationMain) then
                -- timer:CancelTimer(mainTimer)
                -- mainTimer = timer:ScheduleTimerFixed(swingEnd, timeLeft - 0.4 * swingDurationMain, "main")
                Unit.mainSwingOffset = 0.4 * Unit.swingDurationMain
                Unit.mainLand = Unit.mainLand - Unit.mainSwingOffset
                -- WeakAuras.ScanEvents("SWING_TIMER_CHANGE")
            elseif (timeLeft > 0.2 * Unit.swingDurationMain) then
                -- timer:CancelTimer(mainTimer)
                -- mainTimer = timer:ScheduleTimerFixed(swingEnd, timeLeft - 0.2 * swingDurationMain, "main")
                Unit.mainSwingOffset = 0.2 * Unit.swingDurationMain
                -- WeakAuras.ScanEvents("SWING_TIMER_CHANGE")
            end
        end
    end
    if DMW.Tables.Swing.Units[destPointer] ~= nil then
        if event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REMOVED" then
            -- print(select(2, ...))
            if select(2, ...) == "Flurry" then
                -- print("flurry")
                Unit = DMW.Tables.Swing.Units[destPointer]
                -- local mainSpeedNew, offSpeedNew = UnitAttackSpeed("player")
                -- offSpeedNew = offSpeedNew or 0
                if Unit.lastSwingMain then
                    Unit.TimeCache = DMW.Time
                    -- if mainSpeedNew ~= Unit.mainSpeed then
                        -- local multiplier
                        -- -- if event == "SPELL_AURA_APPLIED" then
                        --     multiplier = 1 / 1.3
                        --     print("faster")
                        -- else
                        --     -- multiplier = 1/ (1/1.3)
                        --     print("slower")
                        -- end
                        -- local timeLeft = (Unit.mainLand - DMW.Time) * multiplier
                        -- Unit.swingDurationMain = mainSpeedNew
                        -- Unit.mainLand = DMW.Time + timeLeft -- Unit.mainSpeed * multiplier
                        -- if checkbuff ~= nil then
                        --     print(checkbuff)
                        --     print(Unit.mainLand)

                        -- end
                    -- end
                end
            end
        end
    end
    -- WeakAuras.StopProfileSystem("generictrigger swing")
end

local function swingTimerEventCheck(event, unit, guid, spell)
    -- print(event, unit, guid, spell)
    local unitPointer = DMW.Tables.Misc.guid2pointer[UnitGUID(unit)]
    -- if DMW.Tables.Swing.Units[unitPointer] == nil then return end
    local Unit = DMW.Tables.Swing.Units[unitPointer]
    if Unit then
        if event == "UNIT_ATTACK_SPEED" then
            -- C_Timer.After(0.5, function()
            -- local mainSpeed, offSpeed = Unit.mainSpeed, Unit.offSpeed
            local mainSpeedNew, offSpeedNew = UnitAttackSpeed("player")
            offSpeedNew = offSpeedNew or 0
            if Unit.lastSwingMain then
                if mainSpeedNew ~= Unit.mainSpeed and Unit.TimeCache then
                    -- timer:CancelTimer(mainTimer)
                    -- local multiplier = mainSpeedNew / mainSpeed
                    -- local timeLeft = (lastSwingMain + swingDurationMain - GetTime()) * multiplier
                    -- swingDurationMain = mainSpeedNew
                    -- checkbuff = Unit.mainLand
                    local multiplier = mainSpeedNew / Unit.mainSpeed
                    -- print(multiplier)
                    if Unit.mainSpeed > mainSpeedNew then
                        -- multiplier = 0.8
                        -- print("faster")
                    else
                        -- multiplier = 0.8
                        -- print("slower")
                    end





                    local timeLeft = (Unit.TimeCache and (Unit.mainLand - Unit.TimeCache) * multiplier) or (Unit.mainLand - DMW.Time) * multiplier
                    -- Unit.mainForced = GetTime() + timeLeft
                    Unit.swingDurationMain = mainSpeedNew
                    ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                    Unit.mainLand = Unit.TimeCache + timeLeft
                    -- print(DMW.Time - Unit.TimeCache.. "Difference " ) -- Unit.mainSpeed * multiplier
                    -- Unit.mainLand = DMW.Time + timeLeft
                    -- print("as changed")
                    -- swingDurationMain = mainSpeedNew
                    -- mainTimer = timer:ScheduleTimerFixed(swingEnd, timeLeft, "main")
                end
            end
            if Unit.lastSwingOff then
                if offSpeedNew ~= Unit.offSpeed then
                    local multiplier = offSpeedNew / Unit.offSpeed
                    local timeLeft = DMW.Helpers.Swing.GetSwing(unitPointer, "off") * multiplier
                    Unit.offForced = GetTime() + timeLeft
                    Unit.swingDurationOff = offSpeedNew
                    -- offTimer = timer:ScheduleTimerFixed(swingEnd, timeLeft, "off")
                end
            end
            Unit.mainSpeed, Unit.offSpeed = mainSpeedNew, offSpeedNew
        -- end)
        elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
            if DMW.Tables.Swing.ResetMelee[spell] then
                -- local event
                -- print(spell.. "         "..DMW.Time)
                DMW.Helpers.Swing.resetMH(unitPointer)
                -- print("slam  "..DMW.Time)
                -- if (lastSwingMain) then
                --     timer:CancelTimer(mainTimer)
                --     event = "SWING_TIMER_CHANGE"
                -- else
                --     event = "SWING_TIMER_START"
                -- end
                -- mainTimer = timer:ScheduleTimerFixed(swingEnd, mainSpeed, "main")
                -- WeakAuras.ScanEvents(event)
            elseif DMW.Tables.Swing.ResetRanged[spell] then
                Unit.rangedSpeed = UnitRangedDamage("player")
                -- if Unit.lastSwingRange then timer:CancelTimer(rangeTimer, true) end
                Unit.lastSwingRange = GetTime()
                Unit.swingDurationRange = Unit.rangedSpeed
                -- if WeakAuras.IsClassic() then
                --     rangeTimer = timer:ScheduleTimerFixed(swingEnd, speed, "ranged")
                -- else
                --     mainTimer = timer:ScheduleTimerFixed(swingEnd, speed, "main")
                -- end
            end
        end
    end
end

DMW.Helpers.Swing.InitSwingTimer = function()
    -- DMW.Tables.Swing = {}
    -- DMW.Tables.Swing.Units = {}
    DMW.Tables.Swing.ResetMelee = {}
    for i, spellid in ipairs(resetMeleeList) do DMW.Tables.Swing.ResetMelee[spellid] = true end
    DMW.Tables.Swing.ResetRanged = {
        [2480] = true, -- Shoot Bow
        [7919] = true, -- Shoot Crossbow
        [7918] = true, -- Shoot Gun
        [2764] = true, -- Throw
        [5019] = true, -- Shoot Wands
        [75] = true -- Auto Shot
    }
    if not swingTimerFrame then
        swingTimerFrame = CreateFrame("frame")
        swingTimerFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        -- swingTimerFrame:RegisterEvent("PLAYER_ENTER_COMBAT")
        swingTimerFrame:RegisterUnitEvent("UNIT_ATTACK_SPEED", "player")
        swingTimerFrame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
        swingTimerFrame:SetScript("OnEvent", function(_, event, ...)
            if event == "COMBAT_LOG_EVENT_UNFILTERED" then
                swingTimerCLEUCheck(CombatLogGetCurrentEventInfo())
            else
                swingTimerEventCheck(event, ...)
            end
        end)
        -- selfGUID = UnitGUID("player")
    end
    DMW.Tables.Swing.Init = true
end
