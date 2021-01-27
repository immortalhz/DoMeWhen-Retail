local DMW = DMW
local Spell = DMW.Classes.Spell
local CastTimer = GetTime()

local function FacingCast(SpellName, Target)
	local CastTime = select(4, GetSpellInfo(SpellName))
	if CastTime == 0 and UnitIsVisible(Target or "Target") and not ObjectIsFacing("Player", Target or "Target") and not UnitIsUnit("Player", Target or "Target") then
		local Facing = ObjectFacing("Player")
		-- local MouselookActive = false
		-- if IsMouselooking() then
		-- 	MouselookActive = true
		-- 	MouselookStop()
		-- end
		FaceDirection(Target or "Target", true)
		CastSpellByName(SpellName, Target)
		FaceDirection(Facing)
		-- if MouselookActive then
		-- 	MouselookStart()
		-- end
		C_Timer.After(
			0.1,
			function()
				FaceDirection(ObjectFacing("player"), true)
			end
		)
	else
		CastSpellByName(SpellName, Target)
	end
end

function Spell:FacingCast(Unit)
	if DMW.Settings.profile.Enemy.AutoFace and not DMW.Player.Pointer ~= Unit.Pointer and self:CastTime() == 0 and not Unit:Facing() then
		local Facing = ObjectFacing("player")
		local MouselookActive = false
		if IsMouselooking() then
			MouselookActive = true
			MouselookStop()
		end
		FaceDirection(Unit.Pointer, true)
        CastSpellByName(self.SpellName, Unit.Pointer)
		FaceDirection(Facing)
		if MouselookActive then
			MouselookStart()
		end
		C_Timer.After(0.1, function()
			FaceDirection(ObjectFacing("player"), true)
        end)
	else
        CastSpellByName(self.SpellName, Unit.Pointer)
	end
end

function Spell:FacingCastRevenge(Facing)
	if DMW.Settings.profile.Enemy.AutoFace then
		local FacingOld = ObjectFacing("Player")
		local MouselookActive = false
		if IsMouselooking() then
			MouselookActive = true
			MouselookStop()
		end
		FaceDirection(Facing, true)
        CastSpellByName(self.SpellName)
		FaceDirection(FacingOld)
		if MouselookActive then
			MouselookStart()
		end
		C_Timer.After(0.1, function()
			FaceDirection(ObjectFacing("player"), true)
        end)
        return true
	end
end

local SpellQueued
local lastBotCast

function Spell:Cast(Unit, Extra)
	if not Unit then
		if self.IsHarmful and DMW.Player.Target then
			Unit = DMW.Player.Target
		elseif self.IsHelpful then
			Unit = DMW.Player
		else
			return false
		end
	end
	local range = self.MaxRange < 5 and 5 or self.MaxRange

	-- if IsCurrentSpell(lastBotCast) then
	-- 	print("queued "..lastBotCast)
	-- 	return false
	-- end
	-- print(self.Key)
	-- if DMW.Time > CastTimer and
	-- if Unit.Distance == nil then
	-- 	print(self.Key)
	-- end
	if (not self.CastTimer or
	DMW.Time > self.CastTimer)
	and self:IsReady() and
	(Unit.Distance <= range or
	IsSpellInRange(self.SpellName, Unit.Pointer) == 1) then
		if self.BaseGCD ~= 0 then
			self.CastTimer = DMW.Time + (math.random(250, 270) / 1000)
		else
			self.CastTimer = DMW.Time + (math.random(400, 500) / 1000)
		end
		CastTimer = DMW.Time + (math.random(150,170)/1000)
		if DMW.Player.Moving then
			SendMovementUpdate()
        end
        if self.CastType == "Ground" then
			if Unit == DMW.Player then
				RunMacroText("/cast [@player] " .. self.SpellName)
			elseif self:CastGround(Unit.PosX, Unit.PosY, Unit.PosZ) then
				self.LastBotTarget = Unit.Pointer
			else
				return false
			end
		else
			FacingCast(self.SpellName, Unit.Pointer)
			self.LastBotTarget = Unit.Pointer
			lastBotCast = self.SpellID
			-- print(lastBotCast)
		end
		-- print(DMW.Player:SpellQueued())
        DMW.UI.Log.AddCast(self.SpellName, Unit.Name, Extra)
		return true
    end
    return false
