local DMW = DMW
DMW.Helpers.Rotation = {}
local Rotation = DMW.Helpers.Rotation
DMW.Helpers.Rotation.CastingCheck = true
DMW.Helpers.Rotation.StandingCheck = true
DMW.Helpers.Rotation.MountCheck = true
DMW.Helpers.Rotation.FlyingCheck = true


function Rotation.Active()
    if DMW.Settings.profile.HUD.Rotation == 1 and not UnitIsDeadOrGhost("player") and
    (not DMW.Helpers.Rotation.CastingCheck or not DMW.Player.Casting) and
    (not DMW.Helpers.Rotation.MountCheck or not UnitIsMounted("player")) and
    (not DMW.Helpers.Rotation.FlyingCheck or not IsFlying()) and
    not DMW.Player.NoControl then --and (not DMW.Helpers.Rotation.StandingCheck or DMW.Player:Standing()) then
        return true
    end
    return false
end

function Rotation.GetSpellByID(SpellID)
    local SpellName = GetSpellInfo(SpellID)
    for _, Spell in pairs(DMW.Player.Spells) do
        if Spell.SpellName == SpellName then
            return Spell
        end
    end
end

function Rotation.RawDistance(X1, Y1, Z1, X2, Y2, Z2)
    return sqrt(((X1 - X2) ^ 2) + ((Y1 - Y2) ^ 2) + ((Z1 - Z2) ^ 2))
end

function Rotation.Setting(Setting)
    return DMW.Settings.profile.Rotation[Setting]
end
