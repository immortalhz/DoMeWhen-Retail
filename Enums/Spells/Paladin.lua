local Spells = DMW.Enums.Spells

Spells.PALADIN = {
    --Protection
    Protection = {
        Abilities = {
            Judgement = {275779},
            ArdentDefender = {31850},
            CleanseToxins               = {213644},
            -- ShieldOfVengeance           = {53600},
            GuardianOfAncientKings = {86659},
            HammerOfRighteous = {53595},
            Rebuke                      = {96231},
            AvengerShield = {31935},
            Seraphim = {152262},
			HolyAvenger = {105809},
			BlessedHammer = {204019}
        },
        Buffs = {
			ShiningLight = {327510},
			ShiningLightStacks = {182104},
            Seraphim = {152262},
			Consecration = {188370},
			BulwarkSoR = {337848}
        },
        Debuffs = {

        },
        Talents = {
            HolyAvenger = 17599,
            Seraphim = 17601,
			DivinePurpose = 17597,
			BlessedHammer = 23469
        }
    },
    Retribution = {
        Abilities = {
            BladeOfJustice              = {184575},
            CleanseToxins               = {213644},
            DivineStorm                 = {53385},
            -- GreaterBlessingOfKings      = {203538},
            -- GreaterBlessingOfWisdom     = {203539},
            HandOfHinderance            = {183218},
            Judgement                   = {20271},
            Rebuke                      = {96231},
            ShieldOfVengeance           = {184662},
            TemplarsVerdict             = {85256},
            WakeOfAshes                 = {255937},
            Judgment                    = {275773},

        },
        Buffs = {
            -- Recklessness                      = {1719},
            -- GreaterBlessingOfKings      = {203538},
            -- GreaterBlessingOfWisdom     = {203539},
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
            HolyAvenger                 = {105809},
            Judgment                    = {275773},

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
            DivineSteed                 = {190784},
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
            WordOfGlory = {85673},
			ShieldOfTheRighteous = {53600},
			DivineToll = {304971}
        },
        Buffs = {
            DivineShield                = {642},
            DivineSteed                 = {221885},
            BlessingOfProtection        = {1022},
            ShieldOfTheRighteous = {132403},
            DivinePurpose               = {223819},
            DevotionAura = {465},
            CrusaderAura = {32223},
            AvengingWrath = {31884}

        },
        Debuffs = {
            Forbearance                 = 25771,
            HammerOfJustice             = 853,
            BlindingLight               = 105421,
            Consecration                = 204242
        }
    }
}
