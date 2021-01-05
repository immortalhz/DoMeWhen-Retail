local DMW = DMW
local Unit = DMW.Classes.Unit
DMW.Helpers.Dodgie = {}
DMW.Tables.Dodgie = {}
local Dodgie = DMW.Helpers.Dodgie
local LibDraw = LibStub("LibDraw-1.0")
DMW.Tables.Dodgie.DrawUnits = {}
DMW.Tables.Dodgie.SpellsToDraw = {
	-- [308742] = {"rect", 35, 50}, -- tests
	--Shadowlands

	--NecroticWake
	[324323] = {"cone", 5, 120}, --Gruesome Cleave
	[333489] = {"rect", 25, 10}, --Amarth Necrotic Breath???????????????????????
	[333488] = {"rect", 25, 10}, --Amarth Necrotic Breath
	[333477] = {"cone", 10, 60}, -- Gut Slice

	--De Other Side
	[334051] = {"rect", 20, 7},  --Erupting Darkness
	--Mists of Tirna Scithe
	[323137] = {"cone", 35, 20}, --Bewildering Pollen
	[321968] = {"cone", 35, 20}, --Bewildering Pollen
	[340160] = {"cone", 20,45}, --Radiant Breath
	[340300] = {"cone", 12,60}, --Tongue Lashing
	--PlagueFall
	[324667] = {"cone", 100,60}, -- Slime Wave
	[328395] = {"cone",15,30}, --Venompiercer
	[330404] = {"rect", 15,10}, --Wing Buffet
	[318949] = {"cone", 20, 60}, --FesteringBelch
	[327233] = {"cone", 30,45}, --Belch Plague
	--Halls of Attonement
	-- [325797] = {"cone"} -- Rapid Fire 325797 325793 325799 not found
	--322936 First boss ???
	[346866] = {"cone", 15, 60}, --Stone Breath
	[325523] = {"cone",  8, 40}, --Deadly Thrust
	[326623] = {"cone",  8, 90}, --Reaping Strike
	[326997] = {"cone",  7, 60}, --Powerful Swipe
	[323236] = {"cone", 25, 30}, --Unleashed Suffering
	--Sanguine Depths
	[320991] = {"rect",   8, 5}, --Echoing Thrust ??? add areatriggers
	[322429] = {"cone", 8,60}, --Severing Slice
	--Spires of Ascension
	[317943] = {"cone", 8, 60}, --Sweeping Blow
	[323943] = {"rect", 25, 4}, --Run Through
	[324205] = {"cone", 30, 25}, --Blinding Flash
	--Theeatre of Pain


	--misc
	[331718] = {"cone", 60, 15}, --Spear Flurry ???
	[333294] = {"rect", 25, 10}, --Death Winds ??? or 333297
	[334329] = {"cone", 60, 15}, --Sweeping Slash
	-- [330403] = {"rect", 10, 20}, --WingBuffet ???
	[329518] = {"cone", 60, 20},
	[326455] = {"cone", 75, 10},
	[329181] = {"rect", 15, 5}, --last Cleave
}
--no info 328458,333488,

