local DMW = DMW
local AceGUI = LibStub("AceGUI-3.0")

local defaults = {
    profile = {
        MinimapIcon = {
            hide = false
        },
        HUDPosition = {
            point = "LEFT",
            relativePoint = "LEFT",
            xOfs = 40,
            yOfs = 100
        },
        HUD = {
            Rotation = 1,
            Show = true
        },
        Enemy = {
            InterruptDelay = 0.8,
            InterruptTarget = 1,
            InterruptMark = 1,
            AutoFace = false,
            CustomTTDEnabled = false,
            TTDDPS = 0,
            CustomTTDHealthValue = 0,
            InterruptSpells = "",
            SortingEnemyScore = false,
            SortingTarget = false,
            SortingThreat = false,
            SortingHighestHealth = false,
            SortingLowestHealth = false,
            SortingAuraID = false,
            SortingAuraIDString = "",
            SortingAuraName = false,
            SortingAuraNameString = "",
            SortingObjectIDs = false,
            SortingObjectIDsString = "",
        },
        Friend = {
            DispelDelay = 1
        },
        Rotation = {},
        Queue = {
            Wait = 2,
            Items = true
        },
        Helpers = {
            AutoLoot = false,
            AutoSkinning = false,
            AutoGather = false,
            ShowVisuals = false,
            ShowIDs = false,
            DirectX = false
        },
        Tracker = {
            Herbs = false,
            Ore = false,
            CheckRank = false,
			DrawTTD = false,
            HideGrey = false,
            TrackNPC = false,
            QuestieHelper = false,
            TrackRare = false,
            QuestieHelperColor = {0,0,0,1},
            HerbsColor = {0,0,0,1},
            OreColor = {0,0,0,1},
            TrackRareColor = {0,0,0,1},
            TrackUnitsColor = {0,0,0,1},
            TrackObjectsColor = {0,0,0,1},
            TrackPlayersColor = {0,0,0,1},
            TrackNPCColor = {1,0.6,0,1},
            OreAlert = 0,
            HerbsAlert = 0,
            QuestieHelperAlert = 0,
            TrackUnitsAlert = 0,
            TrackRareAlert = 0,
            TrackObjectsAlert = 0,
            TrackPlayersAlert = 0,
            OreLine = 0,
            HerbsLine = 0,
            QuestieHelperLine = 0,
            TrackUnitsLine = 0,
            TrackRareLine = 0,
            TrackObjectsLine = 0,
            TrackPlayersLine = 0,
            TrackPlayersEnemy = false,
            TrackPlayersAny = false,
            TrackObjectsMailbox = false
        },
        Navigation = {
            WorldMapHook = false,
            AttackDistance = 14,
            MaxDistance = 30,
            FoodHP = 60,
            FoodID = 0,
            LevelRange = 3
        }
    },
    char = {
        SelectedProfile = select(2, UnitClass("player")):gsub("%s+", "")
    }
}

local function MigrateSettings()
    local Reload = false
    for k,v in pairs(DMW.Settings.profile.Tracker) do
        if string.match(k, "Alert") and type(v) == "string" then
            if tonumber(v) then
                DMW.Settings.profile.Tracker[k] = tonumber(v)
            else
                DMW.Settings.profile.Tracker[k] = 0
            end
            Reload = true
        end
    end

    if type(DMW.Settings.profile.Helpers.TrackPlayers) == "boolean" then
        DMW.Settings.profile.Helpers.TrackPlayers = nil
        Reload = true
    end
    for k,v in pairs(DMW.Settings.profile.Helpers) do
        local moveNew = true
        if k == "AutoGather" or k == "AutoLoot" or k == "AutoSkinning" or k == "ShowVisuals" or k == "ShowIDs" or k == "DirectX" then
            moveNew = false
        end
        if moveNew then
            DMW.Settings.profile.Tracker[k] = v
            DMW.Settings.profile.Helpers[k] = nil
            Reload = true
        end
    end
    if Reload then
        ReloadUI()
    end
end
-- function DMW.
function DMW.InitSettings()
    DMW.Settings = LibStub("AceDB-3.0"):New("DMWSettings", defaults, "Default")
    DMW.Settings:SetProfile(DMW.Settings.char.SelectedProfile)
    DMW.Settings.RegisterCallback(DMW, "OnProfileChanged", "OnProfileChanged")
    MigrateSettings()
end

function DMW:OnProfileChanged(self, db, profile)
    DMW.Settings.char.SelectedProfile = profile
    ReloadUI()
end