end

function Spell:CastNoGCD(Unit)
	if not Unit then
		if self.IsHarmful and DMW.Player.Target then
			Unit = DMW.Player.Target
		elseif self.IsHelpful then
			Unit = DMW.Player
		else
			return false
		end
	end
    -- if self:Known() and self:IsReady() and ((Unit.Distance <= self.MaxRange and (self.MinRange == 0 or Unit.Distance >= self.MinRange)) or IsSpellInRange(self.SpellName, Unit.Pointer) == 1) then
    if self:IsReady() and (Unit.Distance <= self.MaxRange or IsSpellInRange(self.SpellName, Unit.Pointer) == 1) then
        -- if self:CD() == 0 and (DMW.Time - CastTimer) >= 0 then
        --     CastTimer = DMW.Time
        --     if self.CastType == "Ground" then
        --         if self:CastGround(Unit.PosX, Unit.PosY, Unit.PosZ) then
        --             self.LastBotTarget = Unit.Pointer
        --         else
        --             return false
        --         end
        --     else
        --         self:FacingCast(Unit)
        --         self.LastBotTarget = Unit.Pointer
        --     end
        --     return true
        -- end
		-- CastTimer = DMW.Time + (math.random(110, 170) / 1000)
		if DMW.Player.Moving then
			SendMovementUpdate()
        end
        if self.CastType == "Ground" then
			if Unit == DMW.Player then
				RunMacroText("/cast [@player] " .. self.SpellName)
			elseif self:CastGround(Unit.PosX, Unit.PosY, Unit.PosZ) then
				self.LastBotTarget = Unit.Pointer
			else
				return false
			end
		else
			FacingCast(self.SpellName, Unit.Pointer)
			self.LastBotTarget = Unit.Pointer
        end
        DMW.UI.Log.AddCast(self.SpellName, Unit.Name)
		return true
    end
    return false
end

function Spell:CastSpellGround(Unit)
    if not Unit then
        if self.IsHarmful and DMW.Player.Target then
            Unit = DMW.Player.Target
        elseif self.IsHelpful then
            Unit = DMW.Player
        else
            return false
        end
    end
    if self:Known() and self:IsReady() and ((Unit.Distance <= self.MaxRange and (self.MinRange == 0 or Unit.Distance >= self.MinRange)) or IsSpellInRange(self.SpellName, Unit.Pointer) == 1) then
        if self:CD() == 0 and (DMW.Time - CastTimer) >= 0 then
            CastTimer = DMW.Time
            if self:CastGround(Unit.PosX, Unit.PosY, Unit.PosZ) then
                self.LastBotTarget = Unit.Pointer
            else
                return false
            end
            return true
        end
    end
    return false
end

function Spell:CastSpellGroundRandom(Unit, Dif)
    if not Unit then
        if self.IsHarmful and DMW.Player.Target then
            Unit = DMW.Player.Target
        elseif self.IsHelpful then
            Unit = DMW.Player
        else
            return false
        end
	end
	Dif = Dif or 3
    if self:Known() and self:IsReady() and ((Unit.Distance <= self.MaxRange and (self.MinRange == 0 or Unit.Distance >= self.MinRange)) or IsSpellInRange(self.SpellName, Unit.Pointer) == 1) then
        if self:CD() == 0 and (DMW.Time - CastTimer) >= 0 then
            CastTimer = DMW.Time
            if self:CastGround(Unit.PosX + math.random(-Dif, Dif), Unit.PosY + math.random(-Dif, Dif), Unit.PosZ) then
                self.LastBotTarget = Unit.Pointer
            else
                return false
            end
            return true
        end
    end
    return false
end

function Spell:CycleCast(EnemyTable, Conditions)
    for _, Unit in ipairs(EnemyTable) do
        local ConditionalCheck = Conditions == nil and true or Unit..Conditions
        if ConditionalCheck then
            if Spell:Cast(Unit) then
                return true
            end
        end
    end
