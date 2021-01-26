DMW = LibStub("AceAddon-3.0"):NewAddon("DMW", "AceConsole-3.0")
local DMW = DMW
DMW.Cache = {}
DMW.Cache.GetEnemies = {}
DMW.Tables = {}
DMW.Enums = {}
DMW.Functions = {}
DMW.Rotations = {}
DMW.Player = {}
DMW.Plugins = {}
DMW.UI = {}
DMW.Settings = {}
DMW.Helpers = {}
DMW.Timers = {
    OM = {},
    QuestieHelper = {},
    Trackers = {},
    Gatherers = {},
    Rotation = {}
}
DMW.Frames = {}
DMW.Pulses = 0
local Initialized = false
local DebugStart
local RotationCount = 0

function DMW.Helpers.FindRotation()
    if DMW.Rotations[DMW.Player.Class] and DMW.Rotations[DMW.Player.Class].Rotation then
        DMW.Player.Rotation = DMW.Rotations[DMW.Player.Class].Rotation
        if DMW.Rotations[DMW.Player.Class].Settings then
            DMW.Rotations[DMW.Player.Class].Settings()
        end
        DMW.UI.HUD.Load()
        DMW.Tables.Misc.GROUP_ROSTER_UPDATE()
    end
end

function DMW.Helpers.ReloadSettings()
    if DMW.Rotations[DMW.Player.Class] and DMW.Rotations[DMW.Player.Class].Rotation then
        if DMW.Rotations[DMW.Player.Class].Settings then
            DMW.Rotations[DMW.Player.Class].Settings()
        end
    end
