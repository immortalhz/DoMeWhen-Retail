local LibDraw = LibStub("LibDraw-1.0")
local DMW = DMW
local AlertTimer = GetTime()
DMW.Helpers.QuestieHelper = {}
DMW.Cache.QuestieCache = {}

function DMW.Helpers.DrawLineDMWC(sx, sy, sz, ex, ey, ez)
    local function WorldToScreen(wX, wY, wZ)
        local sX, sY = _G.WorldToScreen(wX, wY, wZ)
        if sX and sY then
            return sX, -(WorldFrame:GetTop() - sY)
        else
            return sX, sY
        end
    end
    local startx, starty = WorldToScreen(sx, sy, sz)
    local endx, endy = WorldToScreen(ex, ey, ez)
    if (endx == nil or endy == nil) and (startx and starty) then
        local i = 1
        while (endx == nil or endy == nil) and i < 50 do
            endx, endy = WorldToScreen(GetPositionBetweenPositions(ex, ey, ez, sx, sy, sz, i))
            i = i + 1
        end
    end
    if (startx == nil or starty == nil) and (endx and endy) then
        local i = 1
        while (startx == nil or starty == nil) and i < 50 do
            startx, starty = WorldToScreen(GetPositionBetweenPositions(sx, sy, sz, ex, ey, ez, i))
            i = i + 1
        end
    end
    LibDraw.Draw2DLine(startx, starty, endx, endy)
end

function DMW.Helpers.QuestieHelper.Run()
    if DMW.Settings.profile.Tracker.QuestieHelper then
        local s = 1
        local tX, tY, tZ
        local r, b, g, a = DMW.Settings.profile.Tracker.QuestieHelperColor[1], DMW.Settings.profile.Tracker.QuestieHelperColor[2], DMW.Settings.profile.Tracker.QuestieHelperColor[3], DMW.Settings.profile.Tracker.QuestieHelperColor[4]
        LibDraw.SetColorRaw(r, b, g, a)
        for _, Unit in pairs(DMW.Units) do
            if Unit.Quest and (not Unit.Dead or UnitCanBeLooted(Unit.Pointer)) and not Unit.Target and not UnitIsTapDenied(Unit.Pointer) then
                if tonumber(DMW.Settings.profile.Tracker.QuestieHelperAlert) > 0 and (AlertTimer + 5) < DMW.Time and not IsForeground() then
                    FlashClientIcon()
                    if GetCVarBool("Sound_EnableSFX") then
                        PlaySound(DMW.Settings.profile.Tracker.QuestieHelperAlert)
                    else
                        PlaySound(DMW.Settings.profile.Tracker.QuestieHelperAlert, "MASTER")
                    end
                    AlertTimer = DMW.Time
                end
                Unit:UpdatePosition()
                tX, tY, tZ = Unit.PosX, Unit.PosY, Unit.PosZ
                LibDraw.SetWidth(4)
                LibDraw.Line(tX, tY, tZ + s * 1.3, tX, tY, tZ)
                LibDraw.Line(tX - s, tY, tZ, tX + s, tY, tZ)
                LibDraw.Line(tX, tY - s, tZ, tX, tY + s, tZ)
                if DMW.Settings.profile.Tracker.QuestieHelperLine > 0 then
                    local w = DMW.Settings.profile.Tracker.QuestieHelperLine
                    LibDraw.SetWidth(w)
                    DMW.Helpers.DrawLineDMWC(tX, tY, tZ, DMW.Player.PosX, DMW.Player.PosY, DMW.Player.PosZ + 2)
                end
            end
        end
        for _, Object in pairs(DMW.GameObjects) do
            if Object.Quest then
                if tonumber(DMW.Settings.profile.Tracker.QuestieHelperAlert) > 0 and (AlertTimer + 5) < DMW.Time and not IsForeground() then
                    FlashClientIcon()
                    if GetCVarBool("Sound_EnableSFX") then
                        PlaySound(DMW.Settings.profile.Tracker.QuestieHelperAlert)
                    else
                        PlaySound(DMW.Settings.profile.Tracker.QuestieHelperAlert, "MASTER")
                    end
                    AlertTimer = DMW.Time
                end
                tX, tY, tZ = Object.PosX, Object.PosY, Object.PosZ
                LibDraw.SetWidth(4)
                LibDraw.Line(tX, tY, tZ + s * 1.3, tX, tY, tZ)
                LibDraw.Line(tX - s, tY, tZ, tX + s, tY, tZ)
                LibDraw.Line(tX, tY - s, tZ, tX, tY + s, tZ)
                if DMW.Settings.profile.Tracker.QuestieHelperLine > 0 then
                    local w = DMW.Settings.profile.Tracker.QuestieHelperLine
                    LibDraw.SetWidth(w)
                    DMW.Helpers.DrawLineDMWC(tX, tY, tZ, DMW.Player.PosX, DMW.Player.PosY, DMW.Player.PosZ + 2)
                end
            end
        end
    end
