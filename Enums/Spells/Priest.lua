local Spells = DMW.Enums.Spells

Spells.PRIEST = {

    Shadow = {
        Abilities = {
            DevouringPlague = {335467},
            Mindfly = {15407},
            VampiricTouch = {34914},
            DarkMending = {186263},
            Shadowfiend = {34433},
            VoidErruption = {228260},
            VoidBolt = {205448},
            ShadowForm = {232698},
            MindSear = {48045},
            PurifyDisease = {213634}
        },
        Buffs = {
            ShadowForm = {232698},
            VoidForm = {194249},
            DarkThoughts = {341207}
        },
        Debuffs = {
            VampiricTouch              = 34914,
            DevouringPlague = 335467
        },
        Talents = {
            -- WarMachine = 22632, -- 262231
            Misery = 23126,

			--
		},
		Traits = {
			-- ColdSteel = 176
		}
    },
    Holy = {
        Abilities = {
            Purify = {527}
        },
        Buffs = {

        },
        Debuffs = {
            -- GlimmerOfLight              = 287280
        },
        Talents = {


            -- SanctifiedWrath = , -- 23191, 23456, 23457
		},
		Traits = {
		}
    },
    Discipline = {
        Abilities = {
            Purify = {527}
        },
        Buffs = {

        },
        Debuffs = {
            -- GlimmerOfLight              = 287280
        },
        Talents = {


            -- SanctifiedWrath = , -- 23191, 23456, 23457
		},
		Traits = {
		}
    },
	Shared = {
        Abilities = {
            FlashHeal = {2061},
            MindBlast = {8092},
            Ressurection = {2006},
            MentalFear = {8122},
            PWFortitude = {21562},
            PWShield = {17},
            SWPain = {589},
            SWDeath = {32379},
            DispelMagic = {528}
        },
        Buffs = {
            PWShield = {17}
        },
        Debuffs = {
            SWPain = 589,

            WeakenedSoul = 6788
        }
    }
}
