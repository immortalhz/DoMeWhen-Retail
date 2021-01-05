-- DMW.Enums.MeleeSpell = {WARRIOR = 23881, ROGUE = 193315, DEMONHUNTER = 162794} --193315

DMW.Enums.MeleeSpell = {
    ["Vengeance"] = 228477,
    ["Havoc"] = 162794,
    ["Outlaw"] = 1766,
    ["Assassination"] = 193315,
    ["Blood"] = 49998,
    ["Unholy"] = 49998,
    ["Fury"] = 6552,
    ["Protection"] = 96231,
    ["Arms"] = 1,
    ["Holy"] = 35395,
    ["Retribution"] = 35395,
    ["Balance"] = 33917,
    ["Enhancment"] = 73889,
	["Subtlety"] = 1766,
	["Feral"] = 1822
}

DMW.Enums.Range40Spell = {
    ["WARLOCK"] = 172,
}

DMW.Enums.CreatureType = {
    [1] = "Beast",
    [2] = "Dragonkin",
    [3] = "Demon",
    [4] = "Elemental",
    [5] = "Giant",
    [6] = "Undead",
    [7] = "Humanoid",
    [8] = "Critter",
    [9] = "Mechanical",
    [10] = "Not specified",
    [11] = "Totem",
    [12] = "NON_COMBAT_PET",
    [13] = "GAS_CLOUD",
    [14] = "WILD_PET",
    [15] = "ABERRATION"
}

DMW.Enums.PowerTypesToCheck =
{
	MANA = {Enum.PowerType.Mana, "Power"},
	RAGE = {Enum.PowerType.Rage, "Rage"},
	FOCUS = {Enum.PowerType.Focus, "Focus"},
	ENERGY = {Enum.PowerType.Energy, "Energy"},
	COMBO_POINTS = {Enum.PowerType.ComboPoints, "ComboPoints"},
	RUNES = {Enum.PowerType.Runes, "Runes"},
	RUNIC_POWER = {Enum.PowerType.RunicPower, "RunicPower"},
	SOUL_SHARDS = {Enum.PowerType.SoulShards, "SoulShards"},
	LUNAR_POWER = {Enum.PowerType.LunarPower, "LunarPower"},
	HOLY_POWER = {Enum.PowerType.HolyPower, "HolyPower"},
	ALTERNATE = {Enum.PowerType.Alternate, "Alternate"},
	MAELSTROM = {Enum.PowerType.Maelstrom, "Maelstrom"},
	CHI = {Enum.PowerType.Chi, "Chi"},
	ARCANE_CHARGES = {Enum.PowerType.ArcaneCharges, "ArcaneCharges"},
	FURY = {Enum.PowerType.Fury, "Fury"},
	PAIN = {Enum.PowerType.Pain, "Pain"},
	INSANITY = {Enum.PowerType.Insanity, "Insanity"}
}

-- Name = "CorruptionEffectInfo",
-- Type = "Structure",
-- Fields =
-- {
--     { Name = "name", Type = "string", Nilable = false },
--     { Name = "description", Type = "string", Nilable = false },
--     { Name = "minCorruption", Type = "number", Nilable = false },
-- },



DMW.Enums.ClassColor = {
    DRUID = {r = 255, g = 125, b = 10},
    HUNTER = {r = 171, g = 212, b = 115},
    MAGE = {r = 64, g = 199, b = 235},
    PALADIN = {r = 245, g = 140, b = 186},
    PRIEST = {r = 255, g = 255, b = 255},
    ROGUE = {r = 255, g = 245, b = 105},
    SHAMAN = {r = 0, g = 112, b = 222},
    WARLOCK = {r = 135, g = 135, b = 237},
    WARRIOR = {r = 199, g = 156, b = 110}
}

