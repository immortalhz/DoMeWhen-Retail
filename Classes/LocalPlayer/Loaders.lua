local DMW = DMW
local LocalPlayer = DMW.Classes.LocalPlayer
local Spell = DMW.Classes.Spell
local Buff = DMW.Classes.Buff
local Debuff = DMW.Classes.Debuff

function LocalPlayer:GetSpells()
    if self.Class == "SHAMAN"  then
        self.Totems = {}
        DMW.Tables.Totems = {}
        DMW.Tables.Totems.Elements = {"Fire", "Earth", "Water", "Air"}
    end
    self.Spells = {}
    self.Buffs = {}
    self.Debuffs = {}
    local CastType, Duration
    for k, v in pairs(DMW.Enums.Spells) do
        local table = (k == "GLOBAL" and v) or (k == self.Class and (v[self.SpecID]) or v["Shared"])
        if table then
            for SpellType, SpellTable in pairs(table) do
                if SpellType == "Abilities" then
                    for SpellName, SpellInfo in pairs(SpellTable) do
                        -- print(SpellName)
                        CastType = SpellInfo[2] or "Normal"
                        self.Spells[SpellName] = Spell(SpellInfo[1], CastType)
                        -- self.Spells[SpellName].Key = SpellName
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
                        self.Buffs[SpellName] = Buff(SpellInfo[1])
                    end
                elseif SpellType == "Debuffs" then
                    for SpellName, SpellInfo in pairs(SpellTable) do
                        Duration = SpellInfo[2] or nil
                        self.Debuffs[SpellName] = Debuff(SpellInfo[1], Duration)
                    end
                end
            end
        end
    end
end

function LocalPlayer:GetTalents()
    if self.SpecID == "LowLevel" then return end
    if self.Talents then
        table.wipe(self.Talents)
    else
        self.Talents = {}
    end
    local foundInTier
    for k, v in pairs(DMW.Enums.Spells[self.Class][self.SpecID].Talents) do
            local specGroup = GetActiveSpecGroup()
            for r = 1, 7 do --search each talent row
                for c = 1, 3 do -- search each talent column
                    local learned, _ , id = select(4,GetTalentInfo(r,c,specGroup))
                    if v == id then
                        foundInTier = true
                        -- Add All Matches to Talent List for Boolean Checks
                        self.Talents[k] = true
                        -- Add All Active Ability Matches to Ability/Spell List for Use Checks
                        -- if not IsPassiveSpell(v) then
                        --     self.spell['abilities'][k] = v
                        --     self.spell[k] = v
                        -- end
                        break;
                    end
                end
                -- If we found the talent, then stop looking for it.
                if foundInTier then break end
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

function LocalPlayer:UpdateProfessions()
    table.wipe(self.Professions)
    for i = 1, GetNumSkillLines() do
        local Name, _, _, Rank = GetSkillLineInfo(i)
        if Name == "Fishing" then
            self.Professions.Fishing = Rank
        elseif Name == "Mining" then
            self.Professions.Mining = Rank
        elseif Name == "Herbalism" then
            self.Professions.Herbalism = Rank
        elseif Name == "Skinning" then
            self.Professions.Skinning = Rank
        end
    end
end
