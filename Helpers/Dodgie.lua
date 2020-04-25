local DMW = DMW
local Unit = DMW.Classes.Unit
DMW.Helpers.Dodgie = {}
DMW.Tables.Dodgie = {}
local Dodgie = DMW.Helpers.Dodgie
local LibDraw = LibStub("LibDraw-1.0")
DMW.Tables.Dodgie.DrawUnits = {}
DMW.Tables.Dodgie.SpellsToDraw = {
    [270487] = {"cone", 45, 5},-- kr berserk cleave
    [270507] = {"cone", 60, 20},-- kr bm poison sting
    [265540] = {"cone", 40, 30},-- UR maggot aoe
    [265019] = {"cone", 45, 5},-- UR Matron melee cleave
    [260894] = {"cone", 45, 5},-- UR 1st boss aoe
    [272609] = {"rect", 45, 5},-- UR Faceless corruptor aoe
    [293957] = {"rect", 45, 5},-- cos trash
    [257426] = {"cone", 60, 10},-- FH Enforcer melee cleave
    [257784] = {"cone", 30, 5},-- FH ratlike shit frost 30m aoe
    [274400] = {"cone", 45, 5},-- FH duelist charge
    [257870] = {"cone", 360, 4},-- FH https://www.wowhead.com/spell=257870/blade-barrage
    [256589] = {"cone", 360, 10},-- FH Council smash https://www.wowhead.com/spell=256589/barrel-smash
    [258381] = {"cone", 45, 5},-- FH Council boss jump + shoot stuff
    [258352] = {"cone", 45, 5},-- same
    [276268] = {"cone", 45, 10},-- SotS Templar melee cleave
    [264101] = {"rect", 30, 12},-- SotS aqua boss charge
    [267899] = {"cone", 45, 5},-- SotS 2nd boss melee cleave
    [267385] = {"cone", 45, 5},-- tentacle cast last boss SotS
    [256627] = {"cone", 45, 5},-- SoB Halberd cleave
    [257292] = {"rect", 40, 5},-- SoB 1st boss melee cleave
    [279761] = {"rect", 40, 5},-- SoB 1st boss melee cleave
    [257288] = {"rect", 40, 5},-- SoB 1st boss melee cleave
    [272874] = {"rect", 40, 7},-- SoB horse charge
    [268260] = {"cone", 45, 5},-- SoB Cannoneer bambam
    [269029] = {"cone", 45, 5},-- SoB 2nd boss cleave 45
    [272827] = {"cone", 45, 5},-- SoB Pillager poison aoe
    [269266] = {"cone", 15, 35},-- SoB last boss tentacle cleave
    [272711] = {"rect", 45, 10},-- SoB Crushing Slam https://www.wowhead.com/spell=272711/crushing-slam
    [268230] = {"cone", 45, 5},-- SoB thrash cleave
    [256709] = {"cone", 45, 5},-- >.>
    [257036] = {"cone", 45, 5},-- <.<
    [270003] = {"cone", 45, 5},-- kr robots aoe
    [268391] = {"cone", 45, 5},-- SoB cultist aoe stun
    [264574] = {"rect", 45, 2.5},-- ToS power shot
    [263309] = {"cone", 45, 10},-- ToS 1st boss Cyclone Strike
    [263573] = {"cone", 45, 5},--Tos 1st boss stuff
    [263912] = {"cone", 45, 5},--TOS 2nd boss green poo
    [255741] = {"cone", 45, 8},--TOS rider melee
    [273995] = {"cone", 360, 10},--TOS Pyrrhic Blast
    [272657] = {"cone", 60, 20},-- tos thrashe aoe green stuff
    [257337] = {"cone", 45, 5},-- ML 1st boss cone
    [268415] = {"cone", 45, 5},-- ML trash cleave
    [268846] = {"cone", 45, 5},-- ml trash cleave
    [275907] = {"cone", 45, 20},-- ML tectonic smash
    [269313] = {"cone", 360, 8},-- ml final blast
    [268865] = {"cone", 45, 5},--
    [262804] = {"cone", 45, 5},--
    [260669] = {"rect", 20, 3},--ml rixxa pewpew ??
    [272457] = {"cone", 45, 5},-- ur 2nd boss
    [269843] = {"cone", 45, 5},-- ur last boss
    [258864] = {"cone", 45, 5},-- td thrash  suppression fire
    [256955] = {"cone", 45, 5},-- td 2nd boss
    [265372] = {"cone", 45, 5},-- wm thrash cleave
    [271174] = {"cone", 45, 5},--
    [264923] = {"cone", 50, 5},-- wm pig boss cleave
    [259711] = {"cone", 360, 6},-- block warden aoe cleave td
    [288694] = {"cone", 45, 5},-- Reaping smash https://www.wowhead.com/spell=288694/shadow-smash
    ------------------------Uldir-------------------------------------------
    [273538] = {"rect", 40, 6}, --mytrax
    [274113] = {"rect", 40, 6}, --mytrax transmission lazor
    [272115] = {"rect", 40, 6}, --mytrax p2 beam
    [273282] = {"cone", 60, 18}, --mytrax
    [265264] = {"cone", 60, 18},-- zekvoz boss cleave
    [267787] = {"cone", 40, 15},-- 2nd boss cleave
    [262292] = {"cone", 60, 20},-- fetid cleave
    ------------------------BoD----------------------------------------------
    [285177] = {"rect", 40, 7},-- Jaina https://www.wowhead.com/spell=285177/freezing-blast
    [288345] = {"rect", 40, 5},-- Jaina https://www.wowhead.com/spell=288345/glacial-ray
    [282153] = {"rect", 40, 6},-- High Tinker Mekkatorque https://www.wowhead.com/spell=282153/buster-cannon
    [283606] = {"cone", 45, 15},-- Opulence https://www.wowhead.com/spell=283606/crush
    [289906] = {"cone", 45, 15},-- Opulence https://www.wowhead.com/spell=289906/crush
    [282939] = {"cone", 40, 15},-- Opulence https://www.wowhead.com/spell=282939/flames-of-punishment
    [287659] = {"cone", 40, 15},-- Opulence https://www.wowhead.com/spell=287659/flames-of-punishment
    [283063] = {"cone", 40, 15},-- Opulence https://www.wowhead.com/spell=283063/flames-of-punishment
    [287513] = {"cone", 40, 15},-- Opulence https://www.wowhead.com/spell=287513/flames-of-punishment
    [283587] = {"rect", 60, 5},-- Champion of the Light https://www.wowhead.com/spell=283587/wave-of-light
    [283598] = {"rect", 60, 5},-- Champion of the Light https://ptr.wowhead.com/spell=283598/wave-of-light
    [289572] = {"rect", 20, 3},-- Trash charge https://www.wowhead.com/spell=289572/charge
    [285893] = {"cone", 90, 10},-- Gonk Wild Maul https://www.wowhead.com/spell=285893/wild-maul
    [289560] = {"cone", 90, 12},-- Kimbul Lacerating Claws https://www.wowhead.com/spell=282444/lacerating-claws
    [285178] = {"rect", 45, 10},-- Rastakhan Serpent Totem https://www.wowhead.com/spell=285178/serpents-breath
    [270833] = {"rect", 25, 10},-- tests
    [270839] = {"cone", 90, 12},-- tests
    ------------------------CoS----------------------------------------------
    [282589] = {"cone", 30, 45},-- The Restless Cabal https://www.wowhead.com/spell=282589/cerebral-assault
    -----------------Nzo--------------------------------------
    [309671] = {"cone", 60, 10},-- HV Empowered Forge Breath
    [305875] = {"cone", 45, 15},-- HV Visceral Fluid
    [298502] = {"cone", 45, 10},-- HV Toxic Breath
    [297746] = {"rect", 20, 3},-- HV Seismic Slam
    [300388] = {"rect", 20, 5},-- HV Decimator
    [300351] = {"rect", 20, 5},-- HV Surging Fist
    [306726] = {"rect", 20, 5},-- HV Defiled Ground
    [300424] = {"rect", 30, 4},-- Junkyard Shockwave
    [300777] = {"rect", 30, 4},-- Junkyard Slimewave
    [299475] = {"cone", 45, 10},-- Junkyard B.O.R.K
    [293986] = {"cone", 60, 15},-- Workshop Sonic Pulse
    [314483] = {"cone", 360, 5},-- Cascading Terror M+
    [305663] = {"cone", 20, 30},-- Maut Black Wings
    [310396] = {"rect", 60, 5},-- Drest'agath Void Glare
    [310614] = {"cone", 60, 10},-- Drest'agath Crushing Slam
    -- [308742] = {"rect", 25, 5} -- tests
}