end

function Spell:CastPool(Unit, Extra)
	Extra = Extra or 0
	if (self:Cost() + Extra) > DMW.Player.Power then
		return true
	end
	return self:Cast(Unit)
end

function Spell:CastGround(X, Y, Z)
    if self:IsReady() then
        local MouseLooking = false
        local PX, PY, PZ = DMW.Player.PosX, DMW.Player.PosY, DMW.Player.PosZ
        local Distance = sqrt(((X - PX) ^ 2) + ((Y - PY) ^ 2) + ((Z - PZ) ^ 2))
        if Distance > self.MaxRange then
            X,Y,Z = GetPositionBetweenPositions (X, Y, Z, PX, PY, PZ, Distance - self.MaxRange)
		end
		Z = select(3, TraceLine(X, Y, Z+5, X, Y, Z-5, 0x110))
		if Z ~= nil and TraceLine(PX, PY, PZ+2, X, Y, Z+1, 0x100010) == nil and TraceLine(X, Y, Z+4, X, Y, Z, 0x1) == nil then
            if IsMouselooking() then
                MouseLooking = true
                MouselookStop()
            end
				CastSpellByName(self.SpellName)
            ClickPosition(X, Y, Z)
            if MouseLooking then
                MouselookStart()
            end
            return true
        end
    end
    return false
end

local BestConeTime = GetTime()
function Spell:CastBestConeEnemy(Length, Angle, MinHit, TTD)
	if not self:IsReady() or DMW.Time < BestConeTime then
		return false
	end
	MinHit = MinHit or 1
	TTD = TTD or 0
	local Table, TableCount = DMW.Player:GetEnemies(Length)
	if TableCount < MinHit then
		return false
	end
	if not DMW.Settings.profile.Enemy.AutoFace then
		CastSpellByName(self.SpellName)
		BestConeTime = DMW.Time + 0.3
		return true
	end
	local PX, PY, PZ = DMW.Player.PosX, DMW.Player.PosY, DMW.Player.PosZ
	local ConeTable = {}
	local X, Y, Z, AngleToUnit
	for _, Unit in pairs(Table) do
		if Unit.TTD >= TTD then
			X, Y, Z = Unit.PosX, Unit.PosY, Unit.PosZ
			AngleToUnit = rad(atan2(Y - PY, X - PX))
			if AngleToUnit < 0 then
				AngleToUnit = rad(360 + atan2(Y - PY, X - PX))
			end
			tinsert(ConeTable, AngleToUnit)
		end
	end
	local Facing, BestAngle, MostHit, Units = 0, 0, 0, 0
	local AngleToUnit, AngleDifference, ShortestAngle, FinalAngle
	while Facing <= 6.2 do
		Units = 0
		for i = 1, #ConeTable do
			AngleToUnit = ConeTable[i]
			AngleDifference = Facing > AngleToUnit and Facing - AngleToUnit or AngleToUnit - Facing
			ShortestAngle = AngleDifference < math.pi and AngleDifference or math.pi * 2 - AngleDifference
			FinalAngle = ShortestAngle * 180 / math.pi
			if FinalAngle < Angle / 2 then
				Units = Units + 1
			end
		end
		if Units > MostHit then
			MostHit = Units
			BestAngle = Facing
		end
		Facing = Facing + 0.05
	end
	if MostHit >= MinHit then
		local CurrentFacing = ObjectFacing("player")
		local mouselookActive = false
		if IsMouselooking() then
			mouselookActive = true
			MouselookStop()
			TurnOrActionStop()
			MoveAndSteerStop()
		end
		FaceDirection(BestAngle, true)
		CastSpellByName(self.SpellName)
		FaceDirection(CurrentFacing)
		if mouselookActive then
			MouselookStart()
		end
		C_Timer.After(
			0.1,
			function()
				FaceDirection(ObjectFacing("player"), true)
			end
		)
		BestConeTime = DMW.Time + 0.3
		return true
	end
	return false
end