DMW.Enums.ClassSpec = {
    -- Death Knight
    [250] = { "DeathKnight", "Blood" },
    [251] = { "DeathKnight", "Frost" },
    [252] = { "DeathKnight", "Unholy" },
    -- Demon Hunter
    [577] = { "DemonHunter", "Havoc" },
    [581] = { "DemonHunter", "Vengeance" },
    -- Druid
    [102] = { "Druid", "Balance" },
    [103] = { "Druid", "Feral" },
    [104] = { "Druid", "Guardian" },
    [105] = { "Druid", "Restoration" },
    -- Hunter
    [253] = { "Hunter", "BeastMastery" },
    [254] = { "Hunter", "Marksmanship" },
    [255] = { "Hunter", "Survival" },
    -- Mage
    [62] = { "Mage", "Arcane" },
    [63] = { "Mage", "Fire" },
    [64] = { "Mage", "Frost" },
    -- Monk
    [268] = { "Monk", "Brewmaster" },
    [269] = { "Monk", "Windwalker" },
    [270] = { "Monk", "Mistweaver" },
    -- Paladin
    [65] = { "Paladin", "Holy" },
    [66] = { "Paladin", "Protection" },
    [70] = { "Paladin", "Retribution" },
    -- Priest
    [256] = { "Priest", "Discipline" },
    [257] = { "Priest", "Holy" },
    [258] = { "Priest", "Shadow" },
    -- Rogue
    [259] = { "Rogue", "Assassination" },
    [260] = { "Rogue", "Outlaw" },
    [261] = { "Rogue", "Subtlety" },
    -- Shaman
    [262] = { "Shaman", "Elemental" },
    [263] = { "Shaman", "Enhancement" },
    [264] = { "Shaman", "Restoration" },
    -- Warlock
    [265] = { "Warlock", "Affliction" },
    [266] = { "Warlock", "Demonology" },
    [267] = { "Warlock", "Destruction" },
    -- Warrior
    [71] = { "Warrior", "Arms" },
    [72] = { "Warrior", "Fury" },
    [73] = { "Warrior", "Protection" }
}

DMW.Enums.GameObjectFlags = {
    IN_USE          = 0x00000001,     -- disables interaction while animated
    LOCKED          = 0x00000002,     -- require key, spell, event, etc to be opened. Makes "Locked" appear in tooltip
    INTERACT_COND   = 0x00000004,     -- cannot interact (condition to interact - requires GO_DYNFLAG_LO_ACTIVATE to enable interaction clientside)
    TRANSPORT       = 0x00000008,     -- any kind of transport? Object can transport (elevator, boat, car)
    NOT_SELECTABLE  = 0x00000010,     -- not selectable even in GM mode
    NODESPAWN       = 0x00000020,     -- never despawn, typically for doors, they just change state
    AI_OBSTACLE     = 0x00000040,     -- makes the client register the object in something called AIObstacleMgr, unknown what it does
    FLAG_FREEZE_ANIMATION = 0x00000080,
    --for object types GAMEOBJECT_TYPE_GARRISON_BUILDING, GAMEOBJECT_TYPE_GARRISON_PLOT and GAMEOBJECT_TYPE_PHASEABLE_MO flag bits 8 to 12 are used as WMOAreaTable::NameSetID
    DAMAGED         = 0x00000200,
    DESTROYED       = 0x00000400,
    INTERACT_DISTANCE_USES_TEMPLATE_MODEL = 0x00080000, -- client checks interaction distance from model sent in SMSG_QUERY_GAMEOBJECT_RESPONSE instead of GAMEOBJECT_DISPLAYID
    MAP_OBJECT      = 0x00100000         --7.0 model loading used to be controlled by file extension (wmo vs m2)
}

DMW.Enums.GameObjectDynamicFlags = {
    HIDE_MODEL        = 0x02, -- Object model is not shown with this flag
    ACTIVATE          = 0x04, -- enables interaction with GO
    ANIMATE           = 0x08, -- possibly more distinct animation of GO
    NO_INTERACT       = 0x10, -- appears to disable interaction (not fully verified)
    SPARKLE           = 0x20, -- makes GO sparkle
    STOPPED           = 0x40  -- Transport is stopped
}

DMW.Enums.UnitFlags = {
    -- From trinity
    NotClientControlled = 0x1,
    PlayerCannotAttack = 0x2,
    RemoveClientControl = 0x4,
    PlayerControlled = 0x8,
    Preparation = 0x20,
    NoAttack = 0x80,
    NotAttackbleByPlayerControlled = 0x100,
    OnlyAttackableByPlayerControlled = 0x200,
    Looting = 0x400,
    PetIsAttackingTarget = 0x800,
    PVP = 0x1000,
    Silenced = 0x2000,
    CannotSwim = 0x4000,
    OnlySwim = 0x8000,
    NoAttack2 = 0x10000,
    Pacified = 0x20000,
    Stunned = 0x40000,
    AffectingCombat = 0x80000,
    OnTaxi = 0x100000,
    MainHandDisarmed = 0x200000,
    Confused = 0x400000,
    Feared = 0x800000,
    PossessedByPlayer = 0x1000000,
    NotSelectable = 0x2000000,
    Skinnable = 0x4000000,
    Mount = 0x8000000,
    PreventKneelingWhenLooting = 0x10000000,
    PreventEmotes = 0x20000000,
    Sheath = 0x40000000
}

