Scriptname SLApproachConfigScript extends SKI_ConfigBase  

;WIP - Scan for people other than talking actor
;WIP - S Kiss
;WIP - Confess
;WIP - Staying Actor


SLApproachBaseQuestScript Property xscript Auto
Quest Property SLApproachAskForSexQuest Auto


String Property ResistType = "$Strafe" Auto Hidden
Int ResistTypeOID

Spell Property SLApproachSpankAura Auto
Spell Property SLApproachMolestAura Auto
Spell Property SLApproachSpankAura2nd Auto

Faction Property SLAX_BoobsTinyFaction Auto
Faction Property SLAX_BoobsNiceFaction Auto
Faction Property SLAX_BoobsAmazingFaction Auto
Faction Property SLAX_BoobsBigFaction Auto
Faction Property SLAX_BoobsFullFaction Auto
Faction Property SLAX_BoobsEnormousFaction Auto

Faction Property SLAX_FaceUglyFaction Auto
Faction Property SLAX_FacePlainFaction Auto
Faction Property SLAX_FaceAverageFaction Auto
Faction Property SLAX_FacePrettyFaction Auto
Faction Property SLAX_FaceBeautifulFaction Auto
Faction Property SLAX_FaceScarredFaction Auto

Faction Property SLAX_AssTinyFaction Auto
Faction Property SLAX_AssNiceFaction Auto
Faction Property SLAX_AssAmazingFaction Auto
Faction Property SLAX_AssBigFaction Auto

GlobalVariable Property sla_slsurvival Auto
GlobalVariable Property SLA_DDI Auto
GlobalVariable Property SLA_BaboDialogue Auto
GlobalVariable Property SLA_FillHerUp Auto
GlobalVariable Property SLA_SLHH Auto
GlobalVariable Property SLA_PeeandFart Auto

GlobalVariable Property SLA_BeeingFemale Auto;WIP
GlobalVariable Property SLA_SoulgemOven Auto
GlobalVariable Property SLA_Fertility Auto
GlobalVariable Property SLA_HentaiPregnancy Auto

GlobalVariable Property SLApproachStayingTime Auto
GlobalVariable Property SLANakedArmorToggle Auto
GlobalVariable Property SLAAppearanceSlide Auto
GlobalVariable Property SLABreastsSlide Auto
GlobalVariable Property SLAButtsSlide Auto

GlobalVariable Property SLApproachDialogArousal auto
GlobalVariable Property SLApproachMultiplayPercent  Auto 

GlobalVariable Property SLAStandardLevelMaximumNPCGlobal  Auto 
GlobalVariable Property SLAStandardLevelMinimumNPCGlobal  Auto 

GlobalVariable Property SLApproachMoralGlobal  Auto 
GlobalVariable Property SLApproachRelationGlobal  Auto 

GlobalVariable Property SLApproachUniqueActorGlobal  Auto 
GlobalVariable Property SLApproachOnlyInTownGlobal  Auto 

GlobalVariable Property SLApproachProstitutionBaseChance  Auto 
GlobalVariable Property SLApproachProstitutionMin  Auto 
GlobalVariable Property SLApproachProstitutionMax  Auto 
GlobalVariable Property SLApproachRapedTimes Auto
GlobalVariable Property SLApproachSpankTimes Auto
GlobalVariable Property SLApproachBackHugTimes Auto
GlobalVariable Property SLApproachBackHugMolestTimes Auto
GlobalVariable Property SLApproachSweetKissTimes Auto
GlobalVariable Property SLApproachForcedKissTimes Auto
GlobalVariable Property SLApproachAskNameTimes Auto
GlobalVariable Property SLApproachAskNameKidTimes Auto
GlobalVariable Property SLApproachAskSexTimes Auto
GlobalVariable Property SLApproachNormalSexTimes Auto
GlobalVariable Property SLApproachProstitutionTimes Auto
GlobalVariable Property SLApproachGiftTimes Auto
GlobalVariable Property SLADetectOutofSight Auto

GlobalVariable Property sla_Appearance Auto Hidden
GlobalVariable Property sla_BreastsScale Auto Hidden
GlobalVariable Property sla_ButtocksScale Auto Hidden

float property moral = 0.0 auto
float property moralmin = 0.0 auto
float property moralmax = 0.0 auto
float property Relation = 4.0 auto

Bool BaboDialogue_Installed
Bool FillHerUp_Installed
Bool SLHHExpansion_Installed
Bool SexlabSurvival_Installed
Bool DeviousDevicesIntegration_Installed
Bool PeeAndFart_Installed

int SLAOnlyInTownOID
int SLAUniqueActorOID
int SLALocktheDoorOID
int SLARemoveHeelEffectOID
int SexlabSurvivalIntegrationOID
int SexlabDDIIntegrationOID

int SLHHIntegrationOID
int BDIntegrationOID
int FHUIntegrationOID
int PeeAndFartIntegrationOID

int SLAmoralOID
int SLAmoralMinOID
int SLAmoralMaxOID
int SLARelationOID
int SLADeviationLevelOID

int cloakFrequencyOID
int SLApproachSpankAuraDurationOID
int SLApproachStruggleDifficultyOID
int SLApproachStruggleDurationOID 
int cloakRangeOID;Obsolete
int cloakSightOID 
int baseChanceMultiplierOID 
int totalAwarnessRangeOID

int debugLogFlagOID
int enableRapeFlagOID

int enableForceThirdPersonHugOID
int enableRelationChangeFlagOID ; no longer used
int enableElderRaceFlagOID
int enableGuardFlagOID
int enableHirelingFlagOID
int enableFollowerFlagOID
int enableThalmorFlagOID
int enableChildFlagOID
int enableDremoraFlagOID
int enableVisitorFlagOID
int enablePetsFlagOID
int enablePlayerHorseFlagOID

int SLALowerLevelNPCOID
int SLAHigherLevelNPCOID
int SLAStandardLevelNPCOID

int PCHairOID
int PCWeightOID
int PCAppearanceOID
int PCBreastsOID
int PCButtsOID

int NakedArmorOID
int ApproachNakedOID

int lowestArousalPCOID
int lowestArousalNPCOID

int dialogueArousalOID

int userAddingPointPcOID
int userAddingPointNpcOID

int userAddingRapePointPcOID
int userAddingRapePointNpcOID

int userAddingAskingNamePointPcOID
int userAddingSexualOffensePointPcOID

int SLARelationshipChanceOID
int SLADislikeChanceOID

int SLAAquaintanceChanceOID
int SLAHouseVisitChanceOID
int SLAHouseStayDaysOID

int SLApproachProstitutionBaseChanceOID
int SLApproachProstitutionMinOID
int SLApproachProstitutionMaxOID

int SLApproachAskNameTimesOID
int SLApproachAskNameKidTimesOID
int SLApproachAskSexTimesOID 
int SLApproachGiftTimesOID
int SLApproachRapedTimesOID 
int SLApproachSpankTimesOID 
int SLApproachBackHugTimesOID 
int SLApproachBackHugMolestTimesOID 

int SLApproachSweetKissTimesOID 
int SLApproachForcedKissTimesOID 
int SLApproachNormalSexTimesOID 
int SLApproachProstitutionTimesOID 

int multiplayPercentOID

int SLAppQuestScriptsOIDS

Perk Property SLAPPDoorLockKeyPerk Auto

int SLAUniqueBullyRiverwoodOID
int SLADeployBoysOID
int SLADeploySpoiledBoysOID
Bool SLAUniqueBullyRiverwood = false
Bool SLADeployBoys = false
Bool SLADeploySpoiledBoys = false

Quest Property SLApproachNPCManagement Auto

int SLAPPResetOID
int SLAPPResetTriggerOID
int SLAPPQTEResetOID
int SLAPPExportSettingsOID 
int SLAPPImportSettingsOID 
int SLAPPNoMoreApproachSpellOID 

Bool SLAPPResetToggle = false
Bool SLAPPResetTriggerToggle = false
Bool SLAPPQTEResetToggle = false
SLAPPResetScript Property SLAPPReset Auto
SLApproachMainScript Property SLApproachMain Auto

Faction BaboAggressiveBoyFriend

Quest Property SLApproach_ExternalMods Auto

String[] Property SLAppHairType Auto
String[] Property SLAppWeightType Auto
String[] Property SLAppHouseVisitListString Auto
int Weightint
int Hairint
int SLAppHouseVisitListInt
int SLAPPHouseVisitListOID

formlist Property SLApproachPlayerHouseBYOH01 Auto
formlist Property SLApproachPlayerHouseWhiterun Auto

Spell Property SLApproachNoApproachSpell Auto

Faction Property slapp_FillHerUpVagFaction Auto
Faction Property slapp_FillHerUpAnalFaction Auto
Faction Property slapp_FillHerUpOralFaction Auto
Faction Property slapp_TraitWeightfaction Auto
Faction Property slapp_TraitHairfaction Auto

Faction FHUVagfaction
Faction FHUAnalfaction
Faction FHUOralfaction

Event OnConfigClose()
	If SLAPPResetToggle
		SLAPPResetToggle = false
		SetToggleOptionValue(SLAPPResetOID, 0)
		SLAPPReset.ResetQuest()
	EndIf
	
	If SLAPPQTEResetToggle
		SLAPPQTEResetToggle = false
		SetToggleOptionValue(SLAPPQTEResetOID, 0)
		(SLApproachAskForSexQuest as SLAppPCSexQuestScript).StruggleBarDisplay(false)
	EndIf
EndEvent

int Function GetVersion()
	return 3
EndFunction

Event OnVersionUpdate(int newVersion)
	If CurrentVersion > 2
		PageReset()
		Debug.notification("$SLAppVersion")
	EndIf
EndEvent

Event OnGameReload()
	parent.OnGameReload()
	VerifyMods()
	SLAPPForexternalmods()
EndEvent

Event OnConfigInit()
	PageReset()
EndEvent

Function PageReset()
	Pages = new string[5]
	Pages[0] = "$SLAppGeneral"
	Pages[1] = "$SLAppQuests"
	Pages[2] = "$SLAppCompatibility"
	Pages[3] = "$SLAppStatistics"
	Pages[4] = "$SLAppDebug"

	SLAppHairType = new String[7]
	SLAppHairType[0] = "$SLAppHairType01"; N/A
	SLAppHairType[1] = "$SLAppHairType02"
	SLAppHairType[2] = "$SLAppHairType03"
	SLAppHairType[3] = "$SLAppHairType04"
	SLAppHairType[4] = "$SLAppHairType05"
	SLAppHairType[5] = "$SLAppHairType06"
	SLAppHairType[6] = "$SLAppHairType07"
	
	SLAppWeightType = new String[8]
	SLAppWeightType[0] = "$SLAppWeightType01"
	SLAppWeightType[1] = "$SLAppWeightType02"
	SLAppWeightType[2] = "$SLAppWeightType03"
	SLAppWeightType[3] = "$SLAppWeightType04"
	SLAppWeightType[4] = "$SLAppWeightType05"
	SLAppWeightType[5] = "$SLAppWeightType06"
	SLAppWeightType[6] = "$SLAppWeightType07"
	SLAppWeightType[7] = "$SLAppWeightType08"

	SLAppHouseVisitListString = new String[8]
	SLAppHouseVisitListString[0] = "$SLAppHouseVisitList00"
	SLAppHouseVisitListString[1] = "$SLAppHouseVisitList01"
	SLAppHouseVisitListString[2] = "$SLAppHouseVisitList02"
	SLAppHouseVisitListString[3] = "$SLAppHouseVisitList03"
	SLAppHouseVisitListString[4] = "$SLAppHouseVisitList04"
	SLAppHouseVisitListString[5] = "$SLAppHouseVisitList05"
	SLAppHouseVisitListString[6] = "$SLAppHouseVisitList06"
	SLAppHouseVisitListString[7] = "$SLAppHouseVisitList07"
