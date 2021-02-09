local DMW = DMW
local Unit = DMW.Classes.Unit
local Unlocked = DMW.Functions.Unlocked
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
    self.Health = Unlocked.UnitHealth(self.Pointer)
    self.HealthMax = Unlocked.UnitHealthMax(self.Pointer)
    self.HP = self.Health / self.HealthMax * 100
    self.HealthDeficit = self.HealthMax - self.Health
end
