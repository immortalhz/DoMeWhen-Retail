local DMW = DMW
local Spell = DMW.Classes.Spell
local CastTimer = GetTime()

function Spell:FacingCast(Unit)
	if DMW.Settings.profile.Enemy.AutoFace and not UnitIsUnit("player", Unit.Pointer) and self:CastTime() == 0 and not Unit:Facing() then
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
	if DMW.Settings.profile.Enemy.AutoFace  then
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

function Spell:Cast(Unit)
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
        -- if IsAutoRepeatSpell(DMW.Player.Spells.Shoot.SpellName) and self:CD(Rank) < 0.2 then
        --     MoveForwardStart()
        --     MoveForwardStop()
        --     return true
        -- else
        if self:CD() == 0 and (DMW.Time - CastTimer) >= 0 then
            CastTimer = DMW.Time
            if self.CastType == "Ground" then
                if self:CastGround(Unit.PosX, Unit.PosY, Unit.PosZ) then
                    self.LastBotTarget = Unit.Pointer
                else
                    return false
                end
            else
                -- self:HealCommFix(Rank)
                self:FacingCast(Unit)
                self.LastBotTarget = Unit.Pointer
                -- print(self.SpellName)
                -- print(DMW.Time, Unit.Pointer, self.SpellName)
                -- print(self.SpellName,DMW.Time,Unit.Pointer)
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

function Spell:HealCommFix(rank)
    -- DMW.Helpers.HealComm.Settings.timeframe = 0
    -- if DMW.Player.Class == "SHAMAN" then
    --     if self.SpellName == "Chain Heal" or self.SpellName == "Lesser Healing Wave" or self.SpellName == "Healing Wave" then
    --         DMW.Helpers.HealComm.Settings.timeframe = self:CastTime(rank) + 0.2
    --     end
    -- elseif DMW.Player.Class == "PRIEST" then
    --     if self.SpellName == "Greater Heal" or self.SpellName == "Flash Heal" then
    --         DMW.Helpers.HealComm.Settings.timeframe = self:CastTime(rank) + 0.2
    --     end
    -- elseif DMW.Player.Class == "DRUID" then
    --     if self.SpellName == "Healing Touch" or self.SpellName == "Regrowth" then
    --         DMW.Helpers.HealComm.Settings.timeframe = self:CastTime(rank) + 0.2
    --     end
    -- elseif DMW.Player.Class == "PALADIN" then
    --     if self.SpellName == "Holy Light" or self.SpellName == "Flash of Light" then
    --         DMW.Helpers.HealComm.Settings.timeframe = self:CastTime(rank) + 0.2
    --     end
    -- end
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
		Z = select(3,TraceLine(X, Y, Z+5, X, Y, Z-5, 0x110))
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