EndFunction

Function VerifyMods()
	BaboDialogue_Installed = Quest.Getquest("BaboDialogueMCM") as Bool
	FillHerUp_Installed = Quest.Getquest("sr_inflateQuest") as Bool
	SLHHExpansion_Installed = Quest.GetQuest("SLHH") as Bool
	SexlabSurvival_Installed = Quest.Getquest("_SLS_Main") as Bool
	DeviousDevicesIntegration_Installed = Game.GetModByName("Devious Devices - Integration.esm") != 255
	PeeAndFart_Installed = Quest.Getquest("PAF_MainQuest") as Bool
EndFunction

Function BaboDialogueLoadData()
	if SLA_BaboDialogue.getvalue() == 1
		sla_Appearance = Game.GetFormFromFile(0x303B1D, "BaboInteractiveDia.esp") as GlobalVariable
		sla_BreastsScale = Game.GetFormFromFile(0x303B1E, "BaboInteractiveDia.esp") as GlobalVariable
		sla_ButtocksScale = Game.GetFormFromFile(0x303B1F, "BaboInteractiveDia.esp") as GlobalVariable
			
		SLAAppearanceSlide.setvalue(sla_Appearance.getvalue())
		SLABreastsSlide.setvalue(sla_BreastsScale.getvalue())
		SLAButtsSlide.setvalue(sla_ButtocksScale.getvalue())
			
		SLApproachMain.BaboAggressiveBoyFriend = Game.GetFormFromFile(0x00BA9DDA, "BabointeractiveDia.esp") as Faction
		SLApproachMain.BaboDialogueFaction = Game.GetFormFromFile(0x00D58522, "BabointeractiveDia.esp") as Faction;BaboDialogueFaction
		SLApproachMain.BaboViceGuardCaptainFaction = Game.GetFormFromFile(0x00B71E3E, "BabointeractiveDia.esp") as Faction;BaboViceGuardCaptainFaction
		SLApproachMain.BaboWasHireling = Game.GetFormFromFile(0x00D6272A, "BabointeractiveDia.esp") as Faction;BaboWasHireling
		SLApproachMain.BaboPotentialHireling = Game.GetFormFromFile(0x00D62725, "BabointeractiveDia.esp") as Faction;BaboPotentialHireling
		SLApproachMain.BaboCurrentHireling = Game.GetFormFromFile(0x00C92D9D, "BabointeractiveDia.esp") as Faction;BaboCurrentHireling
		SLApproachMain.BaboAnonymousSlaverFaction = Game.GetFormFromFile(0x00B347B7, "BabointeractiveDia.esp") as Faction;BaboAnonymousSlaverFaction
		SLApproachMain.BaboAnonymousSlaverGuardFaction = Game.GetFormFromFile(0x00C0A244, "BabointeractiveDia.esp") as Faction;BaboAnonymousSlaverGuardFaction
		SLApproachMain.BaboKidnapCaptiveFaction = Game.GetFormFromFile(0x00965D4A, "BabointeractiveDia.esp") as Faction;BaboKidnapCaptiveFaction
		SLApproachMain.BaboChestWhiterunRef = Game.GetFormFromFile(0x00e46567, "BabointeractiveDia.esp") as objectreference
	endif
EndFunction

Function FillHerUpLoadData()
	if SLA_FillHerUp.getvalue() == 1
		FHUVagfaction = Game.GetFormFromFile(0x00A991, "sr_FillHerUp.esp") as Faction
		FHUOralfaction = Game.GetFormFromFile(0x14204B, "sr_FillHerUp.esp") as Faction
		
		Game.getplayer().setfactionrank(slapp_FillHerUpVagFaction, Game.getplayer().getfactionrank(FHUVagfaction))
		Game.getplayer().setfactionrank(slapp_FillHerUpOralFaction, Game.getplayer().getfactionrank(FHUOralfaction))
	endif
EndFunction

Function SLAPPForexternalmods()
	if BaboDialogue_Installed
		BaboDialogueLoadData()
	endif
	if FillHerUp_Installed
		FillHerUpLoadData()
	endif
EndFunction

Function DisplayBaboPage()
	UnloadCustomContent()
	LoadCustomContent("SLAPP/SLAPPCover.dds",120,0)
EndFunction

event OnPageReset(string page)

	If Page == ("")
	
		DisplayBaboPage()
	
	ElseIf (page == "$SLAppGeneral")
	UnloadCustomContent()
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)
		
		AddHeaderOption("$SLAAppearanceSetting")
		
		PCAppearanceOID =  AddSliderOption("$SLAAppearance", SLAAppearanceSlide.getvalue(), "{0}")
		PCBreastsOID =  AddSliderOption("$SLABreasts", SLABreastsSlide.getvalue(), "{0}")
		PCButtsOID =  AddSliderOption("$SLAButts", SLAButtsSlide.getvalue(), "{0}")
		AddEmptyOption()
		PCWeightOID = AddMenuOption("$SLAppWeightType", SLAppWeightType[Weightint])
		PCHairOID = AddMenuOption("$SLAppHairType", SLAppHairType[Hairint])

		AddHeaderOption("$SLAppGeneral")
		
		cloakFrequencyOID =  AddSliderOption("$CloakFrequency", SLApproachMain.cloakFrequency, "$per0sec")
		cloakSightOID =  AddToggleOption("$CloakSight", SLADetectOutofSight.getvalue())
		baseChanceMultiplierOID =  AddSliderOption("$BaseChanceMultiplier", SLApproachMain.baseChanceMultiplier, "{1}")
		
		SLApproachSpankAuraDurationOID =  AddSliderOption("$SLApproachSpankAuraDuration", SLApproachMain.SLApproachSpankAuraDuration, "{1}sec")

		AddHeaderOption("$SLAppONOFF")

		enableRapeFlagOID = AddToggleOption("$EnableRape", SLApproachMain.enableRapeFlag)
		enableElderRaceFlagOID = AddToggleOption("$EnableElderRace", SLApproachMain.enableElderRaceFlag)
		enableFollowerFlagOID = AddToggleOption("$EnableFollowers", SLApproachMain.enableFollowerFlag)
		enableHirelingFlagOID = AddToggleOption("$EnableHireling", SLApproachMain.enableHirelingFlag)
		enableGuardFlagOID = AddToggleOption("$EnableGuard", SLApproachMain.enableGuardFlag)
;		enableChildFlagOID = AddToggleOption("$EnableChild", SLApproachMain.enableChildFlag); No more supports
		enableDremoraFlagOID = AddToggleOption("$EnableDremora", SLApproachMain.enableDremoraFlag)
;		enableThalmorFlagOID = AddToggleOption("$EnableThalmor", SLApproachMain.enableThalmorFlag) WIP
		
		NakedArmorOID = AddToggleOption("$SLANakedArmor", SLApproachMain.SLANakedArmor)
		ApproachNakedOID = AddToggleOption("$SLAApproachNaked", SLApproachMain.enableApproachNakedFlag)

		SetCursorPosition(1)

		AddHeaderOption("$SLAppArousal")
		
		lowestArousalPCOID = AddSliderOption("$LowestArousalPC", SLApproachMain.lowestArousalPC)
		lowestArousalNPCOID = AddSliderOption("$LowestArousalNPC", SLApproachMain.lowestArousalNPC)
		dialogueArousalOID = AddSliderOption("$DialogueArousal", SLApproachDialogArousal.GetValue())
		
		AddHeaderOption("$SLAppMorality")
		
		SLAmoralOID =  addslideroption("Morality:", moral, "{0.0}")
		SLAmoralMinOID =  addslideroption("CharacterMin:", SLApproachMain.SLANPCCharacterMin, "{0.0}")
		SLAmoralMaxOID =  addslideroption("CharacterMax:", SLApproachMain.SLANPCCharacterMax, "{0.0}")
		SLARelationOID =  addslideroption("Relation:", Relation, "{0.0}")
		
		AddHeaderOption("$SLAppETC")
		
		SLAOnlyInTownOID = AddToggleOption("$SLAOnlyInTown", SLApproachMain.SLAOnlyInTown)
		SLAUniqueActorOID = AddToggleOption("$SLAUniqueActor", SLApproachMain.SLAUniqueActor)

		SLApproachStruggleDifficultyOID =  AddSliderOption("$SLApproachStruggleDifficulty", SLApproachMain.SLAPStrafeDifficulty, "{0}")
		SLApproachStruggleDurationOID =  AddSliderOption("$SLApproachStruggleDuration", SLApproachMain.SLAPStruggleDuration, "{0}")

;		enableForceThirdPersonHugOID = AddToggleOption("$EnableForceThirdPersonHug", SLApproachMain.enableForceThirdPersonHug)
		SLApproachProstitutionMinOID = AddSliderOption("$SLApproachProstitutionMin", SLApproachProstitutionMin.getvalue() as int, "{1}")
		SLApproachProstitutionMaxOID = AddSliderOption("$SLApproachProstitutionMax", SLApproachProstitutionMax.getvalue() as int, "{1}")
		SLApproachProstitutionBaseChanceOID = AddSliderOption("$SLApproachProstitutionBaseChance", SLApproachProstitutionBaseChance.getvalue() as int, "{1}")
		
		SLARemoveHeelEffectOID = AddToggleOption("$SLARemoveHeelEffect", SLApproachMain.SLARemoveHeelEffect)
		SLALocktheDoorOID = AddToggleOption("$SLALocktheDoor", SLApproachMain.SLALocktheDoor)
		
		debugLogFlagOID = AddToggleOption("$OutputPapyrusLog", SLApproachMain.debugLogFlag)

	elseif (page == "$SLAppQuests")
	UnloadCustomContent()
		SetCursorFillMode(TOP_TO_BOTTOM)

		SetCursorPosition(0)
		AddHeaderOption("$RegisteredApproachQuests")
		
		SLAppQuestScriptsOIDS = AddToggleOption("$SLAPCQuest", !xscript.isSkipMode)
		
;		int indexCounter = 0 ; Not gonna use it until the NPC sex is complete
;		int amount = SLApproachMain.getRegisteredAmount()
;		SLAppQuestScriptsOIDS = new int[8]
		
