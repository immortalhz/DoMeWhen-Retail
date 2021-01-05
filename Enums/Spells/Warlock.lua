local Spells = DMW.Enums.Spells

Spells.WARLOCK = {
    --Affliction
    ["Affliction"] = {
        Abilities = {
            CurseOfAgony = {980},
            UnstableAffliction = {316099},
            Corruption = {172},
            DrainSoul = {198590},
            MaleficRapture = {324536},
            SiphonLife = {63106},
            Sprint = {111400},
            VileTaint = {278350},
            SeedOfCorruption = {27243},
			SoulRot = {325640},
			Haunt = {48181}
        },
        Buffs = {
            Sprint = {111400}
        },
        Debuffs = {
            CurseOfAgony = 980,
            UnstableAffliction = 316099,
            Corruption = 172,
            SiphonLife = 63106,
            VileTaint = 278350,
			SeedOfCorruption = 27243,
			Haunt = 48181
        },
        Talents = {

        }
    },
    --Demonology
    [266] = {
        Abilities = {

        },
        Buffs = {

        },
        Debuffs = {

        },
        Talents = {

        }
    },
    --Destruction
    ["Destruction"] = {
        Abilities = {
            ChaosBolt = {116858},
            Conflagrate = {17962},
            Immolate = {348},
            Incinerate = {29722},
            SummonImp = {688},
        },
        Buffs = {
            Backdraft = {196406},
        },
        Debuffs = {
            Immolate = {157736},
        },
        Talents = {

        }
    },
    ["LowLevel"] = {
        Abilities = {
            -- ShadowBolt = {232670},
            -- SummonImp = {688},
        },
        Buffs = {

        },
        Debuffs = {

        }
    },
    Shared = {
        Abilities = {
		   ShadowFury = {30283},
		   HealthFunnel = {755},
		   FelDomination = {333889},
		   SummonVoidwalker = {697}
        },
        Buffs = {

        },
        Debuffs = {
        }
    }
}
