local DMW = DMW
local Unit = DMW.Classes.Unit
DMW.Helpers.Dodgie = {}
DMW.Tables.Dodgie = {}
local Dodgie = DMW.Helpers.Dodgie
local LibDraw = LibStub("LibDraw-1.0")
DMW.Tables.Dodgie.DrawUnits = {}
DMW.Tables.Dodgie.SpellsToDraw = {
    [308742] = {"cone", 8, 270}
}
local function getRectUnit(width,length, x, y, z, facing)
    width = width or 3
    length = length or 30
    local halfWidth = width/2
    -- Near Left
    local nlX, nlY, nlZ = GetPositionFromPosition(x, y, z, halfWidth, facing + rad(90), 0)
    -- Near Right
    local nrX, nrY, nrZ = GetPositionFromPosition(x, y, z, halfWidth, facing + rad(270), 0)
    -- Far Left
    local flX, flY, flZ = GetPositionFromPosition(nlX, nlY, nlZ, length, facing, 0)
    -- Far Right
    local frX, frY, frZ = GetPositionFromPosition(nrX, nrY, nrZ, length, facing, 0)

    return nlX, nlY, nrX, nrY, frX, frY, flX, flY, flZ, nlZ, nrZ, frZ
end

function Unit:DrawCleave()
    local drawType, size1, size2 = self.DrawCleaveInfo[1], self.DrawCleaveInfo[2],self.DrawCleaveInfo[3]
    local rotation = self:RawFacing()
    if drawType == "rect" then
        local nlX, nlY, nrX, nrY, frX, frY, flX, flY, flZ, nlZ, nrZ, frZ = getRectUnit(size1, size2, self.PosX, self.PosY, self.PosZ, rotation)
        Line(flX, flY, pZ, nlX, nlY, pZ)
        Line(frX, frY, pZ, nrX, nrY, pZ)
        Line(frX, frY, pZ, flX, flY, pZ)
        Line(nlX, nlY, pZ, nrX, nrY, pZ)
    elseif drawType == "cone" then
        LibDraw.Arc(self.PosX, self.PosY, self.PosZ, size1, size2, rotation)
        print("arc")
    end
    LibDraw.SetColorRaw(0, 1, 0)
    local castRemainReal = self:CastRemains()
    local castRemainPrint = string.format("%0.1f", castRemainReal)
    if castRemainReal <= 3 then
        LibDraw.SetColorRaw(1, 0, 0)
    end
    LibDraw.Text(castRemainPrint, "GameFontNormalSmall", self.PosX, self.PosY, self.PosZ + 2)
end

-- function Dodgie.Run()
-- end


local function CacheCasts(_, event, _, source, _, sourceFlag, _, destination, _, _, _, spell)
    -- if source == DMW.Player.GUID then
    --     print(event, spell, sourceFlag)
    -- end
    if event == "SPELL_CAST_START" then
        local sourceobj = DMW.Tables.Misc.guid2pointer[source]
        local Unit = DMW.Units[sourceobj]
        if Unit then
            Unit:GetCastingInfo()
            local toDraw = DMW.Tables.Dodgie.SpellsToDraw[spell]
            if toDraw ~= nil then
                Unit.DrawCleaveInfo = toDraw
                tinsert(DMW.Tables.Dodgie.DrawUnits, Unit)
            end
        end
    elseif event == "SPELL_CAST_SUCCESS" or event == "SPELL_CAST_FAILED" then
        local sourceobj = DMW.Tables.Misc.guid2pointer[source]
        local Unit = DMW.Units[sourceobj]
        if Unit then
            Unit:ClearCastingInfo()

        end
    -- elseif event == "SPELL_CAST_SUCCESS" or event == "SPELL_CAST_FAILED" then
    --     local sourceobj = DMW.Tables.Misc.guid2pointer[source]
    --     local Unit = DMW.Units[sourceobj]
    --     if Unit and Unit.castinggg then
    --         Unit.castinggg = nil
    --         print(Unit.Name, "FAIL",spell)
    --     end
    end
    -- print(event, source, spell)
end



function DMW.Tables.Dodgie.DrawStuff()
    for k,v in pairs(DMW.Tables.Dodgie.DrawUnits) do
        -- print(v)
        if v.DrawCleaveInfo then

            v:DrawCleave()
        end
    end
end



    -- if checkCleave(thisUnit, spellID) then
    --     LibDraw.SetColorRaw(1, 0, 0)
    -- elseif endtime ~= nil and endtime/1000 <= GetTime() + 2 then
    --     LibDraw.SetColorRaw(1, 0, 1)
    -- else
    --     LibDraw.SetColorRaw(0, 1, 0)
    -- end





DMW.Helpers.Dodgie.Init = function()
    if not DodgieFrame then
        DodgieFrame = CreateFrame("frame")
        DodgieFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        -- swingTimerFrame:RegisterEvent("PLAYER_ENTER_COMBAT")
        DodgieFrame:SetScript("OnEvent", function(_, event, ...)
            if event == "COMBAT_LOG_EVENT_UNFILTERED" then
                CacheCasts(CombatLogGetCurrentEventInfo())
            end
        end)
        -- DodgieFrame:SetScript("OnUpdate", function(self, elapsed)
        --     DrawStuff()
        -- end)
        -- selfGUID = UnitGUID("player")
    end
end



