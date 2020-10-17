local DMW = DMW
local LocalPlayer = DMW.Classes.LocalPlayer
local Spell = DMW.Classes.Spell
local Buff = DMW.Classes.Buff
local Debuff = DMW.Classes.Debuff

local function HasSpell(id)
    return select(7,GetSpellInfo(GetSpellInfo(id))) == id
 end

function LocalPlayer:GetSpells()
    -- if self.Class == "SHAMAN"  then
    --     self.Totems = {}
    --     DMW.Tables.Totems = {}
    --     DMW.Tables.Totems.Elements = {"Fire", "Earth", "Water", "Air"}
    -- end
    if self.Spells then
        table.wipe(self.Spells)
    else
        self.Spells = {}
    end
    if self.Buffs then
        table.wipe(self.Buffs)
    else
        self.Buffs = {}
    end
    if self.Debuffs then
        table.wipe(self.Debuffs)
    else
        self.Debuffs = {}
    end
    -- self.Spells = {}
    -- self.Buffs = {}
    -- self.Debuffs = {}
    local CastType, Duration
    for k, v in pairs(DMW.Enums.Spells) do
        if k == self.Class then
        -- local table = v["Shared"]) v[self.SpecID]
            if v[self.SpecID] then
                for SpellType, SpellTable in pairs(v[self.SpecID]) do
                    if SpellType == "Abilities" then
                        for SpellName, SpellInfo in pairs(SpellTable) do
                            -- print(SpellName)
                            CastType = type(SpellInfo[#SpellInfo]) ~= "number" and SpellInfo[#SpellInfo] or "Normal"
                            if #SpellInfo >= 2 then
                                for _, spellID in pairs(SpellInfo) do
                                    if type(spellID) == "number" and HasSpell(spellID) then
                                        self.Spells[SpellName] = Spell(spellID, CastType)
                                        self.Spells[SpellName].Key = SpellName
                                        break
                                    end
                                end
                            else
                                self.Spells[SpellName] = Spell(SpellInfo[1], CastType)
                                self.Spells[SpellName].Key = SpellName
                            end
                            -- if SpellInfo.Totem ~= nil then
                            --     for i = 1, #SpellInfo.Ranks do
                            --         DMW.Tables.Totems[SpellInfo.Ranks[i]] = {}
                            --         local totem = DMW.Tables.Totems[SpellInfo.Ranks[i]]
                            --         totem["SpellName"] = self.Spells[SpellName]["SpellName"]
                            --         totem["TotemSlot"] = SpellInfo.Totem[1]
                            --         totem["Element"] = DMW.Tables.Totems.Elements[totem["TotemSlot"]]
                            --         totem["Duration"] = SpellInfo.Totem[2]
                            --         totem["Key"] = SpellName
                            --     end
                            --     self.Spells[SpellName].TotemElement = DMW.Tables.Totems[SpellInfo.Ranks[1]]["Element"]
                            -- end
                        end
                    elseif SpellType == "Buffs" then
                        for SpellName, SpellInfo in pairs(SpellTable) do
                            if #SpellInfo >= 2 then
                                for _, spellID in pairs(SpellInfo) do
                                    if type(spellID) == "number" and HasSpell(spellID) then
                                        self.Buffs[SpellName] = Buff(spellID)
                                        break
                                    end
                                end
                            else
                                self.Buffs[SpellName] = Buff(SpellInfo[1])
                            end
                        end
                    elseif SpellType == "Debuffs" then
                        for SpellName, SpellInfo in pairs(SpellTable) do
                            self.Debuffs[SpellName] = Debuff(SpellInfo)
                        end
                    end
                end
            end
            if v["Shared"] then
                for SpellType, SpellTable in pairs(v["Shared"]) do
                    if SpellType == "Abilities" then
                        for SpellName, SpellInfo in pairs(SpellTable) do
                            -- print(SpellName)
                            CastType = type(SpellInfo[#SpellInfo]) ~= "number" and SpellInfo[#SpellInfo] or "Normal"
                            if #SpellInfo >= 2 then
                                for _, spellID in pairs(SpellInfo) do
                                    if type(spellID) == "number" and HasSpell(spellID) then
                                        self.Spells[SpellName] = Spell(spellID, CastType)
                                        self.Spells[SpellName].Key = SpellName
                                        break
                                    end
                                end
                            else
                                self.Spells[SpellName] = Spell(SpellInfo[1], CastType)
                                self.Spells[SpellName].Key = SpellName
                            end
                        end
                    elseif SpellType == "Buffs" then
                        for SpellName, SpellInfo in pairs(SpellTable) do
                            if #SpellInfo >= 2 then
                                for _, spellID in pairs(SpellInfo) do
                                    if type(spellID) == "number" and HasSpell(spellID) then
                                        self.Buffs[SpellName] = Buff(spellID)
                                        break
                                    end
                                end
                            else
                                self.Buffs[SpellName] = Buff(SpellInfo[1])
                            end
                        end
                    elseif SpellType == "Debuffs" then
                        for SpellName, SpellInfo in pairs(SpellTable) do
                            self.Debuffs[SpellName] = Debuff(SpellInfo)
                        end
                    end
                end
            end
        elseif k == "GLOBAL" then
            for SpellType, SpellTable in pairs(v) do
                if SpellType == "Abilities" then
                    for SpellName, SpellInfo in pairs(SpellTable) do
                        -- print(SpellName)
                        CastType = type(SpellInfo[#SpellInfo]) ~= "number" and SpellInfo[#SpellInfo] or "Normal"
                        if #SpellInfo >= 2 then
                            for _, spellID in pairs(SpellInfo) do
                                if type(spellID) == "number" and HasSpell(spellID) then
                                    self.Spells[SpellName] = Spell(spellID, CastType)
                                    self.Spells[SpellName].Key = SpellName
                                    break
                                end
                            end
                        else
                            self.Spells[SpellName] = Spell(SpellInfo[1], CastType)
                            self.Spells[SpellName].Key = SpellName
                        end
                    end
                elseif SpellType == "Buffs" then
                    for SpellName, SpellInfo in pairs(SpellTable) do
                        if #SpellInfo >= 2 then
                            for _, spellID in pairs(SpellInfo) do
                                if type(spellID) == "number" and HasSpell(spellID) then
                                    self.Buffs[SpellName] = Buff(spellID)
                                    break
                                end
                            end
                        else
                            self.Buffs[SpellName] = Buff(SpellInfo[1])
                        end
                    end
                elseif SpellType == "Debuffs" then
                    for SpellName, SpellInfo in pairs(SpellTable) do
                        self.Debuffs[SpellName] = Debuff(SpellInfo)
                    end
                end
            end
        end
    end
end

-- https://github.com/simulationcraft/simc/blob/shadowlands/engine/dbc/generated/sc_talent_data.inc
function LocalPlayer:GetTalents()
    if self.Talents then
        table.wipe(self.Talents)
    else
        self.Talents = {}
    end
    if  DMW.Enums.Spells[self.Class] and DMW.Enums.Spells[self.Class][self.SpecID] and DMW.Enums.Spells[self.Class][self.SpecID].Talents then
        for k, v in pairs(DMW.Enums.Spells[self.Class][self.SpecID].Talents) do
            local learned = select(10, GetTalentInfoByID(v))
            if learned then
                self.Talents[k] = true
            else
                self.Talents[k] = false
            end
        end
    end
end

--https://github.com/simulationcraft/simc/blob/shadowlands/engine/dbc/generated/covenant_data.inc
function LocalPlayer:GetCovenant()
end

--https://github.com/simulationcraft/simc/blob/bfa-dev/engine/dbc/generated/azerite.inc
function LocalPlayer:GetTraits()
    if self.Traits then
        table.wipe(self.Traits)
    else
        self.Traits = {}
    end
    if AzeriteUtil.AreAnyAzeriteEmpoweredItemsEquipped() and DMW.Enums.Spells[self.Class][self.SpecID]["Traits"] then
        local isSelected
        for _, itemLocation in AzeriteUtil.EnumerateEquipedAzeriteEmpoweredItems() do
            for k, v in pairs(DMW.Enums.Spells[self.Class][self.SpecID]["Traits"]) do
                isSelected = C_AzeriteEmpoweredItem.IsPowerSelected(itemLocation, v)
                if not self.Traits[k] then
                    self.Traits[k] = 0
                end
                if isSelected then
                    self.Traits[k] = self.Traits[k] + 1
                end
            end
        end
    end
end

function LocalPlayer:GetAzerite()
    if self.Essences then
        table.wipe(self.Essences.Major)
        table.wipe(self.Essences.Minor)
    else
        self.Essences = {}
        self.Essences.Major = {}
        self.Essences.Minor = {}
    end

    local table = C_AzeriteEssence.GetMilestones()
    if table then
        for i = 1, #table do
            local essenceTable = table[i]
            if essenceTable.unlocked then
                if essenceTable.slot ~= nil then
                    local essence = C_AzeriteEssence.GetMilestoneEssence(essenceTable.ID)
                    if essence ~= nil then
                        local eachEssence = C_AzeriteEssence.GetEssenceInfo(essence)
                        local rank = eachEssence.rank
                        local ID = eachEssence.ID
                        if essenceTable.slot == 0 then
                            local essence = DMW.Enums.Spells.GLOBAL.Essences[ID]
                            if essence ~= nil then
                                local tempEssence = {}
                                tempEssence.Name = essence[1]
                                tempEssence.Rank = rank
                                -- self.Essences.Major.Name = essence[1]
                                -- self.Essences.Major.Rank = rank
                                tinsert(self.Essences.Major,tempEssence)
                                self.Spells[essence[1]] = Spell(essence[2])
                            end
                        else
                            local essence = DMW.Enums.Spells.GLOBAL.Essences[ID]
                            if essence ~= nil then
                                local tempEssence = {}
                                tempEssence.Name = essence[1]
                                tempEssence.Rank = rank
                                -- self.Essences.Major.Name = essence[1]
                                -- self.Essences.Major.Rank = rank
                                tinsert(self.Essences.Minor,tempEssence)

                            end
                        end
                    end
                end
            end
        end
    end
end

function LocalPlayer:UpdateEquipment()
    table.wipe(self.Equipment)
    self.Items.Trinket1 = nil
    self.Items.Trinket2 = nil
    local ItemID
    for i = 1, 19 do
        ItemID = GetInventoryItemID("player", i)
        if ItemID then
            self.Equipment[i] = ItemID
            if i == 13 then
                self.Items.Trinket1 = DMW.Classes.Item(ItemID)
            elseif i == 14 then
                self.Items.Trinket2 = DMW.Classes.Item(ItemID)
            end
        end
    end
end

function LocalPlayer:GetItems()
    local Item = DMW.Classes.Item
    for Name, ItemID in pairs(DMW.Enums.Items) do
        self.Items[Name] = Item(ItemID)
    end
end

-- function LocalPlayer:UpdateProfessions()
--     table.wipe(self.Professions)
--     for i = 1, GetNumSkillLines() do
--         local Name, _, _, Rank = GetSkillLineInfo(i)
--         if Name == "Fishing" then
--             self.Professions.Fishing = Rank
--         elseif Name == "Mining" then
--             self.Professions.Mining = Rank
--         elseif Name == "Herbalism" then
--             self.Professions.Herbalism = Rank
--         elseif Name == "Skinning" then
--             self.Professions.Skinning = Rank
--         end
--     end
-- end
