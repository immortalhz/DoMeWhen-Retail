local DMW = DMW
DMW.Enemies, DMW.Attackable, DMW.Units, DMW.Friends, DMW.GameObjects, DMW.Corpses, DMW.AreaTriggers = {}, {}, {}, {}, {}, {}, {}
DMW.Friends.Units = {}
DMW.Friends.Tanks = {}
DMW.Friends.Party = {}
DMW.Friends.Corpses = {}
DMW.Friends.Healers = {}
-- local DurationLib = LibStub("LibClassicDurationsDMW")
local Enemies, Attackable, Units, Friends, FriendCorpses, GameObjects, AreaTriggers, Corpses, Party = DMW.Enemies, DMW.Attackable, DMW.Units, DMW.Friends.Units, DMW.Friends.Corpses, DMW.GameObjects, DMW.AreaTriggers, DMW.Corpses, DMW.Friends.Party
local Unit, LocalPlayer, GameObject, AreaTrigger = DMW.Classes.Unit, DMW.Classes.LocalPlayer, DMW.Classes.GameObject, DMW.Classes.AreaTrigger

function DMW.Remove(Pointer)
    local GUID
    if Units[Pointer] ~= nil then
        GUID = Units[Pointer].GUID
        Units[Pointer] = nil
    end
    if DMW.Tables.Swing.Units[Pointer] ~= nil then
        DMW.Tables.Swing.Units[Pointer] = nil
    end
    if DMW.Tables.TTD[Pointer] ~= nil then
        DMW.Tables.TTD[Pointer] = nil
    end
    if GUID and DMW.Tables.AuraCache[GUID] ~= nil then
        DMW.Tables.AuraCache[GUID] = nil
    end
    if GameObjects[Pointer] ~= nil then
        GameObjects[Pointer] = nil
    end
    if Corpses[Pointer] ~= nil then
        Corpses[Pointer] = nil
    end
    if AreaTriggers[Pointer] ~= nil then
        AreaTriggers[Pointer] = nil
    end
    -- if DMW.Tables.AuraUpdate[Pointer] then
    --     DMW.Tables.AuraUpdate[Pointer] = nil
    -- end

    -- if DurationLib.nameplateUnitMap[GUID] then
    --     DurationLib.nameplateUnitMap[GUID] = nil
    -- end
end

local function HandleFriends()
    if #Friends > 1 then
        table.sort(
            Friends,
            function(x, y)
                return x.HP < y.HP
            end
        )
    end
    DMW.Friends.LowestHP = 101
    DMW.Friends.LowestUnit = nil
    for _, l in ipairs(Friends) do
        if l.HP < DMW.Friends.LowestHP then
            DMW.Friends.LowestHP = l.HP
            DMW.Friends.LowestUnit = l
        end
    end
    -- if #Friends >= 1 then
    --     for k = 1, #Friends do
    --         local Friend = Friends[k]
    --         if Friend.HealthPredicted then
    --             for i = #Friend.HealthPredicted, 1 do
    --                 local table = Friend.HealthPredicted[i]
    --                 if table.Remove or DMW.Time >= table.time + 0.5 then
    --                     tremove(Friend.HealthPredicted,i)
    --                     -- table = nil
    --                 elseif DMW.Time >= table.time - 0.5 then
    --                     local newHealth = Friend.Health + table.amount
    --                     Friend.Health = newHealth >= Friend.HealthMax and Friend.HealthMax or newHealth
    --                     print(Friend.Name, "health updated")
    --                 end
    --             end
    --             Friend.HealthDeficit = Friend.HealthMax - Friend.Health
    --             if #Friend.HealthPredicted == 0 then Friend.HealthPredicted = nil;print("delete calc") end
    --             -- Friend.HealthPredictedCheck = true
    --         end
    --     end
    -- end
    -- for _, Unit in pairs(Friends) do
    --     Unit.Role = UnitGroupRolesAssigned(Unit.Pointer)
    --     if Unit.Role == "TANK" then
    --         table.insert(DMW.Friends.Tanks, Unit)
    --     end
    -- end
end

FriendsNPCs = {
    [144075] = true
}