;		while (indexCounter != amount)
;			SLApproachBaseQuestScript xscript = SLApproachMain.getApproachQuestScript(indexCounter)
;			SLAppQuestScriptsOIDS[indexCounter] = AddToggleOption(xscript.ApproachName, !xscript.isSkipMode)
;			indexCounter += 1
;		endwhile

		AddEmptyOption()
		AddHeaderOption("$RegisteredQuestsCommonOptions")

		multiplayPercentOID =  AddSliderOption("$SLAppMultiplayPercent", SLApproachMultiplayPercent.GetValue())

		AddHeaderOption("$SLAppUniqueNPC")
		;SLAUniqueBullyRiverwoodOID = AddToggleOption("$SLAUniqueBullyRiverwood", SLAUniqueBullyRiverwood) Experimental
		;SLADeployBoysOID = AddToggleOption("$SLADeployBoys", SLADeployBoys);No more supports
		;SLADeploySpoiledBoysOID = AddToggleOption("$SLADeploySpoiledBoys", SLADeploySpoiledBoys);No more supports
		
		AddHeaderOption("$SLAppHouseVisit")
		
		SLAHouseVisitChanceOID =  AddSliderOption("$SLAHouseVisitChance", SLApproachMain.SLAHouseVisitChance, "{0}")
		SLAHouseStayDaysOID =  AddSliderOption("$SLAHouseStayDays", SLApproachStayingTime.getvalue(), "{0}")
		enableVisitorFlagOID = AddToggleOption("$EnableVisitor", SLApproachMain.enableVisitorFlag)
		
		AddHeaderOption("$SLAppResistKey")
		
		ResistTypeOID = AddTextOption("$ResistHotkey", ResistType)

		SetCursorPosition(1)
		AddHeaderOption("$RegisteredQuestsOptions")
				
		SLAHigherLevelNPCOID = AddToggleOption("$SLAHigherLevelNPC", SLApproachMain.SLAHigherLevelNPC)
		SLALowerLevelNPCOID = AddToggleOption("$SLALowerLevelNPC", SLApproachMain.SLALowerLevelNPC)
		SLAStandardLevelNPCOID = AddToggleOption("$SLAStandardLevelNPC", SLApproachMain.SLAStandardLevelNPC)
		SLADeviationLevelOID =  AddSliderOption("$SLADeviationLevel", SLApproachMain.SLADeviationLevel, "{0}")
		
		userAddingPointPcOID =  AddSliderOption("$AddingPointsNPCPC", SLApproachMain.userAddingPointPc, "{0}")
		userAddingRapePointPcOID =  AddSliderOption("$AddingRapePointsNPCPC", SLApproachMain.userAddingRapePointPc, "{0}")
		userAddingAskingNamePointPcOID =  AddSliderOption("$AddingAskingNamePointsNPCPC", SLApproachMain.userAddingAskingNamePointPc, "{0}")
		userAddingSexualOffensePointPcOID =  AddSliderOption("$AddingSexualOffensePointsNPCPC", SLApproachMain.userAddingSpankingAssPointPc, "{0}")
		
		SLARelationshipChanceOID =  AddSliderOption("$SLARelationshipChance", SLApproachMain.SLARelationshipChance, "{0}")
		SLAAquaintanceChanceOID =  AddSliderOption("$SLAAquaintanceChance", SLApproachMain.SLAAquaintanceChance, "{0}")
		SLADislikeChanceOID =  AddSliderOption("$SLADislikeChance", SLApproachMain.SLADislikeChance, "{0}")

;		userAddingPointNpcOID =  AddSliderOption("$AddingPointsNPCNPC", SLApproachMain.userAddingPointNpc, "{0}")
;		userAddingRapePointNpcOID =  AddSliderOption("$AddingRapePointsNPCNPC", SLApproachMain.userAddingRapePointNpc, "{0}")


	elseif (page == "$SLAppCompatibility")
	UnloadCustomContent()
		SetCursorFillMode(TOP_TO_BOTTOM)

		SetCursorPosition(0)
		AddHeaderOption("$SexlabmodsCompatibility")

		If SLHHExpansion_Installed
			SLHHIntegrationOID = AddToggleOption("$SLHHIntegration", SLApproachMain.enableSLHHFlag)
		Else
			SLApproachMain.enableSLHHFlag = false
			SetToggleOptionValue(SLHHIntegrationOID, SLApproachMain.enableSLHHFlag)
			SLA_SLHH.setvalue(0)
			SLHHIntegrationOID = AddToggleOption("$SLHHIntegration", SLApproachMain.enableSLHHFlag, OPTION_FLAG_DISABLED)
		Endif
		
		If BaboDialogue_Installed
			BDIntegrationOID = AddToggleOption("$BDIntegration", SLApproachMain.enableBDFlag)
		Else
			SLApproachMain.enableBDFlag = false
			SetToggleOptionValue(BDIntegrationOID, SLApproachMain.enableBDFlag)
			SLA_BaboDialogue.setvalue(0)
			BDIntegrationOID = AddToggleOption("$BDIntegration", SLApproachMain.enableBDFlag, OPTION_FLAG_DISABLED)
		Endif
		
		If FillHerUp_Installed
			FHUIntegrationOID = AddToggleOption("$FHUIntegration", SLApproachMain.enableFHUFlag)
		Else
			SLApproachMain.enableFHUFlag = false
			SetToggleOptionValue(FHUIntegrationOID, SLApproachMain.enableFHUFlag)
			SLA_FillHerUp.setvalue(0)
			FHUIntegrationOID = AddToggleOption("$FHUIntegration", SLApproachMain.enableFHUFlag, OPTION_FLAG_DISABLED)
		Endif

		If SexlabSurvival_Installed
			SexlabSurvivalIntegrationOID = AddToggleOption("$SexlabSurvivalIntegration", SLApproachMain.enableSexlabSurvivalFlag)
		Else
			SLApproachMain.enableSexlabSurvivalFlag = false
			SetToggleOptionValue(SexlabSurvivalIntegrationOID, SLApproachMain.enableSexlabSurvivalFlag)
			sla_slsurvival.setvalue(0)
			SexlabSurvivalIntegrationOID = AddToggleOption("$SexlabSurvivalIntegration", SLApproachMain.enableSexlabSurvivalFlag, OPTION_FLAG_DISABLED)
		Endif
		
		If DeviousDevicesIntegration_Installed
			SexlabDDIIntegrationOID = AddToggleOption("$SexlabDDIIntegration", SLApproachMain.enableDDIFlag)
		Else
			SLApproachMain.enableDDIFlag = false
			SetToggleOptionValue(SexlabDDIIntegrationOID, SLApproachMain.enableDDIFlag)
			SLA_DDI.setvalue(0)
			SexlabDDIIntegrationOID = AddToggleOption("$SexlabDDIIntegration", SLApproachMain.enableDDIFlag, OPTION_FLAG_DISABLED)
		Endif
		
		If PeeAndFart_Installed
			PeeAndFartIntegrationOID = AddToggleOption("$PeeAndFartIntegration", SLApproachMain.enablePAF)
		Else
			SLApproachMain.enablePAF = false
			SetToggleOptionValue(PeeAndFartIntegrationOID, SLApproachMain.enablePAF)
			SLA_PeeandFart.setvalue(0)
			PeeAndFartIntegrationOID = AddToggleOption("$PeeAndFartIntegration", SLApproachMain.enablePAF, OPTION_FLAG_DISABLED)
		Endif
		
		
	elseif (page == "$SLAppStatistics")
		SetCursorFillMode(TOP_TO_BOTTOM)

		SetCursorPosition(0)
		AddHeaderOption("$SLAPPApproachStatistics")
		SLApproachAskNameTimesOID = Addtextoption("$SLApproachAskNameTimes", (SLApproachAskNameTimes.getvalue() as int) as string)
		;SLApproachAskNameKidTimesOID = Addtextoption("$SLApproachAskNameKidTimes", (SLApproachAskNameKidTimes.getvalue() as int) as string)
		SLApproachAskSexTimesOID = Addtextoption("$SLApproachAskSexTimes", (SLApproachAskSexTimes.getvalue() as int) as string)
		SLApproachGiftTimesOID = Addtextoption("$SLApproachGiftTimes", (SLApproachGiftTimes.getvalue() as int) as string)
		AddHeaderOption("$SLAPPSexStatistics")
		SLApproachSpankTimesOID = Addtextoption("$SLApproachSpankTimes", (SLApproachSpankTimes.getvalue() as int) as string)
		SLApproachBackHugTimesOID = Addtextoption("$SLApproachBackHugTimes", (SLApproachBackHugTimes.getvalue() as int) as string)
		SLApproachBackHugMolestTimesOID = Addtextoption("$SLApproachBackHugMolestTimes", (SLApproachBackHugMolestTimes.getvalue() as int) as string)
		
		SLApproachSweetKissTimesOID = Addtextoption("$SLApproachSweetKissTimes", (SLApproachSweetKissTimes.getvalue() as int) as string)
		SLApproachForcedKissTimesOID = Addtextoption("$SLApproachForcedKissTimes", (SLApproachForcedKissTimes.getvalue() as int) as string)
		
		SLApproachRapedTimesOID = Addtextoption("$SLApproachRapedTimes", (SLApproachRapedTimes.getvalue() as int) as string)
		SLApproachNormalSexTimesOID = Addtextoption("$SLApproachNormalSexTimes", (SLApproachNormalSexTimes.getvalue() as int) as string)
		AddHeaderOption("$SLAPPProstitutionStatistics")
		SLApproachProstitutionTimesOID = Addtextoption("$SLApproachProstitutionTimes", (SLApproachProstitutionTimes.getvalue() as int) as string)
	elseif (page == "$SLAppDebug")
	UnloadCustomContent()
		SetCursorFillMode(TOP_TO_BOTTOM)
		
		SetCursorPosition(0)
		AddHeaderOption("$SLAPPEmergency")
		;SLAPPHouseVisitListOID = AddMenuOption("$SLAppHouseVisitList", SLAppHouseVisitListString[SLAppHouseVisitListInt]) Experimental
		SLAPPNoMoreApproachSpellOID = AddTextOption("$SLAPPNoMoreApproachSpell", "$CLICK")
		SLAPPQTEResetOID = AddToggleOption("$SLAPPQTEReset", SLAPPQTEResetToggle)
		SLAPPExportSettingsOID = AddTextOption("$SLAPPExportSettings", "$CLICK")
		SLAPPImportSettingsOID = AddTextOption("$SLAPPImportSettings", "$CLICK")
		SLAPPResetOID = AddToggleOption("$SLAPPReset", SLAPPResetToggle)
		SLAPPResetTriggerOID = AddToggleOption("$SLAPPResetTrigger", SLAPPResetTriggerToggle)
		AddTextOption("Current scene: " + Game.getplayer().GetCurrentScene(), "", OPTION_FLAG_DISABLED)
		AddTextOption("$CurrentSceneInfo", OPTION_FLAG_DISABLED)
	endif
