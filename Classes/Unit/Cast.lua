local DMW = DMW
local Unit = DMW.Classes.Unit

function Unit:GetProperCastingInfo()
    if self.Cast == "Channel" then
        self:GetChannelingInfo()
    elseif self.Cast == "Cast" then
        self:GetCastingInfo()
    end
end

function Unit:PopulateCasting()
    if not self.CacheCasting or DMW.Time > self.CacheCasting then
        local castingInfo = self:GetCastingInfo()
        self.CacheCasting = DMW.Time
        if castingInfo[1] then
            self.Cast = "Cast"
			self.Casting = castingInfo
			if DMW.Tables.Dodgie.SpellsToDraw[castingInfo[9]] ~= nil then
				self.DrawDodgie = DMW.Tables.Dodgie.SpellsToDraw[castingInfo[9]]
				self.NextUpdate = DMW.Time
            end
			-- print("cast")
            return
        end
        local channelInfo = self:GetChannelingInfo()
        if channelInfo[1] then
            self.Cast = "Channel"
			self.Casting = channelInfo
			if DMW.Tables.Dodgie.SpellsToDraw[channelInfo[8]] ~= nil then
				self.DrawDodgie = DMW.Tables.Dodgie.SpellsToDraw[channelInfo[8]]
				self.NextUpdate = DMW.Time

            end
            -- print("chan")
            return
        end
        self.CastingCheck = nil
        self.Cast = nil
        self.Casting = nil
		self.DrawDodgie = nil
		-- print("nil")
    end
end

function Unit:GetCastingInfo()
    return {UnitCastingInfo(self.Pointer)}
end


-- Get the Casting Infos from the Cache.
function Unit:CastingInfo(Index)
    -- if not self.Casting then
    --     -- name, nameSubtext, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID
    --     self:GetProperCastingInfo()
    -- end
    if not self.Casting then return false end
    if Index then
        return self.Casting[Index]
    else
        return unpack(self.Casting)
    end
    return nil
end

-- Get if the unit is casting or not. Param to check if the unit is casting a specific spell or not
function Unit:IsCasting(SpellID)
    if SpellID then
        return self:CastingInfo(9) == SpellID and true or false
    else
        return self:CastingInfo(1) and true or false
    end
end

function Unit:CastIdCheck()
    if self:IsCasting() then
        if self.Cast == "Cast" then
            return self:CastingInfo(9)
        elseif self.Cast == "Channel" then
            return self:CastingInfo(8)
        end
    end
    return 0
end

function Unit:CastIdName()
    if self:IsCasting() then
        return self:CastingInfo(1)
    end
    return "False"
end

function Unit:PlayerCastCheck()
    if self:IsCasting() then
        if self.Cast == "Cast" then
            return select(3, UnitCastID(self.Pointer)) == DMW.Player.Pointer
        elseif self.Cast == "Channel" then
            return select(4, UnitCastID(self.Pointer)) == DMW.Player.Pointer
        end
    end
    return false
end

-- Get the unit cast's name if there is any.
function Unit:CastName() return self:IsCasting() and self:CastingInfo(1) or "" end

-- Get the unit cast's id if there is any.
function Unit:CastID() return self:IsCasting() and self:CastingInfo(9) or -1 end

--- Get all the Channeling Infos from an unit and put it into the Cache.
function Unit:GetChannelingInfo()
        -- name, nameSubtext, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID
        -- self.Casting = {UnitChannelInfo(self.Pointer)}
        return {UnitChannelInfo(self.Pointer)}
end

-- Get the Channeling Infos from the Cache.
function Unit:ChannelingInfo(Index)
    if not self.Casting then
        -- name, nameSubtext, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID
        self:GetProperCastingInfo()
	end
	if not self.Casting then return false end
    if Index then
        return self.Casting[Index]
    else
        return unpack(self.Casting)
    end
    return nil
end

-- Get if the unit is channeling or not.
function Unit:IsChanneling(SpellID)
    if SpellID then
        return self:ChannelName() == SpellID and true or false
    else
        return self:ChannelingInfo(1) and true or false
    end
end

-- Get the unit channel's name if there is any.
function Unit:ChannelName() return self:IsChanneling() and self:ChannelingInfo(1) or "" end

-- Get if the unit cast is interruptible if there is any.
function Unit:IsInterruptible()
    if self:IsCasting() then
        if self.Cast == "Cast" then
            return not self:CastingInfo(8)
        elseif self.Cast == "Channel" then
            return not self:CastingInfo(7)
        end
    end
    return false
    -- return (self:CastingInfo(8) == false or self:ChannelingInfo(7) == false) and true or false
end

function Unit:CastGetName()
	if self:IsChanneling() then
		return self:ChannelingInfo(1)
	elseif self:IsCasting() then
		return self:CastingInfo(1)
	end
	return ""
end

-- Get when the cast, if there is any, started (in seconds).
function Unit:CastStart()
    if self:IsCasting() then return self:CastingInfo(4) / 1000 end
    return 0
end

-- Get when the cast, if there is any, will end (in seconds).
function Unit:CastEnd()
    if self:IsCasting() then return self:CastingInfo(5) / 1000 end
    return 0
end

-- Get the full duration, in seconds, of the current cast, if there is any.
function Unit:CastDuration() return self:CastEnd() - self:CastStart() end

function Unit:CastCurrent()
	-- print(DMW.Time - self:CastStart())
	if self:IsCasting() then return DMW.Time - self:CastStart() end
	return 0
end

-- Get the remaining cast time, if there is any.
function Unit:CastRemains()
    if self:IsCasting() then return self:CastEnd() - DMW.Time end
    return 0
end

-- Get the progression of the cast in percentage if there is any.
-- By default for channeling, it returns total - progress, if ReverseChannel is true it'll return only progress.
function Unit:CastPercentage(ReverseChannel)
    if self:IsCasting() then
        local CastStart = self:CastStart()
        return (DMW.Time - CastStart) / (self:CastEnd() - CastStart) * 100
    end
    if self:IsChanneling() then
        local CastStart = self:CastStart()
        return ReverseChannel and (DMW.Time - CastStart) / (self:CastEnd() - CastStart) * 100 or 100 - (DMW.Time - CastStart) /
                   (self:CastEnd() - CastStart) * 100
    end
    return 0
end

function Unit:ClearCastingInfo()
    self.Casting = nil
    self.Channelling = nil
    self.DrawCleaveInfo = nil
end

function Unit:CheckCastingInfo()
    if self.Casting and UnitCastingInfo(self.Pointer) == nil then
        self:ClearCastingInfo()
        return true
    end
    -- if self.Casting then
    --     -- name, nameSubtext, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID
    --     self.Casting = {UnitCastingInfo(self.Pointer)}
    -- end
end