end
local function UnlockAPI()
	if wmbapi ~= nil then
        -- Active Player
        StopFalling = wmbapi.StopFalling
        FaceDirection = function(a) if wmbapi.GetObject(a) then wmbapi.FaceDirection(GetAnglesBetweenObjects(a,"player"),true) else wmbapi.FaceDirection(a,true) end end
        -- Object
        ObjectTypeFlags = wmbapi.ObjectTypeFlags
        ObjectPointer = function(obj)
            if UnitIsVisible(obj) then
                return wmbapi.GetObject(obj)
            else
                return ""
            end
        end
        ObjectExists = wmbapi.ObjectExists
        ObjectIsVisible = UnitIsVisible
        ObjectPosition = function(obj)
            local x,y,z = wmbapi.ObjectPosition(obj)
            if x then
                return x,y,z
            else
                return 0,0,0
            end
        end
        ObjectFacing = function(obj)
            if UnitIsVisible(obj) then
                return wmbapi.ObjectFacing(obj)
            else
                return 0
            end
        end
        ObjectName = function(obj)
            if UnitIsVisible(obj) then
                return UnitName(obj)
            else
                return ""
            end
        end
        ObjectID = function(obj)
            if UnitIsVisible(obj) then
                return wmbapi.ObjectId(obj)
            else
                return 0
            end
        end
        ObjectIsUnit = function(obj) return UnitIsVisible(obj) and wmbapi.ObjectIsType(obj,wmbapi.GetObjectTypeFlagsTable().Unit) end
        GetDistanceBetweenPositions = function(...) return (... and wmbapi.GetDistanceBetweenPositions(...)) or 0 end
        GetDistanceBetweenObjects = function(obj1,obj2)
            if UnitIsVisible(obj1) and UnitIsVisible(obj2) then
                return wmbapi.GetDistanceBetweenObjects(obj1,obj2)
            else
                return 0
            end
        end
        GetPositionBetweenObjects = function(obj1,obj2,dist)
            if UnitIsVisible(obj1) and UnitIsVisible(obj2) then
                return wmbapi.GetPositionBetweenObjects(obj1,obj2,dist)
            else
                return 0,0,0
            end
        end
        GetPositionFromPosition = function(...) return (... and wmbapi.GetPositionFromPosition(...)) or 0,0,0 end
        ObjectIsFacing = function(obj1,obj2,toler)
            if UnitIsVisible(obj1) and UnitIsVisible(obj2) then
                return (toler and wmbapi.ObjectIsFacing(obj1,obj2,toler)) or (not toler and wmbapi.ObjectIsFacing(obj1,obj2))
            end
        end
        ObjectInteract = InteractUnit
        -- Object Manager
        GetObjectCount = wmbapi.GetObjectCount
        GetObjectWithIndex = wmbapi.GetObjectWithIndex
        GetObjectWithGUID = function(GUID)
            if GUID and #GUID > 1 then
                return wmbapi.GetObjectWithGUID(GUID)
            else
                return ""
            end
        end
        -- Unit
        UnitBoundingRadius = function(obj)
            if UnitIsVisible(obj) then
                return wmbapi.UnitBoundingRadius(obj)
            else
                return 0
            end
        end
        UnitCombatReach = function(obj)
            if UnitIsVisible(obj) then
                return wmbapi.UnitCombatReach(obj)
            else
                return 0
            end
        end
        UnitTarget = function(obj)
            if UnitIsVisible(obj) then
                return wmbapi.UnitTarget(obj)
            else
                return ""
            end
        end
        UnitCastID = function(obj)
            if UnitIsVisible(obj) then
                local spellId,target = wmbapi.UnitCasting(obj)
                return spellId or 0,spellId or 0,target or "",target or ""
            else
                return 0,0,"",""
            end
        end
        UnitCreator = function(obj)
            if UnitIsVisible(obj) then
                return wmbapi.UnitCreator(obj)
            else
                return ""
            end
        end
        -- World
        TraceLine = wmbapi.TraceLine
        GetCameraPosition = wmbapi.GetCameraPosition
        CancelPendingSpell = wmbapi.CancelPendingSpell
        ClickPosition = wmbapi.ClickPosition
        IsAoEPending = wmbapi.IsAoEPending
        GetTargetingSpell = wmbapi.IsAoEPending
        WorldToScreen = function(...)
            local scale, x, y = UIParent:GetEffectiveScale(), select(2,wmbapi.WorldToScreen(...))
            local sx = GetScreenWidth() * scale
            local sy = GetScreenHeight() * scale
            return x * sx, y * sy
        end
        ScreenToWorld = function(X, Y)
            local scale = UIParent:GetEffectiveScale()
            local sx = GetScreenWidth() * scale
            local sy = GetScreenHeight() * scale
            return wmbapi.ScreenToWorld(X / sx, Y / sy)
        end
        GetMousePosition = function()
            local def_x, def_y, real_x, real_y = 768*(GetScreenWidth()/GetScreenHeight()), 768, GetPhysicalScreenSize()
            local cur_x, cur_y = GetCursorPosition()
            local res_x, res_y = cur_x*(real_x/def_x), real_y-cur_y*(real_y/def_y)
            return res_x, res_y, res_x, res_y
        end
        -- Hacks
        IsHackEnabled = function() return end
        SetHackEnabled = function() return true end
        -- Files
        GetDirectoryFiles = wmbapi.GetDirectoryFiles
        ReadFile = wmbapi.ReadFile
        WriteFile = wmbapi.WriteFile
        CreateDirectory = wmbapi.CreateDirectory
        GetWoWDirectory = wmbapi.GetWoWDirectory
        DirectoryExists = wmbapi.DirectoryExists
        -- Callbacks
        AddEventCallback = function(Event, Callback)
            if not BRFrames then
                BRFrames = CreateFrame("Frame")
                BRFrames:SetScript("OnEvent",BRFrames_OnEvent)
            end
            BRFrames:RegisterEvent(Event)
            if not BRFramesEvent[Event] then
                BRFramesEvent[Event] = Callback
            end
        end
        -- Misc
        SendHTTPRequest = wmbapi.SendHttpRequest
        GetKeyState = wmbapi.GetKeyState
        Offsets = {
            ["cggameobjectdata__flags"]="CGGameObjectData__Flags",
            ["cgobjectdata__dynamicflags"]="CGObjectData__DynamicFlags"
        }
        GetOffset = function(offset)
            return wmbapi.GetObjectDescriptorsTable()[Offsets[string.lower(offset)]]
        end
        -- Drawing
        GetWoWWindow = GetPhysicalScreenSize
        -- Draw2DLine = LibDraw.Draw2DLine
        -- Draw2DText = function(textX, textY, text)
        --     local F = tremove(LibDraw.fontstrings) or LibDraw.canvas:CreateFontString(nil, "BACKGROUND")
        --     F:SetFontObject("GameFontNormal")
        --     F:SetText(text)
        --     F:SetTextColor(LibDraw.line.r, LibDraw.line.g, LibDraw.line.b, LibDraw.line.a)
        --     if p then
        --         local width = F:GetStringWidth() - 4
        --         local offsetX = width*0.5
        --         local offsetY = F:GetStringHeight() + 3.5
        --         local pwidth = width*p*0.01
        --         FHAugment.drawLine(textX-offsetX, textY-offsetY, (textX+offsetX), textY-offsetY, 4, r, g, b, 0.25)
        --         FHAugment.drawLine(textX-offsetX, textY-offsetY, (textX+offsetX)-(width-pwidth), textY-offsetY, 4, r, g, b, 1)
        --     end
        --     F:SetPoint("TOPLEFT", UIParent, "TOPLEFT", textX-(F:GetStringWidth()*0.5), textY)
        --     F:Show()
        --     tinsert(LibDraw.fontstrings_used, F)
        -- end
        WorldToScreenRaw = function(...)
            local x, y = select(2,wmbapi.WorldToScreen(...))
            return x, 1-y
		end
		ObjectIsUnit = function (obj)
			return wmbapi.ObjectIsType(obj, 32)
		end
		ObjectIsGameObject = function (obj)
			return wmbapi.ObjectIsType(obj, 256)
		end
		ObjectIsAreaTrigger = function (obj)
			return wmbapi.ObjectIsType(obj, type)
		end
		UnitCreatureTypeID = function(obj)
			return wmbapi.UnitCreatureTypeId(obj)
		end
		ObjectDescriptor = function(obj, offset, type)
			-- print(obj , offset, type)
			return wmbapi.ObjectDescriptor(obj, offset, type)
		end
		ObjectGUID = function(obj)
			return wmbapi.ObjectDescriptor(obj, 0, 15)
		end
		UnitFlags = function(obj)
			return wmbapi.UnitFlags(obj)
		end
		UnitMovementFlags = function(obj)
			return wmbapi.UnitMovementFlags(obj)
		end
		IsQuestObject = function(obj)
			return false, false
		end
		ObjectDynamicFlags = function(obj)
			return wmbapi.ObjectDynamicFlags(obj)
		end
		UnitIsMounted = function(obj)
			return wmbapi.UnitIsMounted(obj)
		end
		UnitIsFacing = function(obj1,obj2)
			return ObjectIsFacing(obj1,obj2)
		end
	end