end

--Quest stuff
--local questPlateTooltip = CreateFrame('GameTooltip', 'QuestPlateTooltip', nil, 'GameTooltipTemplate')
local questTooltipScanQuest = CreateFrame ("GameTooltip", "QuestPlateTooltipScanQuest", nil, "GameTooltipTemplate")
local ScannedQuestTextCache = {}

local visionsNPCs = {
		[161293] = true, -- Neglected Guild Bank
		[157700] = true, -- Agustus Moulaine
		[160404] = true, -- Angry Bear Rug Spirit
        [161324] = true, -- Experimental Buff Mine
        -- Orgrimmar
        [158588] = true, -- Gamon (Pool ol' Gamon)
		[158565] = true, -- Naros
		[161140] = true, -- Bwemba
		[161198] = true -- Warpweaver Dushar (Need ObjectID of the gate that summons him)
}

function DMW.Helpers.QuestieHelper.isQuestieUnit(Pointer, GUID)
	-- local guid = ObjectGUID(unit)
	--local myName = UnitName("player")
	questTooltipScanQuest:SetOwner(WorldFrame, 'ANCHOR_NONE')
	questTooltipScanQuest:SetHyperlink('unit:' .. GUID)
	for i = 1, questTooltipScanQuest:NumLines() do
		ScannedQuestTextCache[i] = _G ["QuestPlateTooltipScanQuestTextLeft" .. i]
	end

	local isQuestUnit = false
	local atLeastOneQuestUnfinished = false
	for i = 1, #ScannedQuestTextCache do
		local text = ScannedQuestTextCache[i]:GetText()
		if (DMW.Cache.QuestieCache[text]) then
			--unit belongs to a quest
			isQuestUnit = true
			local amount1, amount2 = nil, nil
			local j = i
			while (ScannedQuestTextCache[j+1]) do
				--check if the unit objective isn't already done
				local nextLineText = ScannedQuestTextCache [j+1]:GetText()
				if (nextLineText) then
					if not nextLineText:match(THREAT_TOOLTIP) then
						local p1, p2 = nextLineText:match ("(%d+)/(%d+)")
						if (not p1) then
							-- check for % based quests
							p1 = nextLineText:match ("(%d+%%)")
							if p1 then
								-- remove the % sign for consistency
								p1 = string.gsub(p1,"%%", '')
							end
						end
						if (p1 and p2 and not (p1 == p2)) or (p1 and not p2 and not (p1 == "100")) then
							-- quest not completed
							atLeastOneQuestUnfinished = true
							amount1, amount2 = p1, p2
						end
					else
						j = 99 --safely break here, as we saw threat% -> quest text is done
					end
				end
				j = j + 1
			end
		end
	end
	if isQuestUnit and atLeastOneQuestUnfinished and (not UnitIsDeadOrGhost(Pointer) or UnitCanBeLooted(Pointer) or UnitIsFriend("player", Pointer)) then
		return true
	elseif DMW.Units[Pointer].ObjectID and visionsNPCs[DMW.Units[Pointer].ObjectID] then
		return true
	else
		return false
	end
end

local QuestieCacheUpdate = function()
	--clear the quest cache
	wipe(DMW.Cache.QuestieCache)
	DMW.Cache.QuestieCache["CacheTimer"] = DMW.Time
	--do not update if is inside an instance
	-- local isInInstance = IsInInstance()
	-- if (isInInstance) then
	-- 	return
	-- end

	--update the quest cache
	local numEntries, numQuests =  C_QuestLog.GetNumQuestLogEntries()
	for questId = 1, numEntries do
		local tempTable = C_QuestLog.GetInfo(questId)
		-- local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questId, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isStory = C_QuestLog.GetTitleForLogIndex(questId)
		local questIdLog = tempTable["questID"]
		if type (questIdLog) == "number" and questIdLog > 0  then
			local titleLog = tempTable["title"]
			-- print(titleLog)
			-- if not titleLog == "Quest" then
				-- print(questId, questIdLog)
				DMW.Cache.QuestieCache[titleLog] = true
			-- end
		-- if (type (questId) == "number" and questId > 0) then -- and not isComplete
		end
	end

	local mapId = C_Map.GetBestMapForUnit ("player")
	if (mapId) then
		local worldQuests = C_TaskQuest.GetQuestsForPlayerByMapID (mapId)
		if (type (worldQuests) == "table") then
			for i, questTable in ipairs (worldQuests) do
				local x, y, floor, numObjectives, questId, inProgress = questTable.x, questTable.y, questTable.floor, questTable.numObjectives, questTable.questId, questTable.inProgress
				if (type (questId) == "number" and questId > 0) then
					local questName = C_TaskQuest.GetQuestInfoByQuestID (questId)
					if (questName) then
						DMW.Cache.QuestieCache[questName] = true
					end
				end
			end
		end
	end
end

local function QuestieLogUpdate() --private
	if (QuestieCacheThrottle and not QuestieCacheThrottle._cancelled) then
		QuestieCacheThrottle:Cancel()
	end
	QuestieCacheThrottle = C_Timer.NewTimer (2, QuestieCacheUpdate)
end
function DMW.Helpers.QuestieHelper.isQuestObject(objectID, Pointer) --Ty Ssateneth
    if objectID == 325958 or objectID == 325962 or objectID == 325963 or objectID == 325959 or objectID == 335703 or objectID == 152692 or objectID == 163757 or objectID == 290542 or objectID == 113768 or objectID == 113771 or objectID == 113769 or objectID == 113770 or objectID == 153290 or
        objectID == 322413 or objectID == 326395 or objectID == 326399 or objectID == 326418 or objectID == 326413 or objectID == 327577 or objectID == 327576 or objectID == 327578 or objectID == 325799 or
        objectID == 326417 or objectID == 326411 or objectID == 326412 or objectID == 326413 or objectID == 326414 or objectID == 326415 or objectID == 326416 or objectID == 326417 or objectID == 326418 or objectID == 326419 or objectID == 326420 or objectID == 326403 or objectID == 326408 or objectID == 326407 or -- nasjatar chests
        objectID == 325662 or objectID == 325659 or objectID == 325660 or objectID == 325661 or objectID == 325663 or objectID == 325664 or objectID == 325665 or objectID == 325666 or objectID == 325667 or objectID == 325668 or -- mechagon chests
		objectID == 151166 -- algan units
		or objectID == 335709 or objectID == 334237 or objectID == 334228 or objectID == 334229 or objectID == 334232-- Uldum chest
    then return true end
    local glow = ObjectDescriptor(Pointer,GetOffset("CGObjectData__DynamicFlags"),"uint")
    if glow and (bit.band(glow,0x4)~=0 or bit.band(glow,0x20)~=0) then
        return true
    end
    return false
end

local eventFunctions = {
	QUEST_REMOVED = function()
		QuestieLogUpdate()
	end,
	QUEST_ACCEPTED = function()
		QuestieLogUpdate()
	end,
	QUEST_ACCEPT_CONFIRM = function()
		QuestieLogUpdate()
	end,
	QUEST_COMPLETE = function()
		QuestieLogUpdate()
	end,
	QUEST_POI_UPDATE = function()
		QuestieLogUpdate()
	end,
	QUEST_QUERY_COMPLETE = function()
		QuestieLogUpdate()
	end,
	QUEST_DETAIL = function()
		QuestieLogUpdate()
	end,
	QUEST_FINISHED = function()
		QuestieLogUpdate()
	end,
	QUEST_GREETING = function()
		QuestieLogUpdate()
	end,
	QUEST_LOG_UPDATE = function()
		QuestieLogUpdate()
	end,
	UNIT_QUEST_LOG_CHANGED = function()
		QuestieLogUpdate()
	end,
}

local function QuestieEventHandler(_, event, ...)
    if GetObjectWithGUID then
        local func = eventFunctions [event]
        if (func) then
            func (event, ...)
        else
            print("no registered function for event " .. (event or "unknown event"))
        end
    end
end

local f = CreateFrame("Frame", "QuestieFrame", UIParent)
		f:RegisterEvent ("QUEST_ACCEPTED")
		f:RegisterEvent ("QUEST_REMOVED")
		f:RegisterEvent ("QUEST_ACCEPT_CONFIRM")
		f:RegisterEvent ("QUEST_COMPLETE")
		f:RegisterEvent ("QUEST_POI_UPDATE")
		f:RegisterEvent ("QUEST_DETAIL")
		f:RegisterEvent ("QUEST_FINISHED")
		f:RegisterEvent ("QUEST_GREETING")
		f:RegisterEvent ("QUEST_LOG_UPDATE")
		f:RegisterEvent ("UNIT_QUEST_LOG_CHANGED")
f:SetScript ("OnEvent", QuestieEventHandler)