endevent

Event OnOptionDefault(int option)
	If Option == PCWeightOID
		Weightint = 0
		Game.getplayer().Setfactionrank(slapp_TraitWeightfaction, Weightint)
		SetMenuOptionValue(Option, SLAppWeightType[Weightint])
	endif
	If Option == PCHairOID
		Hairint = 0
		Game.getplayer().Setfactionrank(slapp_TraitHairfaction, Hairint)
		SetMenuOptionValue(Option, SLAppHairType[Hairint])
	endif
EndEvent

Event OnOptionMenuAccept(Int OptionID, Int MenuItemIndex)
	If OptionID == SLAPPHouseVisitListOID
		If MenuItemIndex >= 0 && MenuItemIndex < SLAppHouseVisitListString.Length
			SetMenuOptionValue(OptionID, SLAppHouseVisitListString[MenuItemIndex])
			SLAppHouseVisitListInt = MenuItemIndex
			
			if MenuItemIndex == 0
				SLApproachPlayerHouseWhiterun.getsize()
			elseif MenuItemIndex == 1
				actor House0 = SLApproachPlayerHouseBYOH01.getat(0) as actor
				actor House1 = SLApproachPlayerHouseBYOH01.getat(1) as actor
				actor House2 = SLApproachPlayerHouseBYOH01.getat(2) as actor
				String House0String = House0.GetBaseObject().GetName()
				String House1String = House1.GetBaseObject().GetName()
				String House2String = House2.GetBaseObject().GetName()
				String msg = House0 + ", " + House1 + ", " + House2 + ", "
				ShowMessage(msg, true, "Yes", "No")
			endif
			
		EndIf
	elseif OptionID == PCWeightOID
		If MenuItemIndex >= 0 && MenuItemIndex < SLAppWeightType.Length
			SetMenuOptionValue(OptionID, SLAppWeightType[MenuItemIndex])
			Weightint = MenuItemIndex
			Game.getplayer().Setfactionrank(slapp_TraitWeightfaction, Weightint)
		EndIf
	elseif OptionID == PCHairOID
		If MenuItemIndex >= 0 && MenuItemIndex < SLAppHairType.Length
			SetMenuOptionValue(OptionID, SLAppHairType[MenuItemIndex])
			Hairint = MenuItemIndex
			Game.getplayer().Setfactionrank(slapp_TraitHairfaction, Hairint)
		EndIf
	Endif
Endevent

Event OnOptionMenuOpen(Int OptionID)
	if OptionID == SLAPPHouseVisitListOID
		SetMenuDialogOptions(SLAppHouseVisitListString)
		SetMenuDialogStartIndex(SLAppHouseVisitListInt)
		SetMenuDialogDefaultIndex(0)
	elseif OptionID == PCWeightOID
		SetMenuDialogOptions(SLAppWeightType)
		SetMenuDialogStartIndex(Weightint)
		SetMenuDialogDefaultIndex(0)
	elseif OptionID == PCHairOID
		SetMenuDialogOptions(SLAppHairType)
		SetMenuDialogStartIndex(Hairint)
		SetMenuDialogDefaultIndex(0)
	Endif
EndEvent

Event OnOptionHighlight(int option)
	if (option == baseChanceMultiplierOID)
		SetInfoText("$BaseChanceMultiplierInfo")
	elseif (option == cloakSightOID)
		SetInfoText("$CloakSightInfo")
	elseif (option == enableRapeFlagOID)
		SetInfoText("$EnableRapeInfo")
	elseif (option == SLHHIntegrationOID)
		SetInfoText("$SLHHIntegrationInfo")
	elseif (option == BDIntegrationOID)
		SetInfoText("$BDIntegrationInfo")
	elseif (option == FHUIntegrationOID)
		SetInfoText("$FHUIntegrationInfo")
	elseif (option == SexlabSurvivalIntegrationOID)
		SetInfoText("$SexlabSurvivalIntegrationInfo")
	elseif (option == SexlabDDIIntegrationOID)
		SetInfoText("$SexlabDDIIntegrationInfo")
	elseif (option == PeeAndFartIntegrationOID)
		SetInfoText("$PeeAndFartIntegrationInfo")
	elseif (option == PCWeightOID)
		SetInfoText("$PCWeightInfo")
	elseif (option == enablePetsFlagOID)
		SetInfoText("$EnablePetsInfo")
	elseif (option == enablePlayerHorseFlagOID)
		SetInfoText("$EnablePlayerHorseInfo")
	elseif (option == enableForceThirdPersonHugOID)
		SetInfoText("$EnableForceThirdPersonHugInfo")
	elseif (option == enableGuardFlagOID)
		SetInfoText("$EnableGuardInfo")
	elseif (option == enableChildFlagOID)
		SetInfoText("$EnableChildInfo")
	elseif (option == enableDremoraFlagOID)
		SetInfoText("$EnableDremoraInfo")
	elseif (option == enableVisitorFlagOID)
		SetInfoText("$EnableVisitorInfo")	
	elseif (option == enableHirelingFlagOID)
		SetInfoText("$EnableHirelingInfo")
	elseif (option == enableFollowerFlagOID)
		SetInfoText("$EnableFollowerInfo")
	elseif (option == enableThalmorFlagOID)
		SetInfoText("$EnableThalmorInfo")
	elseif (option == userAddingPointPcOID)
		SetInfoText("$AddingPointsNPCPCInfo")
	elseif (option == SLALowerLevelNPCOID)
		SetInfoText("$SLALowerLevelNPCInfo")
	elseif (option == SLAHigherLevelNPCOID)
		SetInfoText("$SLAHigherLevelNPCInfo")
	elseif (option == SLAStandardLevelNPCOID)
		SetInfoText("$SLAStandardLevelNPCInfo")
	elseif (option == SLADeviationLevelOID)
		SetInfoText("$SLADeviationLevelInfo")
	elseif (option == userAddingPointNpcOID)
		SetInfoText("$AddingPointsNPCNPCInfo")
	elseif (option == userAddingRapePointPcOID)
		SetInfoText("$AddingRapePointsNPCPCInfo")
	elseif (option == userAddingRapePointNpcOID)
		SetInfoText("$AddingRapePointsNPCNPCInfo")
	elseif (option == SLARelationshipChanceOID)
		SetInfoText("$SLARelationshipChanceInfo")
	elseif (option == userAddingAskingNamePointPcOID)
		SetInfoText("$AddingAskingNamePointsNPCPCInfo")
	elseif (option == userAddingSexualOffensePointPcOID)
		SetInfoText("$AddingSexualOffensePointsNPCPCInfo")
	elseif (option == SLADislikeChanceOID)
		SetInfoText("$SLADislikeChanceInfo")
	elseif (option == SLAAquaintanceChanceOID)
		SetInfoText("$SLAAquaintanceChanceInfo")
	elseif (option == SLAHouseVisitChanceOID)
		SetInfoText("$SLAHouseVisitChanceInfo")
	elseif (option == SLAHouseStayDaysOID)
		SetInfoText("$SLAHouseStayDaysInfo")
	elseif (option == lowestArousalPCOID)
		SetInfoText("$LowestArousalPCInfo")
	elseif (option == lowestArousalNPCOID)
		SetInfoText("$LowestArousalNPCInfo")
	elseif (option == dialogueArousalOID)
		SetInfoText("$DialogueArousalInfo")
	elseif (option == multiplayPercentOID)
		SetInfoText("$SLAppMultiplayPercentInfo")
	elseif (option == PCAppearanceOID)
		SetInfoText("$SLAAppearanceInfo")
	elseif (option == PCBreastsOID)
		SetInfoText("$SLABreastsInfo")
	elseif (option == PCButtsOID)
		SetInfoText("$SLAButtsInfo")
	elseif (option == NakedArmorOID)
		SetInfoText("$SLANakedArmorInfo")
	elseif (option == ApproachNakedOID)
		SetInfoText("$SLAApproachNakedInfo")
	elseif (option == SLAUniqueActorOID)
		SetInfoText("$SLAUniqueActorinfo")
	elseif (option == SLAOnlyInTownOID)
		SetInfoText("$SLAOnlyInTowninfo")
	elseif (option == SLALocktheDoorOID)
		SetInfoText("$SLALocktheDoorinfo")
	elseif (option == SLARemoveHeelEffectOID)
		SetInfoText("$SLARemoveHeelEffectinfo")
	elseif (option == SLAmoralOID)
		SetInfoText("$SLAmoralInfo")
	elseif (option == SLAmoralMinOID)
		SetInfoText("$SLAmoralMinInfo")
	elseif (option == SLAmoralMaxOID)
		SetInfoText("$SLAmoralMaxInfo")
	elseif (option == SLARelationOID)
		SetInfoText("$SLARelationInfo")
	elseif (option == SLAppQuestScriptsOIDS)
		SetInfoText("$SLAPCQuestInfo")
	elseif (option == SLApproachAskNameTimesOID)
		SetInfoText("$SLApproachAskNameTimesInfo")
	elseif (option == SLApproachAskNameKidTimesOID)
		SetInfoText("$SLApproachAskNameKidTimesInfo")
	elseif (option == SLApproachAskSexTimesOID)
		SetInfoText("$SLApproachAskSexTimesInfo")
	elseif (option == SLApproachGiftTimesOID)
		SetInfoText("$SLApproachGiftTimesInfo")
	elseif (option == SLApproachNormalSexTimesOID)
		SetInfoText("$SLApproachNormalSexTimesInfo")
	elseif (option == SLApproachRapedTimesOID)
		SetInfoText("$SLApproachRapedTimesInfo")
	elseif (option == SLApproachSpankTimesOID)
		SetInfoText("$SLApproachSpankTimesInfo")
	elseif (option == SLApproachBackHugTimesOID)
		SetInfoText("$SLApproachBackHugTimesInfo")
	elseif (option == SLApproachBackHugMolestTimesOID)
		SetInfoText("$SLApproachBackHugMolestTimesInfo")
	elseif (option == SLApproachSweetKissTimesOID)
		SetInfoText("$SLApproachSweetKissTimesInfo")
	elseif (option == SLApproachForcedKissTimesOID)
		SetInfoText("$SLApproachForcedKissTimesInfo")		
	elseif (option == SLApproachProstitutionTimesOID)
		SetInfoText("$SLApproachProstitutionTimesInfo")
	elseif (option == SLApproachProstitutionMinOID)
		SetInfoText("$SLApproachProstitutionMinInfo")
	elseif (option == SLApproachProstitutionMaxOID)
		SetInfoText("$SLApproachProstitutionMaxInfo")
	elseif (option == SLApproachProstitutionBaseChanceOID)
		SetInfoText("$SLApproachProstitutionBaseChanceInfo")
	elseif (option == SLADeployBoysOID)
		SetInfoText("$SLADeployBoysInfo")
	elseif (option == SLADeploySpoiledBoysOID)
		SetInfoText("$SLADeploySpoiledBoysInfo")
	elseif (option == SLAUniqueBullyRiverwoodOID)
		SetInfoText("$SLAUniqueBullyRiverwoodInfo")
	elseif (option == SLApproachSpankAuraDurationOID)
		SetInfoText("$SLApproachSpankAuraDurationInfo")
	elseif (option == SLApproachStruggleDifficultyOID)
		SetInfoText("$SLApproachStruggleDifficultyInfo")
	elseif (option == SLApproachStruggleDurationOID)
		SetInfoText("$SLApproachStruggleDurationInfo")
	endif
