local DMW = DMW
DMW.Enemies, DMW.Attackable, DMW.Units, DMW.Friends, DMW.GameObjects, DMW.Corpses, DMW.AreaTriggers = {}, {}, {}, {}, {}, {}, {}
DMW.Friends.Units = {}
DMW.Friends.Tanks = {}
DMW.Friends.Party = {}
DMW.Friends.Corpses = {}
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
    if DMW.Tables.AuraUpdate[Pointer] then
        DMW.Tables.AuraUpdate[Pointer] = nil
    end

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

local function UpdateUnits()
    table.wipe(Attackable)
    table.wipe(Enemies)
    table.wipe(Friends)
    table.wipe(FriendCorpses)
    table.wipe(Party)
    table.wipe(DMW.Friends.Tanks)

    DMW.Player.Target = nil
    -- DMW.Tables.Misc.unit2pointer["target"] = nil
    -- DMW.Player.Focus = nil
    DMW.Player.Mouseover = nil
    DMW.Player.Pet = nil

    for Pointer, Unit in pairs(Units) do
        if not Unit.NextUpdate or Unit.NextUpdate < DMW.Time then
            Unit:Update()
        end
        if not DMW.Player.Target and UnitIsUnit(Pointer, "target") then
            DMW.Player.Target = Unit
            -- DMW.Tables.Misc.unit2pointer["target"] = Pointer

        end
        if not DMW.Player.Mouseover and UnitIsUnit(Pointer, "mouseover") then
            DMW.Player.Mouseover = Unit
        end
        -- elseif not DMW.Player.Focus and UnitIsUnit(Pointer, "focus") then
        --     DMW.Player.Focus = Unit
        if DMW.Player.PetActive and not DMW.Player.Pet and UnitIsUnit(Pointer, "pet") then
            DMW.Player.Pet = Unit
        end
        if Unit.Attackable then
            table.insert(Attackable, Unit)
        end
        if Unit.ValidEnemy then
            table.insert(Enemies, Unit)
        end
        if Unit.Player and UnitIsUnit(Pointer, "player") then
            Unit:CalculateHP()
            table.insert(Friends, Unit)
        elseif DMW.Player.InGroup and Unit.Player and not Unit.Attackable and (UnitInRaid(Pointer) or UnitInParty(Pointer)) then
            Unit:CalculateHP()
            if DMW.Tables.Misc.PlayerGroup ~= nil then
                if DMW.Tables.Misc.PlayerGroupFunc(Unit.GUID) then
                    table.insert(Party, Unit)
                end
            end
            if Unit.MainTank then
                table.insert(DMW.Friends.Tanks, Unit)
            end
            if Unit.Dead then
                table.insert(FriendCorpses, Unit)
            end
            if Unit.LoS then
                table.insert(Friends, Unit)
            end
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

function DMW.UpdateOM()
    local _, updated, added, removed = GetObjectCount(true)
    if updated and #removed > 0 then
        for _, v in pairs(removed) do
            DMW.Remove(v)
        end
    end
    if updated and #added > 0 then
        for _, v in pairs(added) do
            if ObjectIsUnit(v) and  not Units[v] then
                --and (UnitCreatureTypeID(v) ~= 8 or UnitAffectingCombat(v)) then --and (UnitCreatureTypeID(v) ~= 8
                Units[v] = Unit(v)
            elseif ObjectIsGameObject(v) and not GameObjects[v] then
                GameObjects[v] = GameObject(v)
            elseif ObjectRawType(v) == 10 and not Corpses[v] then
                Corpses[v] = GameObject(v)
                -- print(ObjectDynamicFlags(v))
            elseif ObjectIsAreaTrigger(v) and not AreaTriggers[v] then
                AreaTriggers[v] = AreaTrigger(v)
            else
                if ObjectRawType(v) ~= 1 then
                    -- print(ObjectName(v).. "   "..ObjectRawType(v))
                end
            end
        end
    end
    DMW.Player:Update()
    UpdateUnits()
    UpdateGameObjects()
    UpdateCorpses()
    UpdateAreaTriggers()
end
