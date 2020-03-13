local DMW = DMW
local Unit = DMW.Classes.Unit

function Unit:GetCastingInfo()
    if not self.Casting then
        -- name, nameSubtext, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID
        self.Casting = {UnitCastingInfo(self.Pointer)}
    end
end

-- Get the Casting Infos from the Cache.
function Unit:CastingInfo(Index)
    if not self.Casting then
        -- name, nameSubtext, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID
        self:GetCastingInfo()
    end
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

-- Get the unit cast's name if there is any.
function Unit:CastName() return self:IsCasting() and self:CastingInfo(1) or "" end

-- Get the unit cast's id if there is any.
function Unit:CastID() return self:IsCasting() and self:CastingInfo(10) or -1 end

--- Get all the Channeling Infos from an unit and put it into the Cache.
function Unit:GetChannelingInfo() self.Channeling = {UnitChannelInfo(self.Pointer)} end

-- Get the Channeling Infos from the Cache.
function Unit:ChannelingInfo(Index)
    if self.Channeling then self:GetChannelingInfo() end
    if Index then
        return self.Channeling[Index]
    else
        return unpack(self.Channeling)
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
function Unit:IsInterruptible() return (self:CastingInfo(8) == false or self:ChannelingInfo(7) == false) and true or false end

-- Get when the cast, if there is any, started (in seconds).
function Unit:CastStart()
    if self:IsCasting() then return self:CastingInfo(4) / 1000 end
    if self:IsChanneling() then return self:ChannelingInfo(4) / 1000 end
    return 0
end

-- Get when the cast, if there is any, will end (in seconds).
function Unit:CastEnd()
    if self:IsCasting() then return self:CastingInfo(5) / 1000 end
    if self:IsChanneling() then return self:ChannelingInfo(5) / 1000 end
    return 0
end

-- Get the full duration, in seconds, of the current cast, if there is any.
function Unit:CastDuration() return self:CastEnd() - self:CastStart() end

-- Get the remaining cast time, if there is any.
function Unit:CastRemains()
    if self:IsCasting() or self:IsChanneling() then return self:CastEnd() - DMW.Time end
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
