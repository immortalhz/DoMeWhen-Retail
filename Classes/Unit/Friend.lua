local DMW = DMW
local Unit = DMW.Classes.Unit
-- CLH = LibStub("LibCombatLogHealth-2.0")
-- CLH.RegisterCallback("DMW", "COMBAT_LOG_HEALTH", function(event, unit, eventType)
    -- local health = CLH.UnitHealth(unit)
    -- local health = CLH.UnitHealth(unit)
    -- local Pointer = DMW.Tables.Misc.unit2pointerF(unit)
    -- if Pointer then
    --     if DMW.Friends.Units[Pointer] then
    --         DMW.Friends.Units[Pointer]:UpdateHealth(true, health)
    --     end
    -- end
    -- if DMWUnit then
    --     DMWUnit.Health = CLH.UnitHealth(unit)
    --     -- print(unit)
    -- end
    -- print(event, unit, eventType, health)
-- end)

-- function Unit:CLHealth()
--     self.Health = LibCLHealth.UnitHealth(self.GUID)
-- end
function Unit:CalculateHP()
    -- if self.PredictedHeal then
    --     -- print(self.PredictedHeal)
    --     local afterHeal = self.Health + self.PredictedHeal
    --     self.Health = afterHeal < self.HealthMax and afterHeal or self.HealthMax
    -- end
    -- if self.UnitID then
    --     self.Health = CLH.UnitHealth(self.UnitID)
    -- end
    -- if not self.HealthDeficit then
    -- if self.HealthPredicted and not self.HealthPredictedCheck then
    --     -- for i = 1, #self.HealthPredicted do
    --     --     if self.HealthPredicted[1]
    --     -- end
    --     -- print(#self.HealthPredicted)
    --     for _, v in ipairs(self.HealthPredicted) do
    --         -- local Unit = DMW.Units[Pointer]
    --             -- for k, v in ipairs(Unit.HealthPredicted) do
    --             --     if v.caster == arg2 then
    --             --         -- print("asdasd")
    --             --         -- v = nil
    --             --         print(k)
    --             --         tremove(Unit.HealthPredicted, k)
    --             --     end
    --             -- end
    --         for i = #self.HealthPredicted, 1 do
    --             local table = self.HealthPredicted[i]
    --             if table.Remove or (table.caster == arg2 and DMW.Time >= table.time + 0.5) then
    --                 tremove(self.HealthPredicted,i)
    --             end
    --         end
    --         if DMW.Time >= v.time - 0.2 then
    --             local newHealth = self.Health + v.amount
    --             self.Health = newHealth >= self.HealthMax and self.HealthMax or newHealth
    --             -- self.Health = max(self.Health + v.amount, self.HealthMax)
    --         end
    --         if #self.HealthPredicted == 0 then self.HealthPredicted = nil;print("delete") end
    --     end
    --     self.HealthPredictedCheck = true
    -- end
    -- if self.HealthPredicted and not self.HealthPredictedCheck then
    --         for i = #self.HealthPredicted, 1 do
    --             local table = self.HealthPredicted[i]
    --             if table.Remove or DMW.Time >= table.time + 0.3 then
    --                 tremove(self.HealthPredicted,i)
    --             end
    --         end
    --         -- self.HealthDeficit = self.HealthMax - self.Health
    --         if #self.HealthPredicted == 0 then self.HealthPredicted = nil;print("delete calc") end
    --         -- self.HealthPredictedCheck = true
    --     -- end
    -- end
    self.Health = UnitHealth(self.Pointer)
    self.HealthMax = UnitHealthMax(self.Pointer)
    self.HP = self.Health / self.HealthMax * 100
    self.HealthDeficit = self.HealthMax - self.Health
end