-- Sitting = 0x1,
-- Influenced = 0x4, // Stops movement packets
-- Totem = 0x10,
-- Preparation = 0x20, // 3.0.3
-- PlusMob = 0x40, // 3.0.2
-- NotAttackable = 0x100,
-- Looting = 0x400,
-- PetInCombat = 0x800, // 3.0.2
-- PvPFlagged = 0x1000,
-- Silenced = 0x2000, //3.0.3
-- CanPerformAction_Mask1 = 0x60000,
-- TaxiFlight = 0x100000,
-- Fleeing = 0x800000,
-- Dazed = 0x20000000,
-- Sheathe = 0x40000000,
DMW.Enums.UnitFlags2 = {
    AppearDead = 0x1,
    Unk1 = 0x2,
    IgnoreReputation = 0x4,
    ComprehendLanguages = 0x8,
    MirrorImage = 0x10,
    DoNotFadeIn = 0x20,
    ForceMovement = 0x40,
    OffHandDisarmed = 0x80,
    DisablePredictedStats = 0x100,
    RangedDisarm = 0x400,
    RegeneratePower = 0x800,
    RestrictInteractionToPartyOrRaid = 0x1000,
    PreventSpellClick = 0x2000,
    CanInteractEvenIfHostile = 0x4000,
    CannotTurn = 0x8000,
    Unk2 = 0x10000,
    PlayDeathAnimationOnDeath = 0x20000,
    AllowCastingCheatSpells = 0x40000,

    NoActions = 0x800000,
    SwimPrevent = 0x1000000,
    HideInCombatLog = 0x2000000,
    CannotSwitchTargets = 0x4000000,
    IgnoreSpellMinRangeRestrictions = 0x8000000,
    Unk3 = 0x10000000,
}

DMW.Enums.UnitDynFlags = {
    -- None                  = 0x0000,
    -- Lootable              = 0x0001,
    -- TrackUnit             = 0x0002,
    -- Tapped                = 0x0004,
    -- TappedByPlayer        = 0x0008,
    -- EmpathyInfo           = 0x0010,
    -- AppearDead            = 0x0020,
    -- ReferAFriendLinked    = 0x0040,
    -- TappedByAllThreatList = 0x0080
    NONE                       = 0x0000,
    HIDE_MODEL                 = 0x0002, --Object model is not shown with this flag
    LOOTABLE                   = 0x0004,
    TRACK_UNIT                 = 0x0008,
    TAPPED                     = 0x0010, --Lua_UnitIsTapped
    SPECIALINFO                = 0x0020,
    DEAD                       = 0x0040,
    REFER_A_FRIEND             = 0x0080
}

--!!
-- enum CorpseDynFlags
-- {
--     CORPSE_DYNFLAG_LOOTABLE        = 0x0001
-- };

DMW.Enums.NpcFlags = {
    Innkeeper = 0x00010000,
    Repair = 0x0000001000,
    PoisonVendor = 0x0000000400,
    FlightMaster = 0x0000002000,
    ReagentVendor = 0x0000000800,
    Trainer = 0x0000000010,
    ClassTrainer = 0x0000000020,
    ProfessionTrainer = 0x0000000040,
    AmmoVendor = 0x0000000100,
    FoodVendor = 0x0000000200,
    BlackMarket = 0x0080000000,
    TradeskillNpc = 0x4000000000,
    Vendor = 0x0000000080
}

DMW.Enums.MovementFlags = {
    None = 0x00000000,
    Forward = 0x00000001,
    Backward = 0x00000002,
    StrafeLeft = 0x00000004,
    StrafeRight = 0x00000008,
    Left = 0x00000010,
    Right = 0x00000020,
    PitchUp = 0x00000040,
    PitchDown = 0x00000080,
    Walking = 0x00000100,
    DisableGravity = 0x00000200,
    Root = 0x00000400,
    Falling = 0x00000800,
    FallingFar = 0x00001000,
    PendingStop = 0x00002000,
    PendingStrafeStop = 0x00004000,
    PendingForward = 0x00008000,
    PendingBackward = 0x00010000,
    PendingStrafeLeft = 0x00020000,
    PendingStrafeRight = 0x00040000,
    PendingRoot = 0x00080000,
    Swimming = 0x00100000,
    Ascending = 0x00200000,
    Descending = 0x00400000,
    CanFly = 0x00800000,
    Flying = 0x01000000,
    SplineElevation = 0x02000000,
    WaterWalking = 0x04000000,
    FallingSlow = 0x08000000,
    Hover = 0x10000000,
    DisableCollision = 0x20000000,
    Immobilized = 0x400,
}

