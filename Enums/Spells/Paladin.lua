local Spells = DMW.Enums.Spells

Spells.PALADIN = {
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

        }
    },
    Retribution = {
        Abilities = {
            BladeOfJustice              = {184575},
            CleanseToxins               = {213644},
            DivineStorm                 = {53385},
            GreaterBlessingOfKings      = {203538},
            GreaterBlessingOfWisdom     = {203539},
            HandOfHinderance            = {183218},
            Judgement                   = {20271},
            Rebuke                      = {96231},
            ShieldOfVengeance           = {184662},
            TemplarsVerdict             = {85256},
            WakeOfAshes                 = {255937}
        },
        Buffs = {
            -- Recklessness                      = {1719},
            GreaterBlessingOfKings      = {203538},
            GreaterBlessingOfWisdom     = {203539},
            SelflessHealer              = {114250}
        },
        Debuffs = {
			-- ConcentratedFlameBurn                 = 295368,
        },
        Talents = {
			-- WarMachine = 22632, -- 262231
			--
		},
		Traits = {
			-- ColdSteel = 176
		}
    },
    Holy = {
        Abilities = {
            MassRessurection            = {212056},
            AuraMastery                 = {31821},
            BeaconOfLight               = {53563},
            Cleanse                     = {4987},
            DivineProtection            = {498},
            HolyLight                   = {82326},
            HolyShock                   = {20473},
            HolyPrism                   = {114165},
            LightOfDawn                 = {85222},
            LightOfTheMartyr            = {183998},
            RuleOfLaw                   = {214202},
            Judgement                   = {275773},
            HolyAvenger                 = {105809}
        },
        Buffs = {
            AuraOfMercy                 = {183415},
            AuraMastery                 = {31821},
            AvengingWrath               = {31884},
            AvengingWrathCrit           = {294027},
            BeaconOfLight               = {53563},
            BeaconOfFaith               = {156910},
            BlessingOfSacrifice         = {6940},
            BeaconOfVirtue              = {200025},
            BestowFaith                 = {223306},
            GlimmerOfLight              = {287280},
            DivineProtection            = {498},
            DivinePurpose               = {223819},
            FerventMartyr               = {223316},
            InfusionOfLight             = {54149},
            HolyAvenger                 = {105809},
            RuleOfLaw                   = {214202},
            TheLightSaves               = {200423},
            Vindicator                  = {200376},
            avengingCrusader            = {216331},
            symbolOfHope                = {64901},
        },
        Debuffs = {
            Consecration                = 204242,
            GlimmerOfLight              = 287280
        },
        Talents = {

            CrusadersMight = 17565,
            BestowFaith = 17567,
            LightsHammer = 17569,

            SavedByTheLight = 22176,
            JudgmentOfLight = 17575,
            HolyPrism = 17577,

            FistOfJustice = 22179,
            Repentance = 22180,
            BlindingLight = 21811,

            UnbreakableSpirit = 22433,
            Cavalier = 22434,
            RuleOfLaw = 17593,

            DivinePurpose = 17597,
            HolyAvenger = 17599,
            Seraphim = 17601,

            -- SanctifiedWrath = , -- 23191, 23456, 23457
            AvengingCrusader = 22190,
            Awakening = 22484,

            GlimmerOfLight = 21201,
            BeaconOfFaith = 21671,
            BeaconOfVirtue = 21203,
		},
		Traits = {
			BreakingDawn                = 394,
            GraceoftheJusticar          = 393,
            IndomitableJustice          = 235,
            GlimmerOfLight              = 139
		}
    },
	Shared = {
        Abilities = {
            AvengingWrath               = {31884},
            BlessingOfFreedom           = {1044},
            BlessingOfProtection        = {1022},
            Contemplation               = {12118},
            CrusaderStrike              = {35395},
            DivineShield                = {642},
            DivineSteed                 = {19078},
            FlashOfLight                = {19750},
            HammerOfJustice             = {853},
            HandOfReckoning             = {62124},
            LayOnHands                  = {633},
            Redemption                  = {7328},
            Repentance                  = {20066},
            BlindingLight               = {115750},
            HammerOfWrath = {24275},
            DevotionAura = {465},
            CrusaderAura = {32223},
            RetributionAura = {183435},
            BlessingOfSacrifice         = {6940},
            TurnEvil = {10326},
            Consecration                = {26573},
            Judgment                    = {275773},
            WordOfGlory = {85673},
            ShieldOfTheRighteous = {53600}
        },
        Buffs = {
            DivineShield                = {642},
            DivineSteed                 = {221885},
            BlessingOfProtection        = {1022},
        },
        Debuffs = {
            Forbearance                 = 25771,
            HammerOfJustice             = 853,
            BlindingLight               = 105421,
            Consecration                = 204242
        }
    }
}
