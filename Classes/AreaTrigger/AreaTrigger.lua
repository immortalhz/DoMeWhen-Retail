local DMW = DMW
local AreaTrigger = DMW.Classes.AreaTrigger
local Corpse = DMW.Classes.Corpse

function AreaTrigger:New(Pointer)
    self.Pointer = Pointer
    self.Name = ObjectName(Pointer)
    self.ObjectID = ObjectID(Pointer)
    self.GUID = UnitGUID(Pointer)
end

function AreaTrigger:Update()
    self.NextUpdate = DMW.Time + (math.random(100, 400) / 1000)
    self.PosX, self.PosY, self.PosZ = ObjectPosition(self.Pointer)
    -- self.Distance = self:GetDistance()
    if not self.Name or self.Name == "" then
        self.Name = ObjectName(self.Pointer)
    end
    -- if not self.Quest or (DMW.Cache.QuestieCache.CacheTimer and DMW.Time > DMW.Cache.QuestieCache.CacheTimer) then
    --     self.Quest = self:IsQuest()
    -- end
    -- self.Herb = self:IsHerb()
    -- self.Ore = self:IsOre()
    self.Trackable = self:IsTrackable()
end

function AreaTrigger:GetDistance(OtherUnit)
    OtherUnit = OtherUnit or DMW.Player
    return sqrt(((self.PosX - OtherUnit.PosX) ^ 2) + ((self.PosY - OtherUnit.PosY) ^ 2) + ((self.PosZ - OtherUnit.PosZ) ^ 2))
end

-- function AreaTrigger:IsQuest()
--     if DMW.Helpers.QuestieHelper.isQuestObject(self.ObjectID, self.Pointer) then return true end
--     return false
-- end

-- function GameObject:IsHerb()
--     if DMW.Settings.profile.Tracker.Herbs and DMW.Enums.Herbs[self.ObjectID] and (not DMW.Settings.profile.Tracker.CheckRank or (DMW.Player.Professions.Herbalism and DMW.Enums.Herbs[self.ObjectID].SkillReq <= DMW.Player.Professions.Herbalism)) and (not DMW.Settings.profile.Tracker.HideGrey or (DMW.Player.Professions.Herbalism and DMW.Enums.Herbs[self.ObjectID].SkillReq > (DMW.Player.Professions.Herbalism - 100))) then
--         return true
--     end
--     return false
-- end

-- function GameObject:IsOre()
--     if DMW.Settings.profile.Tracker.Ore and DMW.Enums.Ore[self.ObjectID] and (not DMW.Settings.profile.Tracker.CheckRank or (DMW.Player.Professions.Mining and DMW.Enums.Ore[self.ObjectID].SkillReq <= DMW.Player.Professions.Mining)) and (not DMW.Settings.profile.Tracker.HideGrey or (DMW.Player.Professions.Mining and DMW.Enums.Ore[self.ObjectID].SkillReq > (DMW.Player.Professions.Mining - 100))) then
--         return true
--     end
--     return false
-- end

-- function GameObject:HasFlag(Flag)
--     return bit.band(ObjectDescriptor(self.Pointer, GetOffset("CGGameObjectData__Flags"), "int"), Flag) > 0
-- end

function AreaTrigger:IsTrackable() --TODO: enums
    if DMW.Settings.profile.Helpers.ShowIDs then
        return true
    elseif DMW.Settings.profile.Tracker.Trackable and DMW.Enums.Trackable[self.ObjectID] then
        return true
    elseif DMW.Enums.VisionsPots[self.ObjectID] and DMW.Player.BadPotion and DMW.Player.BadPotion ~= self.ObjectID then
        return true
    elseif DMW.Enums.horrificVisionChests[self.ObjectID] then
        return true
    elseif DMW.Settings.profile.Tracker.TrackObjects and DMW.Settings.profile.Tracker.TrackObjects ~= "" then
        for k in string.gmatch(DMW.Settings.profile.Tracker.TrackObjects, "([^,]+)") do
            if strmatch(string.lower(self.Name), string.lower(string.trim(k))) then
                return true
            end
        end
    end
    return false
end

local LibDraw = LibStub("LibDraw-1.0")

function AreaTrigger:Draw(Type, size1, size2, size3) --TODO: enums
    if Type == "Circle" then
        local r, b, g, a = 1, 0 , 0 ,1
        LibDraw.SetColorRaw(r, b, g, a)
        LibDraw.Circle(self.PosX, self.PosY, self.PosZ, size1)
    elseif Type == "Rect" then
        local rotation = select(2, ObjectFacing(self.Pointer))
        local nlX, nlY, nrX, nrY, frX, frY, flX, flY, flZ, nlZ, nrZ, frZ = DMW.Tables.Dodgie.getRectUnit(size1, size2, self, rotation) --self.PosX, self.PosY, self.PosZ, rotation)
        DMW.Helpers.DrawLineDMWC(flX, flY, DMW.Player.PosZ, nlX, nlY, DMW.Player.PosZ)
        DMW.Helpers.DrawLineDMWC(frX, frY, DMW.Player.PosZ, nrX, nrY, DMW.Player.PosZ)
        DMW.Helpers.DrawLineDMWC(frX, frY, DMW.Player.PosZ, flX, flY, DMW.Player.PosZ)
        DMW.Helpers.DrawLineDMWC(nlX, nlY, DMW.Player.PosZ, nrX, nrY, DMW.Player.PosZ)
    elseif Type == "Cross" then

    elseif Type == "Cone" then
        local rotation = select(2, ObjectFacing(self.Pointer))
        LibDraw.Arc(self.PosX, self.PosY, DMW.Player.PosZ, size1, size2, rotation)
    end
end

function Corpse:New(Pointer)
    self.Pointer = Pointer
    self.Name = ObjectName(Pointer)
    self.ObjectID = ObjectID(Pointer)
end

function Corpse:Update()
    self.NextUpdate = DMW.Time + (math.random(100, 400) / 1000)
    self.PosX, self.PosY, self.PosZ = ObjectPosition(self.Pointer)
    self.Distance = self:GetDistance()
    if not self.Name or self.Name == "" then
        self.Name = ObjectName(self.Pointer)
    end
    self.Quest = self:IsQuest()
    self.Herb = self:IsHerb()
    self.Ore = self:IsOre()
    self.Trackable = self:IsTrackable()
end