local function Line(sx, sy, sz, ex, ey, ez)
    local function WorldToScreen (wX, wY, wZ)
        local sX, sY = _G.WorldToScreen(wX, wY, wZ);
        if sX and sY then
            return sX, -(WorldFrame:GetTop() - sY);
        else
            return sX, sY;
        end
    end
    local startx, starty = WorldToScreen(sx, sy, sz)
    local endx, endy = WorldToScreen(ex, ey, ez)
    if (endx == nil or endy == nil) and (startx and starty) then
        local i = 1
        while (endx == nil or endy == nil) and i < 50 do
            endx, endy = WorldToScreen(GetPositionBetweenPositions(ex, ey, ez, sx, sy, sz, i))
            i = i + 1
        end
    end
    if (startx == nil or starty == nil) and (endx and endy) then
        local i = 1
        while (startx == nil or starty == nil) and i < 50 do
            startx, starty = WorldToScreen(GetPositionBetweenPositions(sx, sy, sz, ex, ey, ez, i))
            i = i + 1
        end
    end
    LibDraw.Draw2DLine(startx, starty, endx, endy)
end

local function getRectUnit(length,width, Unit)
    width = width or 3
    length = length or 30
    local facing = Unit:RawFacing()
    local x,y,z = Unit.PosX, Unit.PosY, Unit.PosZ
    local halfWidth = width/2
    -- Near Left
    local nlX, nlY, nlZ = GetPositionFromPosition(x, y, z, halfWidth, facing + math.rad(90), 0)
    -- Near Right
    local nrX, nrY, nrZ = GetPositionFromPosition(x, y, z, halfWidth, facing + math.rad(270), 0)
    -- Far Left
    local flX, flY, flZ = GetPositionFromPosition(nlX, nlY, nlZ, length, facing, 0)
    -- Far Right
    local frX, frY, frZ = GetPositionFromPosition(nrX, nrY, nrZ, length, facing, 0)

    return nlX, nlY, nrX, nrY, frX, frY, flX, flY, flZ, nlZ, nrZ, frZ
