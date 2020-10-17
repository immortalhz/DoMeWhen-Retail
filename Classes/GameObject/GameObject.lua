local DMW = DMW
local GameObject = DMW.Classes.GameObject
local Corpse = DMW.Classes.Corpse

function GameObject:New(Pointer)
    self.Pointer = Pointer
    self.Name = ObjectName(Pointer)
    self.ObjectID = ObjectID(Pointer)
    self.GUID = UnitGUID(Pointer)

end

function GameObject:Update()
    self.NextUpdate = DMW.Time + (math.random(100, 400) / 1000)
    self.PosX, self.PosY, self.PosZ = ObjectPosition(self.Pointer)
    self.Distance = self:GetDistance()
    if not self.Name or self.Name == "" then
        self.Name = ObjectName(self.Pointer)
    end
    if not self.Quest or (DMW.Cache.QuestieCache.CacheTimer and DMW.Time > DMW.Cache.QuestieCache.CacheTimer) then
        self.Quest = self:IsQuest()
    end
    self.Herb = self:IsHerb()
    self.Ore = self:IsOre()
    self.Trackable = self:IsTrackable()
end

function GameObject:GetDistance(OtherUnit)
    OtherUnit = OtherUnit or DMW.Player
    return sqrt(((self.PosX - OtherUnit.PosX) ^ 2) + ((self.PosY - OtherUnit.PosY) ^ 2) + ((self.PosZ - OtherUnit.PosZ) ^ 2))
end

function GameObject:IsQuest()
    -- if IsQuestObject(self.Pointer) then print(self.Name) end
    if IsQuestObject(self.Pointer) or DMW.Helpers.QuestieHelper.isQuestObject(self.ObjectID, self.Pointer) then return true end
    return false
end

function GameObject:IsHerb()
    if DMW.Settings.profile.Tracker.Herbs and DMW.Enums.Herbs[self.ObjectID] and (not DMW.Settings.profile.Tracker.CheckRank or (DMW.Player.Professions.Herbalism and DMW.Enums.Herbs[self.ObjectID].SkillReq <= DMW.Player.Professions.Herbalism)) and (not DMW.Settings.profile.Tracker.HideGrey or (DMW.Player.Professions.Herbalism and DMW.Enums.Herbs[self.ObjectID].SkillReq > (DMW.Player.Professions.Herbalism - 100))) and bit.band(ObjectDescriptor(self.Pointer, GetOffset("CGObjectData__DynamicFlags"), "int"), 0x0000000016) == 0 then--ObjectDescriptor(self.Pointer, GetOffset("CGGameObjectData__Flags"), "int") == 278528 then
        return true
    end
    return false
end

function GameObject:IsOre()
    if DMW.Settings.profile.Tracker.Ore and DMW.Enums.Ore[self.ObjectID] and (not DMW.Settings.profile.Tracker.CheckRank or (DMW.Player.Professions.Mining and DMW.Enums.Ore[self.ObjectID].SkillReq <= DMW.Player.Professions.Mining)) and (not DMW.Settings.profile.Tracker.HideGrey or (DMW.Player.Professions.Mining and DMW.Enums.Ore[self.ObjectID].SkillReq > (DMW.Player.Professions.Mining - 100))) then
        return true
    end
    return false
end

function GameObject:HasFlag(Flag)
    local Flags = ObjectDescriptor(self.Pointer, GetOffset("CGGameObjectData__Flags"), "int")
    return bit.band(Flags, Flag) > 0
end

function GameObject:HasDynFlag(Flag)
    local dynFlags = ObjectDescriptor(self.Pointer, GetOffset("CGObjectData__DynamicFlags"), "int")
    return bit.band(dynFlags, Flag) > 0
end

function GameObject:IsTrackable() --TODO: enums
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
