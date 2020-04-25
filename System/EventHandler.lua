local DMW = DMW
local EHFrame = CreateFrame("Frame")
-- local class = select(2, UnitClass("player"))
-- local PlayerIsHealer = (class == "SHAMAN" or class == "PRIEST" or class == "DRUID" or class == "PALADIN") and true or false
EHFrame:RegisterEvent("ENCOUNTER_START")
EHFrame:RegisterEvent("ENCOUNTER_END")
EHFrame:RegisterEvent("PLAYER_TOTEM_UPDATE")
EHFrame:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
EHFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
EHFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
EHFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
EHFrame:RegisterEvent("LOOT_OPENED")
EHFrame:RegisterEvent("LOOT_CLOSED")
EHFrame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
EHFrame:RegisterEvent("UNIT_INVENTORY_CHANGED")
EHFrame:RegisterEvent("SKILL_LINES_CHANGED")
EHFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
EHFrame:RegisterEvent("UNIT_ATTACK_SPEED")
-- EHFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

-- if PlayerIsHealer then
--     EHFrame:RegisterEvent("UNIT_HEALTH")
--     EHFrame:RegisterEvent("UNIT_MAXHEALTH")
--     EHFrame:RegisterEvent("UNIT_HEALTH_FREQUENT")
-- end
-- if class == "ROGUE" or class == "DRUID" then
EHFrame:RegisterUnitEvent("UNIT_POWER_FREQUENT", "player")
-- EHFrame:RegisterUnitEvent("UNIT_POWER_UPDATE", "player")
EHFrame:RegisterUnitEvent("UNIT_MAXPOWER", "player")

EHFrame:RegisterEvent("PLAYER_TALENT_UPDATE")
EHFrame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
EHFrame:RegisterEvent("CHARACTER_POINTS_CHANGED")