end

function Unit:DrawCleave()
    -- local spellID =
    if self.Dead or UnitCastingInfo(self.Pointer) == nil then return true end
    local drawType, size1, size2 = self.DrawCleaveInfo[1], self.DrawCleaveInfo[2],self.DrawCleaveInfo[3]
    local rotation = self:RawFacing()
    if drawType == "rect" then
        local nlX, nlY, nrX, nrY, frX, frY, flX, flY, flZ, nlZ, nrZ, frZ = getRectUnit(size1, size2, self) --self.PosX, self.PosY, self.PosZ, rotation)
        DMW.Helpers.DrawLineDMWC(flX, flY, DMW.Player.PosZ, nlX, nlY, DMW.Player.PosZ)
        DMW.Helpers.DrawLineDMWC(frX, frY, DMW.Player.PosZ, nrX, nrY, DMW.Player.PosZ)
        DMW.Helpers.DrawLineDMWC(frX, frY, DMW.Player.PosZ, flX, flY, DMW.Player.PosZ)
        DMW.Helpers.DrawLineDMWC(nlX, nlY, DMW.Player.PosZ, nrX, nrY, DMW.Player.PosZ)
    elseif drawType == "cone" then
        LibDraw.Arc(self.PosX, self.PosY, self.PosZ, size1, size2, rotation)
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


local function CacheCasts(_, event, _, source, sourceName, sourceFlag, _, destination, _, _, _, spell)
    -- if source == DMW.Player.GUID then
    --     print(event, spell, sourceFlag)
    -- end
    -- print(sourceName, event)
    if event == "SPELL_CAST_START" then
        -- print(sourceName, event)
        local sourceobj = DMW.Tables.Misc.guid2pointer[source]
        local Unit = DMW.Units[sourceobj]
        if Unit then
            -- print(Unit.Name)
            Unit:GetCastingInfo()
            local toDraw = DMW.Tables.Dodgie.SpellsToDraw[spell]
            if toDraw ~= nil then
                Unit.DrawCleaveInfo = toDraw
                tinsert(DMW.Tables.Dodgie.DrawUnits, Unit)
            end
        end
    elseif event == "SPELL_CAST_SUCCESS" or event == "SPELL_CAST_FAILED" or event == "UNIT_DIED" or event == "SPELL_INTERRUPT" or event == "PARTY_KILL" then
        local sourceobj = DMW.Tables.Misc.guid2pointer[source]
        local Unit = DMW.Units[sourceobj]
        if Unit and Unit.DrawCleaveInfo then
            Unit:CheckCastingInfo()

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
    for k,v in ipairs(DMW.Tables.Dodgie.DrawUnits) do
        -- print(v)
        if v.DrawCleaveInfo then
            if v:DrawCleave() then tremove(DMW.Tables.Dodgie.DrawUnits, k); end
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
                -- print(CombatLogGetCurrentEventInfo())
            end
        end)
        -- DodgieFrame:SetScript("OnUpdate", function(self, elapsed)
        --     DrawStuff()
        -- end)
        -- selfGUID = UnitGUID("player")
    end
end



