local DMW = DMW
local AlertTimer = GetTime()
DMW.Helpers.Trackers = {}
local LibDraw = LibStub("LibDraw-1.0")

local friends = {

}

function DMW.Helpers.Trackers.Run()
    local tX, tY, tZ
    -- if (DMW.Settings.profile.Tracker.TrackUnits and DMW.Settings.profile.Tracker.TrackUnits ~= "") or DMW.Settings.profile.Tracker.TrackNPC or DMW.Settings.profile.Tracker.TrackRare or DMW.Settings.profile.Tracker.DrawTTD or DMW.Settings.profile.Helpers.ShowIDs then
    if true then
        local s = 1
        for _, Unit in pairs(DMW.Units) do
            -- if friends[Unit.Name] then return end
            if DMW.Settings.profile.Tracker.TrackNPC and not Unit.Player and Unit.Friend then
                local r, b, g, a = DMW.Settings.profile.Tracker.TrackNPCColor[1], DMW.Settings.profile.Tracker.TrackNPCColor[2], DMW.Settings.profile.Tracker.TrackNPCColor[3], DMW.Settings.profile.Tracker.TrackNPCColor[4]
                DMW.Helpers.DrawColor(r, b, g, a)
                for k, v in pairs(DMW.Enums.NpcFlags) do
                    if Unit:HasNPCFlag(v) then
                        DMW.Helpers.DrawText(k, "GameFontNormalSmall", Unit.PosX, Unit.PosY, Unit.PosZ + 2)
                        break
                    end
                end
            end
            if DMW.Settings.profile.Tracker.DrawTTD and Unit.Attackable and Unit.CreatureType ~= "Critter" and Unit.TTD then
                DMW.Helpers.DrawText(math.floor(Unit.TTD), "GameFontNormalSmall", Unit.PosX, Unit.PosY, Unit.PosZ)
            end
            if (DMW.Settings.profile.Tracker.TrackUnits ~= nil and DMW.Settings.profile.Tracker.TrackUnits ~= "") and not Unit.Player and Unit.Trackable and not Unit.Dead and not Unit.Target then
                local r, b, g, a = DMW.Settings.profile.Tracker.TrackUnitsColor[1], DMW.Settings.profile.Tracker.TrackUnitsColor[2], DMW.Settings.profile.Tracker.TrackUnitsColor[3], DMW.Settings.profile.Tracker.TrackUnitsColor[4]
                DMW.Helpers.DrawColor(r, b, g, a)
                if DMW.Settings.profile.Tracker.TrackUnitsAlert > 0 and (AlertTimer + 5) < DMW.Time and not IsForeground() then
                    FlashClientIcon()
                    if GetCVarBool("Sound_EnableSFX") then
                        PlaySound(DMW.Settings.profile.Tracker.TrackUnitsAlert)
                    else
                        PlaySound(DMW.Settings.profile.Tracker.TrackUnitsAlert, "MASTER")
                    end
                    AlertTimer = DMW.Time
                end
                Unit:UpdatePosition()
                tX, tY, tZ = Unit.PosX, Unit.PosY, Unit.PosZ
                LibDraw.SetWidth(4)
                LibDraw.Line(tX, tY, tZ + s * 1.3, tX, tY, tZ)
                LibDraw.Line(tX - s, tY, tZ, tX + s, tY, tZ)
                LibDraw.Line(tX, tY - s, tZ, tX, tY + s, tZ)
                if DMW.Settings.profile.Tracker.TrackUnitsLine > 0 then
                    local w = DMW.Settings.profile.Tracker.TrackUnitsLine
                    LibDraw.SetWidth(w)
                    DMW.Helpers.DrawLine(tX, tY, tZ, DMW.Player.PosX, DMW.Player.PosY, DMW.Player.PosZ + 2)
                end
            end
            if DMW.Settings.profile.Tracker.TrackRare and (Unit.Classification == "rareelite" or Unit.Classification == "rare") and not Unit.Dead and not Unit.Target then
                local r, b, g, a = DMW.Settings.profile.Tracker.TrackRareColor[1], DMW.Settings.profile.Tracker.TrackRareColor[2], DMW.Settings.profile.Tracker.TrackRareColor[3], DMW.Settings.profile.Tracker.TrackRareColor[4]
                DMW.Helpers.DrawColor(r, b, g, a)
                if DMW.Settings.profile.Tracker.TrackRareAlert > 0 and (AlertTimer + 5) < DMW.Time and not IsForeground() then
                    FlashClientIcon()
                    if GetCVarBool("Sound_EnableSFX") then
                        PlaySound(DMW.Settings.profile.Tracker.TrackRareAlert)
                    else
                        PlaySound(DMW.Settings.profile.Tracker.TrackRareAlert, "MASTER")
                    end
                    AlertTimer = DMW.Time
                end
                Unit:UpdatePosition()
                tX, tY, tZ = Unit.PosX, Unit.PosY, Unit.PosZ
                LibDraw.SetWidth(4)
                LibDraw.Line(tX, tY, tZ + s * 1.3, tX, tY, tZ)
                LibDraw.Line(tX - s, tY, tZ, tX + s, tY, tZ)
                LibDraw.Line(tX, tY - s, tZ, tX, tY + s, tZ)
                if DMW.Settings.profile.Tracker.TrackRareLine > 0 then
                    local w = DMW.Settings.profile.Tracker.TrackRareLine
                    LibDraw.SetWidth(w)
                    DMW.Helpers.DrawLine(tX, tY, tZ, DMW.Player.PosX, DMW.Player.PosY, DMW.Player.PosZ + 2)
                end
            end
            -- if Unit.NPC ~= false then
            --     DMW.Helpers.DrawText(Unit.NPC, "GameFontNormal", self.PosX, self.PosY, self.PosZ + 2)
            -- end
            if DMW.Settings.profile.Helpers.ShowIDs then
                if Unit.ObjectID then
                    Unit:UpdatePosition()
                DMW.Helpers.DrawText(Unit.Name.. " - " .. Unit.ObjectID .. " - " .. UnitFlags(Unit.Pointer) .. " - " .. ObjectDynamicFlags(Unit.Pointer) , "GameFontNormal", Unit.PosX, Unit.PosY, Unit.PosZ + 2)
                end
            elseif Unit.Trackable then
                local r, b, g, a = DMW.Settings.profile.Tracker.TrackObjectsColor[1], DMW.Settings.profile.Tracker.TrackObjectsColor[2], DMW.Settings.profile.Tracker.TrackObjectsColor[3], DMW.Settings.profile.Tracker.TrackObjectsColor[4]
                DMW.Helpers.DrawColor(r, b, g, a)
                Unit:UpdatePosition()
                DMW.Helpers.DrawText(Unit.Name .. " - " .. math.floor(Unit.Distance) .. " Yards", "GameFontNormal", Unit.PosX, Unit.PosY, Unit.PosZ + 2)
            end
        end
    end
    for _, Object in pairs(DMW.GameObjects) do
        if Object.Herb and not Object.HerbTaken then
            local r, b, g, a = DMW.Settings.profile.Tracker.HerbsColor[1], DMW.Settings.profile.Tracker.HerbsColor[2], DMW.Settings.profile.Tracker.HerbsColor[3], DMW.Settings.profile.Tracker.HerbsColor[4]
            DMW.Helpers.DrawColor(r, b, g, a)
            if DMW.Settings.profile.Tracker.HerbsAlert > 0 and (AlertTimer + 5) < DMW.Time and not IsForeground() then
                FlashClientIcon()
                if GetCVarBool("Sound_EnableSFX") then
                    PlaySound(DMW.Settings.profile.Tracker.HerbsAlert)
                else
                    PlaySound(DMW.Settings.profile.Tracker.HerbsAlert, "MASTER")
                end
                AlertTimer = DMW.Time
            end
            -- for k, v in pairs(DMW.Enums.GameObjectFlags) do
            --     if Object:HasDynFlag(v) then
            --         print(k)
            --         DMW.Helpers.DrawText(k, "GameFontNormalSmall", Object.PosX, Object.PosY, Object.PosZ + 5)
            --         break
            --     end
            -- end
            DMW.Helpers.DrawText(Object.Name .. " - " .. math.floor(Object.Distance) .. " Yards", "GameFontNormal", Object.PosX, Object.PosY, Object.PosZ + 2)
            if DMW.Settings.profile.Tracker.HerbsLine > 0 then
                local w = DMW.Settings.profile.Tracker.HerbsLine
                LibDraw.SetWidth(w)
                DMW.Helpers.DrawLine(Object.PosX, Object.PosY, Object.PosZ, DMW.Player.PosX, DMW.Player.PosY, DMW.Player.PosZ + 2)
            end
        elseif Object.Ore then
            local r, b, g, a = DMW.Settings.profile.Tracker.OreColor[1], DMW.Settings.profile.Tracker.OreColor[2], DMW.Settings.profile.Tracker.OreColor[3], DMW.Settings.profile.Tracker.OreColor[4]
            DMW.Helpers.DrawColor(r, b, g, a)
            ----------------------------------------------------------------------------
            if DMW.Settings.profile.Tracker.OreAlert > 0 and (AlertTimer + 5) < DMW.Time and not IsForeground() then
                FlashClientIcon()
                if GetCVarBool("Sound_EnableSFX") then
                    PlaySound(DMW.Settings.profile.Tracker.OreAlert)
                else
                    PlaySound(DMW.Settings.profile.Tracker.OreAlert, "MASTER")
                end
                AlertTimer = DMW.Time
            end
            DMW.Helpers.DrawText(Object.Name .. " - " .. math.floor(Object.Distance) .. " Yards", "GameFontNormal", Object.PosX, Object.PosY, Object.PosZ + 2)
            if DMW.Settings.profile.Tracker.OreLine > 0 then
                local w = DMW.Settings.profile.Tracker.OreLine
                LibDraw.SetWidth(w)
                DMW.Helpers.DrawLine(Object.PosX, Object.PosY, Object.PosZ, DMW.Player.PosX, DMW.Player.PosY, DMW.Player.PosZ + 2)
            end
        elseif Object.Trackable then
            local r, b, g, a = DMW.Settings.profile.Tracker.TrackObjectsColor[1], DMW.Settings.profile.Tracker.TrackObjectsColor[2], DMW.Settings.profile.Tracker.TrackObjectsColor[3], DMW.Settings.profile.Tracker.TrackObjectsColor[4]
            DMW.Helpers.DrawColor(r, b, g, a)
            ----------------------------------------------------------------------------
            if DMW.Settings.profile.Tracker.TrackObjectsAlert > 0 and (AlertTimer + 5) < DMW.Time and not IsForeground() then
                local sound = DMW.Settings.profile.Tracker.TrackObjectsAlert
                FlashClientIcon()
                if GetCVarBool("Sound_EnableSFX") then
                    PlaySound(sound)
                else
                    PlaySound(sound, "MASTER")
                end
                AlertTimer = DMW.Time
            end
            if DMW.Settings.profile.Helpers.ShowIDs then
                DMW.Helpers.DrawText(Object.Name.. " - " .. Object.ObjectID .. " - " .. GameObjectFlags(Object.Pointer) .. " - " .. ObjectDynamicFlags(Object.Pointer), "GameFontNormal", Object.PosX, Object.PosY, Object.PosZ)
            else
                DMW.Helpers.DrawText(Object.Name .. " - " .. math.floor(Object.Distance) .. " Yards", "GameFontNormal", Object.PosX, Object.PosY, Object.PosZ + 2)
            end
            if DMW.Settings.profile.Tracker.TrackObjectsLine > 0 then
                local w = DMW.Settings.profile.Tracker.TrackObjectsLine
                LibDraw.SetWidth(w)
                DMW.Helpers.DrawLine(Object.PosX, Object.PosY, Object.PosZ, DMW.Player.PosX, DMW.Player.PosY, DMW.Player.PosZ + 2)
            end
        elseif DMW.Settings.profile.Tracker.TrackObjectsMailbox and strmatch(string.lower(Object.Name), "mailbox") then
            local r, b, g, a = DMW.Settings.profile.Tracker.TrackObjectsColor[1], DMW.Settings.profile.Tracker.TrackObjectsColor[2], DMW.Settings.profile.Tracker.TrackObjectsColor[3], DMW.Settings.profile.Tracker.TrackObjectsColor[4]
            DMW.Helpers.DrawColor(r, b, g, a)
            DMW.Helpers.DrawText(Object.Name .. " - " .. math.floor(Object.Distance) .. " Yards", "GameFontNormal", Object.PosX, Object.PosY, Object.PosZ + 2)
            local w = DMW.Settings.profile.Tracker.TrackObjectsLine
            LibDraw.SetWidth(w)
            DMW.Helpers.DrawLine(Object.PosX, Object.PosY, Object.PosZ, DMW.Player.PosX, DMW.Player.PosY, DMW.Player.PosZ + 2)
        end
    end
    for _, Object in pairs(DMW.AreaTriggers) do
        if DMW.Tables.Dodgie.AreaTriggersToDraw[Object.ObjectID] ~= nil then
            Object:Draw(DMW.Tables.Dodgie.AreaTriggersToDraw[Object.ObjectID][1], DMW.Tables.Dodgie.AreaTriggersToDraw[Object.ObjectID][2], DMW.Tables.Dodgie.AreaTriggersToDraw[Object.ObjectID][3])
            -- print(Object.ObjectID, DMW.Tables.Dodgie.AreaTriggersToDraw[Object.ObjectID])
        end
        if Object.Trackable then
            local r, b, g, a = 1, 0 , 0 ,1
            DMW.Helpers.DrawColor(r, b, g, a)


            if DMW.Settings.profile.Helpers.ShowIDs then
                DMW.Helpers.DrawText(Object.ObjectID, "GameFontNormal", Object.PosX, Object.PosY, Object.PosZ -2)
            end
        end
    end
    if DMW.Settings.profile.Tracker.TrackPlayersNamePlates or (DMW.Settings.profile.Tracker.TrackPlayers ~= "") or DMW.Settings.profile.Tracker.TrackPlayersAny or DMW.Settings.profile.Tracker.TrackPlayersEnemy then
        local Color
        local s = 1
        for _, Unit in pairs(DMW.Units) do
            if ((DMW.Settings.profile.Tracker.TrackPlayers ~= nil and DMW.Settings.profile.Tracker.TrackPlayers ~= "") or DMW.Settings.profile.Tracker.TrackPlayersAny or DMW.Settings.profile.Tracker.TrackPlayersEnemy)
             and Unit.Player and not Unit.Dead and Unit.Trackable and (not DMW.Player.Target or DMW.Player.Target.Pointer ~= Unit.Pointer) then
                local r, b, g, a = DMW.Settings.profile.Tracker.TrackPlayersColor[1], DMW.Settings.profile.Tracker.TrackPlayersColor[2], DMW.Settings.profile.Tracker.TrackPlayersColor[3], DMW.Settings.profile.Tracker.TrackPlayersColor[4]
                DMW.Helpers.DrawColor(r, b, g, a)
                if DMW.Settings.profile.Tracker.TrackPlayersAlert > 2 and (AlertTimer + 5) < DMW.Time and not IsForeground() and (Unit.Distance < 30 or Unit.Target == DMW.Player.Pointer) then
                    local sound = DMW.Settings.profile.Tracker.TrackPlayersAlert
                    FlashClientIcon()
                    if GetCVarBool("Sound_EnableSFX") then
                        PlaySound(sound)
                    else
                        PlaySound(sound, "MASTER")
                    end
                    AlertTimer = DMW.Time
                end
                if DMW.Settings.profile.Tracker.TrackPlayersAlert == 1 and (AlertTimer + 5) < DMW.Time and not IsForeground() and (Unit.Distance < 30 or Unit.Target == DMW.Player.Pointer) then
                    FlashClientIcon()
                    if GetCVarBool("Sound_EnableSFX") then
                        PlaySoundFile("Interface\\AddOns\\DoMeWhen-Retail\\Sounds\\goes-without-saying-608.mp3", "MASTER")
                    else
                        PlaySoundFile("Interface\\AddOns\\DoMeWhen-Retail\\Sounds\\goes-without-saying-608.mp3", "MASTER")
                    end
                    AlertTimer = DMW.Time
                end
                Unit:UpdatePosition()
                tX, tY, tZ = Unit.PosX, Unit.PosY, Unit.PosZ
                LibDraw.SetWidth(4)
                LibDraw.Line(tX, tY, tZ + s * 1.3, tX, tY, tZ)
                LibDraw.Line(tX - s, tY, tZ, tX + s, tY, tZ)
                LibDraw.Line(tX, tY - s, tZ, tX, tY + s, tZ)
                if DMW.Settings.profile.Tracker.TrackPlayersLine > 0 then
                    local w = DMW.Settings.profile.Tracker.TrackPlayersLine
                    LibDraw.SetWidth(w)
                    DMW.Helpers.DrawLine(tX, tY, tZ, DMW.Player.PosX, DMW.Player.PosY, DMW.Player.PosZ + 2)
                end
            end
            if DMW.Settings.profile.Tracker.TrackPlayersNamePlates and Unit.Player and not Unit.Dead and not UnitIsFriend("player", Unit.Pointer) and not C_NamePlate.GetNamePlateForUnit(Unit.Pointer) then
                Unit:UpdatePosition()
                Color = DMW.Enums.ClassColor[Unit.Class]
                DMW.Helpers.DrawColor(Color.r, Color.g, Color.b)
                if Unit.RealisticHonor then
                    DMW.Helpers.DrawText(Unit.RealisticHonor .. " HP: " .. Unit.HP .. " - " .. math.floor(Unit.Distance), "GameFontNormalSmall", Unit.PosX, Unit.PosY, Unit.PosZ + 2)
                else
                    DMW.Helpers.DrawText(Unit.Name .. " (" .. Unit.Level .. ") - HP: " .. Unit.HP .. " - " .. math.floor(Unit.Distance) .. " Yards", "GameFontNormalSmall", Unit.PosX, Unit.PosY, Unit.PosZ + 2)
                end
            end
        end
    end
end
