local Spells = DMW.Enums.Spells

Spells.DEATHKNIGHT = {
    --Protection
    Blood = {
        Abilities = {
			-- AncestralCall         = {274738},
			-- ArcanePulse           = {260364},
			-- ArcaneTorrent         = {50613},
			-- Berserking            = {26297},
			-- BloodFury             = {20572},
			-- Fireblood             = {265221},
			-- LightsJudgment        = {255647},
			-- BagofTricks           = {312411},
			-- Abilities
			Asphyxiate            = {221562},
			BloodBoil             = {50842},
			Blooddrinker          = {206931},
			BloodMirror           = {206977},
			-- BloodShield           = {77535},
			BoneStorm             = {194844},
			Consumption           = {205223},
			-- CrimsonScourge        = {81141},
			DancingRuneWeapon     = {49028},
			DeathsCaress          = {195292},
			DeathStrike           = {49998},
			HeartBreaker          = {221536},
			HeartStrike           = {206930},

			Marrowrend            = {195182},
			MindFreeze            = {47528},
			Ossuary               = {219788},
			RapidDecomposition    = {194662},
			RuneStrike            = {210764},
			RuneTap               = {194679},
			Tombstone             = {219809},

			UnholyStrengthBuff    = {53365},
			VampiricBlood         = {55233},
			-- Pool                  = {9999000010},
			GorefiendsGrasp = {108199},
			Lifetap = {194679}
        },
        Buffs = {
			BoneShield            = {195181},
			DancingRuneWeaponBuff = {81256},
			HemostasisBuff        = {273947},
			TombstoneBuff         = {219809},
			CrimsonScourge 		  = {81141},
			Lifetap = {194679},
			VampiricBlood = {55233},
			RuneTap = {194679}
        },
        Debuffs = {
			-- RazorCoralDebuff      = {303568},
			BloodPlague = 55078
        },
        Talents = {

        }
    },
    --Fury
    Frost = {
        Abilities = {
			RemorselessWinter                     = {196770},
			GatheringStorm                        = {194912},
			GlacialAdvance                        = {194913},
			Frostscythe                           = {207230},
			FrostStrike                           = {49143},
			HowlingBlast                          = {49184},
			RimeBuff                              = {59052},

			RunicAttenuation                      = {207104},
			Obliterate                            = {49020},
			HornofWinter                          = {57330},
			ArcaneTorrent                         = {50613},
			PillarofFrost                         = {51271},
			ChainsofIce                           = {45524},

			FrostwyrmsFury                        = {279302},

			BloodFury                             = {20572},
			Berserking                            = {26297},
			ArcanePulse                           = {260364},
			LightsJudgment                        = {255647},
			Fireblood                             = {265221},
			AncestralCall                         = {274738},
			BagofTricks                           = {312411},
			EmpowerRuneWeapon                     = {47568},
			BreathofSindragosa                    = {152279},
			ColdHeart                             = {281208},

			FrozenPulse                           = {194909},

			Icecap                                = {207126},
			Obliteration                          = {281238},
			DeathStrike                           = {49998},

			FrozenTempest                         = {278487},

			IcyCitadel                            = {272718},

			MindFreeze                            = {47528},
			BloodoftheEnemy                       = {297108},
			MemoryofLucidDreams                   = {298357},
			PurifyingBlast                        = {295337},
			RippleInSpace                         = {302731},
			ConcentratedFlame                     = {295373},
			TheUnboundForce                       = {298452},
			WorldveinResonance                    = {295186},
			FocusedAzeriteBeam                    = {295258},
			GuardianofAzeroth                     = {295840},
			ReapingFlames                         = {310690},
			-- RecklessForceCounter                  = Multi{298409, 302917},


			ConcentratedFlameBurn                 = {295368},
			ChillStreak                           = {305392},
        },
        Buffs = {
			KillingMachineBuff                    = {51124},
			PillarofFrostBuff                     = {51271},
			EmpowerRuneWeaponBuff                 = {47568},
			FrozenPulseBuff                       = {194909},
			FrostFeverDebuff                      = {55095},
			DeathStrikeBuff                       = {101568},
			UnholyStrengthBuff                    = {53365},
			IcyCitadelBuff                        = {272723},
			RecklessForceBuff                     = {302932},
			SeethingRageBuff                      = {297126},
			ColdHeartBuff                         = {281209},

			IcyTalonsBuff                         = {194879},
        },
        Debuffs = {
			RazoriceDebuff                        = {51714},

			RazorCoralDebuff                      = {303568},

        },
        Talents = {
			-- EndlessRage                   = {278826},
			-- FreshMeat             = {242188},
			-- ImpendingVictory                   = {260708},
			-- StormBolt                       = {275540},
			-- InnerRage                       = {52437},
			-- SuddenDeath                        = {225947},
			-- FuriousSlash                     = {302932},
			-- OverpowerBuff                         = {7384},
			-- FervorofBattle                        = {202316},
        }
    },
    Unholy = {
        Abilities = {
			Outbreak = {77575},
			ScourgeStrike = {55090},
			FesteringStrike = {85948},
			DarkTransformation = {63560},
			Apocalypse = {275699},
			UnholyAssault = {207289},
			Epidemic = {207317},
			SummonGargoyle = {49206},
			SoulReaper = {343294},
			UnholyBlight = {115989},
			RaiseDead = {46584},
			ArmyOfTheDead = {42650},
			DeathAndDecay = {43265},
			Asphyxiate 	= {108194},
			ClawingShadows = {207311},
			Defile = {152280}
        },
        Buffs = {
			DeathAndDecay = {188290},
			SuddenDoom = {81340},
			RunicSpeed = {51460},
			DarkSuccor = {101568},
			RunicCorruption = {51460},
			UnholyBlight = {115989},
			DarkTransformation = {63560}
        },
        Debuffs = {
			FesteringWound = 194310,
			VirulentPlague = 191587,
			UnholyBlight = 115994
        },
        Talents = {
			UnholyBlight = 22029,
			UnholyAssault = 22538,
			SummonGargoyle = 22110,
			ArmyOfTheDamned = 22030,
			SoulReaper = 22526,
			ClawingShadows = 22026,
			Defile = 22536
        }
    },
    LowLevel = {
        Abilities = {


        },
        Buffs = {

        },
        Debuffs = {

        }
	},
	Conduits = {
		[337381] = "EternalHunger",
	},
	Shared = {
        Abilities = {
			MindFreeze = {47528},
			DeathCoil = {47541},
			DeathStrike = {49998},
			DeathAndDecay = {43265},
			DeathGrip = {49576},
			AbominationLimb = {315443},
			DarkCommand = {56222},
			Asphyxiate            = {221562},
			IceboundFortitude = {48792},
			Lichborne = {49039},
			AntimagicZone = {51052},
			WraithWalk = {212552}
        },
        Buffs = {
			DeathAndDecay = {188290},
			IceboundFortitude = {48792},
			Lichborne = {49039},
        },
        Debuffs = {

        }
    }
}
