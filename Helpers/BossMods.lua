local DMW = DMW
DMW.BossMods = {}
local BossMods = DMW.BossMods
local BWInited = false

function BossMods.BWInit()
    if not BossMods.Timer then
        BossMods.Timer = {}
    end
    -- if BossMods.BigWigs ~= nil then return end
    BossMods.BigWigs = {}
    local BigWigs = BossMods.BigWigs
    BigWigs.callback = {}
    local callback = BigWigs.callback
    BigWigs.BigwigsCallback = function(event, ...)
        if event == "BigWigs_StartBar" then
            local module, spellId, msg, duration, icon = ...
            local clone = false
            if spellId == nil then
                if tostring(icon) == "134062" then
                    -- print("break")
                    spellId = "Break"
                elseif tostring(icon) == "132337" then
                    -- print("pull")
                    spellId = "Pull"
                else
                    return
                end
            end
            for i = 1, #BossMods.Timer do
                if BossMods.Timer[i] ~= nil and BossMods.Timer[i].id == spellId then
                    clone = true
                    BossMods.Timer[i].exptime = DMW.Time + duration
                    break
                end
            end
            if not clone then
                local timer = {}
                timer.id = spellId
                timer.exptime = DMW.Time + duration
                tinsert(BossMods.Timer, timer)
                clone = false
            end
        elseif (event == "BigWigs_StopBars"
            or event == "BigWigs_OnBossDisable"
        or event == "BigWigs_OnPluginDisable") then
            if #BossMods.Timer > 0 then
                local count = #BossMods.Timer
                for i = 0, count do
                    BossMods.Timer[i] = nil
                end
            end
        else
            -- print("lalala")
        end
    end
    if BigWigsLoader then
        BigWigs.callback = {}
        BigWigsLoader.RegisterMessage(callback, "BigWigs_StartBar", BigWigs.BigwigsCallback);
        BigWigsLoader.RegisterMessage(callback, "BigWigs_StopBars", BigWigs.BigwigsCallback);
        BigWigsLoader.RegisterMessage(callback, "BigWigs_OnBossDisable", BigWigs.BigwigsCallback);
        BigWigsLoader.RegisterMessage(callback, "BigWigs_OnPluginDisable", BigWigs.BigwigsCallback);
    end
    BWInited = true
    -- print("inited")
end

function BossMods.BWCheck()
    if #BossMods.Timer > 0 then
        for i = 1, #BossMods.Timer do
            if BossMods.Timer[i] ~= nil then
                if BossMods.Timer[i].exptime < DMW.Time then
                    BossMods.Timer[i] = nil
                end
            else
            end
        end
    end
end

function BossMods.getTimerBW(spellID, time)
    local hasTimer = false
    local isBelowTime = false
    local currentTimer = 0
    for i = 1, #BossMods.Timer do
        -- Check if timer with spell id is present
        if BossMods.Timer[i] ~= nil and BossMods.Timer[i].id == spellID then
            hasTimer = true
            currentTimer = BossMods.Timer[i].exptime - DMW.Time
            -- if a time is given set var to true
            if time then
                if currentTimer <= time then
                    isBelowTime = true
                end
                if hasTimer and isBelowTime then
                    return true
                else
                    return false
                end
            else
                if hasTimer then
                    return currentTimer
                end
            end
        end
    end
    return 999
end

function BossMods.getTimer(spellID, time)
    if BossMods.Timer then
        if IsAddOnLoaded('DBM-Core') then
            local hasTimer = false
            local isBelowTime = false
            local currentTimer = 0
            for i = 1, #BossMods.Timer do
                -- Check if timer with spell id is present
                if tonumber(BossMods.Timer[i].spellid) == spellID then
                    hasTimer = true
                    currentTimer = BossMods.Timer[i].timer
                    -- if a time is given set var to true
                    if time then
                        if currentTimer <= time then
                            isBelowTime = true
                        end
                        if hasTimer and isBelowTime then
                            return true
                        else
                            return false
                        end
                    else
                        if hasTimer then
                            return currentTimer
                        end
                    end
                end
            end
        elseif IsAddOnLoaded("BigWigs") then
            return BossMods.getTimerBW(spellID, time)
        end
    end
        -- if a time is given return true if timer and below given time
        -- else return time
    return 999 -- return number to avoid conflicts but to high so it should never trigger
end

function BossMods.Check()
    if IsAddOnLoaded('DBM-Core') then
        -- br.DBM:getBars()
    elseif IsAddOnLoaded("BigWigs") then
        if not BWInited then
            BossMods.BWInit()
        else
            BossMods.BWCheck()
        end
    end
end
