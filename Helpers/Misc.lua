local DMW = DMW
DMW.Tables.Misc = {}
local Misc = DMW.Tables.Misc

Misc.guid2pointer = {}
Misc.pointer2guid = {}
Misc.unit2guid = {}
Misc.guid2unit = {}
Misc.guid2group = {}
Misc.pointer2unit = {}
Misc.unit2pointer = {}

-- DMW.Tables.pointer2guid = {}
-- DMW.Tables.pointer2guid = {}
hooksecurefunc(DMW, "Remove", function(pointer)
    if DMW.Tables.Misc.pointer2guid[pointer] ~= nil then
        DMW.Tables.Misc.guid2pointer[DMW.Tables.Misc.pointer2guid[pointer]] = nil
        DMW.Tables.Misc.pointer2guid[pointer] = nil
    end
end)

function Misc.guid2pointerF(guid)
    return Misc.guid2pointer[guid]
end

function Misc.pointer2guidF(pointer)
    return Misc.pointer2guid[pointer]
end

function Misc.unit2pointerF(unit)
    return Misc.unit2pointer[unit]
end

function Misc.PlayerGroupFunc(GUID)
    return Misc.guid2group[GUID] == Misc.PlayerGroup
end

function Misc.pointer2unitFunc(Pointer)
    return Misc.pointer2unit[Pointer]
end

function Misc.guid2friendlyUnit(guid)
    for _, Unit in ipairs(DMW.Friends.Units) do
        if Unit.GUID == guid then
            return Unit
        end
    end
end

local function updateUnit(unit)
    local guid = UnitGUID(unit)
    if guid then
        local raidID = UnitInRaid(unit)
        local group = raidID and select(3, GetRaidRosterInfo(raidID)) or 1
        if unit == "player" then
            Misc.PlayerGroup = group
        end
        Misc.guid2unit[guid] = unit
        Misc.guid2group[guid] = group
        Misc.unit2guid[unit] = guid
        local pointer = Misc.guid2pointerF(guid)
        if pointer then
            Misc.pointer2unit[pointer] = unit
            Misc.unit2pointer[unit] = pointer
            if DMW.Units[pointer] then
                DMW.Units[pointer].UnitID = unit
            end
            -- print("123")
            if GetPartyAssignment("MAINTANK", unit) then
                -- print("tank")
                DMW.Units[pointer].MainTank = true
            elseif Unlocked.UnitGroupRolesAssigned(pointer) == "TANK" then
                DMW.Units[pointer].MainTank = true
            elseif Unlocked.UnitGroupRolesAssigned(pointer) == "HEALER" then
                DMW.Units[pointer].Healer = true
            end
        end

    end
end

function Misc.GROUP_ROSTER_UPDATE()
    -- table.wipe(Misc.guid2pointer)
    -- table.wipe(Misc.pointer2guid)
    table.wipe(Misc.unit2guid)
    table.wipe(Misc.guid2unit)
    table.wipe(Misc.pointer2unit)
    table.wipe(Misc.guid2group)
    table.wipe(Misc.unit2pointer)
    for k,v in pairs(DMW.Units) do
        if v.UnitID then
            v.UnitID = nil
        end
    end
    updateUnit("player")
	if GetNumGroupMembers() > 0 then
        if not IsInRaid() then
            for i = 1, MAX_PARTY_MEMBERS do
                updateUnit(format("party%d", i))
            end
        else
            for i = 1, MAX_RAID_MEMBERS do
                updateUnit(format("raid%d", i))
            end
        end
    end
end



-- function Misc.pointer2unit(Pointer)
--     return Misc.guid2group[GUID] == Misc.PlayerGroup
-- end

-- function Misc.MainTank(Pointer)
--     return Misc.guid2group[GUID] == Misc.PlayerGroup
-- end

