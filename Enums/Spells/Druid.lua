local Spells = DMW.Enums.Spells

Spells.DRUID = {

    Balance = {
        Abilities = {
           Wrath = {190984},
           Starfire = {194153},
           Starsurge = {78674},
        },
        Buffs = {
            EclipseLunar = {48518},
            EclipseSonar = {48517}
        },
        Debuffs = {
            -- ConcentratedFlameBurn                 = 295368,
        },
        Talents = {
			-- WarMachine = 22632, -- 262231
			--
		},

	},
	Feral = {
        Abilities = {
           Berserk = {106951},
           BrutalSlash = {202028},
		   FeralFrenzy = {274837},
		   Maim = {22570},
		   Rake = {1822},
		   Rip = {1079},
		   SkullBash = {106839},
		   SurvivalInstincts = {61336},
		   Thrash = {106830},
		   TigersFury = {5217},
		   WildCharge = {49376},
		   Swipe = {213764},
		   MightyBash = {5211}
        },
        Buffs = {
            EclipseLunar = {48518},
			EclipseSonar = {48517},
			BloodTalons = {145152},
			PredatorySwiftness = {69369},
			Berserk = {106951}
        },
        Debuffs = {
			-- ConcentratedFlameBurn                 = 295368,
			Thrash = 106830
        },
        Talents = {
			-- WarMachine = 22632, -- 262231
			BloodTalons = 21649,
			BrutalSlash = 21711
		},

	},
	Guardian = {
        Abilities = {
           Berserk = {50334},
		   Maul = {6807},
		   FrenziedRegeneration = {22842},
		   Maim = {22570},
		   Rip = {1079},
		   SkullBash = {106839},
		   SurvivalInstincts = {61336},
		   WildCharge = {49376},
		   Swipe = {213764},
		   MightyBash = {5211},
		   Thrash = {106832},
           IncarnationGuardianOfUrsoc = {102558}
        },
        Buffs = {
            EclipseLunar = {48518},
			EclipseSonar = {48517},
			PredatorySwiftness = {69369},
			-- Berserk = {106951},
			GalacticGuardian = {213708},
            SurvivalInstincts = { 61336 },
			Berserk = {50334},

        },
        Debuffs = {
			-- ConcentratedFlameBurn                 = 295368,
			Thrash = 192090
        },
        Talents = {
			-- WarMachine = 22632, -- 262231
			BloodTalons = 21649,
			BrutalSlash = 21711,
            IncarnationGuardianOfUrsoc = 22388
		},

    },
    Restoration = {
        Abilities = {
            Swiftmend            = {18562},
            NaturesCure            = {88423},
            Ironbark            = {102342},
            Lifebloom            = {33763},
            WildGrowth = {48438},
            Wrath = {5176},
            Starfire = {197628},
            Starsurge = {197626},
            UrsolVortex = {102793},
            Tranquility = {740},
            Efflorence = {145205},
            FormMoonkin = {197625},
            Rip = {1079},
            Rake = {1822},
            Shred = {5221},
            FerociousBite = {22568},
            Swipe = {106832},
            Stealth = {5215}
        },
        Buffs = {
            WildGrowth                 = {183415},
            Ironbark            = {102342},
            Lifebloom            = {33763},
            Clearcasting = {16870},
            EclipseLunar = {48518},
            EclipseSonar = {48517},
            FormMoonkin = {197625},
            Stealth = {5215}

        },
        Debuffs = {
            -- GlimmerOfLight              = 287280
            Rip = 1079,
            Rake = 1822,
        },
        Talents = {
            BalanceAffinity = 22366,
            FeralAffinity = 22367,
            GuardianAffinity = 22160
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
            Moonfire = {8921},
            Regrowth = {8936},
            FormCat = {768},
            FormBear = {5487},
            FormTravel = {783},
            FormMoonkin = {24858},
            FormFly = {276029},
            Shred = {5221},
            FerociousBite = {22568},
            Mangle = {33917},
            Ressurection = {50769},
            Growl = {6795},
            Ironfur = {192081},
            Barkskin = {22812},
            RemoveCorruption = {2782},
            Sunfire = {93402},
            StampedingRoar = {77761},
            Typhoon = {132469},
			WildChargeCat = {102401},
			WildChargeTravel = {102417},
			Convoke = {323764},
			Prowl = {5215},
			Soothe = {2908},
			Rake = {1822},
			Rejuvenation            = {774},
        },
        Buffs = {
            FormCat = {768},
            FormBear = {5487},
            FormTravel = {783},
            FormMoonkin = {24858},
            FormFly = {276029},
			Regrowth = {8936},
			Prowl = {5215},
			Clearcasting = {135700},
			Ironfur = {192081},
			Rejuvenation            = {774},
        },
        Debuffs = {
            Moonfire  = 164812,
			Sunfire = 164815,
			Rake = 1822,
			Rip = 1079

        }
    }
}