EndEvent

event OnOptionSelect(int option)
	if(option == debugLogFlagOID)
		SLApproachMain.debugLogFlag = !SLApproachMain.debugLogFlag
		SetToggleOptionValue(debugLogFlagOID, SLApproachMain.debugLogFlag)

	elseif(option == enableGuardFlagOID)
		SLApproachMain.enableGuardFlag = !SLApproachMain.enableGuardFlag
		SetToggleOptionValue(enableGuardFlagOID, SLApproachMain.enableGuardFlag)
	elseif(option == enableChildFlagOID)
		SLApproachMain.enableChildFlag = !SLApproachMain.enableChildFlag
		SetToggleOptionValue(enableChildFlagOID, SLApproachMain.enableChildFlag)
	elseif(option == enableDremoraFlagOID)
		SLApproachMain.enableDremoraFlag = !SLApproachMain.enableDremoraFlag
		SetToggleOptionValue(enableDremoraFlagOID, SLApproachMain.enableDremoraFlag)
	elseif(option == enableVisitorFlagOID)
		SLApproachMain.enableVisitorFlag = !SLApproachMain.enableVisitorFlag
		SetToggleOptionValue(enableVisitorFlagOID, SLApproachMain.enableVisitorFlag)
	elseif(option == enableHirelingFlagOID)
		SLApproachMain.enableHirelingFlag = !SLApproachMain.enableHirelingFlag
		SetToggleOptionValue(enableHirelingFlagOID, SLApproachMain.enableHirelingFlag)
	elseif(option == enableFollowerFlagOID)
		SLApproachMain.enableFollowerFlag = !SLApproachMain.enableFollowerFlag
		SetToggleOptionValue(enableFollowerFlagOID, SLApproachMain.enableFollowerFlag)
	elseif(option == enableThalmorFlagOID)
		SLApproachMain.enableThalmorFlag = !SLApproachMain.enableThalmorFlag
		SetToggleOptionValue(enableThalmorFlagOID, SLApproachMain.enableThalmorFlag)
	elseif(option == enableRapeFlagOID)
		SLApproachMain.enableRapeFlag = !SLApproachMain.enableRapeFlag
		SetToggleOptionValue(enableRapeFlagOID, SLApproachMain.enableRapeFlag)
	elseif(option == cloakSightOID)
		if SLADetectOutofSight.getvalue() == 0
			SLADetectOutofSight.setvalue(1)
		else
			SLADetectOutofSight.setvalue(0)
		endif
		SetToggleOptionValue(cloakSightOID, SLADetectOutofSight.getvalue())
	elseif(option == SLHHIntegrationOID)
		SLApproachMain.enableSLHHFlag = !SLApproachMain.enableSLHHFlag
		SetToggleOptionValue(SLHHIntegrationOID, SLApproachMain.enableSLHHFlag)
		If SLApproachMain.enableSLHHFlag && SLHHExpansion_Installed
			SLA_SLHH.setvalue(1)
			SLApproachMain.SLHHScriptEventKeyword = Game.GetFormFromFile(0x0000C510, "SexLabHorribleHarassment.esp") as Keyword
		Else
			SLA_SLHH.setvalue(0)
		Endif
	elseif(option == BDIntegrationOID)
		SLApproachMain.enableBDFlag = !SLApproachMain.enableBDFlag
		SetToggleOptionValue(BDIntegrationOID, SLApproachMain.enableBDFlag)
		If SLApproachMain.enableBDFlag && BaboDialogue_Installed
			SLA_BaboDialogue.setvalue(1)
			BaboDialogueLoadData()
		Else
			SLA_BaboDialogue.setvalue(0)
		EndIf
		
	elseif(option == FHUIntegrationOID)
		SLApproachMain.enableFHUFlag = !SLApproachMain.enableFHUFlag
		SetToggleOptionValue(FHUIntegrationOID, SLApproachMain.enableFHUFlag)
		If SLApproachMain.enableFHUFlag && FillHerUp_Installed
			SLA_FillHerUp.setvalue(1)
			FillHerUpLoadData()
		Else
			SLA_FillHerUp.setvalue(0)
		EndIf

	elseif(option == SexlabSurvivalIntegrationOID)
		SLApproachMain.enableSexlabSurvivalFlag = !SLApproachMain.enableSexlabSurvivalFlag
		SetToggleOptionValue(SexlabSurvivalIntegrationOID, SLApproachMain.enableSexlabSurvivalFlag)
		If SLApproachMain.enableSexlabSurvivalFlag && SexlabSurvival_Installed
			sla_slsurvival.setvalue(1)
			(SLApproach_ExternalMods as SLApproachExternalScript).SetFormIDSLS()
		else
			sla_slsurvival.setvalue(0)
		EndIf
		
	elseif(option == SexlabDDIIntegrationOID)
		SLApproachMain.enableDDIFlag = !SLApproachMain.enableDDIFlag
		SetToggleOptionValue(SexlabDDIIntegrationOID, SLApproachMain.enableDDIFlag)
		If SLApproachMain.enableDDIFlag && DeviousDevicesIntegration_Installed
			SLA_DDI.setvalue(1)
			(SLApproach_ExternalMods as SLApproachExternalScript).SetFormIDDDI()
		Else
			SLA_DDI.setvalue(0)
		Endif
		
	elseif(option == PeeAndFartIntegrationOID)
		SLApproachMain.enablePAF = !SLApproachMain.enablePAF
		SetToggleOptionValue(PeeAndFartIntegrationOID, SLApproachMain.enablePAF)
		If SLApproachMain.enablePAF && PeeAndFart_Installed
			SLA_PeeandFart.setvalue(1)
		Else
			SLA_PeeandFart.setvalue(0)
		Endif
		
	elseif(option == SLADeployBoysOID)
		If SLADeployBoys == false
			If ShowMessage("$DeployBoysWarningMessage") 
				SLADeployBoys = true
				SetToggleOptionValue(SLADeployBoysOID, SLADeployBoys)
				if !SLApproachNPCManagement.isrunning()
					SLApproachNPCManagement.start()
				endif
				(SLApproachNPCManagement as SLAppSpawnNPCs).DeployBoys(true)
			endif
		else
			If ShowMessage("$DeleteBoysWarningMessage")
				SLADeployBoys = false
				SetToggleOptionValue(SLADeployBoysOID, SLADeployBoys)
				(SLApproachNPCManagement as SLAppSpawnNPCs).DeployBoys(false)
			endif
		endif
	elseif(option == SLADeploySpoiledBoysOID)
		If SLADeploySpoiledBoys == false
			If ShowMessage("$DeployBoysWarningMessage") 
				SLADeploySpoiledBoys = true
				SetToggleOptionValue(SLADeploySpoiledBoysOID, SLADeploySpoiledBoys)
				if !SLApproachNPCManagement.isrunning()
					SLApproachNPCManagement.start()
				endif
				(SLApproachNPCManagement as SLAppSpawnNPCs).DeploySpoiledBoys(true)
			endif
		else
			If ShowMessage("$DeleteBoysWarningMessage")
				SLADeploySpoiledBoys = false
				SetToggleOptionValue(SLADeploySpoiledBoysOID, SLADeploySpoiledBoys)
				(SLApproachNPCManagement as SLAppSpawnNPCs).DeploySpoiledBoys(false)
			endif
		endif
	elseif(option == SLAUniqueBullyRiverwoodOID)
		SLAUniqueBullyRiverwood = !SLAUniqueBullyRiverwood
		SetToggleOptionValue(SLAUniqueBullyRiverwoodOID, SLAUniqueBullyRiverwood)
		if !SLApproachNPCManagement.isrunning()
			SLApproachNPCManagement.start()
		endif
		if SLAUniqueBullyRiverwood
			(SLApproachNPCManagement as SLAppSpawnNPCs).spawnBullyNPCRiverwood()
		else
			(SLApproachNPCManagement as SLAppSpawnNPCs).DespawnBullyNPCRiverwood()
		endif
		
	elseif(option == SLAPPResetOID)
		SLAPPResetToggle = !SLAPPResetToggle
		SetToggleOptionValue(SLAPPResetOID, SLAPPResetToggle)
	elseif(option == SLAPPResetTriggerOID)
		If ShowMessage("$SLAPPResetTriggerMessage") 
			(SLApproachAskForSexQuest as SLAppPCSexQuestScript).StopSceneForce()
		Endif
	elseif(option == SLAPPQTEResetOID)
		SLAPPQTEResetToggle != SLAPPQTEResetToggle
		SetToggleOptionValue(SLAPPQTEResetOID, SLAPPQTEResetToggle)
	Elseif Option == SLAPPExportSettingsOID
		If ShowMessage("$ExportWarningMessage") 
			ExportSettings()
		Endif
	Elseif Option == SLAPPNoMoreApproachSpellOID
		If ShowMessage("$SLAPPNoMoreApproachSpellMessage") 
			SLApproachMain.PlayerRef.addspell(SLApproachNoApproachSpell)
		Endif
	Elseif Option == SLAPPImportSettingsOID
		If ShowMessage("$ImportWarningMessage") 
			ImportSettings()
		Endif
	elseif(option == SLALowerLevelNPCOID)
		SLApproachMain.SLALowerLevelNPC = !SLApproachMain.SLALowerLevelNPC
		SetToggleOptionValue(SLALowerLevelNPCOID, SLApproachMain.SLALowerLevelNPC)
	elseif(option == SLAHigherLevelNPCOID)
		SLApproachMain.SLAHigherLevelNPC = !SLApproachMain.SLAHigherLevelNPC
		SetToggleOptionValue(SLAHigherLevelNPCOID, SLApproachMain.SLAHigherLevelNPC)
	elseif(option == SLAStandardLevelNPCOID)
		SLApproachMain.SLAStandardLevelNPC = !SLApproachMain.SLAStandardLevelNPC
		SetToggleOptionValue(SLAStandardLevelNPCOID, SLApproachMain.SLAStandardLevelNPC)
	elseif(option == enablePetsFlagOID)
		SLApproachMain.enablePetsFlag = !SLApproachMain.enablePetsFlag
		SetToggleOptionValue(enablePetsFlagOID, SLApproachMain.enablePetsFlag)
	elseif(option == enablePlayerHorseFlagOID)
		SLApproachMain.enablePlayerHorseFlag = !SLApproachMain.enablePlayerHorseFlag
		SetToggleOptionValue(enablePlayerHorseFlagOID, SLApproachMain.enablePlayerHorseFlag)
	elseif(option == enableForceThirdPersonHugOID)
		SLApproachMain.enableForceThirdPersonHug = !SLApproachMain.enableForceThirdPersonHug
		SetToggleOptionValue(option, SLApproachMain.enableForceThirdPersonHug)
	elseif(option == enableElderRaceFlagOID)
		SLApproachMain.enableElderRaceFlag = !SLApproachMain.enableElderRaceFlag
		SetToggleOptionValue(enableElderRaceFlagOID, SLApproachMain.enableElderRaceFlag)

	elseif(option == NakedArmorOID)
		SLApproachMain.SLANakedArmor = !SLApproachMain.SLANakedArmor
		SetToggleOptionValue(NakedArmorOID, SLApproachMain.SLANakedArmor)
		SLANakedArmorToggle.setvalue(SLApproachMain.SLANakedArmor as int)
	elseif(option == ApproachNakedOID)
		SLApproachMain.enableApproachNakedFlag = !SLApproachMain.enableApproachNakedFlag
		SetToggleOptionValue(ApproachNakedOID, SLApproachMain.enableApproachNakedFlag)
		;SLAApproachNakedToggle.setvalue(SLApproachMain.enableApproachNakedFlag as int)
	elseif(option == SLAUniqueActorOID)
		SLApproachMain.SLAUniqueActor = !SLApproachMain.SLAUniqueActor
		SetToggleOptionValue(SLAUniqueActorOID, SLApproachMain.SLAUniqueActor)
		SLApproachUniqueActorGlobal.setvalue(SLApproachMain.SLAUniqueActor as int)
	elseif(option == SLAOnlyInTownOID)
		SLApproachMain.SLAOnlyInTown = !SLApproachMain.SLAOnlyInTown
		SetToggleOptionValue(SLAOnlyInTownOID, SLApproachMain.SLAOnlyInTown)
		SLApproachOnlyInTownGlobal.setvalue(SLApproachMain.SLAOnlyInTown as int)
	elseif(option == SLALocktheDoorOID)
		SLApproachMain.SLALocktheDoor = !SLApproachMain.SLALocktheDoor
		SetToggleOptionValue(SLALocktheDoorOID, SLApproachMain.SLALocktheDoor)
		if SLApproachMain.SLALocktheDoor
			Game.getplayer().addperk(SLAPPDoorLockKeyPerk)
		else
			Game.getplayer().removeperk(SLAPPDoorLockKeyPerk)
		endif
	elseif(option == SLARemoveHeelEffectOID)
		SLApproachMain.SLARemoveHeelEffect = !SLApproachMain.SLARemoveHeelEffect
		SetToggleOptionValue(SLARemoveHeelEffectOID, SLApproachMain.SLARemoveHeelEffect)
	elseif(option == SLAppQuestScriptsOIDS)
		bool opt = xscript.isSkipMode
		xscript.isSkipMode = !opt
		SetToggleOptionValue(SLAppQuestScriptsOIDS, opt)
	elseif(option == ResistTypeOID)
		If ResistType == "$Strafe"
			ResistType = "$Attack"
		Else
			ResistType = "$Strafe"
		Endif
		SetTextOptionValue(Option, ResistType)
	elseif(option == PeeAndFartIntegrationOID)
		SLApproachMain.enablePAF = !SLApproachMain.enablePAF
		SetToggleOptionValue(PeeAndFartIntegrationOID, SLApproachMain.enablePAF)
		If SLApproachMain.enablePAF && PeeAndFart_Installed
			SLA_PeeandFart.setvalue(1)
		Else
			SLA_PeeandFart.setvalue(0)
		Endif