-- C_Timer.After(10, function() Misc.GROUP_ROSTER_UPDATE() end)
DMW.Enums.ClassPowerTypes = {
    WARLOCK = {
        "Power",
        "SoulShards"
    },
    WARRIOR = {
        "Rage"
        -- "Alternate",
    },
    DEATHKNIGHT = {
        "RunicPower",
        "Runes"
    },
    ROGUE = {
        "Energy",
        "ComboPoints",
        -- "Alternate"
    },
    PALADIN = {
        "Power",
        "HolyPower"
    },
    DEMONHUNTER = {
        "Fury",
        "Pain"
    },
    DRUID ={
        "Power",
        "ComboPoints",
        "Rage",
        "Energy",
        "LunarPower"
    },
    PRIEST ={
        "Power",
        "Insanity"
	},
	HUNTER = {
		"Focus"
	}
}

DMW.Enums.PowerTypes = {
    Power = {"MANA", 0 },
	Rage = {"RAGE", 1},
	Focus = {"FOCUS",2},
	Energy = {"ENERGY", 3},
	ComboPoints = {"COMBO_POINTS", 4},
	Runes = {"RUNES", 5},
	RunicPower = {"RUNIC_POWER", 6},
	SoulShards = {"SOUL_SHARDS", 7},
	LunarPower = {"LUNAR_POWER", 8},
	HolyPower = {"HOLY_POWER", 9},
	Maelstrom = {"MAELSTROM_POWER", 11},
	Chi = {"CHI_POWER", 12},
	Insanity = {"INSANITY_POWER", 13},
	ArcaneCharges = {"ARCANE_CHARGES_POWER", 16},
	Fury = {"FURY", 17},
	Pain = {"PAIN", 18},
    -- HealthCost = -2 ,
    -- None = -1,
    Boss = {"Alternate", 10},
    -- Obsolete = 14,
    -- Obsolete2 = 15,
}

function Misc.TrackerInstanceIdCheck()

end









-- --Honor Tracking

-- local baseRankHonorTable = {
-- 	[0] = "199",
-- 	[5] = "199",
-- 	[6] = "210",
-- 	[7] = "221",
-- 	[8] = "233",
-- 	[9] = "246",
-- 	[10] = "260",
-- 	[11] = "274",
-- 	[12] = "289",
-- 	[13] = "305",
-- 	[14] = "321",
-- 	[15] = "339",
-- 	[16] = "357",
-- 	[17] = "377",
-- 	[18] = "398"
-- }

-- local baseLevelHonorTable = {
-- 	[60] = "1",
-- 	[59] = ".9",
-- 	[58] = ".8",
-- 	[57] = ".7",
-- 	[56] = ".6",
-- 	[55] = ".5",
-- 	[54] = ".47",
-- 	[53] = ".35",
-- 	[52] = ".32",
-- 	[51] = ".28",
-- 	[50] = ".05",
-- 	[49] = ".03",
-- 	[48] = ".02"
-- }

-- local Unit = DMW.Classes.Unit
-- local loaded = false
-- local f = CreateFrame("Frame", "MyAddon", UIParent)
-- f:SetScript(
--     "OnUpdate",
--     function(self, elapsed)
--         if not loaded then


--             if IsAddOnLoaded("HPH") then
--                 local HPH = LibStub("AceAddon-3.0"):GetAddon("HPH")
--                 hooksecurefunc(Unit, "New", function(Table, Pointer)
--                     if Table.Player and Table.Level >= 48 and Unlocked.UnitCanAttack("player", Table.Pointer) then
--                         -- Table.rankPVP = UnitPVPRank(Pointer);
--                         -- Table.UnitName = GetUnitName(Pointer)
--                         local timesKilled = HPH.GetTimesKilled(HPH.GetName(Table.Name))
--                         local discountRate, _ = HPH.GetDiscountRate(timesKilled)
--                         local rHonor = baseRankHonorTable[UnitPVPRank(Pointer)] *
--                         baseLevelHonorTable[Table.Level]
--                         * (1 - discountRate)
--                         -- print(rHonor)

--                         Table.RealisticHonor = rHonor
--                         -- self.PVPRank = self.rankPVP >= 5 and (self.rankPVP - 4) or 0
--                     end
--                 end)
--                 loaded = true
--                 --hook here
--             end
--         end
--     end
-- )


