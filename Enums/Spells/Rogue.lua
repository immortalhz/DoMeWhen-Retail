local Spells = DMW.Enums.Spells

Spells.ROGUE = {
    -- Protection
    Assassination = {
        Abilities = {
            Blindside = {111240},
            CrimsonTempest = {121411},

            Envenom = {32645},
            Evasion = {5277},
            Exsanguinate = {200806},
            FanOfKnives = {51723},
            Garrote = {703},
            KidneyShot = {408},
            Mutilate = {1329},
            PoisonedKnife = {185565},
            Rupture = {1943},
            Shadowstep = {36554},
            ToxicBlade = {245388},
            Vendetta = {79140},

            Stealth = {1784, 115191},
            CrimsonVial = {185311},
            CloakOfShadows = {31224},

        },
        Buffs = {
            Blindside = {111240},

            ElaboratePlanning = {193641},
            Envenom = {32645},
            HiddenBlades = {270070},
            LeechingPoison = {108211},
            SharpenedBlades = {272916},
            MasterAssassin = {256735},
            Stealth = {1784, 115191},
            Subterfuge = {115192},
            TheDreadlordsDeceit = {208692},

        },
        Debuffs = {
            CrimsonTempest = 121411,
            CripplingPoison = 3409,
            DeadlyPoison = 2818,
            Garrote = 703,
            InternalBleeding = 154953,
            Rupture = 1943,
            SurgeOfToxins = 192425,
            ToxicBlade = 245389,
            Vendetta = 79140,
            -- WoundPoison = 8680
        },
        Talents = {
            MasterPoisoner = 22337,
            ElaboratePlanning = 22338,
            Blindside = 22339,
            Nightstalker = 22331,
            Subterfuge = 22332,
            MasterAssassin = 23022,
            Vigor = 19239,
            DeeperStratagem = 19240,
            MarkedForDeath = 19241,
            LeachingPoison = 22340,
            CheatingDeath = 22122,
            Elusiveness = 22123,
            InternalBleeding = 19245,
            IronWire = 23037,
            PreyOnTheWeak = 22115,
            VenomRush = 22343,
            ToxicBlade = 23015,
            Exsanguinate = 22344,
            PoisonBomb = 21186,
            HiddenBlades = 22133,
            CrimsonTempest = 23174
        },
        Traits = {
            DoubleDose = 136,
            EchoingBlades = 407,
            -- SharpenedBlades             = 272911,
            ShroudedSuffocation = 408,
            ScentOfBlood = 406
        }
    },
    -- Fury
    Outlaw = {
        Abilities = {
            Dispatch = {2098},
            BetweenTheEyes = {315341},
            PistolShot = {185763},
            MarkOfDeath = {137619},
            AdrenalineRush = {13750},
            BladeFlurry = {13877},
            BladeRush = {271877},
            GhostlyStrike = {196937},
            Gouge = {1776},
            GrapplingHook = {195457},
            KillingSpree = {51690},
            -- Riposte = {199754},
            RollTheBones = {315508},
            FocusedAzeriteBeam  = {295258},
        },
        Buffs = {
            Opportunity = {195627},
            AdrenalineRush = {13750},
            Alacrity = {193538},
            BladeFlurry = {13877},
            Blunderbuss = {202895},
            Deadshot = {272940},
            HiddenBlade = {202754},
            LoadedDice = {256171},
            SliceAndDice = {5171},
            Snakeeeyes = {275863},

            Broadside = {193356},
            BuriedTreasure = {199600},
            GrandMelee = {193358},
            RuthlessPrecision = {193357},
            SkullAndCrossbones = {199603},
            TrueBearing = {193359},
            Wits = {288988},
        },
        Debuffs = {BetweenTheEyes = 315341},
        Talents = {BladeRush = 23075, DeeperStratagem = 19240, MarkedForDeath = 19241, QuickDraw = 22119, GhostlyStrike = 22120},
        Traits = {Deadshot = 129, AceUpYourSleeve = 411}
    },
    -- Arms
    Subtlety = {
        Abilities = {
            Rupture = {1943},
            SymbolsOfDeath = {212283},
            SecretTechnique = {280719},
            ShadowDance = {185313},
            ShadowBlades = {121471},
            Backstab = {53},
            ShadowStrike = {185438},
            ShurikenStorm = {197835},
            Eviscerate = {196819},
            ShurikenTornado = {277925},
            BlackPowder = {319175}
        },
        Buffs = {
            SymbolsOfDeath = {212283},
            ShadowDance = {185422},
            Premeditation = {343173},
            ShurikenTornado = {123213},
            ShadowBlades = {121471},
			SymbolsOfDeathCritBuff = {227151}
        },
        Debuffs = {
            FindWeakness = 316220,
            Rupture = 1943,
        },
        Talents = {
            WeaponMaster = 19233,
            Premeditation = 19234,
            Gloomblade = 19235,

            Nightstalker = 22331,
            Subterfuge = 22332,
            ShadowFocus = 22333,

            Vigor = 19239,
            DeeperStratagem = 19240,
            MarkedForDeath =  19241,

            DarkShadow = 22335,
            Alacrity = 19249,
            EnvelopingShadows = 22336,

            MasterOfShadows = 22132,
            SecretTechnique = 23183,
            ShurikenTornado = 21188,
        },
        Traits = {Inevitability = 414, BladeInTheShadows = 240}
    },
    Shared = {
        Abilities = {
            Ambush = {8676},
            Blind = {2094},
            Stealth = {1784},
            SinisterStrike = {193315},
            SliceAndDice = {315496},
            Evasion = {5277},
            CrimsonVial = {185311},
            KidneyShot = {408},
            CheapShot = {1833},
            CloakOfShadows = {31224},
            Kick = {1766},
            Vanish = {1856},
            Shroud = {114018},
            Tricks = {57934},
            CripplingPoison = {3408},
            -- DeadlyPoison = {2823},
            WoundPoison = {8679},
			InstantPoison = {315584},
			NumbingPoison = {5761},
            Shiv = {5938},
            Distract = {1725},
            Feint = {1966},
            MarkedForDeath = {137619},
			EchoingReprimand = {323547},
			Sepsis = {328305}
        },
        Buffs = {
			NumbingPoison = {5761},
            SliceAndDice = {315496},
            Vanish = {11327},
            Shroud = {114018},
            Stealth = {1784},
            Tricks = {57934},
            WoundPoison = {8679},
            CripplingPoison = {3408},
            Feint = {1966},
            -- DeadlyPoison = {2823},
            InstantPoison = {315584},
            Kyrian3p = {323559},
            Kyrian2p = {323558},
            Kyrian4p = {323560}
        },
        Debuffs = {

        }
    }
}