--Circle, radius
--Rect, length, width
--Cone, range, angle
DMW.Tables.Dodgie.GameObjectsToDraw = {

}
DMW.Tables.Dodgie.AreaTriggersToDraw = {
    -- [12929] = {"Cone", 5, 90}
    -- [17760] = {"Cone", 2.5, 360}, -- sots tornado council boss
    -- [18334] = {"Cone", 2.5, 360}, -- sots thrash tornado
	-- [19019] = {"Cone", 5, 360}, -- sots
	[26228] = {"Cone", 5, 360}
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

function DMW.Tables.Dodgie.getRectUnit(length,width, Unit, facing)
    width = width or 3
    length = length or 30
    -- local facing = select(2, ObjectFacing(Unit.Pointer))
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
    -- if self.Dead or UnitCastingInfo(self.Pointer) == nil then return true end
    self:UpdatePosition()
    local drawType, size1, size2 = self.DrawDodgie[1], self.DrawDodgie[2], self.DrawDodgie[3]
    local rotation = select(2, ObjectFacing(self.Pointer))
    DMW.Helpers.DrawColor(0, 1, 0)

    if drawType == "rect" then
        local nlX, nlY, nrX, nrY, frX, frY, flX, flY, flZ, nlZ, nrZ, frZ = DMW.Tables.Dodgie.getRectUnit(size1, size2, self, rotation)
        DMW.Helpers.DrawLine(flX, flY, self.PosZ, nlX, nlY, self.PosZ)
        DMW.Helpers.DrawLine(frX, frY, self.PosZ, nrX, nrY, self.PosZ)
        DMW.Helpers.DrawLine(frX, frY, self.PosZ, flX, flY, self.PosZ)
        DMW.Helpers.DrawLine(nlX, nlY, self.PosZ, nrX, nrY, self.PosZ)
    elseif drawType == "cone" then
        LibDraw.Arc(self.PosX, self.PosY, self.PosZ, size1, size2, rotation)
    end
    local castRemainReal = self:CastRemains()
    local castRemainPrint = string.format("%0.1f", castRemainReal)
    if castRemainReal <= 3 then
        DMW.Helpers.DrawColor(1, 0, 0)
    end
    DMW.Helpers.DrawText(castRemainPrint, "GameFontNormalSmall", self.PosX, self.PosY, self.PosZ + 2)
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
        local sourceobj = GetObjectWithGUID(source)
        local Unit = DMW.Units[sourceobj]
		if Unit then
            -- print(Unit.Name)
            -- print(UnitCastingInfo(Unit.Pointer), "start")
            Unit:PopulateCasting()
            -- local toDraw = DMW.Tables.Dodgie.SpellsToDraw[spell]
            -- if toDraw ~= nil then
            --     Unit.DrawCleaveInfo = toDraw
            --     tinsert(DMW.Tables.Dodgie.DrawUnits, Unit)
            -- end
			local spellid = Unit:CastIdCheck()
			-- print(Unit.Name, spellid)
            if DMW.Tables.Dodgie.SpellsToDraw[spellid] ~= nil then
                Unit.DrawDodgie = DMW.Tables.Dodgie.SpellsToDraw[spellid]
            end
        end
    -- elseif event == "SPELL_CAST_SUCCESS" or event == "SPELL_CAST_FAILED" or event == "UNIT_DIED" or event == "SPELL_INTERRUPT" or event == "PARTY_KILL" then
    --     local sourceobj = GetObjectWithGUID(source)
    --     local Unit = DMW.Units[sourceobj]
    --     if Unit then
    --         -- print(UnitCastingInfo(Unit.Pointer), "finish")
    --         Unit:PopulateCasting()
    --     end
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
    if not DMW.Settings.profile.Helpers.ShowVisuals then return end
    for _, Unit in pairs(DMW.Units) do
        if Unit.DrawDodgie then
            Unit:DrawCleave()
        end
	end
	for _, Object in pairs(DMW.AreaTriggers) do
		if DMW.Tables.Dodgie.AreaTriggersToDraw[Object.ObjectID] ~= nil and ObjectCreator(Object.Pointer) == DMW.Player.Pointer then
            Object:Draw(Object.ID)
            -- print(Object.ObjectID, DMW.Tables.Dodgie.AreaTriggersToDraw[Object.ObjectID])
        end
    end
end

DMW.Helpers.Dodgie.Init = function()
    -- if not DodgieFrame then
        DodgieFrame = CreateFrame("frame")
        DodgieFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    --     -- swingTimerFrame:RegisterEvent("PLAYER_ENTER_COMBAT")
        -- DodgieFrame:SetScript("OnEvent", function(_, event, ...)
        --         CacheCasts(CombatLogGetCurrentEventInfo())
        -- end)
end



