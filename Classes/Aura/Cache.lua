local DMW = DMW
DMW.Tables.AuraCache = {}
DMW.Tables.AuraUpdate = {}
DMW.Functions.AuraCache = {}
local AuraCache = DMW.Functions.AuraCache
local Buff = DMW.Classes.Buff
local Debuff = DMW.Classes.Debuff
-- local DurationLib = LibStub("LibClassicDurationsDMW")
-- DurationLib:Register("DMW")
-- local UnitAura = DurationLib.UnitAuraWithBuffs
local f = CreateFrame("Frame", nil)
f:RegisterUnitEvent("UNIT_AURA", "player")


function AuraCache.Player_AURA(...)
    -- print(...)
    -- local guid = DMW.Tables.Misc.pointer2guidF(Pointer)
    -- print(guid)
    -- local Pointer = DMW.Tables.Misc.guid2pointerF(GUID)
    if not DMW.Player.GUID then return end
        AuraCache.Refresh(DMW.Player.Pointer, DMW.Player.GUID)
    -- for i=1,100 do
    --     local name, _, _, _, duration, expirationTime, _, _, _, spellId = UnitAura(Pointer, i, "HELPFUL")
    --     if not name then break end
    --     print(name, duration, expirationTime)
    -- end
    -- for i=1,100 do
    --     local name, _, _, _, duration, expirationTime, _, _, _, spellId = UnitAura(Pointer, i, "HARMFUL")
    --     if not name then break end
    --     print(name, duration, expirationTime)
    -- end
end

f:SetScript("OnEvent", AuraCache.Player_AURA)

function AuraCache.Refresh(Pointer, GUID)
    if DMW.Tables.AuraCache[GUID] then
        table.wipe(DMW.Tables.AuraCache[GUID])
    else
        DMW.Tables.AuraCache[GUID] = {}
    end
    local AuraReturn
    for i = 1, 40 do
        AuraReturn = {UnitAura(Pointer, i, "HELPFUL")}
        if AuraReturn[1] == nil then break end

        -- if DMW.Tables.AuraCache[GUID][AuraReturn[1]] == nil then
            DMW.Tables.AuraCache[GUID][AuraReturn[1]] = {["AuraReturn"] = AuraReturn, Type = "HELPFUL"}
        -- end
        if AuraReturn[7] ~= nil and AuraReturn[7] == "player" then
            DMW.Tables.AuraCache[GUID][AuraReturn[1]]["player"] = {["AuraReturn"] = AuraReturn, Type = "HELPFUL"}
        end
    end

    for i = 1, 40 do
        AuraReturn = {UnitAura(Pointer, i, "HARMFUL")}
        if AuraReturn[1] == nil then break end
        -- if DMW.Tables.AuraCache[GUID][AuraReturn[1]] == nil then
        DMW.Tables.AuraCache[GUID][AuraReturn[1]] = {["AuraReturn"] = AuraReturn, Type = "HARMFUL"}
        -- print(AuraReturn)
        -- end
        if AuraReturn[7] ~= nil and AuraReturn[7] == "player" then
            DMW.Tables.AuraCache[GUID][AuraReturn[1]]["player"] = {["AuraReturn"] = AuraReturn, Type = "HARMFUL"}
        end
    end
end

function AuraCache.Event(...)
    local timeStamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags,
          spellID, spellName, spellSchool, auraType = ...
    if destGUID and
        (event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_APPLIED_DOSE" or event == "SPELL_AURA_REMOVED_DOSE" or event ==
            "SPELL_AURA_REFRESH" or event == "SPELL_AURA_REMOVED" or event == "SPELL_PERIODIC_AURA_REMOVED")
            --or (DurationLib.indirectRefreshSpells[spellName] and DurationLib.indirectRefreshSpells[spellName].events[event]))
            then
                if DMW.Enums.Spells and DMW.Enums.Spells[DMW.Player.Class] and DMW.Enums.Spells[DMW.Player.Class][DMW.Player.SpecID] then
                    for k,v in pairs(DMW.Enums.Spells[DMW.Player.Class][DMW.Player.SpecID].Debuffs) do
                        if sourceGUID == DMW.Player.GUID and destGUID ~= DMW.Player.GUID and v == spellID then
                            -- print(spellID)
                            local destobj = DMW.Tables.Misc.guid2pointer[destGUID]
                            -- print(spellName)
                            AuraCache.Refresh(destobj, destGUID)
                        end

                    end
                end

        -- DMW.Tables.AuraUpdate[destGUID] = true
        -- if destGUID == DMW.Player.GUID then
        --     DMW.Player.AuraUpdate = true
        -- end
    elseif event == "PARTY_KILL" then
        if DMW.Tables.AuraCache[destGUID] then DMW.Tables.AuraCache[destGUID] = nil end
    elseif event == "UNIT_DIED" or event == "UNIT_DESTROYED" then
        local guid = select(7, ...)
        if DMW.Tables.AuraCache[guid] then DMW.Tables.AuraCache[guid] = nil end
    -- elseif event == "SPELL_DISPEL" then
    --     local dispelledName = select(16, ...)
    --     if DMW.Tables.AuraCache[destGUID] and DMW.Tables.AuraCache[destGUID][dispelledName] then
    --         DMW.Tables.AuraCache[destGUID][dispelledName] = nil
    --     end
    end
end

function Buff:Query(Unit, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or false
    if not Unit then return nil end
    Unit = Unit.GUID
    if DMW.Tables.AuraCache[Unit] ~= nil and DMW.Tables.AuraCache[Unit][self.SpellName] ~= nil and
        (not OnlyPlayer or DMW.Tables.AuraCache[Unit][self.SpellName]["player"] ~= nil) then
        local AuraReturn
        if OnlyPlayer then
            AuraReturn = DMW.Tables.AuraCache[Unit][self.SpellName]["player"].AuraReturn
        else
            AuraReturn = DMW.Tables.AuraCache[Unit][self.SpellName].AuraReturn
        end
        return unpack(AuraReturn)
    end
    return nil
end

function Debuff:Query(Unit, OnlyPlayer)
    OnlyPlayer = OnlyPlayer or false
    if not Unit then return nil end
    Unit = Unit.GUID
    if DMW.Tables.AuraCache[Unit] ~= nil and DMW.Tables.AuraCache[Unit][self.SpellName] ~= nil and
        (not OnlyPlayer or DMW.Tables.AuraCache[Unit][self.SpellName]["player"] ~= nil) then
        local AuraReturn
        if OnlyPlayer then
            AuraReturn = DMW.Tables.AuraCache[Unit][self.SpellName]["player"].AuraReturn
        else
            AuraReturn = DMW.Tables.AuraCache[Unit][self.SpellName].AuraReturn
        end
        return unpack(AuraReturn)
    end
    return nil
end

