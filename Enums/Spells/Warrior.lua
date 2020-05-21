local Spells = DMW.Enums.Spells

Spells.WARRIOR = {
    --Protection
    Protection = {
        Abilities = {
			ThunderClap                           = {6343},
			DemoralizingShout                     = {1160},
			DragonRoar                            = {118000},
			Revenge                               = {6572},
			Ravager                               = {228920},
			ShieldBlock                           = {2565},
			ShieldSlam                            = {23922},
			UnstoppableForce                      = {275336},
			BraceForImpact                        = {277636},
			DeafeningCrash                        = {272824},
			Devastate                             = {20243},
			Intercept                             = {198304},
			Taunt                             	  = {355},
			BloodFury                             = {20572},
			Berserking                            = {26297},
			BerserkerRage 						  = {18499},
			ArcaneTorrent                         = {50613},
			LightsJudgment                        = {255647},
			Fireblood                             = {265221},
			AncestralCall                         = {274738},
			BagofTricks                           = {312411},
			IgnorePain                            = {190456},
			Avatar                                = {107574},
			LastStand                             = {12975},
			ShieldWall                            = {871},
			ShockWave                             = {46968},
			VictoryRush                           = {34428},
			ImpendingVictory                      = {202168},
			Pummel                                = {6552},
			SpellReflect 						  = {23920},
			RallyingCry 						  = {97462},
			IntimidatingShout                     = {5246},
			HeroicThrow 						  = {57755},
			RazorCoralDebuff                      = {303568},
			BloodoftheEnemy                       = {297108},
			MemoryofLucidDreams                   = {298357},
			PurifyingBlast                        = {295337},
			RippleInSpace                         = {302731},
			ConcentratedFlame                     = {295373},
			TheUnboundForce                       = {298452},
			WorldveinResonance                    = {295186},
			FocusedAzeriteBeam                    = {295258},
			GuardianofAzeroth                     = {295840},
			AnimaofDeath                          = {294926},
			ConcentratedFlameBurn                 = {295368},
        },
        Buffs = {
			FreeRevenge                           = {5302},
			ShieldBlock               			= {132404},
			Avatar                           	 = {107574},
			LastStandBuff                         = {12975},
			IgnorePain                            = {190456},

			RecklessForceBuff                     = {302932}

        },
        Debuffs = {

        },
        Talents = {
			IntoTheFray = 15760, -- 202603
			Punish = 15759, -- 275334
			ImpendingVictory = 15774, -- 202168

			CracklingThunder = 22373, -- 203201
			BoundingStride = 22629, -- 202163
			Safeguard = 22409, -- 223657

			BestServedCold = 22378, -- 202560
			UnstoppableForce = 22626, -- 275336
			DragonRoar = 23260, -- 118000

			Indomitable = 23096, -- 202095
			NeverSurrender = 23261, -- 202561
			Bolster = 22488, -- 280001

			Menace = 22384, -- 275338
			RumblingEarth = 22631, -- 275339
			StormBolt = 22800, -- 107570

			BoomingVoice = 22395, -- 202743
			Vengeance = 22544, -- 202572
			Devastator = 22401, -- 236279

			AngerManagement = 21204, -- 152278
			HeavyRepercussions = 22406, -- 203177
			Ravager = 23099, -- 228920

        }
    },
    --Fury
    Fury = {
        Abilities = {
			Recklessness                          = {1719},
			FuriousSlash                          = {100130},
			-- RecklessAbandon                       = {202751},
			HeroicLeap                            = {6544},
			Siegebreaker                          = {280772},
			Rampage                               = {184367},
			Execute                               = {5308, 280735},
			Bloodthirst                           = {23881},
			RagingBlow                            = {85288},
			Bladestorm                            = {46924},
			DragonRoar                            = {118000},
			Whirlwind                             = {190411},
			Charge                                = {100},
			BloodFury                             = {20572},
			Berserking                            = {26297},
			LightsJudgment                        = {255647},
			Fireblood                             = {265221},
			AncestralCall                         = {274738},
			BagofTricks                           = {312411},
			Pummel                                = {6552},
			RallyingCry 						  = {97462},
			IntimidatingShout                     = {5246},
			ColdSteelHotBlood                     = {288080},
			BloodOfTheEnemy                       = {297108},
			PurifyingBlast                        = {295337},
			RippleInSpace                         = {302731},
			ConcentratedFlame                     = {295373},
			TheUnboundForce                       = {298452},
			WorldveinResonance                    = {295186},
			FocusedAzeriteBeam                    = {295258},
			GuardianofAzeroth                     = {295840},
			ReapingFlames                         = {310690},
        },
        Buffs = {
			Recklessness                      = {1719},
			SuddenDeathBuff                       = {280776},
			FuriousSlashBuff                     = {202539},
			MemoryofLucidDreams                   = {298357},
			Enrage                           = {184362},

			SiegebreakerDebuff                    = {280773},

			FujiedasFuryBuff                      = {207775},

			MeatCleaverBuff                     = {85739},

			GuardianofAzerothBuff                 = {295855},

			RecklessForceBuff                     = {302932},

        },
        Debuffs = {
			ConcentratedFlameBurn                 = 295368,
			RazorCoralDebuff                      = 303568,
			ConductiveInkDebuff                   = 302565,
			ColdSteelHotBlood = 288091


        },
        Talents = {

			WarMachine = 22632, -- 262231
			EndlessRage = 22633, -- 202296
			FreshMeat = 22491, -- 215568

			DoubleTime = 19676, -- 103827
			ImpendingVictory = 22625, -- 202168
			StormBolt = 23093, -- 107570

			InnerRage = 22379, -- 215573
			SuddenDeath = 22381, -- 280721
			FuriousSlash = 23372, -- 100130

			FuriousCharge = 23097, -- 202224
			BoundingStride = 22627, -- 202163
			Warpaint = 22382, -- 208154

			Carnage = 22383, -- 202922
			Massacre = 22393, -- 206315
			FrothingBerserker = 19140, -- 215571

			MeatCleaver = 22396, -- 280392
			DragonRoar = 22398, -- 118000
			Bladestorm = 22400, -- 46924

			RecklessAbandon = 22405, -- 202751
			AngerManagement = 22402, -- 152278
			Siegebreaker = 16037, -- 280772
		},
		Traits = {
			ColdSteel = 176
		}
    },
    --Arms
    Arms = {
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
	Shared = {
        Abilities = {
			BattleShout = {6673},
			VictoryRush = {34428},
			-- VictoryRush = {34428},

        },
        Buffs = {
			BattleShout = {6673},
        },
        Debuffs = {

        }
    }
}