;	elseif (SLAppQuestScriptsOIDS.Find(option) > -1)
;		int idx = SLAppQuestScriptsOIDS.Find(option)
;		SLApproachBaseQuestScript xscript = SLApproachMain.getApproachQuestScript(idx)
;		bool opt = xscript.isSkipMode
;		xscript.isSkipMode = !opt
;		SetToggleOptionValue(option, opt)
	endif
endevent

event OnOptionSliderOpen(int option)
	if (option == cloakFrequencyOID)
		SetSliderDialogStartValue(SLApproachMain.cloakFrequency)
		SetSliderDialogDefaultValue(70)
		SetSliderDialogRange(10, 240)
		SetSliderDialogInterval(1)
	elseif (option == SLApproachSpankAuraDurationOID)
		SetSliderDialogStartValue(SLApproachMain.SLApproachSpankAuraDuration)
		SetSliderDialogDefaultValue(30)
		SetSliderDialogRange(5, 60)
		SetSliderDialogInterval(1)
	elseif (option == SLApproachStruggleDifficultyOID)
		SetSliderDialogStartValue(SLApproachMain.SLAPStrafeDifficulty)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0, 80)
		SetSliderDialogInterval(1)
	elseif (option == SLApproachStruggleDurationOID)
		SetSliderDialogStartValue(SLApproachMain.SLAPStruggleDuration)
		SetSliderDialogDefaultValue(2)
		SetSliderDialogRange(1, 10)
		SetSliderDialogInterval(1)
	elseif (option == baseChanceMultiplierOID)
		SetSliderDialogStartValue(SLApproachMain.baseChanceMultiplier)
		SetSliderDialogDefaultValue(0.8)
		SetSliderDialogRange(0.0, 2.0)
		SetSliderDialogInterval(0.1)
	elseif (option == PCAppearanceOID)
		SetSliderDialogStartValue(SLAAppearanceSlide.getvalue())
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	elseif (option == PCBreastsOID)
		SetSliderDialogStartValue(SLABreastsSlide.getvalue())
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0.0, 120.0)
		SetSliderDialogInterval(1)	
	elseif (option == PCButtsOID)
		SetSliderDialogStartValue(SLAButtsSlide.getvalue())
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)		
	elseif (option == userAddingPointPcOID)
		SetSliderDialogStartValue(SLApproachMain.userAddingPointPc)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 10)
		SetSliderDialogInterval(1)
	elseif (option == SLADeviationLevelOID)
		SetSliderDialogStartValue(SLApproachMain.SLADeviationLevel)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(1, 50)
		SetSliderDialogInterval(1)
	elseif (option == userAddingPointNpcOID)
		SetSliderDialogStartValue(SLApproachMain.userAddingPointNpc)
		SetSliderDialogDefaultValue(-10)
		SetSliderDialogRange(-100, 100)
		SetSliderDialogInterval(1)

	elseif (option == SLAmoralOID)
		SetSliderDialogStartValue(moral)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 3.0)
		SetSliderDialogInterval(1.0)

	elseif (option == SLAmoralMinOID)
		SetSliderDialogStartValue(SLApproachMain.SLANPCCharacterMin)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 4.0)
		SetSliderDialogInterval(1.0)
	elseif (option == SLAmoralMaxOID)
		SetSliderDialogStartValue(SLApproachMain.SLANPCCharacterMax)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 4.0)
		SetSliderDialogInterval(1.0)
		
	elseif (option == SLARelationOID)
		SetSliderDialogStartValue(Relation)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(-3.0, 5.0)
		SetSliderDialogInterval(1.0)
		
	elseif (option == userAddingRapePointPcOID)
		SetSliderDialogStartValue(SLApproachMain.userAddingRapePointPc)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
		
	elseif (option == userAddingRapePointNpcOID)
		SetSliderDialogStartValue(SLApproachMain.userAddingRapePointNpc)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(-150, 100)
		SetSliderDialogInterval(1)

	elseif (option == userAddingAskingNamePointPcOID)
		SetSliderDialogStartValue(SLApproachMain.userAddingAskingNamePointPc)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 10)
		SetSliderDialogInterval(1)
		
	elseif (option == userAddingSexualOffensePointPcOID)
		SetSliderDialogStartValue(SLApproachMain.userAddingSpankingAssPointPc)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 10)
		SetSliderDialogInterval(1)

	elseif (option == SLApproachProstitutionMinOID)
		SetSliderDialogStartValue(SLApproachProstitutionMin.getvalue() as int)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, 2000)
		SetSliderDialogInterval(1)
	elseif (option == SLApproachProstitutionMaxOID)
		SetSliderDialogStartValue(SLApproachProstitutionMax.getvalue() as int)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, 2000)
		SetSliderDialogInterval(1)
	elseif (option == SLApproachProstitutionBaseChanceOID)
		SetSliderDialogStartValue(SLApproachProstitutionBaseChance.getvalue() as int)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
		
	elseif (option == SLARelationshipChanceOID)
		SetSliderDialogStartValue(SLApproachMain.SLARelationshipChance)
		SetSliderDialogDefaultValue(40)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)	
	elseif (option == SLADislikeChanceOID)
		SetSliderDialogStartValue(SLApproachMain.SLADislikeChance)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)

	elseif (option == SLAAquaintanceChanceOID)
		SetSliderDialogStartValue(SLApproachMain.SLAAquaintanceChance)
		SetSliderDialogDefaultValue(80)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif (option == SLAHouseVisitChanceOID)
		SetSliderDialogStartValue(SLApproachMain.SLAHouseVisitChance)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)

	elseif (option == SLAHouseStayDaysOID)
		SetSliderDialogStartValue(SLApproachStayingTime.getvalue())
		SetSliderDialogDefaultValue(24)
		SetSliderDialogRange(0, 96)
		SetSliderDialogInterval(1)

	elseif (option == lowestArousalPCOID)
		SetSliderDialogStartValue(SLApproachMain.lowestArousalPC)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif (option == lowestArousalNPCOID)
		SetSliderDialogStartValue(SLApproachMain.lowestArousalNPC)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)

	elseif (option == dialogueArousalOID)
		SetSliderDialogStartValue(SLApproachDialogArousal.GetValue())
		SetSliderDialogDefaultValue(90)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif (option == multiplayPercentOID)
		SetSliderDialogStartValue(SLApproachMultiplayPercent.GetValue())
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	endif
endevent