EHFrame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
local function EventHandler(self, event, ...)
    if GetObjectWithGUID then
        if event == "ENCOUNTER_START" then
            DMW.Player.EID = select(1, ...)
        elseif event == "ENCOUNTER_END" then
            DMW.Player.EID = false
        elseif event == "ACTIONBAR_SLOT_CHANGED" then
            DMW.Helpers.Queue.GetBindings()
        elseif event == "PLAYER_REGEN_ENABLED" then
            DMW.Player.Combat = false
            DMW.Player.CombatLeft = DMW.Time
        elseif event == "PLAYER_REGEN_DISABLED" then
            DMW.Player.Combat = DMW.Time
            DMW.Player.CombatLeft = false
        elseif event == "PLAYER_EQUIPMENT_CHANGED" then
            --DMW.Player:UpdateEquipment()
        elseif event == "CHARACTER_POINTS_CHANGED" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "PLAYER_TALENT_UPDATE" then
            if DMW.Player then
                C_Timer.After(0.3, function() DMW.Player:UpdateVariables() end)
            end
            if DMW.Player.GetTalents  then DMW.Player:GetTalents() end
        elseif event == "RAID_TARGET_UPDATE" then
            DMW.Player.UpdateMarkCache()
        elseif event == "LOOT_OPENED" then
            DMW.Player.Looting = true
        elseif event == "LOOT_CLOSED" then
            DMW.Player.Looting = false
        elseif event == "GET_ITEM_INFO_RECEIVED" then
            local ItemID = select(1, ...)
            if DMW.Tables.ItemInfo[ItemID] then
                DMW.Tables.ItemInfo[ItemID]:Refresh()
                DMW.Tables.ItemInfo[ItemID] = nil
            end
        -- elseif event == "UNIT_INVENTORY_CHANGED" then
        --     local unit = select(1, ...)
        --     if unit == "player" then
        --         DMW.Helpers.Swing.OnInventoryChange(nil,...)
        --     end
        -- elseif event == "UNIT_ATTACK_SPEED" then
        --     DMW.Helpers.Swing.SpeedUpdate(nil,...)
        elseif event == "UNIT_POWER_FREQUENT" then --or event == "PLAYER_TALENT_UPDATE" then --or event == "UNIT_POWER_UPDATE" then
            local _, powerType = ...
            -- print(event, powerType)
            if DMW.Player and DMW.Player.UpdatePower and powerType ~= 10 then DMW.Player:UpdatePower("Current", powerType) end
            -- print(event,...)
        elseif event == "UNIT_MAXPOWER" then
            local _, powerType = ...
            -- print(event, powerType)
            if DMW.Player and DMW.Player.UpdatePower and powerType ~= 10 then DMW.Player:UpdatePower("Max", powerType) end
            -- print(event,...)
            -- local a, b = ...
            -- -- print(...)
            -- if class == "ROGUE" or (class == "DRUID" and GetShapeshiftForm() == 3) then
            --     local Power = UnitPower("player") or 0
            --     if DMW.Player and DMW.Player.Power and a == "player" and b == "ENERGY" and DMW.Player.Power < Power then
            --         DMW.Player.TickTime = DMW.Time
            --     -- EHFrame:UnregisterEvent("UNIT_POWER_FREQUENT")
            --     end
            -- end
        -- elseif event == "SKILL_LINES_CHANGED" and DMW.Player.UpdateProfessions then
        --     DMW.Player:UpdateProfessions()
        -- elseif PlayerIsHealer and (event == "UNIT_MAXHEALTH" or event == "UNIT_HEALTH_FREQUENT") then --event == "UNIT_HEALTH" or
        --     local unit = ...
        --     local Pointer = DMW.Tables.Misc.unit2pointerF(unit)
        --     if Pointer then
        --         DMW.Units[Pointer]:UpdateHealth()
        --     end
            -- if unit == "target" then
            --     WriteFile("checkychecky.txt", event.. "," .. DMW.Time .. " , " .. UnitHealth(unit).."\n", true)
            --     print(event, GetTime())

            -- end
            -- DMW.Helpers.HealComm:Update(unit)
        -- elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        -- --     -- if DMW.Player.Class == "SHAMAN" then
        -- --     --     local _, _, spellID = ...
        -- --     --     -- WriteFile("checkychecky.txt", event .. " , "..spellID.. " , " .. DMW.Time .. " , " .. UnitHealth(DMW.Player.Target.Pointer).."\n", true)
        -- --     --     if TotemList[spellID] ~= nil then
        -- --     --         DMW.Player:NewTotem(spellID)
        -- --     --     end
        -- --     -- end
        --     if DMW.Player.Class == "WARRIOR" and DMW.Player.SpecID == "Fury" then
        --         local _, _, spellID = ...
        --         -- print(...)
        --         if spellID == 126664 or spellID == 100 then
        --             DMW.Player.LastCast = "Charge"
        --         else
        --             DMW.Player.LastCast = SpellID
        --         end
        --     end
            -- DMW.Helpers.Swing.ResetSpell(spellID)
        elseif event == "PLAYER_TOTEM_UPDATE" then
            -- need fixes
            if DMW.Player.Class == "PALADIN" then
                if GetTotemInfo(1) then
                    DMW.Player.Consecration = {
                        PosX = DMW.Player.PosX,
                        PosY = DMW.Player.PosY,
                        PosZ = DMW.Player.PosZ
                    }
                else
                    DMW.Player.Consecration = false
                end
            -- elseif DMW.Player.Class == "SHAMAN" then
            --     local slotID = ...
            --     C_Timer.After(0.3, function() DMW.Player:UpdateTotem(slotID) end)
                -- DMW.Player:UpdateTotemsCache()
            end
        elseif event == "GROUP_ROSTER_UPDATE" then
            -- print("12312")
            DMW.Tables.Misc.GROUP_ROSTER_UPDATE()
        elseif event == "PLAYER_ENTERING_WORLD" then
            print("123")
        end
    end
end
EHFrame:SetScript("OnEvent", EventHandler)

-- if class == "SHAMAN" then
--     hooksecurefunc(DMW, "Remove", function(pointer)
--         -- print(UnitName(pointer))
--             for _, Element in pairs(DMW.Player.Totems) do
--                 -- if Element.Unit then
--                     if Element.Pointer == pointer then
--                         -- print("delete")
--                         table.wipe(Element)
--                     end
--                 -- end
--             end
--     end)
-- end
