local DMW = DMW
local Unit = DMW.Classes.Unit
local Unlocked = DMW.Functions.Unlocked

function Unit:IsTanking(ThreatThreshold)
	local ThreatThreshold = ThreatThreshold or 2
	local ThreatSituation =  Unlocked.UnitThreatSituation(DMW.Player.Pointer, self.Pointer)
	return ThreatSituation and ThreatSituation >= ThreatThreshold or false
end

function Unit:ThreatLevel()
	local ThreatSituation =  Unlocked.UnitThreatSituation(DMW.Player.Pointer, self.Pointer)
	-- if ThreatSituation then print(ThreatSituation) end
	return ThreatSituation and ThreatSituation or -1
end

local ThreatTable = {
	[-1] = true,
	[0] = true,
	[1] = false,
	[2] = true,
	[3] = false
}
function Unit:NotPlayerTanking()
	local threatLevel = self:ThreatLevel()
	-- print(threatLevel)
	local status = ThreatTable[threatLevel]
	-- if status then
	-- 	-- print(self.Name, status)
	-- end
	return status or false
end

-- function Unit:IsTanking()
-- 	for _, Unit in pairs(DMW.Enemies) do
-- 		if (Unit: Unlocked.UnitThreatSituation(self) and Unit: Unlocked.UnitThreatSituation(self) > 1) or (Unit.Target and Unlocked.UnitIsUnit(self.Pointer, Unit.Target)) then
-- 			return true
-- 		end
-- 	end
-- 	return false
-- end
