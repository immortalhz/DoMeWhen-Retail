local DMW = DMW
DMW.Helpers.Gatherers = {}
local Looting = false
local Skinning = false
local Unlocked = DMW.Functions.Unlocked

function DMW.Helpers.Gatherers.Run()
    if not DMW.Player.Casting and not IsMounted() and not Unlocked.UnitIsDeadOrGhost("player") then
        if Looting and (DMW.Time - Looting) > 0 and not DMW.Player.Looting then
            Looting = false
        end
        if DMW.Settings.profile.Helpers.AutoLoot then
            if not Looting and (not DMW.Player.Combat or DMW.Player.Instance == "pvp") then
                for _, Unit in pairs(DMW.Units) do
                    if Unit.Dead and Unit.Distance < 5 and UnitCanBeLooted(Unit.Pointer) then
                        Unlocked.InteractUnit(Unit.Pointer)
                        Looting = DMW.Time + 0.6
                    end
                end
            end
        end
        if DMW.Settings.profile.Helpers.AutoSkinning then
            if Skinning and (DMW.Time - Skinning) > 2.3 then
                Skinning = false
            end
            if not Skinning and not DMW.Player.Combat and not DMW.Player.Moving and not DMW.Player.Casting then
                for _, Unit in pairs(DMW.Units) do
                    if Unit.Dead and Unit.Distance < 5 and UnitCanBeSkinned(Unit.Pointer) then
                        Unlocked.InteractUnit(Unit.Pointer)
                        Skinning = DMW.Time
                    end
                end
            end
        end
        if DMW.Settings.profile.Helpers.AutoGather then
            if not Looting and not DMW.Player.Casting and not DMW.Player.Moving and (not DMW.Player.Combat or DMW.Player.Instance == "pvp") then
                for _, Object in pairs(DMW.GameObjects) do
                    if Object.Distance < 5 then
                        if Object.Herb and (not DMW.Player.Spells.HerbGathering:LastCast() or (DMW.Player.LastCast[1].SuccessTime and (DMW.Time - DMW.Player.LastCast[1].SuccessTime) > 2.5)) then
                            ObjectInteract(Object.Pointer)
                            Looting = DMW.Time + 0.3
                        elseif Object.Ore and (not DMW.Player.Spells.Mining:LastCast() or (DMW.Player.LastCast[1].SuccessTime and (DMW.Time - DMW.Player.LastCast[1].SuccessTime) > 2)) then
                            ObjectInteract(Object.Pointer)
                            Looting = DMW.Time + 0.3
                        elseif Object.Trackable then
                            ObjectInteract(Object.Pointer)
                            Looting = DMW.Time + 0.6
                        end
                    end
                end
            end
        end
    end
end