end

local function Init()
	UnlockAPI()
    DMW.InitSettings()
    DMW.UI.Init()
    DMW.UI.HUD.Init()
	DMW.Player = DMW.Classes.LocalPlayer(ObjectPointer("player"))
    DMW.UI.InitQueue()
    -- DMW.Helpers.HealComm:OnInitialize()
	DMW.Helpers.Dodgie.Init()
	DMW.Locale = GetLocale()

    -- InitializeNavigation(function(Result)
    --     if Result then
    --         if DMW.Settings.profile.Navigation.WorldMapHook then
    --             DMW.Helpers.Navigation:InitWorldMap()
    --         end
    --         DMW.UI.InitNavigation()
    --     end
    -- end)
	Initialized = true
	--Unlocks
	-- SetupProtectedFuncHook('IsItemInRange')


end

local function ExecutePlugins()
    for _, Plugin in pairs(DMW.Plugins) do
        if type(Plugin) == "function" then
            Plugin()
        end
    end
end

local f = CreateFrame("Frame", "DoMeWhen", UIParent)
f:SetScript(
    "OnUpdate",
    function(self, elapsed)
        if wmbapi then
            LibStub("LibDraw-1.0").clearCanvas()
            DMW.Time = GetTime()
            DMW.Pulses = DMW.Pulses + 1
            if not Initialized and not DMW.UI.MinimapIcon then
                Init()
            end
            DebugStart = debugprofilestop()
            DMW.UpdateOM()
            DMW.Tables.Dodgie.DrawStuff()
            DMW.Timers.OM.Last = debugprofilestop() - DebugStart
            DMW.UI.Debug.Run()
            DMW.BossMods.Check()
            DebugStart = debugprofilestop()
            DMW.Helpers.QuestieHelper.Run()
            DMW.Timers.QuestieHelper.Last = debugprofilestop() - DebugStart
            DebugStart = debugprofilestop()
            DMW.Helpers.Trackers.Run()
            DMW.Timers.Trackers.Last = debugprofilestop() - DebugStart
            DebugStart = debugprofilestop()
            DMW.Helpers.Gatherers.Run()
            DMW.Timers.Gatherers.Last = debugprofilestop() - DebugStart
            -- DMW.Helpers.Swing.Run(elapsed)
            -- if not DMW.Tables.Swing.Init then
            --     DMW.Helpers.Swing.InitSwingTimer()
            -- end
            ExecutePlugins()
            if not DMW.Player.Rotation then
                DMW.Helpers.FindRotation()
                return
            else
                -- print(DMW.Player:SpellQueued())
                -- print(UnitCastID("player"))
                -- print(DMW.Player:GCDRemain())

				if DMW.Helpers.Rotation.Active() then
					if DMW.Helpers.Queue.Run() then
						return
					end
                    if DMW.Player.Combat then
                        RotationCount = RotationCount + 1
                        DebugStart = debugprofilestop()
                    end
                    DMW.Player.Rotation()
                    if DMW.Player.Combat then
                        DMW.Timers.Rotation.Last = debugprofilestop() - DebugStart
                        DMW.Timers.Rotation.Total = DMW.Timers.Rotation.Total and (DMW.Timers.Rotation.Total + DMW.Timers.Rotation.Last) or DMW.Timers.Rotation.Last
                        DMW.Timers.Rotation.Average = DMW.Timers.Rotation.Total / RotationCount
                    end
                end
            end
            DMW.Helpers.Navigation:Pulse()
            DMW.Timers.OM.Total = DMW.Timers.OM.Total and (DMW.Timers.OM.Total + DMW.Timers.OM.Last) or DMW.Timers.OM.Last
            DMW.Timers.QuestieHelper.Total = DMW.Timers.QuestieHelper.Total and (DMW.Timers.QuestieHelper.Total + DMW.Timers.QuestieHelper.Last) or DMW.Timers.QuestieHelper.Last
            DMW.Timers.Trackers.Total = DMW.Timers.Trackers.Total and (DMW.Timers.Trackers.Total + DMW.Timers.Trackers.Last) or DMW.Timers.Trackers.Last
            DMW.Timers.Gatherers.Total = DMW.Timers.Gatherers.Total and (DMW.Timers.Gatherers.Total + DMW.Timers.Gatherers.Last) or DMW.Timers.Gatherers.Last
            DMW.Timers.Rotation.Total = DMW.Timers.Rotation.Total and (DMW.Timers.Rotation.Total + DMW.Timers.Rotation.Last) or DMW.Timers.Rotation.Last or nil
            DMW.Timers.OM.Average = DMW.Timers.OM.Total / DMW.Pulses
            DMW.Timers.QuestieHelper.Average = DMW.Timers.QuestieHelper.Total / DMW.Pulses
            DMW.Timers.Trackers.Average = DMW.Timers.Trackers.Total / DMW.Pulses
            DMW.Timers.Gatherers.Average = DMW.Timers.Gatherers.Total / DMW.Pulses
        end
    end
)