local TargetExists, FocusExists, MouseoverExists
local function UpdateUnits()
    table.wipe(Attackable)
    table.wipe(Enemies)
    table.wipe(Friends)
    table.wipe(FriendCorpses)
    table.wipe(Party)
    table.wipe(DMW.Friends.Tanks)
    table.wipe(DMW.Friends.Healers)

    DMW.Player.Target = nil
    -- DMW.Tables.Misc.unit2pointer["target"] = nil
    DMW.Player.FocusUnit = nil
    DMW.Player.Mouseover = nil
    DMW.Player.Pet = nil
	-- TargetExists =
    -- FocusExists = UnitIsVisible("focus")
	-- MouseoverExists = UnitIsVisible("mouseover")
	if UnitIsVisible("target") then
		local target = ObjectPointer("target")
		if Units[target] then
			DMW.Player.Target = Units[target]
		end
	end
	if UnitIsVisible("focus") then
		local focus = ObjectPointer("focus")
		if Units[focus] then
			DMW.Player.FocusUnit = Units[focus]
		end
	end
	if UnitIsVisible("mouseover") then
		local mouseover = ObjectPointer("mouseover")
		if Units[mouseover] then
			DMW.Player.Mouseover = Units[mouseover]
		end
	end
	if UnitIsVisible("mouseover") then
		local mouseover = ObjectPointer("mouseover")
		if Units[mouseover] then
			DMW.Player.Mouseover = Units[mouseover]
		end
	end
	if UnitIsVisible("pet") then
		local pet = ObjectPointer("pet")
		if Units[pet] then
			DMW.Player.Pet = Units[pet]
		end
	end
    for Pointer, Unit in pairs(Units) do
        if not Unit.NextUpdate or Unit.NextUpdate < DMW.Time then
            Unit:Update()
        end
        if Unit.Attackable then
            table.insert(Attackable, Unit)
        end
        if Unit.ValidEnemy then
            table.insert(Enemies, Unit)
        end
        if Unit.Player and UnitIsUnit(Pointer, "player") then
            -- Unit:CalculateHP()
            table.insert(Friends, Unit)
        elseif (DMW.Player.InGroup and Unit.Player and not Unit.Attackable and (UnitInRaid(Pointer) or UnitInParty(Pointer))) then
            -- Unit:CalculateHP()
            if DMW.Tables.Misc.PlayerGroup ~= nil then
                if DMW.Tables.Misc.PlayerGroupFunc(Unit.GUID) then
                    table.insert(Party, Unit)
                end
            end
            if Unit.Dead then
                table.insert(FriendCorpses, Unit)
            else
                if Unit.LoS then
                    if Unit.MainTank then
                        table.insert(DMW.Friends.Tanks, Unit)
                    elseif Unit.Healer then
                        table.insert(DMW.Friends.Healers, Unit)
                    end
                    table.insert(Friends, Unit)
                end
            end
        end
        if (Unit.ObjectID and FriendsNPCs[Unit.ObjectID]) then
        -- if Unit.ObjectID == 144075 then
            -- print("added")
            table.insert(Friends, Unit)
        end
    end
    HandleFriends()
end

local function UpdateGameObjects()
    for _, Object in pairs(GameObjects) do
        if not Object.NextUpdate or Object.NextUpdate < DMW.Time then
            Object:Update()
        end
    end
end

local function UpdateAreaTriggers()
    for _, Object in pairs(AreaTriggers) do
        if not Object.NextUpdate or Object.NextUpdate < DMW.Time then
            Object:Update()
        end
    end
end

local function UpdateCorpses()
    for _, Object in pairs(Corpses) do
        if not Object.NextUpdate or Object.NextUpdate < DMW.Time then
            Object:Update()
        end
    end
end

local CurrentTable,OldTable
local function copyTable(datatable)
    local tblRes={}
    if type(datatable)=="table" then
    	for k,v in pairs(datatable) do
        	tblRes[copyTable(k)] = copyTable(v)
      	end
    else
    	tblRes=datatable
    end
    return tblRes
end

local function GetObjectCount()
	if not OldTable and not CurrentTable then
		CurrentTable = lb.GetObjects()
		return #CurrentTable, true, CurrentTable, {}
	else
		OldTable = CurrentTable
		CurrentTable = lb.GetObjects()
		local TempTable = copyTable(CurrentTable)
		local TempTableOld = copyTable(OldTable)
		for i = #TempTableOld, 1, -1 do
			for k = #TempTable, 1, -1 do
				if TempTableOld[i] == TempTable[k] then
					table.remove(TempTable, k)
					table.remove(TempTableOld, i)
					break
				end
			end
		end
		return #CurrentTable, true, TempTable, TempTableOld
	end
end

function DMW.UpdateOM()
	local _, updated, added, removed = GetObjectCount(true)
	if updated and removed and #removed > 0 then
		for _, v in ipairs(removed) do
            DMW.Remove(v)
		end
    end
	if updated and added and #added > 0 then
        for _, v in ipairs(added) do
            if ObjectIsUnit(v) and not Units[v] and (UnitCreatureTypeID(v) ~= 8) then
                --and (UnitCreatureTypeID(v) ~= 8 or UnitAffectingCombat(v)) then --and (UnitCreatureTypeID(v) ~= 8
				Units[v] = Unit(v)
            elseif ObjectIsGameObject(v) and not GameObjects[v] then
				GameObjects[v] = GameObject(v)

            -- elseif ObjectRawType(v) == 10 and not Corpses[v] then
            --     Corpses[v] = GameObject(v)
                -- print(ObjectDynamicFlags(v))
            -- elseif ObjectIsAreaTrigger(v) and not AreaTriggers[v] then
            --     AreaTriggers[v] = AreaTrigger(v)
            -- else
                -- if ObjectRawType(v) ~= 1 then
                --     -- print(ObjectName(v).. "   "..ObjectRawType(v))
                -- end
            end
		end
	end
    DMW.Player:Update()
	UpdateUnits()
    UpdateGameObjects()
    UpdateCorpses()
    UpdateAreaTriggers()
end
