local DMW = DMW

DMW.Enums.Spells = {
    GLOBAL = {
        Abilities = {
            Attack = {6603, "Toggle"},
            Shoot = {5019},
            --Racials
            BloodFury = {20572},
            EveryManForHimself = {59752},
            Berserking = {26297},
            WillofTheForsaken = {7744},
            WarStomp = {20549},

            --Professions, multiple ID's shouldn't matter, just for tracking casts
            -- Mining = {Ranks = {2575}, CastType = "Profession"},
            -- HerbGathering = {Ranks = {2366}, CastType = "Profession"},
            -- Skinning = {Ranks = {8613}, CastType = "Profession"}
        },
        Buffs = {
        },
        Debuffs = {
            ConcentratedFlameBurn = {295368}
        },
        Talents = {

        },
        Essences = {
               [25]={"AegisOfTheDeep"                 ,298168},
               [7]={"AnimaOfDeath"                   ,294926},
               [2]={"AzerothsUndyingGift"            ,298081},
               [23]={"BloodOfTheEnemy"                ,297108},
               [12]={"ConcentratedFlame"              ,295373},
               [14]={"CondensedLifeForce"             ,299357},
               [13]={"EmpoweredNullBarrier"           ,295746},
               [5]={"FocusedAzeriteBeam"             ,295258},
               [14]={"GuardianOfAzeroth"              ,299355},
            --    [1]={"guardianShell"                  ,296036},--added in 8.3
            --    [1]={"heartEssence"                   ,296208},
            --    [1]={"lifeBindersInvocation"          ,293032},
               [27]={"MemoryOfLucidDreams"            ,298357},
            --    [1]={"overchargeMana"                 ,296072},
               [6]={"PurifyingBlast"                 ,299345},
            --    [1]={"reapingFlames"                  ,310690},-- Added in 8.3
            --    [1]={"refreshment"                    ,296197},
            --    [1]={"replicaOfKnowledge"             ,312725},--added in 8.3
               [15]={"RippleInSpace"                  ,302731},
               [24]={"SpiritOfPreservation"           ,297375},-- added in 8.3
            --    [1]={"standstill"                     ,299882},
            [35] = {"BreathOfDying", 11},
            [36] = {"SparkOfInspiration", 11},
               [3]={"SuppressingPulse"               ,300009},
               [28]={"TheUnboundForce"                ,299376},
               [22]={"VisionOfPerfection"             ,299370},
               [21]={"VitalityConduit"                ,299958},
               [32]={"Conflict"                       ,303823},
               [4]={"WorldveinResonance"             ,295186}
        }
    }
}