DMW.Enums.MovementFlags.Moving = bit.bor(DMW.Enums.MovementFlags.Forward, DMW.Enums.MovementFlags.Backward,
                                         DMW.Enums.MovementFlags.StrafeLeft, DMW.Enums.MovementFlags.StrafeRight,
                                         DMW.Enums.MovementFlags.Falling, DMW.Enums.MovementFlags.Ascending,
                                         DMW.Enums.MovementFlags.Descending)

DMW.Enums.DummyList = {
    -- City (SW, Orgri, ...)
    [153285] = true,
    [31146] = true, -- Raider's Training Dummy
    [31144] = true, -- Training Dummy
    [32666] = true, -- Training Dummy
    [32667] = true, -- Training Dummy
    [46647] = true, -- Training Dummy
    -- MoP Shrine of Two Moons
    [67127] = true, -- Training Dummy
    -- WoD Alliance Garrison
    [87317] = true, -- Mage Tower Damage Training Dummy
    [87318] = true, -- Mage Tower Damage Dungeoneer's Training Dummy (& Garrison)
    [87320] = true, -- Mage Tower Damage Raider's Training Dummy
    [88314] = true, -- Tanking Dungeoneer's Training Dummy
    [88316] = true, -- Healing Training Dummy ----> FRIENDLY
    -- WoD Horde Garrison
    [87760] = true, -- Mage Tower Damage Training Dummy
    [87761] = true, -- Mage Tower Damage Dungeoneer's Training Dummy (& Garrison)
    [87762] = true, -- Mage Tower Damage Raider's Training Dummy
    [88288] = true, -- Tanking Dungeoneer's Training Dummy
    [88289] = true, -- Healing Training Dummy ----> FRIENDLY
    -- Legion Rogue Class Order Hall
    [92164] = true, -- Training Dummy
    [92165] = true, -- Dungeoneer's Training Dummy
    [92166] = true, -- Raider's Training Dummy
    -- Legion Priest Class Order Hall
    [107555] = true, -- Bound void Wraith
    [107556] = true, -- Bound void Walker
    -- Legion Druid Class Order Hall
    [113964] = true, -- Raider's Training Dummy
    [113966] = true, -- Dungeoneer's Training Dummy
    -- Legion Warlock Class Order Hall
    [102052] = true, -- Rebellious imp
    [102048] = true, -- Rebellious Felguard
    [102045] = true, -- Rebellious WrathGuard
    [101956] = true, -- Rebellious Fel Lord
    -- Legion Mage Class Order Hall
    [103397] = true, -- Greater Bullwark Construct
    [103404] = true, -- Bullwark Construct
    [103402] = true, -- Lesser Bullwark Construct
    -- BfA Dazar'Alor
    [144081] = true, -- Training Dummy
    [144082] = true, -- Training Dummy
    [144085] = true, -- Training Dummy
    [144086] = true, -- Raider's Training Dummy
    [160325] = true,
    [154564] = true,
    [154580] = true,
	[154583] = true,
	[174487] = true, --Necrolord left dummies
}

DMW.Enums.HeroismBuff = {
        90355, -- Ancient Hysteria
        2825, -- Bloodlust
        32182, -- Heroism
        160452, -- Netherwinds
        80353, -- Time Warp
        178207, -- Drums of Fury
        35475, -- Drums of War
        230935, -- Drums of Montain
        256740 -- Drums of Maelstrom
}

