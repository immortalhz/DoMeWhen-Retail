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
               [25]={"aegisOfTheDeep"                 ,298168},
               [7]={"animaOfDeath"                   ,294926},
               [2]={"azerothsUndyingGift"            ,298081},
               [23]={"bloodOfTheEnemy"                ,297108},
               [12]={"ConcentratedFlame"              ,295373},
               [14]={"condensedLifeForce"             ,299357},
               [13]={"empoweredNullBarrier"           ,295746},
               [5]={"focusedAzeriteBeam"             ,295258},
               [14]={"guardianOfAzeroth"              ,299355},
            --    [1]={"guardianShell"                  ,296036},--added in 8.3
            --    [1]={"heartEssence"                   ,296208},
            --    [1]={"lifeBindersInvocation"          ,293032},
               [27]={"memoryOfLucidDreams"            ,298357},
            --    [1]={"overchargeMana"                 ,296072},
               [6]={"purifyingBlast"                 ,299345},
            --    [1]={"reapingFlames"                  ,310690},-- Added in 8.3
            --    [1]={"refreshment"                    ,296197},
            --    [1]={"replicaOfKnowledge"             ,312725},--added in 8.3
               [15]={"rippleInSpace"                  ,302731},
               [24]={"spiritOfPreservation"           ,297375},-- added in 8.3
            --    [1]={"standstill"                     ,299882},
            [35] = {"BreathOfDying", 11},
            [36] = {"SparkOfInspiration", 11},
               [3]={"suppressingPulse"               ,300009},
               [28]={"theUnboundForce"                ,299376},
               [22]={"visionOfPerfection"             ,299370},
               [21]={"vitalityConduit"                ,299958},
               [32]={"conflict"                       ,303823},
               [4]={"worldveinResonance"             ,295186}
        }
    }
}
