local Spells = DMW.Enums.Spells

Spells.DEATHKNIGHT = {
    --Protection
    Blood = {
        Abilities = {
			AncestralCall         = {274738},
			ArcanePulse           = {260364},
			ArcaneTorrent         = {50613},
			Berserking            = {26297},
			BloodFury             = {20572},
			Fireblood             = {265221},
			LightsJudgment        = {255647},
			BagofTricks           = {312411},
			-- Abilities
			Asphyxiate            = {221562},
			BloodBoil             = {50842},
			Blooddrinker          = {206931},
			BloodMirror           = {206977},
			BloodPlague           = {55078},
			BloodShield           = {77535},
			Bonestorm             = {194844},
			Consumption           = {205223},
			CrimsonScourge        = {81141},
			DancingRuneWeapon     = {49028},

			DeathandDecay         = {43265},
			DeathsCaress          = {195292},
			DeathStrike           = {49998},
			HeartBreaker          = {221536},
			HeartStrike           = {206930},

			Marrowrend            = {195182},
			MindFreeze            = {47528},
			Ossuary               = {219786},
			RapidDecomposition    = {194662},
			RuneStrike            = {210764},
			RuneTap               = {194679},
			Tombstone             = {219809},

			UnholyStrengthBuff    = {53365},
			VampiricBlood         = {55233},
			-- Pool                  = {9999000010}
        },
        Buffs = {
			BoneShield            = {195181},

			DancingRuneWeaponBuff = {81256},
			HemostasisBuff        = {273947},
			TombstoneBuff         = {219809},
        },
        Debuffs = {
			RazorCoralDebuff      = {303568},
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
    --Arms
    Unholy = {
        Abilities = {
			Skullsplitter                         = {260643},
			DeadlyCalm                            = {262228},
			Ravager                               = {152277},
			ColossusSmash                         = {167105},
			Warbreaker                            = {262161},
			Bladestorm                            = {227847},
			Cleave                                = {845},
			Slam                                  = {1464},
			MortalStrike                          = {12294},
			Dreadnaught                           = {262150},
			Execute                               = {163201, 281000},
			Overpower                             = {7384},
			TestofMight                           = {275529},
			SweepingStrikes                       = {260708},
			Whirlwind                             = {1680},
			Rend                                  = {772},
			AngerManagement                       = {152278},
			SeismicWave                           = {277639},
			Charge                                = {100},
			HeroicLeap                            = {6544},
			BloodFury                             = {20572},
			Berserking                            = {26297},
			ArcaneTorrent                         = {50613},
			LightsJudgment                        = {255647},
			Fireblood                             = {265221},
			AncestralCall                         = {274738},
			BagofTricks                           = {312411},
			Avatar                                = {107574},
			Massacre                              = {281001},
			Pummel                                = {6552},
			IntimidatingShout                     = {5246},
			BloodoftheEnemy                       = {297108},
			PurifyingBlast                        = {295337},
			RippleInSpace                         = {302731},
			ConcentratedFlame                     = {295373},
			TheUnboundForce                       = {298452},
			WorldveinResonance                    = {295186},
			FocusedAzeriteBeam                    = {295258},
			GuardianofAzeroth                     = {295840},
			ReapingFlames                         = {310690},
			ConcentratedFlameBurn                 = {295368},
			-- VictoryRush = {34428},
			-- VictoryRush = {34428},
			VictoryRush = {34428},
        },
        Buffs = {
			MemoryofLucidDreams                   = {298357},
			VictoryRush = {32216},
			DeadlyCalmBuff                        = {262228},
			CrushingAssaultBuff                   = {278826},
			ExecutionersPrecisionBuff             = {242188},
			SweepingStrikesBuff                   = {260708},
			TestofMightBuff                       = {275540},
			SuddenDeathBuff                       = {52437},
			StoneHeartBuff                        = {225947},
			RecklessForceBuff                     = {302932},
			OverpowerBuff                         = {7384},
        },
        Debuffs = {
			ColossusSmashDebuff                   = {208086},

			DeepWoundsDebuff                      = {262115},

			RazorCoralDebuff                      = {303568},

			ConductiveInkDebuff                   = {302565},
			RendDebuff                            = {772},

        },
        Talents = {
			WarMachine                        = 262231,
			SuddenDeath                   = 29725,
			Skullsplitter             = 26043,
			DoubleTime             = 103827,
			ImpendingVictory                   = 202168,
			StormBolt                       = 107570,
			Massacre                       = 281001,
			FervorOfBattle                        = 202316,
			Rend                     = 772,
			SecondWind                         = 29838,
			BoundingStride                        = 202163,
			DefensiveStance                   = 197690,
			CollateralDamage                       = 268243,
			Warbreaker                       = 262161,
			Cleave                        = 845,
			InForTheKill                     = 248621,
			Avatar                         = 107574,
			DeadlyCalm                        = 262228,
			AngerManagement                     = 152278,
			Dreadnaught                         = 262150,
			Ravager                        = 152277,
        }
    },
    LowLevel = {
        Abilities = {
			Charge = {100},
			-- VictoryRush = {34428},
			-- VictoryRush = {34428},
			Execute = {163201},
			MortalStrike = {12294},
			Slam = {1464},
			VictoryRush = {34428},
        },
        Buffs = {
			VictoryRush = {32216},
        },
        Debuffs = {

        }
	},
	Shared = {
        Abilities = {
			BattleShout = {6673},
			-- VictoryRush = {34428},
			-- VictoryRush = {34428},

        },
        Buffs = {
			BattleShout = {6673},
        },
        Debuffs = {

        }
    }
}