DMW.Enums.DungeonStuff = {
    Stun = {
		[168949] = true,
		[168992] = true,
		[168986] = true,
		[170147] = true,
		[167963] = true,
		[167965] = true,
		[167967] = true,
		[170490] = true,
		[170480] = true,
		[164862] = true,
		[164857] = true,
		[171342] = true,
		[164873] = true,
		[164861] = true,
		[171341] = true,
		[171181] = true,
		[165515] = true,
		[164562] = true,
		[164563] = true,
		[165414] = true,
		[165415] = true,
		[165529] = true,
		[167610] = true,
		[167611] = true,
		[167892] = true,
		[165111] = true,
		[164920] = true,
		[164921] = true,
		[163058] = true,
		[166301] = true,
		[166276] = true,
		[166299] = true,
		[166275] = true,
		[167113] = true,
		[172312] = true,
		[167117] = true,
		[167116] = true,
		[166304] = true,
		[168968] = true,
		[168365] = true,
		[169696] = true,
		[168969] = true,
		[168572] = true,
		[168578] = true,
		[168580] = true,
		[168361] = true,
		[168574] = true,
		[171474] = true,
		[163892] = true,
		[168878] = true,
		[168627] = true,
		[164705] = true,
		[163891] = true,
		[164707] = true,
		[168022] = true,
		[163862] = true,
		[167493] = true,
		[168747] = true,
		[164737] = true,
		[163857] = true,
		[162041] = true,
		[162046] = true,
		[166396] = true,
		[165076] = true,
		[171448] = true,
		[162039] = true,
		[162056] = true,
		[167956] = true,
		[168591] = true,
		[171384] = true,
		[168058] = true,
		[172265] = true,
		[162049] = true,
		[162051] = true,
		[171455] = true,
		[167955] = true,
		[163459] = true,
		[163457] = true,
		[163458] = true,
		[163503] = true,
		[163501] = true,
		[168420] = true,
		[163506] = true,
		[163524] = true,
		[168418] = true,
		[168718] = true,
		[168717] = true,
		[166411] = true,
		[162729] = true,
		[165138] = true,
		[166302] = true,
		[163121] = true,
		[165872] = true,
		[163128] = true,
		[163619] = true,
		[163618] = true,
		[163126] = true,
		[163122] = true,
		[165222] = true,
		[166079] = true,
		[171500] = true,
		[173016] = true,
		[166264] = true,
		[165911] = true,
		[163622] = true,
		[163623] = true,
	},
	Incapacitate = {
		[168949] = true,
		[168992] = true,
		[168986] = true,
		[167967] = true,
		[170490] = true,
		[171333] = true,
		[170480] = true,
		[164862] = true,
		[164857] = true,
		[171342] = true,
		[164873] = true,
		[164861] = true,
		[171341] = true,
		[171181] = true,
		[165515] = true,
		[164562] = true,
		[164563] = true,
		[165414] = true,
		[165415] = true,
		[165529] = true,
		[167610] = true,
		[167611] = true,
		[167892] = true,
		[165111] = true,
		[164920] = true,
		[164921] = true,
		[163058] = true,
		[166301] = true,
		[166276] = true,
		[166299] = true,
		[166275] = true,
		[167113] = true,
		[172312] = true,
		[167117] = true,
		[167116] = true,
		[166304] = true,
		[168968] = true,
		[168365] = true,
		[169696] = true,
		[168969] = true,
		[168572] = true,
		[168578] = true,
		[168580] = true,
		[168361] = true,
		[168574] = true,
		[163892] = true,
		[168878] = true,
		[168627] = true,
		[164705] = true,
		[163891] = true,
		[164707] = true,
		[168022] = true,
		[163862] = true,
		[167493] = true,
		[168747] = true,
		[164737] = true,
		[163857] = true,
		[162041] = true,
		[162046] = true,
		[166396] = true,
		[165076] = true,
		[171448] = true,
		[162039] = true,
		[162056] = true,
		[167956] = true,
		[168591] = true,
		[171384] = true,
		[168058] = true,
		[172265] = true,
		[162049] = true,
		[162051] = true,
		[171455] = true,
		[167955] = true,
		[163459] = true,
		[163457] = true,
		[163458] = true,
		[163503] = true,
		[163501] = true,
		[168420] = true,
		[163506] = true,
		[163524] = true,
		[168418] = true,
		[168718] = true,
		[168717] = true,
		[166411] = true,
		[162729] = true,
		[165138] = true,
		[166302] = true,
		[163121] = true,
		[165872] = true,
		[163128] = true,
		[163619] = true,
		[163618] = true,
		[163126] = true,
		[163122] = true,
		[165222] = true,
		[166079] = true,
		[171500] = true,
		[173016] = true,
		[166264] = true,
		[165911] = true,
		[163622] = true,
		[163623] = true,
	}
}