event OnOptionSliderAccept(int option, float value)
	if (option == cloakFrequencyOID)
		SLApproachMain.cloakFrequency = value as Int
		SetSliderOptionValue(cloakFrequencyOID, SLApproachMain.cloakFrequency, "$per0sec")
	elseif (option == SLApproachSpankAuraDurationOID)
		SLApproachMain.SLApproachSpankAuraDuration = value as Int
		SetSliderOptionValue(SLApproachSpankAuraDurationOID, SLApproachMain.SLApproachSpankAuraDuration, "{1}sec")
		SLApproachSpankAura.SetNthEffectDuration(0, value as Int)
		SLApproachSpankAura2nd.SetNthEffectDuration(0, value as Int)
		SLApproachMolestAura.SetNthEffectDuration(0, value as Int)
	elseif (option == SLApproachStruggleDifficultyOID)
		SLApproachMain.SLAPStrafeDifficulty = value as Int
		SetSliderOptionValue(SLApproachStruggleDifficultyOID, SLApproachMain.SLAPStrafeDifficulty, "{0}")
	elseif (option == SLApproachStruggleDurationOID)
		SLApproachMain.SLAPStruggleDuration = value as Int
		SetSliderOptionValue(SLApproachStruggleDurationOID, SLApproachMain.SLAPStruggleDuration, "{0}")
	elseif (option == baseChanceMultiplierOID )
		SLApproachMain.baseChanceMultiplier = value
		SetSliderOptionValue(baseChanceMultiplierOID , SLApproachMain.baseChanceMultiplier, "{1}")
	elseif (option == PCAppearanceOID)
		SLApproachMain.SLAPCAppearance = value as Int
		SLAAppearanceSlide.SetValue(Value)
		SetSliderOptionValue(option, value as Int, "{0}")
	elseif (option == PCBreastsOID)
		SLApproachMain.SLAPCBreasts = value as Int
		SLABreastsSlide.SetValue(Value)
		SetSliderOptionValue(option, value as Int, "{0}")
	elseif (option == PCButtsOID)
		SLApproachMain.SLAPCButts = value as Int
		SLAButtsSlide.SetValue(Value)
		SetSliderOptionValue(option, value as Int, "{0}")

	elseIf (Option == SLAmoralOID)
		Moral = value
		SetSliderOptionValue(SLAmoralOID, Moral, "{0.0}")
		SLApproachMoralGlobal.SetValue(moral)
	elseIf (Option == SLAmoralMinOID)
		SetSliderOptionValue(SLAmoralMinOID, value, "{0.0}")
		SLApproachMain.SLANPCCharacterMin = value as int
		if SLApproachMain.SLANPCCharacterMax < SLApproachMain.SLANPCCharacterMin
			SLApproachMain.SLANPCCharacterMax = (value + 1) as int
		endif
	elseIf (Option == SLAmoralMaxOID)
		SetSliderOptionValue(SLAmoralMaxOID, value, "{0.0}")
		SLApproachMain.SLANPCCharacterMax = value as int
		if SLApproachMain.SLANPCCharacterMin > SLApproachMain.SLANPCCharacterMax
			SLApproachMain.SLANPCCharacterMin = (value - 1) as int
		endif
		
	elseIf (Option == SLARelationOID)
		Relation = value
		SetSliderOptionValue(SLARelationOID, Relation, "{0.0}")
		SLApproachRelationGlobal.SetValue(Relation)

	elseif (option == SLApproachProstitutionMinOID)
		SLApproachProstitutionMin.setvalue(value as Int)
		SetSliderOptionValue(SLApproachProstitutionMinOID , SLApproachProstitutionMin.getvalue() as int, "{0.0}")
		if SLApproachProstitutionMin.getvalue() >= SLApproachProstitutionMax.getvalue()
			SLApproachProstitutionMax.setvalue(SLApproachProstitutionMin.getvalue() + 1)
			SetSliderOptionValue(SLApproachProstitutionMaxOID , SLApproachProstitutionMax.getvalue() as int, "{0.0}")
		endif
	elseif (option == SLApproachProstitutionMaxOID)
		SLApproachProstitutionMax.setvalue(value as Int)
		SetSliderOptionValue(SLApproachProstitutionMaxOID , SLApproachProstitutionMax.getvalue() as int, "{0.0}")
		if SLApproachProstitutionMax.getvalue() <= SLApproachProstitutionMin.getvalue()
			SLApproachProstitutionMin.setvalue(SLApproachProstitutionMax.getvalue() - 1)
			SetSliderOptionValue(SLApproachProstitutionMinOID , SLApproachProstitutionMin.getvalue() as int, "{0.0}")
		endif
	elseif (option == SLApproachProstitutionBaseChanceOID)
		SLApproachProstitutionBaseChance.setvalue(value as Int)
		SetSliderOptionValue(SLApproachProstitutionBaseChanceOID , SLApproachProstitutionBaseChance.getvalue() as int, "{0.0}")
		
	elseif (option == SLADeviationLevelOID)
		SLApproachMain.SLADeviationLevel = value as Int
		SetSliderOptionValue(SLADeviationLevelOID , SLApproachMain.SLADeviationLevel)
		SLAStandardLevelMaximumNPCGlobal.value = (Game.getplayer().getlevel()) + value
		SLAStandardLevelMinimumNPCGlobal.value = (Game.getplayer().getlevel()) - value
	elseif (option == userAddingPointPcOID)
		SLApproachMain.userAddingPointPc = value as Int
		SetSliderOptionValue(userAddingPointPcOID , SLApproachMain.userAddingPointPc)
	elseif (option == userAddingPointNpcOID)
		SLApproachMain.userAddingPointNpc = value as Int
		SetSliderOptionValue(userAddingPointNpcOID , SLApproachMain.userAddingPointNpc)
		
	elseif (option == userAddingRapePointPcOID)
		SLApproachMain.userAddingRapePointPc = value as Int
		SetSliderOptionValue(userAddingRapePointPcOID , SLApproachMain.userAddingRapePointPc)
	elseif (option == userAddingRapePointNpcOID)
		SLApproachMain.userAddingRapePointNpc = value as Int
		SetSliderOptionValue(userAddingRapePointNpcOID , SLApproachMain.userAddingRapePointNpc)

	elseif (option == userAddingAskingNamePointPcOID)
		SLApproachMain.userAddingAskingNamePointPc = value as Int
		SetSliderOptionValue(userAddingAskingNamePointPcOID, SLApproachMain.userAddingAskingNamePointPc)

	elseif (option == userAddingSexualOffensePointPcOID)
		SLApproachMain.userAddingSpankingAssPointPc = value as Int
		SetSliderOptionValue(userAddingSexualOffensePointPcOID, SLApproachMain.userAddingSpankingAssPointPc)
		
	elseif (option == SLARelationshipChanceOID)
		SLApproachMain.SLARelationshipChance = value as Int
		SetSliderOptionValue(SLARelationshipChanceOID, SLApproachMain.SLARelationshipChance)
	elseif (option == SLADislikeChanceOID)
		SLApproachMain.SLADislikeChance = value as Int
		SetSliderOptionValue(SLADislikeChanceOID, SLApproachMain.SLADislikeChance)
		
	elseif (option == SLAAquaintanceChanceOID)
		SLApproachMain.SLAAquaintanceChance = value as Int
		SetSliderOptionValue(SLAAquaintanceChanceOID, SLApproachMain.SLAAquaintanceChance)
		
	elseif (option == SLAHouseVisitChanceOID)
		SLApproachMain.SLAHouseVisitChance = value as Int
		SetSliderOptionValue(SLAHouseVisitChanceOID, SLApproachMain.SLAHouseVisitChance)
	
	elseif (option == SLAHouseStayDaysOID)
		SLApproachStayingTime.setvalue(value as int)
		SetSliderOptionValue(SLAHouseStayDaysOID, SLApproachStayingTime.getvalue())
		
	elseif (option == lowestArousalPCOID)
		SLApproachMain.lowestArousalPC = value as Int
		SetSliderOptionValue(lowestArousalPCOID, SLApproachMain.lowestArousalPC)
	elseif (option == lowestArousalNPCOID)
		SLApproachMain.lowestArousalNPC = value as Int
		SetSliderOptionValue(lowestArousalNPCOID, SLApproachMain.lowestArousalNPC)

	elseif (option == dialogueArousalOID)
		SLApproachDialogArousal.SetValue(value as Int)
		SetSliderOptionValue(dialogueArousalOID, SLApproachDialogArousal.GetValue())
	elseif (option == multiplayPercentOID)
		SLApproachMultiplayPercent.SetValue(value as Int)
		SetSliderOptionValue(multiplayPercentOID, SLApproachMultiplayPercent.GetValue())

	endif
endevent

;.......... Import / Export
Function ExportInt(string File, string Name, int Value)
	JsonUtil.SetIntValue(File, Name, Value)
EndFunction
Int Function ImportInt(string File, string Name, int DefaultValue)
	return JsonUtil.GetIntValue(File, Name, DefaultValue)
EndFunction
Function ExportBool(string File, string Name, bool Value)
	JsonUtil.SetIntValue(File, Name, Value as int)
EndFunction
Bool Function ImportBool(string File, string Name, bool DefaultValue)
	return JsonUtil.GetIntValue(File, Name, DefaultValue as int) as bool
EndFunction
Function ExportFloat(string File, string Name, float Value)
	JsonUtil.SetFloatValue(File, Name, Value)
EndFunction
Float Function ImportFloat(string File, string Name, float DefaultValue)
	return JsonUtil.GetFloatValue(File, Name, DefaultValue)
EndFunction
Function ExportString(string File, string Name, string Value)
	JsonUtil.SetStringValue(File, Name, Value)
EndFunction
String Function ImportString(string File, string Name, string DefaultValue)
	return JsonUtil.GetStringValue(File, Name, DefaultValue)
EndFunction

