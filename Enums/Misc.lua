DMW.Enums.MeleeSpell = {WARRIOR = 23881, ROGUE = 1329, DEMONHUNTER = 162243} --193315

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
    [253] = { "Hunter", "Beast Mastery" },
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
    DisableCollision = 0x20000000
}

DMW.Enums.MovementFlags.Moving = bit.bor(DMW.Enums.MovementFlags.Forward, DMW.Enums.MovementFlags.Backward,
                                         DMW.Enums.MovementFlags.StrafeLeft, DMW.Enums.MovementFlags.StrafeRight,
                                         DMW.Enums.MovementFlags.Falling, DMW.Enums.MovementFlags.Ascending,
                                         DMW.Enums.MovementFlags.Descending)

DMW.Enums.DummyList = {
    -- City (SW, Orgri, ...)
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
    [144086] = true -- Raider's Training Dummy
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

DMW.Enums.DispelTypes = {}
local Magic = {
    11, 16, 17, 65, 67, 89, 91, 113, 116, 118, 120, 122, 128, 130, 131, 132, 134, 139, 168, 172, 184, 205, 228, 246, 302, 324, 325, 339,
    348, 379, 409, 410, 411, 457, 467, 474, 507, 509, 512, 527, 528, 543, 546, 550, 552, 553, 586, 588, 589, 592, 594, 595, 600, 602, 604,
    605, 606, 687, 689, 696, 699, 700, 706, 707, 709, 710, 770, 774, 776, 778, 782, 806, 835, 837, 839, 849, 851, 853, 855, 863, 865, 867,
    877, 905, 945, 970, 976, 992, 994, 1006, 1008, 1022, 1038, 1044, 1050, 1058, 1062, 1075, 1086, 1090, 1094, 1112, 1116, 1126, 1130, 1138,
    1139, 1243, 1244, 1245, 1430, 1449, 1450, 1451, 1452, 1453, 1459, 1460, 1461, 1463, 1513, 1663, 1664, 1665, 1706, 2090, 2091, 2140,
    2351, 2353, 2354, 2379, 2380, 2381, 2537, 2601, 2602, 2637, 2645, 2647, 2651, 2652, 2767, 2791, 2855, 2871, 2893, 2941, 2947, 2970,
    3019, 3045, 3109, 3130, 3132, 3136, 3143, 3145, 3169, 3204, 3229, 3233, 3246, 3247, 3258, 3261, 3263, 3264, 3269, 3355, 3356, 3369,
    3389, 3416, 3442, 3443, 3477, 3485, 3542, 3574, 3600, 3602, 3627, 3631, 3635, 3636, 3651, 3742, 3747, 3825, 3826, 4057, 4063, 4077,
    4318, 4320, 4979, 4980, 5106, 5115, 5116, 5138, 5142, 5195, 5196, 5202, 5232, 5234, 5254, 5262, 5276, 5320, 5321, 5322, 5323, 5324,
    5325, 5337, 5403, 5484, 5514, 5515, 5567, 5570, 5588, 5589, 5599, 5628, 5665, 5679, 5697, 5782, 5862, 5917, 6065, 6066, 6074, 6075,
    6076, 6077, 6078, 6117, 6131, 6136, 6143, 6146, 6213, 6215, 6222, 6223, 6226, 6229, 6346, 6358, 6431, 6469, 6528, 6605, 6606, 6615,
    6726, 6728, 6742, 6756, 6789, 6820, 6821, 6822, 6823, 6844, 6864, 6866, 6867, 6870, 6871, 6873, 6894, 6940, 6942, 6949, 6950, 6957,
    6960, 6984, 6985, 7001, 7020, 7074, 7093, 7127, 7128, 7140, 7230, 7231, 7232, 7233, 7234, 7235, 7236, 7237, 7238, 7239, 7240, 7241,
    7242, 7243, 7244, 7245, 7246, 7247, 7248, 7249, 7250, 7251, 7252, 7253, 7254, 7272, 7273, 7288, 7290, 7293, 7295, 7300, 7301, 7302,
    7320, 7321, 7322, 7383, 7396, 7399, 7645, 7648, 7651, 7656, 7739, 7761, 7764, 7812, 7840, 7891, 7948, 7964, 7967, 7997, 7998, 8040,
    8050, 8052, 8053, 8056, 8058, 8064, 8067, 8068, 8070, 8078, 8091, 8094, 8095, 8096, 8097, 8098, 8099, 8100, 8101, 8112, 8113, 8114,
    8115, 8116, 8117, 8118, 8119, 8120, 8134, 8140, 8142, 8147, 8150, 8191, 8202, 8224, 8225, 8245, 8272, 8281, 8312, 8314, 8316, 8317,
    8348, 8362, 8365, 8383, 8384, 8385, 8398, 8399, 8406, 8407, 8408, 8437, 8438, 8439, 8450, 8451, 8455, 8457, 8458, 8461, 8462, 8492,
    8494, 8495, 8552, 8602, 8699, 8788, 8823, 8824, 8833, 8834, 8898, 8899, 8900, 8907, 8910, 8914, 8921, 8924, 8925, 8926, 8927, 8928,
    8929, 8936, 8938, 8939, 8940, 8941, 8988, 8994, 9034, 9159, 9176, 9233, 9234, 9275, 9373, 9433, 9459, 9462, 9482, 9484, 9485, 9552,
    9574, 9578, 9579, 9592, 9612, 9614, 9616, 9657, 9658, 9672, 9735, 9749, 9750, 9756, 9800, 9806, 9833, 9834, 9835, 9839, 9840, 9841,
    9852, 9853, 9856, 9857, 9858, 9884, 9885, 9906, 9907, 9910, 9915, 9930, 10017, 10018, 10060, 10156, 10157, 10159, 10160, 10161, 10169,
    10170, 10173, 10174, 10177, 10179, 10180, 10181, 10191, 10192, 10193, 10201, 10202, 10219, 10220, 10223, 10225, 10230, 10253, 10263,
    10278, 10308, 10336, 10337, 10368, 10390, 10431, 10432, 10447, 10448, 10452, 10472, 10473, 10618, 10730, 10831, 10855, 10892, 10893,
    10894, 10898, 10899, 10900, 10901, 10911, 10912, 10927, 10928, 10929, 10937, 10938, 10941, 10942, 10951, 10952, 10955, 10957, 10958,
    10987, 11014, 11020, 11087, 11088, 11129, 11264, 11350, 11359, 11363, 11364, 11371, 11426, 11436, 11443, 11444, 11445, 11538, 11639,
    11640, 11641, 11657, 11665, 11667, 11668, 11671, 11672, 11699, 11700, 11703, 11704, 11733, 11734, 11735, 11739, 11740, 11743, 11770,
    11771, 11831, 11835, 11836, 11841, 11922, 11962, 11966, 11974, 11975, 11983, 11984, 12022, 12040, 12042, 12043, 12096, 12098, 12160,
    12174, 12175, 12176, 12177, 12178, 12179, 12248, 12494, 12528, 12529, 12530, 12531, 12536, 12542, 12544, 12545, 12548, 12550, 12551,
    12557, 12561, 12579, 12611, 12654, 12674, 12675, 12685, 12731, 12737, 12738, 12742, 12743, 12747, 12748, 12824, 12825, 12826, 12843,
    12888, 12890, 13005, 13031, 13032, 13033, 13181, 13235, 13322, 13323, 13326, 13327, 13377, 13424, 13439, 13530, 13578, 13585, 13586,
    13729, 13745, 13747, 13752, 13787, 13797, 13810, 13812, 13864, 13896, 13903, 13907, 14032, 14207, 14253, 14298, 14299, 14300, 14301,
    14308, 14309, 14314, 14315, 14323, 14324, 14325, 14326, 14327, 14515, 14517, 14518, 14533, 14621, 14743, 14751, 14752, 14818, 14819,
    14893, 14907, 14914, 14915, 15039, 15041, 15043, 15044, 15063, 15089, 15090, 15096, 15123, 15128, 15229, 15231, 15233, 15244, 15253,
    15258, 15261, 15262, 15263, 15264, 15265, 15266, 15267, 15269, 15271, 15277, 15279, 15288, 15346, 15357, 15359, 15366, 15453, 15487,
    15497, 15499, 15505, 15506, 15507, 15530, 15531, 15532, 15534, 15535, 15548, 15570, 15573, 15588, 15599, 15604, 15616, 15646, 15654,
    15661, 15709, 15732, 15733, 15784, 15798, 15822, 15850, 15859, 15876, 15970, 15981, 16050, 16093, 16097, 16104, 16166, 16168, 16170,
    16177, 16188, 16236, 16237, 16246, 16249, 16322, 16323, 16325, 16326, 16327, 16329, 16333, 16337, 16350, 16366, 16402, 16430, 16431,
    16451, 16470, 16498, 16536, 16555, 16561, 16576, 16587, 16591, 16593, 16595, 16598, 16599, 16601, 16603, 16608, 16617, 16689, 16707,
    16708, 16709, 16711, 16798, 16799, 16803, 16804, 16810, 16811, 16812, 16813, 16838, 16843, 16857, 16864, 16870, 16873, 16874, 16875,
    16876, 16877, 16878, 16881, 16882, 16883, 16884, 16885, 16886, 16888, 16889, 16891, 16892, 16893, 16894, 16895, 16898, 16916, 16927,
    16939, 17008, 17038, 17116, 17139, 17140, 17141, 17142, 17146, 17150, 17151, 17152, 17154, 17172, 17173, 17174, 17175, 17177, 17201,
    17205, 17238, 17243, 17281, 17286, 17293, 17329, 17331, 17332, 17333, 17364, 17390, 17391, 17392, 17503, 17506, 17510, 17528, 17543,
    17544, 17545, 17546, 17548, 17549, 17620, 17633, 17682, 17716, 17729, 17730, 17734, 17740, 17741, 17794, 17797, 17798, 17799, 17800,
    17883, 17925, 17926, 17928, 17941, 17961, 18088, 18099, 18100, 18101, 18118, 18137, 18146, 18165, 18186, 18264, 18265, 18268, 18278,
    18288, 18327, 18371, 18376, 18425, 18469, 18498, 18503, 18520, 18542, 18543, 18557, 18647, 18652, 18656, 18657, 18658, 18708, 18763,
    18787, 18798, 18802, 18820, 18828, 18879, 18880, 18881, 18942, 18956, 18957, 18958, 18968, 18972, 18977, 18979, 19028, 19108, 19133,
    19137, 19185, 19261, 19262, 19264, 19265, 19266, 19271, 19273, 19274, 19275, 19289, 19291, 19292, 19293, 19308, 19309, 19310, 19311,
    19312, 19362, 19365, 19366, 19367, 19369, 19393, 19408, 19438, 19440, 19441, 19442, 19443, 19476, 19478, 19479, 19496, 19514, 19626,
    19634, 19635, 19638, 19652, 19653, 19654, 19655, 19656, 19659, 19660, 19690, 19702, 19712, 19714, 19740, 19742, 19776, 19821, 19834,
    19835, 19836, 19837, 19838, 19850, 19852, 19853, 19854, 19937, 19970, 19971, 19972, 19973, 19974, 19975, 19977, 19978, 19979, 20006,
    20007, 20050, 20052, 20053, 20054, 20055, 20066, 20154, 20162, 20164, 20165, 20166, 20184, 20185, 20186, 20188, 20216, 20217, 20223,
    20233, 20236, 20287, 20288, 20289, 20290, 20291, 20292, 20293, 20294, 20297, 20300, 20301, 20302, 20303, 20305, 20306, 20307, 20308,
    20344, 20345, 20346, 20347, 20348, 20349, 20354, 20355, 20356, 20357, 20375, 20425, 20545, 20604, 20631, 20654, 20655, 20656, 20663,
    20664, 20665, 20669, 20683, 20694, 20697, 20699, 20701, 20706, 20729, 20740, 20743, 20787, 20792, 20798, 20800, 20806, 20812, 20819,
    20822, 20826, 20828, 20911, 20912, 20913, 20914, 20915, 20918, 20919, 20920, 20925, 20927, 20928, 20961, 20962, 20967, 20968, 20989,
    21030, 21049, 21063, 21064, 21068, 21073, 21082, 21084, 21098, 21134, 21183, 21331, 21335, 21337, 21369, 21401, 21562, 21564, 21670,
    21790, 21849, 21850, 21857, 21898, 21956, 21970, 21976, 21992, 22009, 22067, 22127, 22128, 22168, 22187, 22206, 22271, 22274, 22356,
    22357, 22373, 22415, 22417, 22418, 22419, 22420, 22423, 22433, 22438, 22460, 22478, 22519, 22559, 22561, 22566, 22582, 22642, 22643,
    22645, 22648, 22666, 22678, 22692, 22693, 22695, 22696, 22710, 22713, 22715, 22716, 22744, 22746, 22782, 22783, 22800, 22812, 22817,
    22818, 22820, 22850, 22914, 22924, 22938, 22959, 23028, 23038, 23102, 23103, 23115, 23126, 23153, 23207, 23245, 23268, 23298, 23380,
    23396, 23417, 23506, 23552, 23577, 23603, 23618, 23775, 23858, 23859, 23860, 23895, 23918, 23931, 23947, 23948, 23951, 23952, 23991,
    24022, 24053, 24109, 24152, 24185, 24212, 24300, 24354, 24360, 24364, 24389, 24415, 24427, 24435, 24615, 24618, 24648, 24672, 24687,
    24752, 24884, 24924, 24925, 24926, 24927, 24942, 24957, 24974, 24975, 24976, 24977, 24995, 25020, 25022, 25023, 25050, 25058, 25164,
    25228, 25290, 25291, 25299, 25304, 25309, 25311, 25315, 25462, 25651, 25668, 25679, 25746, 25747, 25750, 25751, 25774, 25780, 25782,
    25808, 25890, 25894, 25895, 25898, 25899, 25916, 25918, 26017, 26018, 26069, 26070, 26071, 26072, 26108, 26121, 26129, 26130, 26131,
    26132, 26135, 26192, 26331, 26378, 26386, 26387, 26400, 26470, 26580, 26641, 26643, 27204, 27499, 27532, 27533, 27534, 27535, 27536,
    27538, 27540, 27559, 27564, 27565, 27605, 27606, 27607, 27634, 27637, 27641, 27648, 27681, 27683, 27688, 27689, 27737, 27760, 27775,
    27777, 27779, 27782, 27783, 27784, 27786, 27788, 27798, 27813, 27817, 27818, 27828, 27841, 27868, 27873, 27874, 27989, 27990, 27994,
    27995, 28133, 28270, 28271, 28272, 28315, 28406, 28450, 28478, 28479, 28609, 28610, 28682, 28722, 28723, 28724, 28732, 28753, 28754,
    28762, 28765, 28766, 28768, 28769, 28770, 28772, 28780, 28810, 28813, 28846, 28848, 28850, 28862, 28866, 29063, 29077, 29163, 29164,
    29166, 29168, 29203, 29212, 29228, 29432, 29848, 29849, 30001, 30002, 30094, 30095, 30096, 31365, 31817
}
DMW.Enums.DispelTypes.Magic = {}
for _, v in ipairs(Magic) do DMW.Enums.DispelTypes.Magic[v] = true end
