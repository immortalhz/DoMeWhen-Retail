local DMW = DMW
local Player, Buff, Debuff, Spell
local timeStamp, param, hideCaster, source, sourceName, sourceFlags, sourceRaidFlags, destination, destName, destFlags, destRaidFlags,
      spell, spellName, _, spellType

local DRList = LibStub("DRList-1.0")

DMW.Tables.DRList = {}

local function Locals()
    Player = DMW.Player
    Buff = Player.Buffs
    Debuff = Player.Debuffs
    Spell = Player.Spells
end

DMW.Frames.CombatLog = CreateFrame("Frame")
local frame = DMW.Frames.CombatLog
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(self, event) self:Reader(event, CombatLogGetCurrentEventInfo()) end)

function frame:Reader(event, ...)
    if GetObjectWithGUID then
        timeStamp, param, hideCaster, source, sourceName, sourceFlags, sourceRaidFlags, destination, destName, destFlags, destRaidFlags, spell, spellName, _, spellType =
            ...
		Locals()

        DMW.Functions.AuraCache.Event(...)
        if spellType == "DEBUFF" then
            local category = DRList:GetCategoryBySpellID(spell)
            if not category or category == "knockback" then return end
            local isNPC = bit.band(destFlags, COMBATLOG_OBJECT_CONTROL_NPC) ~= 0
            if not isNPC then return end
            if param == "SPELL_AURA_APPLIED" or param == "SPELL_AURA_REFRESH" then --if eventType == "SPELL_AURA_REFRESH" or eventType == "SPELL_AURA_REMOVED" then
                local destobj = GetObjectWithGUID(destination)
                local destUnit = DMW.Units[destobj]
                if destUnit then
                    destUnit:AddCC(category)
                end
            end
        -- elseif param == "SPELL_CAST_START" or param == "SPELL_CAST_FAILED" then
            -- print("")
        -- else
        --     print(param)
		end
		-- if param == "SPELL_MISSED" and spellType == "EVADE" then
		-- 	local destobj = GetObjectWithGUID(destination)
		-- 	local destUnit = DMW.Units[destobj]
		-- 	if destUnit then

		-- 		print(DMW.Time.. " evade start"..". Time = "..DMW.Time-destUnit.LastHitTime)
		-- 		destUnit.Evaded = true
		-- 	end
		-- end
        -- if source == Player.GUID or destination == Player.GUID then
        --     local sourceobj = DMW.Tables.Misc.guid2pointer[source]
        --     local destobj = DMW.Tables.Misc.guid2pointer[destination]
            -- if Player.Class == "WARRIOR" and source == Player.GUID and destobj then

            --     if string.match(param, "_MISSED") then
            --         local missType = param == "SWING_MISSED" and spell or spellType
            --         if missType == "DODGE" then
            --             Player.OverpowerUnit[destobj] = {}
            --             Player.OverpowerUnit[destobj].time = DMW.Time + 5
            --             Player.RevengeUnit[destobj] = {}
            --             Player.RevengeUnit[destobj].time = DMW.Time + 5
            --             C_Timer.After(5, function()
            --                 if Player.OverpowerUnit[destobj] ~= nil then Player.OverpowerUnit[destobj] = nil end
            --                 if Player.RevengeUnit[destobj] ~= nil then Player.RevengeUnit[destobj] = nil end
            --             end)
            --         elseif missType == "PARRY" dor spellType == "BLOCK" then
            --             Player.RevengeUnit[destobj] = {}
            --             Player.RevengeUnit[destobj].time = DMW.Time + 5
            --             C_Timer.After(5, function()
            --                 if Player.OverpowerUnit[destobj] ~= nil then Player.OverpowerUnit[destobj] = nil end
            --                 if Player.RevengeUnit[destobj] ~= nil then Player.RevengeUnit[destobj] = nil end
            --             end)
            --         end
            --     elseif (param == "SPELL_CAST_SUCCESS" and (spellName == Spell.Overpower.SpellName or spellName == Spell.Revenge.SpellName)) or
            --         param == "UNIT_DIED" then
            --         nilWarriorUnit(destobj)
            --     end
            -- end
            -- if DMW.Tables.Swing.Units[sourceobj] ~= nil or DMW.Tables.Swing.Units[destobj] ~= nil then
            --     if param == "SWING_DAMAGE" then
            --         -- if destination == Player.GUID and not sitenrage then StrafeLeftStart();C_Timer.After(.0000001, function() StrafeLeftStop();sitenrage = true end) end
            --         local _, _, _, _, _, _, _, _, _, offhand = select(12, ...)
            --         if offhand then
            --             DMW.Helpers.Swing.SwingOHReset(sourceobj)
            --         else
            --             DMW.Helpers.Swing.SwingMHReset(sourceobj)
            --         end
            --     elseif param == "SWING_MISSED" then
            --         -- if destination == Player.GUID and not sitenrage then StrafeLeftStart();C_Timer.After(.0000001, function() StrafeLeftStop();sitenrage = true end) end
            --         local missType, offhand = select(12, ...)
            --         DMW.Helpers.Swing.MissHandler(sourceobj, missType, offhand, destobj)
            --     -- elseif param == "SPELL_MISSED" then
            --     --     local missType = select(15, ...)
            --     --     if spellName and DMW.Tables.Swing.Reset[DMW.Player.Class] and DMW.Tables.Swing.Reset[DMW.Player.Class][spellName] then
            --     --         DMW.Helpers.Swing.MissHandler(sourceobj, missType, offhand, destobj)
            --     --     end
            --     end
            -- end
        -- end
        -- if param == "SPELL_PERIODIC_DAMAGE" and destination == Player.GUID then
        --     if DMW.Tables.AuraCache[Player.GUID][spellName] ~= nil then
        --         if not Player.DOTed then Player.DOTed = {} end
        --         Player.DOTed[spellName] = DMW.Tables.AuraCache[Player.GUID][spellName].AuraReturn[6]
        --     end
        -- end
        -- if Player.Class == "ROGUE" then
        --     if param == "SPELL_CAST_SUCCESS" and spellName == "Pick Pocket" then
        --         local destobj = DMW.Tables.Misc.guid2pointer[destination]
        --         if DMW.Units[destobj] ~= nil then DMW.Units[destobj].PickPocketed = true end
        --     end
        -- end
        -- if param == "SPELL_DISPELL" and destination == Player.GUID then
        --     if Player.DOTed then
        --         if Player.DOTed[spellName] ~= nil then
        --             Player.DOTed[spellName] = nil
        --         end
        --     end
        -- end
    end
end