Function ExportSettings()
	String File = "../BakaFactory/SLAppAutoMCM.json"

	ExportString(File, "ExportLabel", SLApproachMain.PlayerRef.GetLeveledActorBase().GetName()+" - "+Utility.GetCurrentRealTime() as int)
	ExportString(File, "Version", GetVersion())

	ExportBool(File, "DetectOutofSight", SLADetectOutofSight.GetValue() as Bool)
	ExportBool(File, "EnableRape", SLApproachMain.enableRapeFlag)
	ExportBool(File, "EnableElderRace", SLApproachMain.enableElderRaceFlag)
	ExportBool(File, "EnableFollowers", SLApproachMain.enableFollowerFlag)
	ExportBool(File, "EnableHireling", SLApproachMain.enableHirelingFlag)
	ExportBool(File, "EnableGuard", SLApproachMain.enableGuardFlag)
	ExportBool(File, "EnableChild", SLApproachMain.enableChildFlag)
	ExportBool(File, "EnableDremora", SLApproachMain.enableDremoraFlag)
	ExportBool(File, "NakedArmor", SLApproachMain.SLANakedArmor)
	ExportBool(File, "UniqueActor", SLApproachMain.SLAUniqueActor)
	ExportBool(File, "RemoveHeelEffect", SLApproachMain.SLARemoveHeelEffect)
	ExportBool(File, "LocktheDoor", SLApproachMain.SLALocktheDoor)
	ExportBool(File, "OutputPapyrusLog", SLApproachMain.debugLogFlag)
	ExportBool(File, "PCQuest", xscript.isSkipMode)
	ExportBool(File, "HigherLevelNPC", SLApproachMain.SLAHigherLevelNPC)
	ExportBool(File, "LowerLevelNPC", SLApproachMain.SLALowerLevelNPC)
	ExportBool(File, "StandardLevelNPC", SLApproachMain.SLAStandardLevelNPC)
	ExportBool(File, "EnableVisitor", SLApproachMain.enableVisitorFlag)
	ExportBool(File, "HHIntegration", SLApproachMain.enableSLHHFlag)
	ExportBool(File, "BDIntegration", SLApproachMain.enableBDFlag)
	ExportBool(File, "FHUIntegration", SLApproachMain.enableFHUFlag)
	ExportBool(File, "SexlabSurvivalIntegration", SLApproachMain.enableSexlabSurvivalFlag)
	ExportBool(File, "DDIIntegration", SLApproachMain.enableDDIFlag)
	ExportBool(File, "PAFIntegration", SLApproachMain.enablePAF)

	ExportInt(File, "Appearance", SLAAppearanceSlide.GetValue() as Int)
	ExportInt(File, "Breasts", SLABreastsSlide.GetValue() as Int)
	ExportInt(File, "Butt", SLAButtsSlide.GetValue() as Int)
	ExportInt(File, "CloakFrequency", SLApproachMain.cloakFrequency)
	ExportInt(File, "SpankAuraDuration", SLApproachMain.SLApproachSpankAuraDuration)
	ExportInt(File, "LowestArousalPC", SLApproachMain.lowestArousalPC)
	ExportInt(File, "LowestArousalNPC", SLApproachMain.lowestArousalNPC)
	ExportInt(File, "DialogueArousal", SLApproachDialogArousal.GetValue() as Int)
	ExportInt(File, "Morality", moral as Int)
	ExportInt(File, "NPCMoralityMin", SLApproachMain.SLANPCCharacterMin)
	ExportInt(File, "NPCMoralityMax", SLApproachMain.SLANPCCharacterMax)
	ExportInt(File, "NPCRelation", Relation as Int)
	ExportInt(File, "StruggleDifficulty", SLApproachMain.SLAPStrafeDifficulty)
	ExportInt(File, "ProstitutionMin", SLApproachProstitutionMin.GetValue() as Int)
	ExportInt(File, "ProstitutionMax", SLApproachProstitutionMax.GetValue() as Int)
	ExportInt(File, "DeviationLevel", SLApproachMain.SLADeviationLevel)
	ExportInt(File, "MultiplayPercent", SLApproachMultiplayPercent.GetValue() as Int)
	ExportInt(File, "AddingPointsNPCPC", SLApproachMain.userAddingPointPc)
	ExportInt(File, "AddingRapePointsNPCPC", SLApproachMain.userAddingRapePointPc)
	ExportInt(File, "AddingAskingNamePointsNPCPC", SLApproachMain.userAddingAskingNamePointPc)
	ExportInt(File, "AddingSexualOffensePointsNPCPC", SLApproachMain.userAddingSpankingAssPointPc)
	ExportInt(File, "RelationshipChance", SLApproachMain.SLARelationshipChance)
	ExportInt(File, "AquaintanceChance", SLApproachMain.SLAAquaintanceChance)
	ExportInt(File, "DislikeChance", SLApproachMain.SLADislikeChance)
	ExportInt(File, "HouseVisitChance", SLApproachMain.SLAHouseVisitChance)
	ExportInt(File, "HouseStayDays", SLApproachStayingTime.GetValue() as Int)

	ExportFloat(File, "BaseChanceMultiplier", SLApproachMain.baseChanceMultiplier)

	ExportString(File, "ResistHotkey", ResistType)

	JsonUtil.Save(File, false)
EndFunction

Function ApproachSpellMessage(actor akactor, bool AddspellBool)
	if AddspellBool
		Debug.notification((akactor.GetBaseObject().GetName() as string) + "$SLAPPNoMoreApproachSpellStringA")
	else
		Debug.notification((akactor.GetBaseObject().GetName() as string) + "$SLAPPNoMoreApproachSpellStringB")
	endif
EndFunction

Function ImportSettings()
	String File = "../BakaFactory/SLAppAutoMCM.json"

	SLADetectOutofSight.SetValue(ImportInt(File, "DetectOutofSight", SLADetectOutofSight.GetValue() as Int))
	SLApproachMain.enableRapeFlag = ImportBool(File, "EnableRape", SLApproachMain.enableRapeFlag)
	SLApproachMain.enableElderRaceFlag = ImportBool(File, "EnableElderRace", SLApproachMain.enableElderRaceFlag)
	SLApproachMain.enableFollowerFlag = ImportBool(File, "EnableFollowers", SLApproachMain.enableFollowerFlag)
	SLApproachMain.enableHirelingFlag = ImportBool(File, "EnableHireling", SLApproachMain.enableHirelingFlag)
	SLApproachMain.enableGuardFlag = ImportBool(File, "EnableGuard", SLApproachMain.enableGuardFlag)
	;SLApproachMain.enableChildFlag = ImportBool(File, "EnableChild", SLApproachMain.enableChildFlag)
	SLApproachMain.enableDremoraFlag = ImportBool(File, "EnableDremora", SLApproachMain.enableDremoraFlag)
	SLApproachMain.SLANakedArmor = ImportBool(File, "NakedArmor", SLApproachMain.SLANakedArmor)
	SLApproachMain.SLAUniqueActor = ImportBool(File, "UniqueActor", SLApproachMain.SLAUniqueActor)
	SLApproachMain.SLARemoveHeelEffect = ImportBool(File, "RemoveHeelEffect", SLApproachMain.SLARemoveHeelEffect)
	SLApproachMain.SLALocktheDoor = ImportBool(File, "LocktheDoor", SLApproachMain.SLALocktheDoor)
	SLApproachMain.debugLogFlag = ImportBool(File, "OutputPapyrusLog", SLApproachMain.debugLogFlag)
	xscript.isSkipMode = ImportBool(File, "PCQuest", xscript.isSkipMode)
	SLApproachMain.SLAHigherLevelNPC = ImportBool(File, "HigherLevelNPC", SLApproachMain.SLAHigherLevelNPC)
	SLApproachMain.SLALowerLevelNPC = ImportBool(File, "LowerLevelNPC", SLApproachMain.SLALowerLevelNPC)
	SLApproachMain.SLAStandardLevelNPC = ImportBool(File, "StandardLevelNPC", SLApproachMain.SLAStandardLevelNPC)
	SLApproachMain.enableVisitorFlag = ImportBool(File, "EnableVisitor", SLApproachMain.enableVisitorFlag)

	If SLHHExpansion_Installed
		SLApproachMain.enableSLHHFlag = ImportBool(File, "HHIntegration", SLApproachMain.enableSLHHFlag)
	EndIf
	If BaboDialogue_Installed
		SLApproachMain.enableBDFlag = ImportBool(File, "BDIntegration", SLApproachMain.enableBDFlag)
	EndIf
	If FillHerUp_Installed
		SLApproachMain.enableFHUFlag = ImportBool(File, "FHUIntegration", SLApproachMain.enableFHUFlag)
	EndIf
	
	If SexlabSurvival_Installed
		SLApproachMain.enableSexlabSurvivalFlag = ImportBool(File, "SexlabSurvivalIntegration", SLApproachMain.enableSexlabSurvivalFlag)
	EndIf
	If DeviousDevicesIntegration_Installed
		SLApproachMain.enableDDIFlag = ImportBool(File, "DDIIntegration", SLApproachMain.enableDDIFlag)
	EndIf
	If PeeAndFart_Installed
		SLApproachMain.enablePAF = ImportBool(File, "PAFIntegration", SLApproachMain.enablePAF)
	EndIf

	SLAAppearanceSlide.SetValue(ImportInt(File, "Appearance", SLAAppearanceSlide.GetValue() as Int))
	SLABreastsSlide.SetValue(ImportInt(File, "Breasts", SLABreastsSlide.GetValue() as Int))
	SLAButtsSlide.SetValue(ImportInt(File, "Butt", SLAButtsSlide.GetValue() as Int))
	SLApproachMain.cloakFrequency = ImportInt(File, "CloakFrequency", SLApproachMain.cloakFrequency)
	SLApproachMain.SLApproachSpankAuraDuration = ImportInt(File, "SpankAuraDuration", SLApproachMain.SLApproachSpankAuraDuration)
	SLApproachMain.lowestArousalPC = ImportInt(File, "LowestArousalPC", SLApproachMain.lowestArousalPC)
	SLApproachMain.lowestArousalNPC = ImportInt(File, "LowestArousalNPC", SLApproachMain.lowestArousalNPC)
	SLApproachDialogArousal.SetValue(ImportInt(File, "DialogueArousal", SLApproachDialogArousal.GetValue() as Int))
	moral = ImportInt(File, "Morality", moral as Int) as Float
	SLApproachMain.SLANPCCharacterMin = ImportInt(File, "NPCMoralityMin", SLApproachMain.SLANPCCharacterMin)
	SLApproachMain.SLANPCCharacterMax = ImportInt(File, "NPCMoralityMax", SLApproachMain.SLANPCCharacterMax)
	Relation = ImportInt(File, "NPCRelation", Relation as Int) as Float
	SLApproachMain.SLAPStrafeDifficulty = ImportInt(File, "StruggleDifficulty", SLApproachMain.SLAPStrafeDifficulty)
	SLApproachProstitutionMin.SetValue(ImportInt(File, "ProstitutionMin", SLApproachProstitutionMin.GetValue() as Int))
	SLApproachProstitutionMax.SetValue(ImportInt(File, "ProstitutionMax", SLApproachProstitutionMax.GetValue() as Int))
	SLApproachMain.SLADeviationLevel = ImportInt(File, "DeviationLevel", SLApproachMain.SLADeviationLevel)
	SLApproachMultiplayPercent.SetValue(ImportInt(File, "MultiplayPercent", SLApproachMultiplayPercent.GetValue() as Int))
	SLApproachMain.userAddingPointPc = ImportInt(File, "AddingPointsNPCPC", SLApproachMain.userAddingPointPc)
	SLApproachMain.userAddingRapePointPc = ImportInt(File, "AddingRapePointsNPCPC", SLApproachMain.userAddingRapePointPc)
	SLApproachMain.userAddingAskingNamePointPc = ImportInt(File, "AddingAskingNamePointsNPCPC", SLApproachMain.userAddingAskingNamePointPc)
	SLApproachMain.userAddingSpankingAssPointPc = ImportInt(File, "AddingSexualOffensePointsNPCPC", SLApproachMain.userAddingSpankingAssPointPc)
	SLApproachMain.SLARelationshipChance = ImportInt(File, "RelationshipChance", SLApproachMain.SLARelationshipChance)
	SLApproachMain.SLAAquaintanceChance = ImportInt(File, "AquaintanceChance", SLApproachMain.SLAAquaintanceChance)
	SLApproachMain.SLADislikeChance = ImportInt(File, "DislikeChance", SLApproachMain.SLADislikeChance)
	SLApproachMain.SLAHouseVisitChance = ImportInt(File, "HouseVisitChance", SLApproachMain.SLAHouseVisitChance)
	SLApproachStayingTime.SetValue(ImportInt(File, "HouseStayDays", SLApproachStayingTime.GetValue() as Int))

	SLApproachMain.baseChanceMultiplier = ImportFloat(File, "BaseChanceMultiplier", SLApproachMain.baseChanceMultiplier)

	ResistType = ImportString(File, "ResistHotkey", ResistType)
EndFunction
