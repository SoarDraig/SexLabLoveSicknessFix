Scriptname SLAppPCSexQuestScript extends SLApproachBaseQuestScript Conditional 

; Misc Dialogue for Housevisit

Function startApproach(Actor akRef)
	ImportPlayerStatus()
	SetPlayerLevel()
	PCApproachOngoing = True
	maxTime = SLApproachMain.SLApproachTimelimit
	ProstitutionChance(akref)
	SetCharacter(akRef)
	SetTraits(akRef, 0, 0, false)
	if akref == StayingActor.GetReference() as Actor
		if selectedScene == SLApproachHouseStayScene || selectedScene == SLApproachHouseStayKidScene
			akref.addtofaction(slapp_VisitingScenePlayFaction)
			slappUtil.log("Selected scene is stayingguestevent, roll rape chance.")
		endif
	else
		talkingActor.ForceRefTo(akRef)
		if (selectedScene == SLApproachAskForSexQuestScene) || (selectedScene == SLAppAskingNameToPCScene)
			slappUtil.log("Selected scene is sex to pc, roll rape chance.")
		endif
	endif
	self.rollRapeChance(akRef)
	SLApproachRapeToggle.setvalue(willRape as int)
	if SLA_BaboDialogue.getvalue() == 1
		;AkWorld = akref.getworldspace() ; haven't decided whether to add it or not.
		;if Akworld == Whiterunworld
		;	if PlayerRef.isinfaction(WhiterunOrcFuckToyTitleRank)
		;		SLApproachPlayerHouseWhiterun.addform(akref)
		;	endif			
		;elseif Akworld == Solitudeworld
		;endif
	endif
	selectedScene.ForceStart()
	;approachEnding = True
	parent.startApproach(akRef)
	if SLApproachMain.debugLogFlag
		Debug.notification("StartApproach," + (selectedScene.getname() as string) + "starts from " + (akRef.GetBaseObject().GetName() as string))
	endif
EndFunction

Function SetPlayerLevel()
	int DLevel = SLApproachMain.SLADeviationLevel
	SLAStandardLevelMaximumNPCGlobal.value = PlayerRef.getlevel() + DLevel
	SLAStandardLevelMinimumNPCGlobal.value = PlayerRef.getlevel() - DLevel
	fPlayerSpeechCraft = PlayerRef.GetActorValue("Speechcraft")
	SlappSpeechAV.setvalue(fPlayerSpeechCraft)
EndFunction

Function SetCharacter(actor akRef)

Int Character

if !akRef.isinfaction(slapp_Characterfaction)
	if !akRef.isinfaction(SLAX_AggressiveFaction)
		actorbase akRefbase = akRef.getbaseobject() as actorbase
		
		if akRefbase.isunique()
			Character = Utility.randomint(SLApproachMain.SLANPCUniqueCharacterMin, SLApproachMain.SLANPCUniqueCharacterMax);0Mild,1Timid,2Confident,3Aggressive,4Rapist
		else
			if akRef.getactorvalue("Morality") <= SLApproachMoralGlobal.getvalue() || akRef.isinfaction(slapp_ThugFaction)
			;if akRef.isinfaction(slapp_ThugFaction) || akRef.isinfaction(slapp_SpoiledKid)
				Character = Utility.randomint(3,4);0Mild,1Timid,2Confident,3Aggressive,4Rapist
			else
				Character = Utility.randomint(SLApproachMain.SLANPCCharacterMin, SLApproachMain.SLANPCCharacterMax);0Mild,1Timid,2Confident,3Aggressive,4Rapist	
			endif
		endif
		
		;if SLApproachMain.SLACurrentActorisChild == true
		;	if Character >= 3 && !akRef.isinfaction(slapp_SpoiledKid)
		;		Character = 2
		;	endif
		;endif
		;if akRef.isinfaction(SLApproachMain.BaboViceGuardCaptainFaction) 
		;	Character = 3
		;endif
		akRef.addtofaction(slapp_Characterfaction)
		akRef.addtofaction(SLAX_AggressiveFaction)
		akRef.setfactionrank(slapp_Characterfaction, Character)
		akRef.setfactionrank(SLAX_AggressiveFaction, Character)
	else
		akRef.addtofaction(slapp_Characterfaction)
		akRef.setfactionrank(slapp_Characterfaction, akRef.getfactionrank(SLAX_AggressiveFaction) as int)
	endif
endif

EndFunction

Bool Function SetTraits(actor akRef, int itrait = 0, int iindex = 0, Bool Reset = false)

if Reset
	akRef.removefromfaction(slapp_TraitAttitudefaction)
endif

if !akRef.isinfaction(slapp_Characterfaction)
	return false
endif

int irank = akRef.getfactionrank(slapp_Characterfaction) as int

int iaddict
int iattitude
int ifetish
int inormal
int iPreferB
int iPreferH
int iPreferF
int iPreferW

faction ftrait
if itrait == 0

	if akRef.isinfaction(slapp_TraitAttitudefaction)
		return false
	endif
	if irank == 0
		iaddict = Utility.randomint(0,1)
		iattitude = Utility.randomint(0,5)
		ifetish = Utility.randomint(0,1)
		inormal = Utility.randomint(0,7)
		iPreferB = Utility.randomint(1,4)
		iPreferH = Utility.randomint(1,6)
		iPreferW = Utility.randomint(0,1)
		iPreferF = Utility.randomint(0,2)
	elseif irank == 1
		iaddict = Utility.randomint(0,3)
		iattitude = Utility.randomint(1,6)
		ifetish = Utility.randomint(0,3)
		inormal = Utility.randomint(0,7)
		iPreferB = Utility.randomint(2,4)
		iPreferH = Utility.randomint(1,6)
		iPreferW = Utility.randomint(1,3)
		iPreferF = Utility.randomint(0,3)
	elseif irank == 2
		iaddict = Utility.randomint(1,4)
		iattitude = Utility.randomint(1,6)
		ifetish = Utility.randomint(0,6)
		inormal = Utility.randomint(0,7)
		iPreferB = Utility.randomint(2,4)
		iPreferH = Utility.randomint(1,6)
		iPreferW = Utility.randomint(0,3)
		iPreferF = 5
	elseif irank == 3
		iaddict = Utility.randomint(1,5)
		iattitude = Utility.randomint(5,7)
		ifetish = Utility.randomint(3,6)
		inormal = Utility.randomint(2,5)
		iPreferB = Utility.randomint(2,4)
		iPreferH = Utility.randomint(3,6)
		iPreferW = 0
		iPreferF = 5
	elseif irank >= 4
		iaddict = Utility.randomint(2,4)
		iattitude = Utility.randomint(5,7)
		ifetish = Utility.randomint(4,6)
		inormal = Utility.randomint(3,5)
		iPreferB = Utility.randomint(3,4)
		iPreferH = Utility.randomint(3,6)
		iPreferW = Utility.randomint(0,1)
		iPreferF = 5
	endif
	
	akRef.setfactionrank(slapp_TraitAddictfaction, iaddict)	
	akRef.setfactionrank(slapp_TraitAttitudefaction, iattitude)	
	akRef.setfactionrank(slapp_TraitFetishfaction, ifetish)
	if akRef.isinfaction(JobMerchantFaction) || akRef.isinfaction(JobJewelerFaction)
		akRef.setfactionrank(slapp_TraitNormalfaction, 7)
	elseif akRef.isinfaction(FavorJobsDrunksFaction)
		akRef.setfactionrank(slapp_TraitNormalfaction, 4)
	else
		akRef.setfactionrank(slapp_TraitNormalfaction, inormal)
	endif
	akRef.setfactionrank(slapp_TraitPreferenceBreastfaction, iPreferB)	
	akRef.setfactionrank(slapp_TraitPreferenceHairfaction, iPreferH)	
	akRef.setfactionrank(slapp_TraitPreferenceFoodfaction, iPreferF)	
	akRef.setfactionrank(slapp_TraitPreferenceWeightfaction, iPreferW)	
	
	return true
	
else
	ftrait = SLApproachTraitList.getat(itrait) as faction
	akRef.setfactionrank(ftrait, iindex)
	return true
endif


EndFunction

Faction Property FavorJobsDrunksFaction Auto
Faction Property JobMerchantFaction Auto
Faction Property JobJewelerFaction Auto

Function approachEndingSwitch(Bool Switch)
	approachEnding = Switch
EndFunction

int Function ProstitutionNPCMoney(Actor akRef) ; How much NPC has money. WIP Trait

 
Armor HeadArmor = akRef.GetWornForm(0x00000001) as Armor
Armor BodyArmor = akRef.GetWornForm(0x00000004) as Armor
Armor HandsArmor = akRef.GetWornForm(0x00000008) as Armor
Armor AmuletArmor = akRef.GetWornForm(0x00000020) as Armor
Armor RingArmor = akRef.GetWornForm(0x00000040) as Armor
Armor FeetArmor = akRef.GetWornForm(0x00000080) as Armor

int ArmorValue = 0
int RichValue = 0

if HeadArmor
	ArmorValue += HeadArmor.GetGoldValue() as int
endif

if BodyArmor
	ArmorValue += BodyArmor.GetGoldValue() as int
endif

if HandsArmor
	ArmorValue += HandsArmor.GetGoldValue() as int
endif

if AmuletArmor
	ArmorValue += AmuletArmor.GetGoldValue() as int
endif

if RingArmor
	ArmorValue += RingArmor.GetGoldValue() as int
endif

if FeetArmor
	ArmorValue += FeetArmor.GetGoldValue() as int
endif

int LevelValue = akref.getlevel() * 10

if akref.wornhaskeyword(ClothingPoor)
	Richvalue = 5
elseif akref.wornhaskeyword(ClothingRich)
	Richvalue = 1500
else
	Richvalue = 500
endif

if akref.getfactionrank(slapp_TraitNormalfaction) == 4;indebt
	Richvalue -= 500
elseif akref.getfactionrank(slapp_TraitNormalfaction) == 7;rich
	Richvalue += 500
endif

Int Totalvalue = Armorvalue + LevelValue + RichValue

Return Totalvalue

EndFunction

int Function ProstitutionPlayerValue(); How much will you offer

int ValueMax = SLApproachProstitutionMax.getvalue() as int
int ValueMin = SLApproachProstitutionMin.getvalue() as int
int extravalue
	extravalue += slappUtil.NudeCalc(PlayerRef);from0~70
	extravalue += slappUtil.AppearanceCalc();from0~75
int PValue = Utility.randomint(ValueMin, ValueMax)
	Pvalue += extravalue
int PValueHalf = PValue / 2
SLApproachProstitutionValue.setvalue(Pvalue as float)
SLApproachProstitutionValueHalf.setvalue(PValueHalf as float);WIP
UpdateCurrentInstanceGlobal(SLApproachProstitutionValue)
UpdateCurrentInstanceGlobal(SLApproachProstitutionValueHalf)
if SLApproachMain.debugLogFlag
	Debug.notification("Your prostitution value is: " + Pvalue)
endif
Return Pvalue

EndFunction

Function ProstitutionChance(Actor akref)

int NPCMoney = ProstitutionNPCMoney(akref)
int PlayerValue = ProstitutionPlayerValue()

float AcceptChance = ((NPCMoney / PlayerValue) * 100) as float
SLApproachProstitutionNPCMoney.setvalue(NPCMoney as float)
ProstitutionAcceptChance = AcceptChance + ComputeChanceSpanking(akref, -10)

If PlayerValue >= NPCMoney
	SLApproachMain.SLAProstitution = false
;	SLApproachProstitutionFraudChance.setvalue();WIP
else
	SLApproachMain.SLAProstitution = true
endif

Endfunction

Function rollRapeChance(Actor akRef)
	if (SLApproachMain.enableRapeFlag)
		if (SLApproachMain.enableSLHHFlag)
			SLHHwillRape = true
		else
			SLHHwillRape = false
		endif
		if (akRef.IsEquipped(SLAppRingBeast))
			willRape = true
			return
		endif
		
		int chance = 0
		chance += slappUtil.NudeCalc(PlayerRef);from0~70
		chance += slappUtil.AppearanceCalc();from0~75
		chance += (slappUtil.ReputationCalc() * 0.1) as int
		chance += (akRef.GetFactionRank(arousalFaction) * 0.1) as int
		chance += slappUtil.CharacterCalc(akRef);from-25~25
		chance += slappUtil.AcquaintanceCalc(akRef);from-50~10
		chance += slappUtil.DislikeCalc(akRef);from10~100
		
		chance += slappUtil.ThinkWeightCalc()
		chance += slappUtil.ThinkFemmeFataleCalc(akRef)
		chance += slappUtil.ThinkExhibitionistCalc(akRef)
		chance += slappUtil.ThinkRapeAllowedCalc(akRef)
		chance += slappUtil.ThinkBitchCalc(akRef)
		
		SLAFactorScore.value = chance; WIP

		chance += slappUtil.HomeAlone();from-50~50
		chance += slappUtil.LightLevelCalc(akRef);from-50~25
		chance += slappUtil.TimeCalc();from-25~25
		
		
;		chance += 5;50+145+5 = 200
		chance = chance / 10
		chance = slappUtil.ValidateChance(chance);From 0 to 150
		chance += SLApproachMain.userAddingRapePointPc;Range(-100, 100)

		int roll = Utility.RandomInt(0, 150)
		
		if (roll < chance)
			willRape  = true
		else
			willRape  = false
		endif
	else
		willRape = false
	endif
EndFunction

Function SimpleForcereference(Actor akRef)
	talkingActor.clear()
	talkingActor.ForceRefTo(akRef)
EndFunction

Function MiscDialogueStart(Actor akRef)
	ImportPlayerStatus()
	SetPlayerLevel()
	talkingActor.clear()
	talkingActor.ForceRefTo(akRef)
	SetTraits(akRef, 0, 0, false)
	ProstitutionChance(akref)
	self.rollRapeChance(akRef)
	SLApproachRapeToggle.setvalue(willRape as int)
	parent.startApproach(akRef)
	PCApproachOngoing = True
	ready()
EndFunction

Function ChanceRollMisc(Actor akRef, Actor akActor, float baseChanceMultiplier, int SceneType = 1)

	string akRefName = akRef.GetActorBase().GetName()
	int roll
	int result
	
	if SLApproachMain.debugLogFlag
		Debug.notification("ChanceRollMisc started")
	endif

	if SLA_DDI.getvalue() == 1
		(SLApproach_ExternalMods as SLApproachExternalScript).CheckDD(akActor)
	endif
	if sla_slsurvival.getvalue() == 1
		(SLApproach_ExternalMods as SLApproachExternalScript).SLSurvivalLicenseCheck()
	endif
	
	roll = Utility.randomint(0, SLApproachMain.userAddingPointPc + SLApproachMain.userAddingaskingnamePointPc)
	
	If (roll <= SLApproachMain.userAddingaskingnamePointPc) && (SLApproachMain.userAddingaskingnamePointPc > 0)
		SLAMiscDialogueType.setvalue(1)
	Elseif (roll <= (SLApproachMain.userAddingPointPc + SLApproachMain.userAddingaskingnamePointPc)) && (SLApproachMain.userAddingPointPc > 0)
		SLAMiscDialogueType.setvalue(2)
	Elseif (roll <= (SLApproachMain.userAddingPointPc + SLApproachMain.userAddingaskingnamePointPc + SLApproachMain.userAddingSpankingAssPointPc)) && (SLApproachMain.userAddingSpankingAssPointPc > 0)
		SLAMiscDialogueType.setvalue(3)
	else
		SLAMiscDialogueType.setvalue(0)
	Endif
	
	ImportPlayerStatus()
	SetPlayerLevel()
	;bool bnaked = slappUtil.CheckArmor(PlayerRef, true)
	slapp_PlayerNakedGlobal.setvalue(slappUtil.IfNaked(PlayerRef) as float)
	slapp_PlayerUnderwearGlobal.setvalue(slappUtil.IfWearingUnderwear(PlayerRef) as float)
	if akref == StayingActor.GetReference() as Actor
		SceneType = 3
	else
		talkingActor.clear()
		talkingActor.ForceRefTo(akRef)
	endif
	SetTraits(akRef, 0, 0, false)
	ProstitutionChance(akref)
	self.rollRapeChance(akRef)
	SLApproachRapeToggle.setvalue(willRape as int)
	
	if SLApproachMain.debugLogFlag
		Debug.notification("Scene Num: " + SceneType)
	endif
	
	if SceneType == 1
		selectedScene = SLAppAskingKid02Scene
		parent.startApproach(akRef)
	elseif SceneType == 2
		selectedScene = SLAppAskingMiscScene
		parent.startApproach(akRef)
	elseif SceneType == 3
		selectedScene = SLAppAskingMiscStayingHouseScene
		parent.startApproach(akRef)
	elseif SceneType == 4
		selectedScene = SLAppPeekingWhileBathing
		parent.startApproachCustom(3)
	elseif SceneType == 5
		selectedScene = SLAppPeekingWhilePeeing
		parent.startApproachCustom(3)
	endif
	
	
	PCApproachOngoing = True
	;SLApproachBase.RegisterAnimationEvent()
	ready()
	selectedScene.forceStart()
EndFunction

Bool Function CheckTown(actor akactor)
		Location kCurrentLoc = akActor.GetCurrentLocation()
		if akactor.isininterior()
			if kCurrentLoc.HasKeyword(LocTypeDwelling) || kCurrentLoc.HasKeyword(LocTypeInn)
				return true
			endif
			Location kParentLoc = PO3_SKSEFunctions.GetParentLocation(kCurrentLoc);PO3 function
			if kParentLoc
				kCurrentLoc = kParentLoc
			endif
		endif
		
		if kCurrentLoc
			if kCurrentLoc.HasKeyword(LocTypeHabitation) || kCurrentLoc.HasKeyword(LocTypeCity) || kCurrentLoc.HasKeyword(LocTypeTown) || kCurrentLoc.HasKeyword(SLAppLocType)
				return true
			endif
		endif
	return false
EndFunction


;PO3_SKSEFunctions.AddKeywordToForm
bool Function chanceRoll(Actor akRef, Actor akActor, float baseChanceMultiplier);triggered directly from SLApproachApplyEffect
	string akRefName = akRef.GetActorBase().GetName()
	int roll
	int result
	
	if SLApproachMain.debugLogFlag
		Debug.notification("ChanceRoll started")
	endif
	
;	if !(self.isPrecheckValid(akRef, akActor, true))
;		return false
;	endif
	if SLApproachMain.SLAOnlyInTown == true
		if CheckTown(akactor) == false
			return false
		endif
	endif
	
	if !(akActor.GetPlayerControls())
		return false
	endif

	int chance = SexUtil.GetArousal(akRef, akActor); get the value of NPC's arousal.
	if (chance < SLApproachMain.lowestArousalNPC)
		slappUtil.log(ApproachName + ": " + akRefName + " :Canceled by NPC's Arousal: " + chance)
		return false
	elseif (SexUtil.GetArousal(akActor, akRef) < SLApproachMain.lowestArousalPC)
		slappUtil.log(ApproachName + ": " + akRefName + " :Canceled by PC's Arousal: ---")
		return false
	endif

	int StandardlevelRangeminimum = (akActor.getlevel() - SLApproachMain.SLADeviationLevel)
	int StandardlevelRangemaximum = (akActor.getlevel() + SLApproachMain.SLADeviationLevel)

	If akref.getlevel() < StandardlevelRangeminimum
		if SLApproachMain.SLALowerLevelNPC == false
			Return false
		endif
	Elseif akref.getlevel() > StandardlevelRangemaximum
		if SLApproachMain.SLAhigherLevelNPC == false
			Return false
		endif
	Elseif (akref.getlevel() >= StandardlevelRangeminimum) && (akref.getlevel() <= StandardlevelRangemaximum)
		if SLApproachMain.SLAStandardLevelNPC == false
			Return false
		endif
	EndIf
	
	int pt_gll = slappUtil.LightLevelCalc(akRef)
	int pt_time = slappUtil.TimeCalc()
	int pt_nude = slappUtil.NudeCalc(akActor)
	int pt_Appearance = slappUtil.AppearanceCalc()
	int pt_bed = slappUtil.BedCalc(akActor) / 2
	;int pt_reject = slappUtil.RejectCalc(akActor) / 2

	; Chance Calculation ---------------------------------
	;chance += slappUtil.RelationCalc(akRef, akActor);(-60~50);Old
	chance += pt_gll;from-50~25
	chance += pt_time;from-25~25
	chance += pt_nude;from0~70
	chance += pt_Appearance;from0~75
	chance += pt_bed;-30or20
	;chance += pt_reject;WIP
	;chance -= 15


	if Parent.PrecheckShota(akRef)
		if !akRef.isinfaction(slapp_KidFaction)
			akRef.addtofaction(slapp_KidFaction)
		endif
	endif

	if SLA_DDI.getvalue() == 1
		(SLApproach_ExternalMods as SLApproachExternalScript).CheckDD(akActor)
	endif
	if sla_slsurvival.getvalue() == 1
		(SLApproach_ExternalMods as SLApproachExternalScript).SLSurvivalLicenseCheck()
	endif
	;bool bnaked = slappUtil.CheckArmor(PlayerRef, false)
	bool bnaked = slappUtil.IfNaked(PlayerRef)
	int ichanceAskSex = ComputeChanceAskSex(akRef, SLApproachMain.userAddingPointPc)
	int ichanceGeneralTalk = ComputeChanceGeneralTalk(akRef, SLApproachMain.userAddingaskingnamePointPc)
	int ichanceSpanking = ComputeChanceSpanking(akRef, SLApproachMain.userAddingSpankingAssPointPc)
	slapp_PlayerNakedGlobal.setvalue(bnaked as float)
	slapp_PlayerUnderwearGlobal.setvalue(slappUtil.IfWearingUnderwear(PlayerRef) as float)
	roll = Utility.randomint(0, ichanceAskSex + ichanceGeneralTalk + ichanceSpanking)
	
	If (roll <= ichanceGeneralTalk) && (ichanceGeneralTalk > 0)
		; for asking name ---------------------------------
		roll = GetDiceRoll()

		;if akRef.isinfaction(slapp_VisitingFaction)
		if akref == StayingActor.GetReference() as Actor
			result = GetResult(chance, SLApproachMain.userAddingVisitorPointPc, baseChanceMultiplier)
			slappUtil.log(ApproachName + ": " + akRefName + " :Kiss: " + roll + " < " + result)
			;SLAFactorScore.value = result

			if (roll < result)
				int randomi = Utility.randomint(1, 2);1 common, 2 Ask for Drink
				akRef.Setactorvalue("Variable06", randomi)
				selectedScene = SLApproachHouseStayScene
				if SLApproachMain.debugLogFlag
					debug.notification("SLAPP House Visitor Start")
				endif
				return true ; for asking name
			endif
		else
			result = GetResult(chance, SLApproachMain.userAddingAskingNamePointPc, baseChanceMultiplier)
			slappUtil.log(ApproachName + ": " + akRefName + " :Kiss: " + roll + " < " + result)
			;SLAFactorScore.value = result
			if (roll < result)

					selectedScene = SLAppAskingNameToPCScene
					If SLApproachMain.enableApproachNakedFlag == false && bnaked; WIP configurable chance?
						selectedScene = SLApproachResponsetoNudityScene
					endif
					If SLApproachMain.enableBDFlag
						if (akRef.isinfaction(SLApproachMain.BaboViceGuardCaptainFaction))
							selectedScene = SLAppViceGuardCaptainScene
						elseIf (akRef.isinfaction(SLApproachMain.BaboAggressiveBoyFriend))
							selectedScene = SLAppAggressiveBFPCScene
						elseIf (akRef.isinfaction(SLApproachMain.BaboAnonymousSlaverFaction));WIP
							return false
							;if (akactor.getfactionrank(SLApproachMain.BaboKidnapCaptiveFaction)) == 0
							;	selectedScene = SLAppAggressiveBFPCScene
							;elseif (akactor.getfactionrank(SLApproachMain.BaboKidnapCaptiveFaction)) == 1
							;	selectedScene = SLAppAggressiveBFPCScene
							;endif
						EndIf
					EndIf

				if SLApproachMain.debugLogFlag
					debug.notification("SLAPP Asking name Start")
				endif
				return true ; for asking name
			endif
		endif
	Elseif (roll <= (ichanceAskSex + ichanceGeneralTalk)) && (ichanceAskSex > 0)
		; for asking Sex ---------------------------------
		;slapp_SexRejectCountFaction WIP
		if SLA_DDI.getvalue() == 1
			if akActor.IsEquipped(SLApproachDDIYokeList)
				return false
			endif
		endif

		roll = GetDiceRoll()
		
		;if akRef.isinfaction(slapp_VisitingFaction)
		if akref == StayingActor.GetReference() as Actor
			result = GetResult(chance, SLApproachMain.userAddingVisitorPointPc, baseChanceMultiplier)
			slappUtil.log(ApproachName + ": " + akRefName + " :Kiss: " + roll + " < " + result)
			;SLAFactorScore.value = result

			if (roll < result)
				int randomi = Utility.randomint(3, 4);3Flirt, 4ask for Sex
				akRef.Setactorvalue("Variable06", randomi)
				selectedScene = SLApproachHouseStayScene
				if SLApproachMain.debugLogFlag
					debug.notification("SLAPP House Visitor Sex Start")
				endif
				return true ; for asking sex
			endif
		else
			result = GetResult(chance, SLApproachMain.userAddingPointPc, baseChanceMultiplier)

			slappUtil.log(ApproachName + ": " + akRefName + " :Sex: " + roll + " < " + result)
			;SLAFactorScore.value = result
			if (roll < result)
				selectedScene = SLApproachAskForSexQuestScene
				
				If SLApproachMain.enableApproachNakedFlag == false && bnaked; WIP configurable chance?
					selectedScene = SLApproachResponsetoNudityScene
				endif
				If SLApproachMain.enableBDFlag
					if (akRef.isinfaction(SLApproachMain.BaboViceGuardCaptainFaction))
						selectedScene = SLAppViceGuardCaptainScene
					elseIf (akRef.isinfaction(SLApproachMain.BaboAggressiveBoyFriend))
						selectedScene = SLAppAggressiveBFPCScene
					EndIf
				EndIf

				if SLApproachMain.debugLogFlag
					debug.notification("SLAPP Asking Sex Start")
				endif
				return true ; for sex
			endif
		endif
	Elseif (roll <= (ichanceAskSex + ichanceGeneralTalk + ichanceSpanking)) && (ichanceSpanking > 0)
		; for Sexual Harrassment ---------------------------------

		if SLA_DDI.getvalue() == 1
			if akActor.IsEquipped(SLApproachDDIYokeList)
				return false
			endif
		endif

		roll = GetDiceRoll()
		
		;if akRef.isinfaction(slapp_VisitingFaction)
		if akref == StayingActor.GetReference() as Actor
			result = GetResult(chance, SLApproachMain.userAddingVisitorPointPc, baseChanceMultiplier)
			slappUtil.log(ApproachName + ": " + akRefName + " :Kiss: " + roll + " < " + result)
			;SLAFactorScore.value = result

			if (roll < result)
				int randomi = Utility.randomint(3, 4);3Flirt, 4ask for Sex
				akRef.Setactorvalue("Variable06", randomi)
				selectedScene = SLApproachHouseStayScene
				if SLApproachMain.debugLogFlag
					debug.notification("SLAPP House Visitor Sex Start")
				endif
				return true ; for asking sex
			endif
		else
			result = GetResult(chance, SLApproachMain.userAddingPointPc, baseChanceMultiplier)

			slappUtil.log(ApproachName + ": " + akRefName + " :Sex: " + roll + " < " + result)
			;SLAFactorScore.value = result
			if (roll < result)

					selectedScene = SLApproachSpankingScene
				If SLApproachMain.enableApproachNakedFlag == false && bnaked; WIP configurable chance?
					selectedScene = SLApproachResponsetoNudityScene
				endif
					If SLApproachMain.enableBDFlag
						if (akRef.isinfaction(SLApproachMain.BaboViceGuardCaptainFaction))
							selectedScene = SLAppViceGuardCaptainSpankScene
						elseIf (akRef.isinfaction(SLApproachMain.BaboAggressiveBoyFriend))
							;Nothing now
						EndIf
					EndIf

				if SLApproachMain.debugLogFlag
					debug.notification("SLAPP Spanking Start")
				endif
				return true ; for sex
			endif
		endif
	EndIf
	return false
EndFunction

int Function ComputeChanceSpanking(actor akactor, int ichance)
	if !akactor.isinfaction(slapp_AquaintedFaction) && akactor.getfactionrank(slapp_Characterfaction) < 3
		ichance = (ichance / 2)  as int
	endif
	if akactor.getfactionrank(slapp_Characterfaction) >= 2
		ichance += akactor.getfactionrank(slapp_Characterfaction) * 5
	endif
	if akactor.getfactionrank(slapp_TraitAttitudefaction) >= 5
		ichance += 5
	endif
	if akactor.getfactionrank(slapp_TraitFetishfaction) >= 1
		ichance += 5
	endif
	if akactor.getfactionrank(slapp_TraitNormalfaction) == 3
		ichance += 5
	endif
	if akactor.getfactionrank(slapp_TraitAddictfaction) == 3
		ichance += 10
	endif	
	ichance += (SLAButtsSlide.value / 10) as int
	return ichance
EndFunction

int Function ComputeChanceAskSex(actor akactor, int ichance)
	if !akactor.isinfaction(slapp_AquaintedFaction) && akactor.getfactionrank(slapp_Characterfaction) < 3
		ichance = (ichance / 2)  as int
	endif
	
	if akactor.isinfaction(slapp_SexRejectCountFaction)
		ichance -= (akactor.getfactionrank(slapp_SexRejectCountFaction) + 1) * 2
	endif
	
	if akactor.getfactionrank(slapp_Characterfaction) >= 2
		ichance += akactor.getfactionrank(slapp_Characterfaction) * 5
	endif

	if akactor.getfactionrank(slapp_TraitAttitudefaction) <= 1
		ichance -= 10
	elseif akactor.getfactionrank(slapp_TraitAttitudefaction) <= 4
		ichance -= 5
	elseif akactor.getfactionrank(slapp_TraitAttitudefaction) >= 5
		ichance += 5
	endif
	if akactor.isinfaction(slapp_WaitingForSexFaction)
		ichance += 30
	endif
	ichance += akactor.getfactionrank(slapp_TraitFetishfaction) + 1
	
	if akactor.getfactionrank(slapp_TraitNormalfaction) == 3
		ichance += 5
	endif
	if akactor.getfactionrank(slapp_TraitAddictfaction) == 3
		ichance += 20
	endif
	
	if ichance < 0
		ichance = 0
	endif
	
	return ichance
EndFunction

int Function ComputeChanceGeneralTalk(actor akactor, int ichance)
	if !akactor.isinfaction(slapp_AquaintedFaction)
		ichance *= 2
	endif
	if akactor.getfactionrank(slapp_TraitAttitudefaction) <= 4
		ichance += 5
	endif
	if akactor.getfactionrank(slapp_TraitNormalfaction) == 2
		ichance += 5
	endif
	
	return ichance
EndFunction

Bool Function CheckEndApproach()
	Actor akRef = talkingActor.GetReference() as Actor
	if SLApproachMain.debugLogFlag
		Debug.notification("Child: CheckEndApproach")
	endif
	
	if akRef
		if akRef.isindialoguewithplayer() == true
			return false
		else
			endApproachForce(none)
			return true
		endif
	else
		endApproachForce(none)
		return true
	endif
EndFunction

bool Function endApproach(bool force = false)
	if SLApproachMain.debugLogFlag
		Debug.notification("Child: EndApproach")
	endif
	int retryTime = 30
	Actor akRef = talkingActor.GetReference() as Actor
	Actor akstayingRef = stayingActor.GetReference() as Actor
	
	SLA_Peeing.setvalue(0)
	if (!force && SLApproachAskForSexQuestFollowPlayerScene.isPlaying())
		slappUtil.log(ApproachName + ": Now following scene is playing, retry.")
		parent.RegisterForSingleUpdate(retryTime)
		return false
;	elseif (!force && SLApproachSDialogueFollowScene.isPlaying())
;		slappUtil.log(ApproachName + ": Now following scene is playing, retry.")
;		parent.RegisterForSingleUpdate(retryTime)
;		return false
	elseif (!force && SLAppHousevisitScene.isPlaying())
		slappUtil.log(ApproachName + ": Now following scene is playing, retry.")
		parent.RegisterForSingleUpdate(retryTime)
		return false
	elseif (!force && akRef && akRef.IsInDialogueWithPlayer())
		slappUtil.log(ApproachName + ": Now IsInDialogueWithPlayer, retry.")
		parent.RegisterForSingleUpdate(retryTime)
		return false
	else
		SLApproachKissResist.setvalue(0)
		PCApproachOngoing = false
		approachEnding = false
		selectedScene.Stop()
		;SLApproachSDialogueFollowScene.Stop()
		SLApproachAskForSexQuestFollowPlayerScene.Stop()
		SLAppHousevisitScene.Stop()
		SLApproachHouseStayScene.stop()
		if akstayingRef && akstayingRef.isinfaction(slapp_VisitingScenePlayFaction)
			akstayingRef.removefromfaction(slapp_VisitingScenePlayFaction)
		endif		
		HelperQuest.Stop()
		talkingActor.clear()
		SLApproachAskForSexQuest.SetStage(100)
		return true
	endif
EndFunction

Function endApproachForce(ReferenceAlias akRef = None)
	UnregisterForUpdate()
	parent.endApproachForce(talkingActor)
	self.followSceneStop()
	self.endApproach(true)
EndFunction

Function StartSex(Actor akActor, Actor akSpeaker, bool rape = false)
	If rape
		SLApproachRapedTimes.setvalue(SLApproachRapedTimes.getvalue() + 1)
	else
		SLApproachNormalSexTimes.setvalue(SLApproachNormalSexTimes.getvalue() + 1)
	endif
	SexUtil.StartSexActors(akSpeaker, akActor, rape)
	;Debug.notification(akSpeaker + "StartSex")
EndFunction

Function StartSexHook(Actor akActor, Actor akSpeaker, bool rape = false, String EventRegisterDummy, String EventName, int Chance, Bool Worse)
	SexUtil.BaboDialogueRandomintSet(Chance, Worse)
	If rape
		SLApproachRapedTimes.setvalue(SLApproachRapedTimes.getvalue() + 1)
	else
		SLApproachNormalSexTimes.setvalue(SLApproachNormalSexTimes.getvalue() + 1)
	endif
	SexUtil.StartSexActorsHook(akSpeaker, akActor, rape, true, EventRegisterDummy, EventName)
	;Debug.notification(akSpeaker + "StartSex")
EndFunction

Function ProstitutionStartSex(Actor akActor, Actor akSpeaker)
	SLApproachProstitutionTimes.setvalue(SLApproachProstitutionTimes.getvalue() + 1)
;	ProstitutionPaid(); This will be changed
	SexUtil.StartSexActorsHook(akSpeaker, akActor, false, true, "AfterProst", "AfterProstitute")
EndFunction

Function StartSexMulti(Actor akActor, Actor akSpeaker, Actor Helper, bool rape = false)
	If rape
		SLApproachRapedTimes.setvalue(SLApproachRapedTimes.getvalue() + 1)
	else
		SLApproachNormalSexTimes.setvalue(SLApproachNormalSexTimes.getvalue() + 1)
	endif
	SexUtil.StartSexMultiActors(akSpeaker, akActor, Helper, rape)
EndFunction

Function StopSceneForce();Used in Config
	UnregisterForUpdate()
	Parent.AnimationPlays(false)
	parent.endApproachForce(none)
	self.followSceneStop()
	self.endApproach(true)
EndFunction

Bool Function StopScene()
	if self.endApproach(false)
		Parent.AnimationPlays(false)
		parent.endApproachForce(talkingActor)
		;self.followSceneStop()
		UnregisterForUpdate()
		return true
	else
		return false
	endif
EndFunction

Function GotoPrivateRoomFade(actor akactor, Bool ToSexCell)
	FadeToBlackImod.Apply()
	utility.wait(2)
	SLApproachMain.TeleporttoSexCell(akactor, ToSexCell)
	FadeToBlackImod.PopTo(FadeToBlackHoldImod)
	ToxicFoodRapedby(akactor)
	utility.wait(2)
	FadeToBlackHoldImod.PopTo(FadeToBlackBackImod)
	FadeToBlackHoldImod.Remove()
EndFunction

Function GotoPrivateRoom(actor akactor, Bool ToSexCell)
	SLApproachMain.TeleporttoSexCell(akactor, ToSexCell)
EndFunction

Function GotoPrivateRoomOnlyNPC(actor akactor, Bool ToSexCell)
	SLApproachMain.TeleporttoSexCellOnlyNPC(akactor, ToSexCell)
EndFunction

Function enjoySman(Actor akactor = none, Bool Rape = false)
	if akactor == none
		akactor = talkingActor.GetReference() as Actor
	endif
	self.SmanSex(akactor, false)
	self.AcquaintancePlus(akactor, false, true)
	Parent.ResetSexRejectCount(akactor)
	self.followSceneStop()
	Utility.wait(1.0)
	Self.StopScene()
EndFunction

Function SmanSex(Actor akactor, Bool Rape)
int Chance
	HelperQuest.Start()
	if Rape
		int choice = SLAPP_ForgiveCrimeMsg.Show()

		if choice == 0
			akactor.setfactionrank(slapp_ThinkRapeAllowedFaction, 1)
		elseif choice == 1
			akactor.addtofaction(slapp_ThinkRapeAllowedFaction)
		else
			akactor.removefromfaction(slapp_ThinkRapeAllowedFaction)
		endif

		Chance = SLApproachMain.SLADislikeChance
		SLApproachRapedTimes.setvalue(SLApproachRapedTimes.getvalue() + 1)
		if akactor.getfactionrank(slapp_ThinkRapeAllowedFaction) == 0
			Self.AcquaintancePlusCalc(akactor, 5, true)
		elseif akactor.getfactionrank(slapp_ThinkRapeAllowedFaction) == 1
			Self.AcquaintancePlusCalc(akactor, 10, true)
		else
			Parent.AddtoDislikeFaction(akactor, Chance, True)
		endif
		slappUtil.DetectPlayerAttire(akactor, 0, 7)
	else
		slappUtil.DetectPlayerAttire(akactor, 4, 0)
	endif
	Self.followSceneStop()
	;self.StartSexMulti(PlayerRef, akactor, HelpRaperRef.GetReference() as Actor, true)
	akactor.removefromfaction(slapp_WaitingForSexFaction)
	SexUtil.StartSexSmall(akactor, PlayerRef, rape, false, "", "")
	Self.StopScene()
EndFunction

Function enjoy()
	actor akactor = talkingActor.GetReference() as Actor
	if SLApproachMain.SLAProstitutionFollow
		self.ProstitutionStartSex(PlayerRef, akactor)
		self.ProstitutionPlus(akactor)
	else
		self.StartSex(PlayerRef, akactor)
		self.AcquaintancePlus(akactor, false, true)
	endif
	Parent.ResetSexRejectCount(akactor)
	self.followSceneStop()
	Utility.wait(1.0)
	Self.StopScene()
EndFunction

Function enjoyStayingActor()
	actor akactor = stayingActor.GetReference() as Actor
	self.StartSex(PlayerRef, akactor)
	self.AcquaintancePlus(akactor, false, true)
	Parent.ResetSexRejectCount(akactor)
	self.followSceneStop()
	Utility.wait(1.0)
	Self.StopScene()
EndFunction

Function Sexforreconciliation(Actor akSpeaker, int Possibility)
	Self.CoolDown(akSpeaker, Possibility)
	slappUtil.DetectPlayerAttire(akSpeaker, 4, 0)
	;SLApproachNormalSexTimes.setvalue(SLApproachNormalSexTimes.getvalue() + 1)
	self.followSceneStop()
	self.StartSex(PlayerRef, akSpeaker)
	Self.StopScene()
EndFunction

Function enjoyMulti(Actor akSpeaker)
	;SLApproachNormalSexTimes.setvalue(SLApproachNormalSexTimes.getvalue() + 1)
	slappUtil.DetectPlayerAttire(akSpeaker, 4, 0)
	self.followSceneStop()
	self.StartSexMulti(talkingActor.GetReference() as Actor, PlayerRef, akSpeaker, false)
	Self.StopScene()
EndFunction



;#############################################
;############Normal Dialogue End##############
;#############################################

Function FirstMetEnd(Actor akactor)
	Parent.AddtoAquaintanceFactionSimple(akactor, SLApproachMain.SLAAquaintanceChance)
	slappUtil.DetectPlayerAttire(akactor, 1, 0)
	Parent.CountConversationRejectTime(akactor, -1)
	Self.StopSceneForce()
EndFunction

Function NothingEnd(actor akactor = none)
	if akactor
		slappUtil.DetectPlayerAttire(akactor, 0, 0)
	endif
	SLApproachHadDialogueSpell.cast(PlayerRef, akactor)
	Self.StopSceneForce()
EndFunction

Function HopeGetDressed(Actor akSpeaker, int rank = 0);WIP
	Parent.AddtoHopeGetDressedFaction(akSpeaker, rank)
	slappUtil.DetectPlayerAttire(akSpeaker, 0, 0)
	Self.StopSceneForce()
EndFunction

Function AcquaintanceRankForce(Actor akactor, int Rank)
	akactor.setfactionrank(slapp_AquaintedFaction, Rank)
	slappUtil.DetectPlayerAttire(akactor, 1, 0)
	Parent.CountConversationRejectTime(akactor, -1)
	SLApproachHadDialogueSpell.cast(PlayerRef, akactor)
	Self.StopScene()
EndFunction

Function AcquaintanceForce(Actor akactor, Bool HadSex)
	Parent.AddtoAquaintanceFaction(akactor, 100, HadSex)
	Parent.sexRelationshipUp(akactor, PlayerRef, 100)
	slappUtil.DetectPlayerAttire(akactor, 1, 0)
	Parent.CountConversationRejectTime(akactor, -1)
	SLApproachHadDialogueSpell.cast(PlayerRef, akactor)
	Self.StopScene()
EndFunction

Function Acquaintance(Actor akactor)
	Self.AcquaintanceCalc(akactor)
	slappUtil.DetectPlayerAttire(akactor, 1, 0)
	Parent.CountConversationRejectTime(akactor, -1)
	SLApproachHadDialogueSpell.cast(PlayerRef, akactor)
	Self.StopScene()
EndFunction

Function AcquaintancePlus(Actor akactor, Bool StopQuest = True, Bool HadSex = True)
	Self.AcquaintancePlusCalc(akactor, 10, Hadsex)
	if Hadsex
		slappUtil.DetectPlayerAttire(akactor, 4, 0)
	else
		slappUtil.DetectPlayerAttire(akactor, 1, 0)
	endif
	if StopQuest == true
		Parent.CountConversationRejectTime(akactor, -1)
		SLApproachHadDialogueSpell.cast(PlayerRef, akactor)
		Self.StopScene()
	endif	 
EndFunction

Function ShowOffBodyEnd(Actor akactor, int iBonus = 0, Bool StopQuest = True, Bool HadSex = False)
	Self.AcquaintancePlusCalc(akactor, iBonus, Hadsex)
	slappUtil.DetectPlayerAttire(akactor, 1, 0)
	if StopQuest == true
		Parent.ResetSexRejectCount(akactor)
		Self.StopScene()
	endif	 
EndFunction


Function AcquaintanceCalc(Actor akSpeaker)
	Parent.AddtoAquaintanceFaction(akSpeaker, SLApproachMain.SLAAquaintanceChance, false)
	Parent.sexRelationshipUp(akSpeaker, PlayerRef, SLApproachMain.SLARelationshipChance)
EndFunction

Function AcquaintancePlusCalc(Actor akSpeaker, int Bonus, Bool HadSex = True)
Int AcquaintanceChance = SLApproachMain.SLAAquaintanceChance + Bonus
Int RelationshipChance = SLApproachMain.SLARelationshipChance + Bonus
	Parent.AddtoAquaintanceFaction(akSpeaker, AcquaintanceChance, Hadsex)
	Parent.sexRelationshipUp(akSpeaker, PlayerRef, RelationshipChance)
EndFunction

Function GiftGive(Actor akactor)
int Number = Utility.randomint(1, 3)
Int AcquaintanceChance = SLApproachMain.SLAAquaintanceChance
	PlayerRef.additem(SLAPPAffectionMiscLVL, Number)

	Parent.GiftFaction(akactor, AcquaintanceChance)
	Utility.wait(1.0)
	slappUtil.DetectPlayerAttire(akactor, 3, 0)
	SLApproachGiftTimes.setvalue(SLApproachGiftTimes.getvalue() + 1)
	Self.AcquaintancePlusCalc(akactor, 20, false)
	Parent.CountConversationRejectTime(akactor, -1)
	SLApproachHadDialogueSpell.cast(PlayerRef, akactor)
	Self.StopScene()
EndFunction

Function CoolDown(Actor akSpeaker, int chance = 20)
	int roll = Utility.RandomInt(0, 100)
	chance += ((SLABreastsSlide.value / 10) + (SLAButtsSlide.value / 10) + (SLAAppearanceSlide.value / 10)) as int
	if roll <= chance
		Int RelationshipChance = SLApproachMain.SLARelationshipChance + 20
		if akspeaker.isinfaction(slapp_DislikeFaction)
			if Parent.RankDownDislikeFaction(PlayerRef) == 0
				Parent.AddtoReconciliationFaction(PlayerRef)
			endif
			Parent.sexRelationshipUp(akSpeaker, PlayerRef, RelationshipChance)
		endif
	endif
Self.StopScene()	 
EndFunction

Function GratefulBye(Actor akactor, int Impression = 0, int IRank = 0)

	if akactor.isinfaction(slapp_AquaintedFaction)
		Self.AcquaintancePlusCalc(akactor, Impression * 5, false)
	else
		Parent.AddtoFirstImpressionFaction(akactor, IRank)
		akactor.addtofaction(slapp_AquaintedFaction);100%
		Self.AcquaintancePlusCalc(akactor, Impression * 3, false)
		;Self.AcquaintanceCalc(akactor)
	endif

	slappUtil.DetectPlayerAttire(akactor, 1, 0)
	Self.StopScene()
EndFunction

Function LoveConfessionFaction(actor akactor, int irank);WIP When Confessed and rejected there might be a chance to be a rapist.
	Parent.AddtoLoverFaction(akactor, irank)
Endfunction


;#############################################
;##############Bad Dialogue End###############
;#############################################

Function disagree(Actor akactor, Bool Prostitution = false, Bool SexOffer = false)
	int factionrank = akactor.getfactionrank(slapp_AquaintedFaction)
	int RejectCount = akactor.getfactionrank(slapp_SexRejectCountFaction)
	if factionrank >= 3 && SexOffer
		if RejectCount >= 3
			Parent.AddtoDislikeFaction(akactor, (SLApproachMain.SLADislikeChance + 20), false)
		else
			Parent.CountSexRejectTime(akactor, Prostitution, 1)
		endif
	elseif factionrank >= 5 && SexOffer;Lover
		Parent.CountSexRejectTime(akactor, Prostitution, 1);WIP
	else
		Parent.AddtoDislikeFaction(akactor, SLApproachMain.SLADislikeChance, false)
	endif
	;slappUtil.DetectPlayerAttire(akactor, 0, 0)
	if Prostitution
		slappUtil.DetectPlayerAttire(akactor, 0, 2)
		SLApproachProstitutionTryTimes.setvalue(SLApproachProstitutionTryTimes.getvalue() + 1)
	else
		slappUtil.DetectPlayerAttire(akactor, 0, 1)
	endif
	Self.StopScene()
EndFunction

Function disagreePlus(Actor akSpeaker, Bool Prostitution = false)
int Chance = SLApproachMain.SLADislikeChance + 20
	Parent.AddtoDislikeFaction(akSpeaker, Chance)
	Parent.sexRelationshipDown(akSpeaker, PlayerRef, SLApproachMain.SLARelationshipChance)
	;slappUtil.DetectPlayerAttire(akSpeaker, 0, 0)
	if Prostitution
		slappUtil.DetectPlayerAttire(akSpeaker, 0, 2)
		SLApproachProstitutionTryTimes.setvalue(SLApproachProstitutionTryTimes.getvalue() + 1)
	else
		slappUtil.DetectPlayerAttire(akSpeaker, 0, 1)
	endif
	Self.StopScene()
EndFunction

Function RefuseVisit(Actor akSpeaker, Bool Prostitution = false)
	disagree(akSpeaker, Prostitution, false)
	CleartheHouse()
EndFunction

Function Disappointed(Actor akSpeaker, int possibility = 70, int rank = 0)
	Parent.AddtoDisappointedFaction(akSpeaker, possibility, rank)
	slappUtil.DetectPlayerAttire(akSpeaker, 0, 0)
	Self.StopSceneForce()
EndFunction

Function DisappointedPlus(Actor akSpeaker);Redundant, No more used.
	Parent.AddtoDisappointedFaction(akSpeaker, 100, 1)
	slappUtil.DetectPlayerAttire(akSpeaker, 0, 0)
	Self.StopSceneForce()
EndFunction

Function ComplainAboutNude(Actor akactor)
	Self.Disagree(akactor, false, false)
	;akspeaker.say(SLApproachTalkAboutWearingsNPCComplainWearingNormal);WIP
EndFunction

Function ComplainAboutWearings(Actor akactor)
	Self.Disagree(akactor, false, false)
	akactor.say(SLApproachTalkAboutWearingsNPCComplainWearingNormal)
EndFunction



Function IgnoreHarrassment(Actor akSpeaker)
int Chance = SLApproachMain.SLADislikeChance - 10
	Parent.AddtoDislikeFaction(akSpeaker, Chance, false)
	Parent.sexRelationshipDown(akSpeaker, PlayerRef, SLApproachMain.SLARelationshipChance)
	slappUtil.DetectPlayerAttire(akSpeaker, 0, 1)
	Self.StopScene()
EndFunction

Function Ignore(Actor akactor)
int Chance = SLApproachMain.SLADislikeChance + 20
	Parent.AddtoDislikeFaction(akactor, Chance, false)
	Parent.sexRelationshipDown(akactor, PlayerRef, SLApproachMain.SLARelationshipChance)
	slappUtil.DetectPlayerAttire(akactor, 0, 0)
	Parent.CountConversationRejectTime(akactor, 1)
	Self.StopScene()
EndFunction

Function IgnoreAcquaintance(Actor akactor)
	if akactor.isinfaction(slapp_ConversationRejectCountFaction)
		int inum = akactor.getfactionrank(slapp_ConversationRejectCountFaction)
		if inum >= 5
			Ignore(akactor)
		else
			Parent.CountConversationRejectTime(akactor, 1)
			NothingEnd(akactor)
		endif
	else
		Parent.CountConversationRejectTime(akactor, 1)
		NothingEnd(akactor)
	endif
EndFunction



Function IntroductionReject(Actor akactor);WIP it will affect the approach chance
	Parent.CountIntroductionRejectTime(akactor, 1)
	Parent.AddtoFirstImpressionFaction(akactor, 4)
	Parent.ManageThinkAboutPlayerFaction(akactor, 5, 0, true, false)
	slappUtil.DetectPlayerAttire(akactor, 0, 0)
	Self.StopScene()
EndFunction

Function ConversationReject(Actor akactor);WIP it will affect the approach chance
	Parent.CountConversationRejectTime(akactor, 1)
	slappUtil.DetectPlayerAttire(akactor, 0, 0)
	Self.StopScene()
EndFunction

Function ConfessReject(Actor akactor);WIP it will affect the approach chance
	Parent.CountConfessRejectTime(akactor, 1)
	;Parent.AddtoFirstImpressionFaction(akactor, 4)
	Parent.ManageThinkAboutPlayerFaction(akactor, 5, 0, true, false)
	Disappointed(akactor, 70, 0)
	;slappUtil.DetectPlayerAttire(akactor, 0, 0)
	;Self.StopScene()
EndFunction

Function UngratefulBye(Actor akactor, int Impression, int IRank = 1);Impression 0 Very bad 1 Bad 2 Normal
	
	int ichance = SLApproachMain.SLADislikeChance
	int factionrank
	if akactor.isinfaction(slapp_AquaintedFaction)
		factionrank = akactor.getfactionrank(slapp_AquaintedFaction)
		if factionrank <= 2
			factionrank += 1
		elseif factionrank >= 3 && factionrank <= 4
			factionrank += 2
		else
			factionrank += 4
		endif
		ichance = Math.Ceiling(ichance / factionrank)
		Parent.AddtoDislikeFaction(akactor, ichance)
	else
		Parent.AddtoFirstImpressionFaction(akactor, IRank)
		akactor.addtofaction(slapp_AquaintedFaction);100%
		;factionrank = Impression + 1
	endif

	slappUtil.DetectPlayerAttire(akactor, 0, 0)
	Self.StopScene()
EndFunction

Function rapedBy(Actor akSpeaker)

int choice = SLAPP_ForgiveCrimeMsg.Show()
	
if choice == 0
	akSpeaker.setfactionrank(slapp_ThinkRapeAllowedFaction, 1)
elseif choice == 1
	akSpeaker.addtofaction(slapp_ThinkRapeAllowedFaction)
else
	akSpeaker.removefromfaction(slapp_ThinkRapeAllowedFaction)
endif

;Actor ActorRaper = talkingActor.GetReference() as Actor
int Chance = SLApproachMain.SLADislikeChance + 40
	HelperQuest.Start()
	SLApproachRapedTimes.setvalue(SLApproachRapedTimes.getvalue() + 1)
	If (SLApproachMain.enableSLHHFlag)
		Self.followSceneStop()
		slappUtil.DetectPlayerAttire(akSpeaker, 0, 6)
		Utility.wait(1.0)
		SLHHActivate(akSpeaker, None)
		if SLApproachMain.debugLogFlag
			Debug.notification(akSpeaker + "SLHH Activated")
		endif

	Else
		slappUtil.DetectPlayerAttire(akSpeaker, 0, 7)
		if akSpeaker.getfactionrank(slapp_ThinkRapeAllowedFaction) == 0
			Self.AcquaintancePlusCalc(akSpeaker, 5, true)
		elseif akSpeaker.getfactionrank(slapp_ThinkRapeAllowedFaction) == 1
			Self.AcquaintancePlusCalc(akSpeaker, 10, true)
		else
			Parent.AddtoDislikeFaction(akSpeaker, Chance, True)
		endif
		Self.followSceneStop()
		self.StartSexMulti(PlayerRef, akSpeaker, HelpRaperRef.GetReference() as Actor, true)
		Self.StopScene()
	EndIf
EndFunction

Function rapedByLover(Actor akSpeaker)


int choice = SLAPP_ForgiveCrimeMsg.Show()
	
if choice == 0
	akSpeaker.setfactionrank(slapp_ThinkRapeAllowedFaction, 1)
elseif choice == 1
	akSpeaker.addtofaction(slapp_ThinkRapeAllowedFaction)
else
	akSpeaker.removefromfaction(slapp_ThinkRapeAllowedFaction)
endif

	HelperQuest.Start()
	SLApproachRapedTimes.setvalue(SLApproachRapedTimes.getvalue() + 1)
	If (SLApproachMain.enableSLHHFlag)
		Self.followSceneStop()
		slappUtil.DetectPlayerAttire(akSpeaker, 0, 6)
		Utility.wait(1.0)
		SLHHActivate(akSpeaker, None)
		if SLApproachMain.debugLogFlag
			Debug.notification(akSpeaker + "SLHH Activated")
		endif

	Else
		slappUtil.DetectPlayerAttire(akSpeaker, 0, 7)
		if akSpeaker.getfactionrank(slapp_ThinkRapeAllowedFaction) == 0
			Self.AcquaintancePlusCalc(akSpeaker, 5, true)
		elseif akSpeaker.getfactionrank(slapp_ThinkRapeAllowedFaction) == 1
			Self.AcquaintancePlusCalc(akSpeaker, 10, true)
		else
			Parent.CountRapeTime(akSpeaker)
		endif
		Self.followSceneStop()
		self.StartSexMulti(PlayerRef, akSpeaker, HelpRaperRef.GetReference() as Actor, true)
		Self.StopScene()
	EndIf
EndFunction

Function rapedPlusBy(Actor akSpeaker)
;Actor ActorRaper = talkingActor.GetReference() as Actor

int choice = SLAPP_ForgiveCrimeMsg.Show()
	
if choice == 0
	akSpeaker.setfactionrank(slapp_ThinkRapeAllowedFaction, 1)
elseif choice == 1
	akSpeaker.addtofaction(slapp_ThinkRapeAllowedFaction)
else
	akSpeaker.removefromfaction(slapp_ThinkRapeAllowedFaction)
endif

int Chance = SLApproachMain.SLADislikeChance + 50
	Parent.sexRelationshipDown(akSpeaker, PlayerRef, SLApproachMain.SLARelationshipChance)
	HelperQuest.Start()
	SLApproachRapedTimes.setvalue(SLApproachRapedTimes.getvalue() + 1)
	If (SLApproachMain.enableSLHHFlag)
		Self.followSceneStop()
		slappUtil.DetectPlayerAttire(akSpeaker, 0, 6)
		Utility.wait(1.0)
		SLHHActivate(akSpeaker, None)
		if SLApproachMain.debugLogFlag
			Debug.notification(akSpeaker + "SLHH Activated")
		endif
	Else
		slappUtil.DetectPlayerAttire(akSpeaker, 0, 7)
		if akSpeaker.getfactionrank(slapp_ThinkRapeAllowedFaction) == 0
			Self.AcquaintancePlusCalc(akSpeaker, 5, true)
		elseif akSpeaker.getfactionrank(slapp_ThinkRapeAllowedFaction) == 1
			Self.AcquaintancePlusCalc(akSpeaker, 10, true)
		else
			Parent.AddtoDislikeFaction(akSpeaker, Chance, True)
		endif
		Self.followSceneStop()
		self.StartSexMulti(PlayerRef, akSpeaker, HelpRaperRef.GetReference() as Actor, true)
		Self.StopScene()
	EndIf
EndFunction

Function SexOfferDeny(Actor akactor, Bool Prostitution = false, int count)
	Parent.CountSexRejectTime(akactor, Prostitution, count)
	if Prostitution
		slappUtil.DetectPlayerAttire(akactor, 0, 2)
		SLApproachProstitutionTryTimes.setvalue(SLApproachProstitutionTryTimes.getvalue() + count)
	else
		slappUtil.DetectPlayerAttire(akactor, 0, 0)
	endif
	;Self.StopScene()
EndFunction

;#############################################
;####################Misc#####################
;#############################################

Function NoSpankFaction(actor akactor, int chance)
	int roll = Utility.RandomInt(0, 100)
	chance += (PlayerRef.getactorvalue("Speechcraft") / 10) as int
	chance += (SLAAppearanceSlide.value / 10) as int
	chance -= (SLAButtsSlide.value / 10) as int
	chance -= slappUtil.CharacterCalc(akactor);from-25~25
	chance -= slappUtil.NudeCalc(PlayerRef);from0~70
	if roll <= chance
		Parent.AddtoNoSpankFaction(akactor)
	endif
;slapp_NoSpankFaction

EndFunction

Function NoBackHugFaction(actor akactor, int chance)
	int roll = Utility.RandomInt(0, 100)
	chance += (PlayerRef.getactorvalue("Speechcraft") / 10) as int
	chance += (SLAAppearanceSlide.value / 10) as int
	chance -= slappUtil.TraitCalc(akactor);from-15~30;Experimental. Replace Character
;	chance -= slappUtil.CharacterCalc(akactor);from-25~25
	chance -= slappUtil.NudeCalc(PlayerRef);from0~70
	if roll <= chance
		Parent.AddtoNoBackHugFaction(akactor)
	endif

EndFunction

Function NoMolestFaction(actor akactor, int chance)
	int roll = Utility.RandomInt(0, 100)
	chance += (PlayerRef.getactorvalue("Speechcraft") / 10) as int
	chance += (SLAAppearanceSlide.value / 10) as int
	chance -= (SLABreastsSlide.value / 10) as int
	chance -= (SLAButtsSlide.value / 10) as int
	chance -= slappUtil.CharacterCalc(akactor);from-25~25
	chance -= slappUtil.NudeCalc(PlayerRef);from0~70
	if roll <= chance
		Parent.AddtoNoMolestFaction(akactor)
	endif
	slappUtil.DetectPlayerAttire(akactor, 0, 5)
EndFunction

Function NoMolestFactionReconciliation(actor akactor, int chance)
	int roll = Utility.RandomInt(0, 100)
	chance += (PlayerRef.getactorvalue("Speechcraft") / 10) as int
	chance += (SLAAppearanceSlide.value / 10) as int
	chance -= (SLABreastsSlide.value / 10) as int
	chance -= (SLAButtsSlide.value / 10) as int
	chance -= slappUtil.CharacterCalc(akactor);from-25~25
	chance -= slappUtil.NudeCalc(PlayerRef);from0~70
	if roll <= chance
		Parent.AddtoNoMolestFaction(akactor)
	endif
	Self.CoolDown(akactor, chance)
	slappUtil.DetectPlayerAttire(akactor, 0, 5)
EndFunction

Function ThinkAboutPlayer(actor akactor, int iindex, bool bfac = true, bool bRank = false, int ibonus = 0)
	int ifavor = slappUtil.FavorTowardPlayer(akactor)
	int randomi = Utility.randomint(15, 35)
	ifavor += ibonus
	int iRank
	if ifavor >= randomi
		iRank = 0
	elseif ifavor >= (randomi / 2)
		iRank = 1
	else
		iRank = 2
	endif
	Parent.ManageThinkAboutPlayerFaction(akactor, iindex, iRank, bfac, bRank)
EndFunction


;#############################################
;###############Event Section#################
;#############################################

Function UnequipStripShow(actor akactor)
	slappUtil.UnequipShieldSimple(akactor)
	slappUtil.UnequipSlot(akactor, 4);Cuirass
	slappUtil.FindLower(akactor, true)
EndFunction

Function StripShowStart(Actor akactor)
	talkingActor.ForceRefTo(akactor)
	NPCActor = akactor
	Parent.AcyclePairedMotion(akactor, 180, 0, 50, 5)
	utility.wait(3.0)
	SLAppShowingOffBodyScene.forcestart()
EndFunction

Function StripShowEnd(int Rankint, bool Uprank)
	Parent.ChangeStateStage(0)
	Parent.AddtoStripShowFaction(NPCActor, Rankint, Uprank)
	;relationship up?
	slappUtil.DetectPlayerAttire(NPCActor, 1, 0)
	Parent.RestoreControl(NPCActor)
	SLApproachStripShowAura.cast(PlayerRef, NPCActor)
	SLAppShowingOffBodyScene.stop()
	Self.StopScene()
EndFunction

Function RandomGropeEvent(Actor akactor, int scenario)
int CharacterRank = akactor.getfactionrank(slapp_Characterfaction)
int RandomChance = Utility.randomint(0, 90)
int iProbability = 10
int irandom
NPCActor = akactor
if scenario == 1;Spank
	SpankStart(akactor)
elseif scenario == 2
	GotoState("TouchPussy")
elseif scenario == 3
	GotoState("BackHugMolest")
elseif scenario == 4
	GotoState("PlayPussy")
elseif scenario == 5
	GotoState("SuckPussy")
elseif scenario == 6
	GotoState("FondleBreasts")
elseif scenario == 7
	GotoState("FondlePussy")
elseif scenario == 8
	GotoState("TouchBreasts")
elseif scenario == 9
	GotoState("SuckBreasts")
else
	if CharacterRank > 0
		iProbability = CharacterRank * 30
	endif
	if iProbability >= RandomChance
		irandom = Utility.randomint(0,2)
		if irandom == 0
			GotoState("PlayPussy")
		elseif irandom == 1
			GotoState("SuckPussy")
		else
			GotoState("BackHugMolest")
		endif
	else
		irandom = Utility.randomint(0,2)
		if irandom == 0
			SpankStart(akactor)
		elseif irandom == 1
			GotoState("TouchPussy")
		else
			GotoState("BackHug")
		endif
	endif
endif

SLAppPeekingWhilePeeing.stop()
SLAppPeekingWhileBathing.stop()

EndFunction

Function SpankStart(Actor akactor)
	slappUtil.DetectPlayerAttire(akactor, 0, 3)
	SLApproachMolestTimes.setvalue(SLApproachMolestTimes.getvalue() + 1)
	SLApproachSpankTimes.setvalue(SLApproachSpankTimes.getvalue() + 1)
	Parent.AcyclePairedMotion(akactor, 0, -54, -27, 1)
EndFunction

Function TouchPussyStart(Actor akactor)
	NPCActor = akactor
	Gotostate("TouchPussy")
EndFunction

Function PlayPussyStart(Actor akactor)
	NPCActor = akactor
	Gotostate("PlayPussy")
EndFunction

Function SuckPussyStart(Actor akactor)
	NPCActor = akactor
	Gotostate("SuckPussy")
EndFunction

Function SuckBreastsStart(Actor akactor)
	NPCActor = akactor
	Gotostate("SuckBreasts")
EndFunction

Function TouchBreastsStart(Actor akactor)
	NPCActor = akactor
	Gotostate("TouchBreasts")
EndFunction

Function StartFrontHug(actor akactor)
	NPCActor = akactor
	GotoState("FrontHug")
EndFunction

Function StartFrontHugAbrupt(actor akactor)
	NPCActor = akactor
	GotoState("FrontHugAbrupt")
EndFunction

Function StealTimeOut(actor akactor)
	if SLApproachMain.debugLogFlag
		Debug.notification("StealTimeOut")
	endif
	if PCApproachOngoing && (talkingActor.GetReference() as Actor == akactor)
		Self.NothingEnd(akactor)
	endif
endfunction

Function StripShowTimeOut(actor akactor);Checking
	if SLApproachMain.debugLogFlag
		Debug.notification("StripShowTimeOut")
	endif
	if PCApproachOngoing && (talkingActor.GetReference() as Actor == akactor)
		Self.NothingEnd(akactor)
	endif
EndFunction

Function TouchBreastsTimeOut(actor akactor)
	if SLApproachMain.debugLogFlag
		Debug.notification("TouchBreastsTimeOut")
	endif
	if akactor.GetfactionRank(slapp_HaveSeenNakedBody) <= 1
		Parent.AddtoStripShowFaction(akactor, 2, false)
	endif
	if PCApproachOngoing && (talkingActor.GetReference() as Actor == akactor)
		Self.NothingEnd(akactor)
	endif
EndFunction

Function SuckBreastsTimeOut(actor akactor)
	if SLApproachMain.debugLogFlag
		Debug.notification("SuckBreastsTimeOut")
	endif
	if akactor.GetfactionRank(slapp_HaveSeenNakedBody) <= 2
		Parent.AddtoStripShowFaction(akactor, 3, false)
	endif
	if PCApproachOngoing && (talkingActor.GetReference() as Actor == akactor)
		Self.NothingEnd(akactor)
	endif
EndFunction

Function TouchPussyTimeOut(actor akactor)
	if SLApproachMain.debugLogFlag
		Debug.notification("TouchPussyTimeOut")
	endif
	if akactor.GetfactionRank(slapp_HaveSeenNakedBody) <= 3
		Parent.AddtoStripShowFaction(akactor, 4, false)
	endif
	if PCApproachOngoing && (talkingActor.GetReference() as Actor == akactor)
		Self.NothingEnd(akactor)
	endif
EndFunction

Function PlayPussyTimeOut(actor akactor)
	if SLApproachMain.debugLogFlag
		Debug.notification("PlayPussyTimeOut")
	endif
	if akactor.GetfactionRank(slapp_HaveSeenNakedBody) <= 4
		Parent.AddtoStripShowFaction(akactor, 5, false)
	elseif akactor.GetfactionRank(slapp_HaveSeenNakedBody) == 5
		Parent.AddtoStripShowFaction(akactor, 6, false)
	endif
	if PCApproachOngoing && (talkingActor.GetReference() as Actor == akactor)
		Self.NothingEnd(akactor)
	endif
EndFunction

Function SuckPussyTimeOut(actor akactor)
	if SLApproachMain.debugLogFlag
		Debug.notification("SuckPussyTimeOut")
	endif
	if akactor.GetfactionRank(slapp_HaveSeenNakedBody) <= 6
		Parent.AddtoStripShowFaction(akactor, 7, false)
	elseif akactor.GetfactionRank(slapp_HaveSeenNakedBody) == 6
		Parent.AddtoStripShowFaction(akactor, 8, false)
	endif
	if PCApproachOngoing && (talkingActor.GetReference() as Actor == akactor)
		Self.NothingEnd(akactor)
	endif
EndFunction


;#############################################
;#############################################

Function GiveCuretoActor(Actor akactor)
	PlayerRef.removeitem(CureDisease, 1, false, akactor)
EndFunction



Function FoodPreference(actor akactor, int iRank = 0, Bool bAddfaction = true)
	if bAddfaction
		Parent.AddtoFoodPreferencefaction(akactor, iRank)
	else
		Parent.RemoveFoodPreferencefaction(akactor)
	endif	
EndFunction


Function ProstitutionPlus(Actor akSpeaker)
	Parent.AddtoProstitutionFaction(akSpeaker)
	slappUtil.DetectPlayerAttire(akSpeaker, 5, 0)
	;Self.StopScene()
EndFunction


Function Visited()
	PCVisitingBefore = false
	PCVisitingon = false
	PCVisitingafter = false
	Parent.AddtoVisitiedFaction(VisitorRef)
	Self.StopScene() ;Why?
EndFunction

Function Stayed()
	PCVisitingBefore = false
	PCVisitingon = false
	PCVisitingafter = false
	Parent.AddtoStayedFaction(VisitorRef)
	stayingactor.clear()
	Self.StopScene()
EndFunction

Function VisitedbutFailed()
	PCVisitingBefore = false
	PCVisitingon = false
	PCVisitingafter = false
	If VisitorRef
		Parent.AddtoVisitiedFailedFaction(VisitorRef)
	EndIf
	Self.StopScene() 
EndFunction

Function GuardPunishmentEnd(Actor akactor)
	akactor.addtofaction(slapp_PunishingGuard)
	SLApproachGuardPunishmentTimes.setvalue(SLApproachGuardPunishmentTimes.getvalue() + 1)
	self.disagree(akactor, false, false)
	FollowerRef.clear()
	Debug.SendAnimationEvent(PlayerRef, "IsBleedingOut")
EndFunction

Function FavorCalc(Actor akactor, int iFavor, int iindex = 0, int Rank = 0, bool bfac = true)
	Parent.FavorCalculation(akactor, iFavor, false)
	slappUtil.DetectPlayerAttire(akactor, 0, 0)
	if iindex > 0
		ThinkAboutPlayer(akactor, iindex, bfac, false, 0)
	endif
	Self.StopScene()
EndFunction

Function Baborape(Actor akSpeaker)
;Actor ActorRaper = talkingActor.GetReference() as Actor
	HelperQuest.Start()
	SLApproachRapedTimes.setvalue(SLApproachRapedTimes.getvalue() + 1)
	If (SLApproachMain.enableSLHHFlag)
		Self.followSceneStop()
		slappUtil.DetectPlayerAttire(akSpeaker, 0, 6)
		Utility.wait(1.0)
		SLHHActivate(akSpeaker, None)
		if SLApproachMain.debugLogFlag
			Debug.notification(akSpeaker + "SLHH Activated")
		endif
	Else
		slappUtil.DetectPlayerAttire(akSpeaker, 0, 7)
		Self.followSceneStop()
		Self.StartSexHook(PlayerRef, akSpeaker, true, "BDA", "BaboDialogueAfter", 100, true)
		Utility.wait(1.0)
		Self.StopScene()
	EndIf
EndFunction

Function Baboenjoy(Actor akSpeaker)
	slappUtil.DetectPlayerAttire(akSpeaker, 4, 0)
	Self.StartSexHook(PlayerRef, akSpeaker, true, "BDA", "BaboDialogueAfter", 40, true)
	Self.followSceneStop()
	Utility.wait(1.0)
	Self.StopScene()
EndFunction

Function BaboNothingEnd(Actor akSpeaker)
	slappUtil.DetectPlayerAttire(akSpeaker, 0, 0)
	BaboDialogueSLAPPTrigger(akSpeaker, false, 10)
	Self.StopScene()
EndFunction

Function GuardSLHHChoke(Actor akSpeaker)

int Chance = SLApproachMain.SLADislikeChance
	HelperQuest.Start()

	If (SLApproachMain.enableSLHHFlag)
		Self.followSceneStop()
		Utility.wait(1.0)
		Self.SLHHChokeActivate(akSpeaker, None, 1)
		NPCtalkingActor = akSpeaker
		if SLApproachMain.debugLogFlag
			Debug.notification(akSpeaker + "GuardSLHHChoke")
		endif
	Else
		Self.followSceneStop()
		Parent.AddtoDislikeFaction(akSpeaker, Chance, True)
		Self.StopScene()
		if SLApproachMain.debugLogFlag
			Debug.notification(akSpeaker + "GuardSLHHChoke no SLHH")
		endif
	EndIf
EndFunction

Function SLHHChoke(Actor akSpeaker, int Type);0Sex 1NoSex
int Chance = SLApproachMain.SLADislikeChance
	HelperQuest.Start()
	SLApproachRapedTimes.setvalue(SLApproachRapedTimes.getvalue() + 1)
	If (SLApproachMain.enableSLHHFlag)
		slappUtil.DetectPlayerAttire(akSpeaker, 0, 6)
		Self.followSceneStop()
		Utility.wait(1.0)
		Self.SLHHChokeActivate(akSpeaker, None, Type)
	Else
		Parent.AddtoDislikeFaction(akSpeaker, Chance, True)
		slappUtil.DetectPlayerAttire(akSpeaker, 0, 7)
		Self.followSceneStop()
		self.StartSexMulti(PlayerRef, akSpeaker, HelpRaperRef.GetReference() as Actor, true)
		Self.StopScene()
	EndIf
EndFunction

Function NeedMoneyReady(Actor akactor);WIP
	akactor.addtofaction(slapp_NeedMoneyReadyFaction)
EndFunction

Function EatCumFood(Actor akactor);WIP Corruption Babodialogue?, Stink spell effect?
	Float fAlchemy = PlayerRef.getactorvalue("Alchemy")
	Float frandom = Utility.randomint(30, 50) as float
	if fAlchemy >= frandom
		SLApproachDetectCumFood.setvalue(1)
	else
		SLApproachDetectCumFood.setvalue(0)
	endif
	if !akactor.isinfaction(slapp_FoodCumTriedFaction) || akactor.getfactionrank(slapp_FoodCumTriedFaction) <= 1
		Debug.sendanimationevent(PlayerRef, "Babo_FoodDisgusting")
		SLApproachFoodCumAura.cast(PlayerRef, akactor)
		SLApproachMain.InflationwithInjectorEvent(PlayerRef, akactor, 4, 0.1, 1)
	elseif akactor.getfactionrank(slapp_FoodCumTriedFaction) >= 2
		Debug.sendanimationevent(PlayerRef, "Babo_FoodEayAnyway")
		SLApproachFoodCumAura.cast(PlayerRef, akactor)
		SLApproachMain.InflationwithInjectorEvent(PlayerRef, akactor, 4, 0.2, 1)
	endif
EndFunction

Function DruggedFood(Actor akactor)
	Float fpoisonresist = PlayerRef.getactorvalue("PoisonResist")
	Float fAlchemy = PlayerRef.getactorvalue("Alchemy")
	Float frandom = Utility.randomint(40, 60) as float
	if fpoisonresist >= frandom
		Debug.sendanimationevent(PlayerRef, "Babo_FoodEayAnyway")
		SLApproachFoodSleepingDrugAura.cast(PlayerRef, akactor)
		frandom = Utility.randomint(50, 60) as float
		if fAlchemy >= frandom
			SLAPP_ResistToxic.show()
			SLApproachDetectDruggedFood.setvalue(1)
		else
			SLApproachDetectDruggedFood.setvalue(0)
		endif
	else
		Parent.AcyclePairedMotion(akactor, 0, -45, -20, 10)
		Utility.wait(1.0)
		SLAppDruggedFoodScene.forcestart()
	endif
EndFunction

Function TakeSweetsEvent(Actor akactor)
	PlayerRef.additem(SLAPPLItemRuralSweets, 1)
	Int AcquaintanceChance = SLApproachMain.SLAAquaintanceChance
	Parent.GiftFaction(akactor, AcquaintanceChance)
	akactor.addtofaction(slapp_GiftFoodGiverFaction)
	SLApproachGiftTimes.setvalue(SLApproachGiftTimes.getvalue() + 1)
EndFunction

Function EatSweetsEvent(Actor akactor)
	;Maybe Animation later? WIP
	Debug.sendanimationevent(PlayerRef, "Babo_FoodEayAnyway")
	SLAPPFavorSweetsSpell.cast(akactor, PlayerRef)
	PlayerRef.EquipItem(PlayerRef.additem(SLAPPLItemRuralSweets, 1))
EndFunction

Function PreDrinkEvent(Actor akSpeaker)

	if Parent.DrinkEvent(PlayerRef, akSpeaker, willrape, SLApproachMain.SLAAquaintanceChance)
		SLAppAfterDrink.forcestart()
	else
		if akspeaker.isinfaction(slapp_DislikeFaction)
			slappUtil.DetectPlayerAttire(akSpeaker, 2, 0)
			Self.CoolDown(akSpeaker, 25)
		else
			;Self.Acquaintance(akSpeaker)
			slappUtil.DetectPlayerAttire(akSpeaker, 2, 0)
			Self.AcquaintanceCalc(akSpeaker)
			Self.StopScene()
		endif
		SLAPPFavorTavernSpell.cast(akSpeaker, PlayerRef)
		PlayerRef.EquipItem(PlayerRef.additem(SLAPPLItemInnRuralDrink, 1))
	endif
EndFunction

Function DrinkRapedby(Actor akSpeaker, int Sex)
;Actor ActorRaper = talkingActor.GetReference() as Actor

	int choice = SLAPP_ForgiveCrimeDrunkMsg.Show()
	if choice == 0
		akSpeaker.setfactionrank(slapp_ThinkRapeAllowedFaction, 1)
	elseif choice == 1
		akSpeaker.addtofaction(slapp_ThinkRapeAllowedFaction)
	else
		akSpeaker.removefromfaction(slapp_ThinkRapeAllowedFaction)
	endif
int Chance = SLApproachMain.SLADislikeChance
	HelperQuest.Start()
	SLApproachRapedTimes.setvalue(SLApproachRapedTimes.getvalue() + 1)
	If (SLApproachMain.enableSLHHFlag)
		Self.followSceneStop()
		slappUtil.DetectPlayerAttire(akSpeaker, 0, 6)
		Utility.wait(1.0)
		SLHHDrinkActivate(akSpeaker, None, Sex)
		if SLApproachMain.debugLogFlag
			Debug.notification(akSpeaker + "SLHHDrinkActivate")
		endif

	Else
		slappUtil.DetectPlayerAttire(akSpeaker, 0, 7)
		self.followSceneStop()
		if akSpeaker.getfactionrank(slapp_ThinkRapeAllowedFaction) == 0
			Self.AcquaintancePlusCalc(akSpeaker, 10, true)
		elseif akSpeaker.getfactionrank(slapp_ThinkRapeAllowedFaction) == 1
			Self.AcquaintancePlusCalc(akSpeaker, 5, true)
		else
			Parent.AddtoDislikeFaction(akSpeaker, Chance, True)
		endif
		Self.followSceneStop()
		self.StartSexMulti(PlayerRef, akSpeaker, HelpRaperRef.GetReference() as Actor, true)
		Self.StopScene()
	EndIf
EndFunction

Function ToxicFoodRapedby(Actor akactor)
	int choice = SLAPP_ForgiveCrimeFoodToxicMsg.Show()
	if choice == 0
		akactor.setfactionrank(slapp_ThinkRapeAllowedFaction, 1)
	elseif choice == 1
		akactor.addtofaction(slapp_ThinkRapeAllowedFaction)
	else
		akactor.removefromfaction(slapp_ThinkRapeAllowedFaction)
	endif
	;HelperQuest.Start()
	SLApproachRapedTimes.setvalue(SLApproachRapedTimes.getvalue() + 1)
	slappUtil.DetectPlayerAttire(akactor, 0, 7)

	Self.StartSexHook(PlayerRef, akactor, true, "OnToxicFoodRapeAfter", "ToxicFoodRapeAfter", 100, true)
EndFunction

Function ToxicFoodRapedbyEnd(Actor akactor)
int Chance = SLApproachMain.SLADislikeChance
	if akactor.getfactionrank(slapp_ThinkRapeAllowedFaction) == 0
		Self.AcquaintancePlusCalc(akactor, 10, true)
	elseif akactor.getfactionrank(slapp_ThinkRapeAllowedFaction) == 1
		Self.AcquaintancePlusCalc(akactor, 5, true)
	else
		Parent.AddtoDislikeFaction(akactor, Chance, True)
	endif
	Self.followSceneStop()
	Self.StopScene()
EndFunction

Function SLHHConsequneceBad(Actor akactor)
int Chance = SLApproachMain.SLADislikeChance + 10
int Factionrank = akactor.getfactionrank(slapp_AquaintedFaction)
if (SLApproachMain.enableBDFlag) && (akactor.isinfaction(SLApproachMain.BaboViceGuardCaptainFaction))
;Nothing
else
	if !akactor.isinfaction(slapp_ThinkRapeAllowedFaction)
		if Factionrank >= 3
			Parent.CountRapeTime(akactor)
		else
			Parent.AddtoDislikeFaction(akactor, Chance, false)
		endif
	endif
	Parent.AddtoRapeFailFaction(akactor, Chance, false)
endif
	Self.StopSceneForce()
EndFunction

Function SLHHConsequneceWorse(Actor akactor, int Type)

int Chance
int AChance
int Factionrank

if SLApproachMain.enableBDFlag
	iF akactor.isinfaction(SLApproachMain.BaboViceGuardCaptainFaction)
		Self.StopSceneForce()
		return
	endif
endif

if Type == 3
	if akactor.isinfaction(GuardDialogueFaction)
		FollowerRef.forcerefto(akactor)
		SLAppGuardPunishmentScene.forcestart()
	endif
endif

Factionrank = akactor.getfactionrank(slapp_AquaintedFaction)
Chance = SLApproachMain.SLADislikeChance + 20
AChance = SLApproachMain.SLAAquaintanceChance

if akactor.isinfaction(slapp_ThinkRapeAllowedFaction)
	if akactor.getfactionrank(slapp_ThinkRapeAllowedFaction) == 1
		if Factionrank >= 3
			AChance += 20
			Parent.AddtoAquaintanceFaction(akactor, AChance, true)
		else
			Parent.AddtoAquaintanceFaction(akactor, AChance, true)
		endif
	endif
else
	if Factionrank >= 3
		Parent.AddtoDislikeFaction(akactor, Chance, True)
	else
		Parent.CountRapeTime(akactor)
	endif
endif

Self.StopSceneForce()
EndFunction

Function PrePaid(Bool Prepaid)
	if Prepaid
		SLApproachMain.SLAProstitutionpayway = 0 ;pre-paid
		ProstitutionPaid()
	else
		SLApproachMain.SLAProstitutionpayway = 1 ;post-paid
	endif
Endfunction

Function ProstitutionPaid()
	PlayerRef.additem(gold001, SLApproachProstitutionValue.getvalue() as int)
EndFunction

Function ProstitutionRefund()
	PlayerRef.removeitem(gold001, SLApproachProstitutionValue.getvalue() as int)
EndFunction

Function travelWith(Actor akSpeaker, Bool Prostitution = false)
	self.SetStage(15)
	Parent.ChangeStateStage(1)
	SLApproachEventGlobal.setvalue(0)
	SLApproachAskForSexQuestFollowPlayerScene.Forcestart()
if Prostitution
	SLApproachMain.SLAProstitutionFollow = True
else
	SLApproachMain.SLAProstitutionFollow = false
endif
EndFunction

Function travelEnd(Actor akactor)
	;ChangeStateStage(0)
	SLApproachAskForSexQuestFollowPlayerScene.stop()
	if EventType == 1;showbody
		StripShowStart(akactor)
	elseif EventType == 2
		TouchPussyStart(akactor)
	elseif EventType == 3
		PlayPussyStart(akactor)
	elseif EventType == 4
		SuckPussyStart(akactor)
	endif
EndFunction

int EventType

Function travelWithForEvent(Actor akSpeaker, int EventTypei);WIP
	self.SetStage(15)
	Parent.ChangeStateStage(1)
	SLApproachEventGlobal.setvalue(EventTypei)
	EventType = EventTypei
	SLApproachAskForSexQuestFollowPlayerScene.Forcestart()
EndFunction

Function followSceneStop()

	if SLAppAfterBackHugMolest.isplaying()
		SLAppAfterBackHugMolest.Stop()
	endif

	if SLAppAfterKiss.isplaying()
		SLAppAfterKiss.Stop()
	endif
	
	if SLAppAggressiveBFPCScene.isplaying()
		SLAppAggressiveBFPCScene.Stop()
	endif

	if SLAppAskingNameToPCScene.isplaying()
		SLAppAskingNameToPCScene.stop()
	endif
	
	if SLAppAskingKidScene.isplaying()
		SLAppAskingKidScene.stop()
	endif
	
	if SLAppAskingForSexKidScene.isplaying()
		SLAppAskingForSexKidScene.stop()
	endif
	
	if SLAppSpankingKidScene.isplaying()
		SLAppSpankingKidScene.stop()
	endif

	if SLAppAskingKid02Scene.isplaying()
		SLAppAskingKid02Scene.stop()
	endif
	
	if SLAppAskingMiscScene.isplaying()
		SLAppAskingMiscScene.stop()
	endif
	
	if SLAppAskingMiscStayingHouseScene.isplaying()
		SLAppAskingMiscStayingHouseScene.stop()
	endif
	
	if SLAppPeekingWhileBathing.isplaying()
		SLAppPeekingWhileBathing.stop()
	endif
	
	if SLAppPeekingWhilePeeing.isplaying()
		SLAppPeekingWhilePeeing.stop()
	endif

	if SLApproachSpankingScene.isplaying()
		SLApproachSpankingScene.stop()
	endif
	
	if (SLApproachHouseStayScene.isplaying())
		SLApproachHouseStayScene.stop()
	endif
	
	if (SLApproachHouseStayKidScene.isplaying())
		SLApproachHouseStayKidScene.stop()
	endif
	
	if (SLApproachAskForSexQuestScene.isplaying())
		SLApproachAskForSexQuestScene.Stop()
	endif

	if (SLAppViceGuardCaptainScene.isplaying())
		SLAppViceGuardCaptainScene.Stop()
	endif

	if (SLAppViceGuardCaptainSpankScene.isplaying())
		SLAppViceGuardCaptainSpankScene.Stop()
	endif

	if (SLApproachAskForSexQuestFollowPlayerScene.isPlaying())
		SLApproachAskForSexQuestFollowPlayerScene.Stop()
	endif
	
	if SLAppShowingOffBodyScene.isplaying()
		SLAppShowingOffBodyScene.stop()
	endif

	if SLAppBackHugScene.isplaying()
		SLAppBackHugScene.stop()
	endif

	if SLAppBackHugKidScene.isplaying()
		SLAppBackHugKidScene.stop()
	endif
EndFunction

Function playKiss(Actor akRef)
	SexUtil.PlayKiss(akRef, PlayerRef)
EndFunction

Function playHug(Actor akRef)
	SexUtil.PlayHug(akRef, PlayerRef, SLApproachMain.enableForceThirdPersonHug)
EndFunction


;-------------------------SLHH Mod -----------------------

Function ExternalTrigger(Form akRef, Bool Worse, int Type)
if SLApproachMain.debugLogFlag
	Debug.notification("ExternalTrigger")
endif
	If Worse
		SLHHConsequneceWorse(akRef as actor, Type)
	Else
		SLHHConsequnecebad(akRef as actor)
	Endif

EndFunction

;-----------------Register HouseLocation-----------------
;variable 06 1~4
;1 - Normal Chat
;2 - eroticclothes
;3 - Drink
;4 - Asking Sex

;5 - Inviting Friends
;6 - Bandit Assualt
;7 - Begging Money;BaboDialogue
;8 - Underwear Thief

Bool Function iGetFormIndex()
	Location CurrentLocation = PlayerRef.GetCurrentLocation()
	Formlist CurrentFormlist
	VisitorRef = None

	if CurrentLocation && CurrentLocation.haskeyword(LocTypePlayerHouse)
		if CurrentLocation == WhiterunBreezehomelocation
			CurrentFormlist = SLApproachPlayerHouseWhiterun
			SLApproachCurrentPlayerHouse.setvalue(1)
		elseif CurrentLocation == BYOHHouse1LocationInterior
			CurrentFormlist = SLApproachPlayerHouseBYOH01
			SLApproachCurrentPlayerHouse.setvalue(2)
		elseif CurrentLocation == BYOHHouse2LocationInterior
			CurrentFormlist = SLApproachPlayerHouseBYOH02
			SLApproachCurrentPlayerHouse.setvalue(3)
		elseif CurrentLocation == BYOHHouse3LocationInterior
			CurrentFormlist = SLApproachPlayerHouseBYOH03
			SLApproachCurrentPlayerHouse.setvalue(4)
		elseif CurrentLocation == SolitudeProudspireManorLocation
			CurrentFormlist = SLApproachPlayerHouseSolitude
			SLApproachCurrentPlayerHouse.setvalue(5)
		elseif CurrentLocation == MarkarthVlindrelHallLocation
			CurrentFormlist = SLApproachPlayerHouseMarkarth
			SLApproachCurrentPlayerHouse.setvalue(6)
		elseif CurrentLocation == RiftenHoneysideLocation
			CurrentFormlist = SLApproachPlayerHouseRiften
			SLApproachCurrentPlayerHouse.setvalue(7)
		elseif CurrentLocation == WindhelmHjerimLocation
			CurrentFormlist = SLApproachPlayerHouseWindhelm
			SLApproachCurrentPlayerHouse.setvalue(8)
		elseif CurrentLocation.HasRefType(SLAppCustomHouseLocKeyword)
			SLApproachCurrentPlayerHouse.setvalue(20)
		else
			SLApproachCurrentPlayerHouse.setvalue(0)
			return false
		endif

		if SLApproachMain.debugLogFlag
			Debug.notification("PlayerHouse " + SLApproachCurrentPlayerHouse.getvalue() as int)
		endif

		int iindex = CurrentFormlist.getsize()
		If iindex > 0
			iindex -= 1
			VisitorRef = CurrentFormlist.getat(Utility.randomint(1, iindex)) as actor

			if VisitorRef && SLApproachMain.debugLogFlag
				String VisitorStringRef = VisitorRef.GetBaseObject().getname() as string
				Debug.notification("Visitor's name is " + VisitorStringRef + "in " + iindex)
			elseif SLApproachMain.debugLogFlag
				Debug.notification("Visitor is not present")
			endif
		else
			if SLApproachMain.debugLogFlag
				Debug.notification("No Index")
			endif
		EndIf

		If VisitorRef == None
			if SLApproachMain.debugLogFlag
				Debug.notification("There's silence in my home.")
			endif
		endif
	Else
		if SLApproachMain.debugLogFlag
			Debug.notification("No Player House")
		endif
	Endif

	Return VisitorRef as Bool
EndFunction

Bool Function KnockKnock()
	If Utility.RandomInt(1, 100) > SLApproachPC.SLAHouseVisitChance
		Return False
	EndIf

	If !SLApproachScanningPlayerHouse.isrunning()
		Return False
	EndIf

	PCApproachOngoing = True

PlayerHouseCenterMarker.ForceRefto(ExternalPlayerHouseCenterMarker.getreference())
PlayerHouseDoor.ForceRefto(ExternalPlayerHouseDoor.getreference())
PlayerHouseCOC.ForceRefto(ExternalPlayerHouseCOC.getreference())
PlayerHouseInteriorStrollA.ForceRefto(ExternalPlayerHouseInteriorStrollA.getreference())
PlayerHouseInteriorStrollB.ForceRefto(ExternalPlayerHouseInteriorStrollB.getreference())
PlayerHouseExteriorStrollA.ForceRefto(ExternalPlayerHouseExteriorStrollA.getreference())
PlayerHouseExteriorStrollB.ForceRefto(ExternalPlayerHouseExteriorStrollB.getreference())
FollowerRef.ForceRefto(ExternalFollowerRef.getreference())

talkingActor.ForceRefTo(VisitorRef)

rollRapeChance(VisitorRef)
SLApproachRapeToggle.setvalue(willRape as int)
PCVisitingBefore = true
PCVisitingAfter = false
VisitorKnocking(VisitorRef)

Return True
EndFunction

Function VisitorKnocking(actor visitor)

Alias_VisitorRef.Clear()
Alias_VisitorRef.ForceRefTo(visitor)

SLApproachScanningPlayerHouse.setstage(10)
Self.setstage(50)

;Moving a visitor in front of a door
;Dialogues are required
SLAPPTemporaryVisitorBackMarker.moveto(visitor)
if SLApproachCurrentPlayerHouse.getvalue() == 1
	visitor.moveto(SLApproachMain.SLAPPXmarkerFrontDoorWhiterunRef)
elseif SLApproachCurrentPlayerHouse.getvalue() == 2
	visitor.moveto(SLApproachMain.SLAPPXmarkerFrontDoorBYOH01Ref)
elseif SLApproachCurrentPlayerHouse.getvalue() == 3
	visitor.moveto(SLApproachMain.SLAPPXmarkerFrontDoorBYOH02Ref)
elseif SLApproachCurrentPlayerHouse.getvalue() == 4
	visitor.moveto(SLApproachMain.SLAPPXmarkerFrontDoorBYOH03Ref)
elseif SLApproachCurrentPlayerHouse.getvalue() == 5
	visitor.moveto(SLApproachMain.SLAPPXmarkerFrontDoorSolitudeRef)
elseif SLApproachCurrentPlayerHouse.getvalue() == 6
	visitor.moveto(SLApproachMain.SLAPPXmarkerFrontDoorMarkarthRef)
elseif SLApproachCurrentPlayerHouse.getvalue() == 7
	visitor.moveto(SLApproachMain.SLAPPXmarkerFrontDoorRiftenRef)
elseif SLApproachCurrentPlayerHouse.getvalue() == 8
	visitor.moveto(SLApproachMain.SLAPPXmarkerFrontDoorWindhelmRef)
elseif SLApproachCurrentPlayerHouse.getvalue() == 20
	visitor.moveto(SLAPPTemporaryVisitorMarker)
else
;Nothing
endif

	PCVisitingBefore = false
	PCVisitingon = true
	PCVisitingafter = false

EndFunction

Function VisitorEntering(actor visitor, objectreference entrance)
	PCVisitingBefore = false
	PCVisitingon = false
	PCVisitingafter = true
	slappUtil.HomeAlone();Detect actors around Player
	SetCharacter(visitor);Double check
	
	visitor.moveto(entrance)
	selectedScene = SLAppHousevisitScene
	selectedScene.forcestart()
	maxTime = (SLApproachMain.SLApproachTimelimit) + 30
	parent.startApproach(visitor)
EndFunction

Function registerHouse(Location akLocation)
actor akactor = talkingActor.GetReference() as Actor
If aklocation == WhiterunBreezehomeLocation
	SLApproachPlayerHouseWhiterun.addform(akactor)
elseif aklocation == BYOHHouse1LocationInterior
	SLApproachPlayerHouseBYOH01.addform(akactor)
elseif aklocation == BYOHHouse2LocationInterior
	SLApproachPlayerHouseBYOH02.addform(akactor)
elseif aklocation == BYOHHouse3LocationInterior
	SLApproachPlayerHouseBYOH03.addform(akactor)
elseif aklocation == SolitudeProudspireManorLocation
	SLApproachPlayerHouseSolitude.addform(akactor)
elseif aklocation == MarkarthVlindrelHallLocation
	SLApproachPlayerHouseMarkarth.addform(akactor)
elseif aklocation == RiftenHoneysideLocation
	SLApproachPlayerHouseRiften.addform(akactor)
elseif aklocation == WindhelmHjerimLocation
	SLApproachPlayerHouseWindhelm.addform(akactor)
EndIf
NothingEnd(akactor)
EndFunction

Function RegisterCustomHouse(int HouseNumber)
actor akactor = talkingActor.GetReference() as Actor
if HouseNumber == 1
	SLApproachPlayerHouseCustom01.addform(akactor)
elseif HouseNumber == 2
	SLApproachPlayerHouseCustom02.addform(akactor)
elseif HouseNumber == 3
	SLApproachPlayerHouseCustom03.addform(akactor)
elseif HouseNumber == 4
	SLApproachPlayerHouseCustom04.addform(akactor)
elseif HouseNumber == 5
	SLApproachPlayerHouseCustom05.addform(akactor)
elseif HouseNumber == 6
	SLApproachPlayerHouseCustom06.addform(akactor)
elseif HouseNumber == 7
	SLApproachPlayerHouseCustom07.addform(akactor)
elseif HouseNumber == 8
	SLApproachPlayerHouseCustom08.addform(akactor)
elseif HouseNumber == 9
	SLApproachPlayerHouseCustom09.addform(akactor)
elseif HouseNumber == 10
	SLApproachPlayerHouseCustom10.addform(akactor)
endif
NothingEnd(akactor)
EndFunction

Function UnregisterHouse(Actor akspeaker, int type)
	SLApproachPlayerHouseWhiterun.RemoveAddedForm(akspeaker)
	SLApproachPlayerHouseBYOH01.RemoveAddedForm(akspeaker)
	SLApproachPlayerHouseBYOH02.RemoveAddedForm(akspeaker)
	SLApproachPlayerHouseBYOH03.RemoveAddedForm(akspeaker)
	SLApproachPlayerHouseSolitude.RemoveAddedForm(akspeaker)
	SLApproachPlayerHouseMarkarth.RemoveAddedForm(akspeaker)
	SLApproachPlayerHouseRiften.RemoveAddedForm(akspeaker)
	SLApproachPlayerHouseWindhelm.RemoveAddedForm(akspeaker)
	if type == 1; No complain
		akspeaker.addtofaction(slapp_NoVisitFaction)
	elseif type == 2; complain
		akspeaker.addtofaction(slapp_NoVisitFaction)
		disagree(akspeaker, false, false)
	elseif type == 3; Rape
		akspeaker.addtofaction(slapp_NoVisitFaction)
		disagree(akspeaker, false, false)
		rapedPlusBy(akspeaker)
	endif
EndFunction

Function registerHouseTest(Location akLocation, Actor akactor)
If aklocation == WhiterunBreezehomeLocation
	SLApproachPlayerHouseWhiterun.addform(akactor)
elseif aklocation == BYOHHouse1LocationInterior
	SLApproachPlayerHouseBYOH01.addform(akactor)
elseif aklocation == BYOHHouse2LocationInterior
	SLApproachPlayerHouseBYOH02.addform(akactor)
elseif aklocation == BYOHHouse3LocationInterior
	SLApproachPlayerHouseBYOH03.addform(akactor)
elseif aklocation == SolitudeProudspireManorLocation
	SLApproachPlayerHouseSolitude.addform(akactor)
elseif aklocation == MarkarthVlindrelHallLocation
	SLApproachPlayerHouseMarkarth.addform(akactor)
elseif aklocation == RiftenHoneysideLocation
	SLApproachPlayerHouseRiften.addform(akactor)
elseif aklocation == WindhelmHjerimLocation
	SLApproachPlayerHouseWindhelm.addform(akactor)
EndIf
EndFunction

Function PreVisitorEntering()
;debug.notification("The visitor is entering.")
	ObjectReference PHCOC = PlayerHouseCOC.getreference()
	SLApproachScanningPlayerHouse.setstage(50)
	Self.setstage(60)
	if PHCOC
		VisitorEntering(VisitorRef, PHCOC)
	Else
		VisitorEntering(VisitorRef, PlayerRef)
	Endif
	SLAKnockCount.setvalue(0)

EndFunction

Function FirstVisit(Bool Rape)
	Actor akRef = talkingActor.GetReference() as Actor
	talkingactor.clear()
	stayingactor.forcerefto(akRef)
	SLAppHousevisitScene.stop()
	self.StayingTimeRegister(Rape)
EndFunction

Function StayingTimeRegister(Bool Rape)
	SLApproachScanningPlayerHouse.setstage(70); This indicates a visitor is gonna stay.
	SLApproachVisitorStaying.setvalue(1)
	SLApproachStayingElapsedTime.setvalue(0)
	SLApproachStayingStartingTime.setvalue(GameDaysPassed.value)
	(stayingactor.GetReference() as Actor).addtofaction(slapp_VisitingFaction)
	(stayingactor.GetReference() as Actor).Setactorvalue("Variable06", 0)
	if rape
		(stayingactor.GetReference() as Actor).addtofaction(slapp_VisitingRapistFaction)
	endif
	RegisterForSingleUpdateGameTime(SLApproachStayingTime.getvalue() as int)
EndFunction

Event OnUpdateGameTime()
;End of a visiting scenario.
SLApproachStayingElapsedTime.setvalue(GameDaysPassed.value - SLApproachStayingStartingTime.value)

if SLApproachStayingElapsedTime.getvalue() <= 72.0;Customizable Wip
	RegisterForSingleUpdateGameTime(SLApproachStayingTime.value)
elseif (stayingactor.GetReference() as Actor).isinfaction(slapp_VisitingEventFaction)
	(stayingactor.GetReference() as Actor).removefromfaction(slapp_VisitingEventFaction);Not used for now. It's gonna be used as Byebye contents
	;int randomi = Utility.randomint(5, 8); for future contents
	;(stayingactor.GetReference() as Actor).Setactorvalue("Variable06", randomi)
	RegisterForSingleUpdateGameTime(SLApproachStayingTime.value)
else
	CleartheHouse()
endif
EndEvent

Function CleartheHouse()
	SLApproachVisitorStaying.setvalue(0)
	(stayingactor.GetReference() as Actor).removefromfaction(slapp_VisitingFaction)
	(stayingactor.GetReference() as Actor).Setactorvalue("Variable06", 0)
	if (stayingactor.GetReference() as Actor).isinfaction(slapp_VisitingRapistFaction)
		(stayingactor.GetReference() as Actor).addtofaction(slapp_VisitedRapistFaction)
		(stayingactor.GetReference() as Actor).removefromfaction(slapp_VisitingRapistFaction)
	endif
	SLApproachScanningVisitor.stop()
	SLApproachScanningPlayerHouse.stop()
	Stayed()
EndFunction

Function HeSpanked(actor akactor)
	if SLApproachMain.debugLogFlag
		Debug.notification("HeSpanked")
	endif
Self.NothingEnd(akactor)
Game.EnablePlayerControls()
EndFunction

Function HeAssGroped(actor akactor)
	if SLApproachMain.debugLogFlag
		Debug.notification("HeAssGroped")
	endif
Self.NothingEnd(akactor)
Game.EnablePlayerControls()
EndFunction

Function SpankDialogueStop(actor akactor)
	akactor.removespell(SLApproachAssGropeBAura)
	akactor.removespell(SLApproachAssGropeAura)
	akactor.removespell(SLApproachSpankAura)
	akactor.removespell(SLApproachMolestAura)
	akactor.removespell(SLApproachMolestSAura)
	akactor.removespell(SLApproachHugAura)
	akactor.removespell(SLApproachFoodCumAura)
	akactor.removespell(SLApproachFoodSleepingDrugAura)
EndFunction

Function AssGropeTimeOut(actor akactor)
	if SLApproachMain.debugLogFlag
		Debug.notification("AssGropeTimeOut")
	endif

	if !akactor.isinfaction(slapp_AssGropeFaction)
		akactor.addtofaction(slapp_AssGropeFaction)
	else
		akactor.setfactionrank(slapp_AssGropeFaction, 1 + akactor.getfactionrank(slapp_AssGropeFaction))
	endif

	If SLApproachMain.enableBDFlag;WIP
		if (akactor.isinfaction(SLApproachMain.BaboViceGuardCaptainFaction))
				BaboDialogueSLAPPTrigger(akactor, false, 20)
			return
		endif
	endif
EndFunction

Function SpankTimeOut(actor akactor)
	if SLApproachMain.debugLogFlag
		Debug.notification("SpankTimeOut")
	endif
	
	If SLApproachMain.enableBDFlag
		if (akactor.isinfaction(SLApproachMain.BaboViceGuardCaptainFaction))
				BaboDialogueSLAPPTrigger(akactor, false, 20)
			return
		endif
	endif
	
	if !akactor.IsInDialogueWithPlayer()
		SLApproachSpankAura2nd.cast(PlayerRef, akactor)
		Game.EnablePlayerControls()
	endif
EndFunction

Function SpankTimeOut2nd(actor akactor)
	if SLApproachMain.debugLogFlag
		Debug.notification("SpankTimeOut2nd")
	endif
	
	if !akactor.isinfaction(slapp_SpankFaction)
		akactor.addtofaction(slapp_SpankFaction)
	else
		akactor.setfactionrank(slapp_SpankFaction, 1 + akactor.getfactionrank(slapp_SpankFaction))
	endif
EndFunction

Function MolestTimeOut(actor akactor)
	if SLApproachMain.debugLogFlag
		Debug.notification("MolestTimeOut")
	endif
	
	SLApproachMain.StolenArmor = None
	SLA_BStolenArmor.setvalue(0)
	if !akactor.isinfaction(slapp_MolestFaction)
		akactor.addtofaction(slapp_MolestFaction)
	else
		akactor.setfactionrank(slapp_MolestFaction, 1 + akactor.getfactionrank(slapp_MolestFaction))
	endif

	Self.NothingEnd(akactor)
EndFunction

Function HugTimeOut(actor akactor)
	if SLApproachMain.debugLogFlag
		Debug.notification("HugTimeOut")
	endif
	if SLApproachAskForSexQuestFollowPlayerScene.isplaying() == false
		if self.CheckEndApproach() == false 
			SLApproachHugAura.cast(PlayerRef, akactor)
		endif
	endif
endfunction

Function FoodToxicTimeOut(actor akactor, int iToxic)
	if SLApproachMain.debugLogFlag
		Debug.notification("FoodToxicTimeOut")
	endif
	if iToxic == 1
		if !akactor.isinfaction(slapp_FoodCumTriedFaction)
			akactor.addtofaction(slapp_FoodCumTriedFaction)
		else
			akactor.setfactionrank(slapp_FoodCumTriedFaction, 1 + akactor.getfactionrank(slapp_FoodCumTriedFaction))
		endif
		SLApproachDetectCumFood.setvalue(0)
	elseif iToxic == 2
		if !akactor.isinfaction(slapp_FoodToxicTriedFaction)
			akactor.addtofaction(slapp_FoodToxicTriedFaction)
		else
			akactor.setfactionrank(slapp_FoodToxicTriedFaction, 1 + akactor.getfactionrank(slapp_FoodToxicTriedFaction))
		endif
	endif
	Self.NothingEnd(akactor)
EndFunction

Function FoodToxicDetected(actor akactor, int iToxic)
	if iToxic == 1
		if !akactor.isinfaction(slapp_FoodCumTriedDetectedFaction)
			akactor.addtofaction(slapp_FoodCumTriedDetectedFaction)
		else
			akactor.setfactionrank(slapp_FoodCumTriedDetectedFaction, 1 + akactor.getfactionrank(slapp_FoodCumTriedDetectedFaction))
		endif
	elseif iToxic == 2
		if !akactor.isinfaction(slapp_FoodSleepingDrugTriedDetectedFaction)
			akactor.addtofaction(slapp_FoodSleepingDrugTriedDetectedFaction)
		else
			akactor.setfactionrank(slapp_FoodSleepingDrugTriedDetectedFaction, 1 + akactor.getfactionrank(slapp_FoodSleepingDrugTriedDetectedFaction))
		endif
	endif
endfunction

;##########################
;########ResistBar#########
;##########################

SLAPQTEWidgetEx Property StruggleBar Auto
Quest Property SLApproach_Config Auto

Bool LeftRight = True
Int StrafeL
Int StrafeR
Float FillDifficulty = 0.0
Float FillThreshold = 0.0
Int ResistTime = 0
int Time = 0
Float DownedTime ; How much time the player will stay downed.
Float Phase01
Float Phase02
Float Phase03
Float Phase04
GlobalVariable property SLApproachHarassmentType Auto
GlobalVariable property SLApproachKissResist Auto
GlobalVariable property SLApproachFlirtType Auto
Scene Property SLAppAfterKiss Auto
Scene Property SLAppAfterBackHugMolest Auto
Scene Property SLApproachTeasingHouseScene Auto
Scene Property SLApproachTeasingScene Auto

int Function GetExposure(actor akactor)
	return (sla_Framework as slaFrameworkScr).GetActorExposure(akactor)
EndFunction

Function SetExposure(actor akactor, int ipoint)
	(sla_Framework as slaFrameworkScr).SetActorExposure(akactor, ipoint)
EndFunction

Function HugKissEnd(Actor akactor)
	Parent.FlirtAnim(akactor, False, 5)
	Utility.wait(12.0)
	Parent.RestoreControl(akactor)
	Self.Acquaintance(akactor)
EndFunction

Function StartFlirt(Actor akactor, int FlirtType, bool HouseVisit)
	SLApproachFlirtType.setvalue(FlirtType)
	Parent.FlirtAnim(akactor, True, FlirtType)
	if HouseVisit
		SLApproachTeasingHouseScene.forcestart()
	else
		SLApproachTeasingScene.forcestart()
	endif
EndFunction

Function StartHarassment(actor akactor, int HarassmentType)
	SLApproachHarassmentType.setvalue(HarassmentType)
	NPCActor = akactor
	GotoState("Harassment")
EndFunction

Function StartSweetKiss(actor akactor, int KissType)
	SLApproachSweetKissType.setvalue(KissType)
	NPCActor = akactor
	Self.CoolDown(akactor, 50)
	GotoState("SweetKiss")
EndFunction

Function SpankTest(actor akactor, int Scenarioe = 0)
	SLA_SpankingScenarioGlobal.setvalue(0)
	ForceAllocation(akactor)
	SpankSceneStart(akactor, Scenarioe)
Endfunction

Function SpankSSceneStart(actor akactor, int Scenarioe = 0)

int CharacterRank = akactor.getfactionrank(slapp_Characterfaction)
int RandomChance = Utility.randomint(0, 90)
int iProbability = 10
NPCActor = akactor

if CharacterRank > 0
	iProbability = CharacterRank * 30
endif

if Scenarioe == 0
	if iProbability >= RandomChance && !akactor.isinfaction(slapp_NoSpankFaction)
		slappUtil.DetectPlayerAttire(akactor, 0, 3)
		SLApproachMolestTimes.setvalue(SLApproachMolestTimes.getvalue() + 1)
		SLApproachAssGropeTimes.setvalue(SLApproachAssGropeTimes.getvalue() + 1)
		Parent.AcyclePairedMotion(akactor, 0, 0, -40, 9);AssGrope
	else
		if !akactor.isinfaction(slapp_NoMolestFaction)
			if willRape == false
				SLAppSpankingKidScene.stop()
				GotoState("BackHug")
				return
			else
				SLAppSpankingKidScene.stop()
				GotoState("BackHugMolest")
				return
			endif
		else
			SLAppSpankingKidScene.stop()
			GotoState("BackHug")
			return
		endif
		SLAppSpankingKidScene.stop()
		GotoState("CatCall")
		return
	endif


elseif Scenarioe == 1
	GotoState("BackHug")
elseif Scenarioe == 2
	GotoState("BackHugMolest")
elseif Scenarioe == 3
	slappUtil.DetectPlayerAttire(akactor, 0, 3)
	SLApproachMolestTimes.setvalue(SLApproachMolestTimes.getvalue() + 1)
	SLApproachAssGropeTimes.setvalue(SLApproachAssGropeTimes.getvalue() + 1)
	Parent.AcyclePairedMotion(akactor, 0, 0, -40, 9);AssGrope
elseif Scenarioe == 4
	;stripunderwear wip
endif
SLAppSpankingKidScene.stop()
EndFunction

Function SpankSceneStart(actor akactor, int Scenarioe = 0)
int CharacterRank = akactor.getfactionrank(slapp_Characterfaction)
int RandomChance = Utility.randomint(0, 90)
int iProbability = 10

if Scenarioe == 1
	NPCActor = akactor
	GotoState("BackHug")
elseif Scenarioe == 2
	NPCActor = akactor
	GotoState("BackHugMolest")
elseif Scenarioe == 3
	SpankStart(akactor)
else
	if CharacterRank > 0
		iProbability = CharacterRank * 30
	endif

	if iProbability >= RandomChance && !akactor.isinfaction(slapp_NoSpankFaction)
		SpankStart(akactor)
	else
		NPCActor = akactor
		if akactor.isinfaction(slapp_DislikeFaction) || akactor.isinfaction(slapp_ThugFaction) || akactor.getfactionrank(slapp_AquaintedFaction) >= 3
			if akactor.isinfaction(slapp_NoMolestFaction) || willRape == false
				SLApproachSpankingScene.stop()
				GotoState("BackHug")
				return
			else
				SLApproachSpankingScene.stop()
				GotoState("BackHugMolest")
				return
			endif
		else
			SLApproachSpankingScene.stop()
			GotoState("BackHug")
			return
		endif
		SLApproachSpankingScene.stop()
		GotoState("CatCall")
		return
	endif
endif

SLApproachSpankingScene.stop()

EndFunction

Function ResistSuccess(actor akactor)
	Self.Restore()
	Parent.AnimationPlays(false)
	Parent.PrecisionCheck(NPCActor, false)
	Parent.RestoreControl(akactor)
EndFunction

Function ResistFailed(actor akactor)
	Self.Restore()
	Parent.AnimationPlays(false)
	Parent.PrecisionCheck(NPCActor, false)
	Parent.RestoreControl(akactor)
EndFunction

State CatCall;WIP
	Event OnBeginState()
		Restore()
		endApproachForce(None)
		;Parent.PrecisionCheck(NPCActor, false)
	EndEvent
EndState

State Harassment;complete

	Event OnBeginState()
		slappUtil.DetectPlayerAttire(NPCActor, 0, 4)
		slappUtil.UnequipShieldSimple(NPCActor)
		SLApproachForcedKissTimes.setvalue(SLApproachForcedKissTimes.getvalue() + 1)
		SLApproachMolestTimes.setvalue(SLApproachMolestTimes.getvalue() + 1)
		SLApproachHarassmentType.setvalue(1);2 is not ready. It will be removed once 2 is ready.
		Parent.KissAnim(NPCActor, 1)
		Parent.AnimationPlays(true)
		utility.wait(1.5)
		DownedTime = 15.0 + SLApproachMain.SLAPStruggleDuration
		FillThreshold = 0.1 / SLApproachMain.SLAPStrafeDifficulty
		StruggleBarDisplay(true)
		RegisterForSingleUpdate(1.0)
	EndEvent
	
	Event OnUpdate() ; Loop to check the situation every 1 second.
		Time += 1
		;Actor akRef = talkingActor.GetReference() as Actor
		If StruggleBar.Percent >= 1.0
			ResistSuccess(NPCActor)
			Return
		Elseif Time > DownedTime
			ResistFailed(NPCActor)
			Return
		Endif
		if Time == 7.0
			Parent.PlayKissSound()
		endif
	StruggleBar.Alpha = 100.0
	RegisterForSingleUpdate(1.0)
	EndEvent
	
	Function ResistSuccess(actor akactor)
		Restore()
		Parent.AnimationPlays(false)
		Parent.PrecisionCheck(NPCActor, false)
		Parent.KissAnimResist(akactor)
		SLApproachKissResist.setvalue(1)
		SLAppAfterKiss.forcestart()
	EndFunction

	Function ResistFailed(actor akactor)
		Restore()
		Parent.AnimationPlays(false)
		Parent.PrecisionCheck(NPCActor, false)
		Parent.KissAnimStop(akactor)
		SLApproachKissResist.setvalue(2)
		SLAppAfterKiss.forcestart()
	EndFunction
EndState

State SweetKiss;complete

	Event OnBeginState()
		slappUtil.DetectPlayerAttire(NPCActor, 3, 0)
		slappUtil.UnequipShieldSimple(NPCActor)
		SLApproachSweetKissTimes.setvalue(SLApproachSweetKissTimes.getvalue() + 1)
		if SLApproachSweetKissType.getvalue() == 1
			Parent.KissAnim(NPCActor, 3)
		elseif SLApproachSweetKissType.getvalue() == 2
			Parent.KissAnim(NPCActor, 4)
		endif
		Parent.AnimationPlays(true)
		utility.wait(3.0)
		DownedTime = 15.0 + SLApproachMain.SLAPStruggleDuration
		FillThreshold = 0.1 / SLApproachMain.SLAPStrafeDifficulty
		StruggleBarDisplay(true)
		slaexposure = (sla_Framework as slaFrameworkScr).GetActorExposure(NPCActor)
		RegisterForSingleUpdate(1.0)
	EndEvent
	
	Event OnUpdate() ; Loop to check the situation every 1 second.
		Time += 1
		If StruggleBar.Percent >= 1.0
			ResistSuccess(NPCActor)
			Return
		Endif
		if Time == 7.0
			Parent.PlayKissSound()
			slaexposure -= 5
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
			Time = 0
		endif
	StruggleBar.Alpha = 100.0
	RegisterForSingleUpdate(1.0)
	EndEvent
	
	Function ResistSuccess(Actor akactor)
		Parent.AddtoKissFaction(akactor, 0)
		Parent.AddtoAquaintanceFaction(akactor, SLApproachMain.SLAAquaintanceChance, false)
		Parent.sexRelationshipUp(akactor, PlayerRef, SLApproachMain.SLARelationshipChance)
		slappUtil.DetectPlayerAttire(akactor, 3, 0)
		SimpleMotionStop(NPCActor)
		Self.StopScene()
	EndFunction
EndState

State FrontHugAbrupt;complete

	Event OnBeginState()
		slappUtil.DetectPlayerAttire(NPCActor, 0, 5)
		slappUtil.UnequipShieldSimple(NPCActor)
		;SLApproachFrontHugTimes.setvalue(SLApproachFrontHugTimes.getvalue() + 1) ; WIP
		NPCActor.addtofaction(slapp_AnimatingAggFaction)
		PlayerRef.addtofaction(slapp_AnimatingAggFaction)
		if Parent.AcyclePairedMotion(NPCActor, -180, 0, 50, 4)
			Parent.AnimationPlays(true)
		endif
		utility.wait(3.0)
		selectedScene.stop()
		if NPCActor.isinfaction(slapp_KidFaction)
			SLAppFrontHugAbruptKidScene.forcestart()
		else
			SLAppFrontHugAbruptScene.forcestart()
		endif
		DownedTime = 15.0 + SLApproachMain.SLAPStruggleDuration
		FillThreshold = 0.1 / SLApproachMain.SLAPStrafeDifficulty
		StruggleBarDisplay(true)
		slaexposure = (sla_Framework as slaFrameworkScr).GetActorExposure(NPCActor)
		Parent.RandomPainMenu(PlayerRef)
		RegisterForSingleUpdate(1.0)
	EndEvent
	
	Event OnUpdate() ; Loop to check the situation every 1 second.
		Time += 1
		If StruggleBar.Percent >= 1.0
			ResistSuccess(NPCActor)
			;Acquaintance(NPCActor)
			Return
		Endif
		if Time == 7.0
			slaexposure -= 6
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
			Time = 0
		endif
	StruggleBar.Alpha = 100.0
	RegisterForSingleUpdate(1.0)
	EndEvent

	Function StopSceneForce();Used in Config
		UnregisterForUpdate()
		ResistSuccess(NPCActor)
	EndFunction

	Function ResistSuccess(actor akactor)
		Parent.Backtoinitial(PlayerRef)
		NPCActor.removefromfaction(slapp_AnimatingAggFaction)
		PlayerRef.removefromfaction(slapp_AnimatingAggFaction)
		SLAppFrontHugScene.stop()
		SLAppFrontHugAbruptScene.stop()
		SLAppFrontHugKidScene.stop()
		SLAppFrontHugAbruptKidScene.stop()
		SimpleMotionStop(akactor)
		;SLApproachHugAura.cast(PlayerRef, akactor); WIP
	EndFunction

EndState

State FrontHug;complete

	Event OnBeginState()
		slappUtil.DetectPlayerAttire(NPCActor, 0, 5)
		slappUtil.UnequipShieldSimple(NPCActor)
		;SLApproachFrontHugTimes.setvalue(SLApproachFrontHugTimes.getvalue() + 1) ; WIP
		if Parent.AcyclePairedMotion(NPCActor, -180, 0, 50, 4)
			Parent.AnimationPlays(true)
		endif
		utility.wait(3.0)
		selectedScene.stop()
		if NPCActor.isinfaction(slapp_KidFaction)
			SLAppFrontHugKidScene.forcestart()
		else
			SLAppFrontHugScene.forcestart()
		endif
		DownedTime = 15.0 + SLApproachMain.SLAPStruggleDuration
		FillThreshold = 0.1 / SLApproachMain.SLAPStrafeDifficulty
		StruggleBarDisplay(true)
		slaexposure = (sla_Framework as slaFrameworkScr).GetActorExposure(NPCActor)
		Parent.RandomPainMenu(PlayerRef)
		RegisterForSingleUpdate(1.0)
	EndEvent
	
	Event OnUpdate() ; Loop to check the situation every 1 second.
		Time += 1
		If StruggleBar.Percent >= 1.0
			ResistSuccess(NPCActor)
			;Acquaintance(NPCActor)
			Return
		Endif
		if Time == 7.0
			slaexposure -= 6
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
			Time = 0
		endif
	StruggleBar.Alpha = 100.0
	RegisterForSingleUpdate(1.0)
	EndEvent

	Function StopSceneForce();Used in Config
		UnregisterForUpdate()
		ResistSuccess(NPCActor)
	EndFunction

	Function ResistSuccess(actor akactor)
		Parent.Backtoinitial(PlayerRef)
		NPCActor.removefromfaction(slapp_AnimatingAggFaction)
		PlayerRef.removefromfaction(slapp_AnimatingAggFaction)
		SLAppFrontHugScene.stop()
		SLAppFrontHugAbruptScene.stop()
		SLAppFrontHugKidScene.stop()
		SLAppFrontHugAbruptKidScene.stop()
		SimpleMotionStop(akactor)
		;SLApproachHugAura.cast(PlayerRef, akactor) WIP
	EndFunction

EndState

State BackHug;complete
	Event OnBeginState()
		slappUtil.DetectPlayerAttire(NPCActor, 0, 5)
		slappUtil.UnequipShieldSimple(NPCActor)
		SLApproachMolestTimes.setvalue(SLApproachMolestTimes.getvalue() + 1)
		SLApproachBackHugTimes.setvalue(SLApproachBackHugTimes.getvalue() + 1)
		if Parent.AcyclePairedMotion(NPCActor, 0, 0, -50, 2)
			Parent.AnimationPlays(true)
		endif
		utility.wait(3.0)
		selectedScene.stop()
		if NPCActor.isinfaction(slapp_KidFaction)
			SLAppBackHugKidScene.forcestart()
		else
			SLAppBackHugScene.forcestart()
		endif
		DownedTime = 15.0 + SLApproachMain.SLAPStruggleDuration
		FillThreshold = 0.1 / SLApproachMain.SLAPStrafeDifficulty
		StruggleBarDisplay(true)
		slaexposure = (sla_Framework as slaFrameworkScr).GetActorExposure(NPCActor)
		Parent.RandomPainMenu(PlayerRef)
		RegisterForSingleUpdate(1.0)
	EndEvent
	
	Event OnUpdate() ; Loop to check the situation every 1 second.
		Time += 1
		If StruggleBar.Percent >= 1.0
			ResistSuccess(NPCActor)
			Return
		Endif
		
		if StruggleBar.Percent >= 0.7
			Parent.RandomPainMenu(PlayerRef)
		elseif StruggleBar.Percent >= 0.3
			Parent.RandomPainMenu(PlayerRef)
		endif
		if Time == 10.0
			slaexposure -= 5
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
			;Parent.PlayKissSound();panting Sound will be added in future updates
			Time = 0
		endif
	StruggleBar.Alpha = 100.0
	RegisterForSingleUpdate(1.0)
	EndEvent

	Function StopSceneForce();Used in Config
		UnregisterForUpdate()
		ResistSuccess(NPCActor)
	EndFunction

	Function ResistSuccess(actor akactor)
		Parent.Backtoinitial(PlayerRef)
		SLAppBackHugScene.stop()
		SLAppBackHugKidScene.stop()
		SimpleMotionStop(akactor)
		SLApproachHugAura.cast(PlayerRef, akactor)
	EndFunction


EndState

State BackHugMolest;complete

	Event OnBeginState()
		slappUtil.DetectPlayerAttire(NPCActor, 0, 5)
		slappUtil.UnequipShieldSimple(NPCActor)
		SLApproachMolestTimes.setvalue(SLApproachMolestTimes.getvalue() + 1)
		SLApproachBackHugMolestTimes.setvalue(SLApproachBackHugMolestTimes.getvalue() + 1)
		if Parent.AcyclePairedMotion(NPCActor, 0, 0, -50, 3)
			Parent.AnimationPlays(true)
		endif
		utility.wait(3.0)
		SLAppBackHugMolest.forcestart()
		DownedTime = 20.0 + SLApproachMain.SLAPStruggleDuration
		FillThreshold = 0.1 / SLApproachMain.SLAPStrafeDifficulty
		StruggleBarDisplay(true)
		slaexposure = (sla_Framework as slaFrameworkScr).GetActorExposure(NPCActor)
		RegisterForSingleUpdate(1.0)
	EndEvent
	
	Event OnUpdate() ; Loop to check the situation every 1 second.
		Time += 1
		;Actor akRef = talkingActor.GetReference() as Actor
		slaexposure += 1
		(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		
		If StruggleBar.Percent >= 1.0
			ResistSuccess(NPCActor)
			PrecisionCheck(NPCActor, false)
			Return
		Elseif Time > DownedTime
			ResistFailed(NPCActor)
			PrecisionCheck(NPCActor, false)
			Return
		Endif

		;if Time == 7.0
			;Parent.PlayKissSound();panting Sound will be added in future updates
		;endif
	StruggleBar.Alpha = 100.0
	RegisterForSingleUpdate(1.0)
	EndEvent

	Function StopSceneForce();Used in Config
		UnregisterForUpdate()
		ResistSuccess(NPCActor)
	EndFunction

	Function ResistSuccess(actor akactor)
		SLAppBackHugMolest.stop()
		Self.Restore()
		Parent.AnimationPlays(false)
		Parent.PrecisionCheck(NPCActor, false)
		Parent.RestoreControl(akactor)
		SLApproachMolestAura.cast(PlayerRef, akactor)
		If SLApproachMain.enableBDFlag
			if (akactor.isinfaction(SLApproachMain.BaboViceGuardCaptainFaction))
				BaboDialogueSLAPPTrigger(akactor, false, 60)
			endif
		endif
	EndFunction

	Function ResistFailed(actor akactor)
		SLAppBackHugMolest.stop()
		Self.Restore()
		Parent.AnimationPlays(false)
		Parent.PrecisionCheck(NPCActor, false)
		;Parent.RestoreControl(akactor)
		SLApproachMain.ResetHeelEffect(PlayerRef)
		if akactor.isinfaction(slapp_KidFaction)
			if !slappUtil.WearingPants(PlayerRef)
				Armor AUnderwear = slappUtil.FindLower(PlayerRef, true)
				if AUnderwear
					int iformId = akactor.GetFormID()
					StorageUtil.FormListAdd(akactor, SLAPRemoveArmorFormList + iformId, AUnderwear)
					PlayerRef.UnequipItem(AUnderwear)
					PlayerRef.Removeitem(AUnderwear, 1, false, akactor)
					SLApproachMain.StolenArmor = AUnderwear;redundant
					Parent.UpdateStealArmor(akactor)
					;SLApproachBase.AddtoStealArmorFaction(akactor, int icount = 1)
					;SLA_BStolenArmor.setvalue(1)
					SLAPP_UnderwearTakenAwayMsg.show()
					SLApproachMolestSAura.cast(PlayerRef, akactor)
				endif
			endif

			return
		else
			SLApproachRapedTimes.setvalue(SLApproachRapedTimes.getvalue() + 1)
		endif

		If SLApproachMain.enableBDFlag
			if (akactor.isinfaction(SLApproachMain.BaboViceGuardCaptainFaction))
				Self.StartSexHook(PlayerRef, akactor, true, "BDA", "BaboDialogueAfter", 80, true)
				return
			endif
		endif

		If (SLApproachMain.enableSLHHFlag)
			SLHHActivate(akactor, None)
			if SLApproachMain.debugLogFlag
				Debug.notification(akactor + "SLHH Activated")
			endif
		Else
			self.StartSexMulti(PlayerRef, akactor, HelpRaperRef.GetReference() as Actor, true)
		EndIf
		;Parent.ResistFailed(akactor);End motion not ready yet
	EndFunction

EndState

State FondlePussy
	Event OnBeginState()
		SLApproachScenePhase.setvalue(0)
		slappUtil.DetectPlayerAttire(NPCActor, 0, 5)
		;slappUtil.UnequipShieldSimple(NPCActor)
		if Parent.AcyclePairedMotion(NPCActor, 0, 0, 0, 11)
			Parent.AnimationPlays(true)
		else
			Debug.sendanimationevent(NPCActor, "Babo_FlirtPussy_A02")
			Debug.sendanimationevent(PlayerRef, "Babo_FlirtPussy_A01")
		endif
		utility.wait(3.0)
		SLAppPussyPlayScene.forcestart()
		DownedTime = 30.0 + SLApproachMain.SLAPStruggleDuration
		FillThreshold = 0.5 / SLApproachMain.SLAPStrafeDifficulty
		Phase01 = DownedTime * 0.2
		Phase02 = DownedTime * 0.4
		Phase03 = DownedTime * 0.6
		Phase04 = DownedTime * 0.8
		StruggleBarDisplay(true)
		slaexposure = (sla_Framework as slaFrameworkScr).GetActorExposure(NPCActor)
		RegisterForSingleUpdate(1.0)
	EndEvent
	
	Event OnUpdate() ; Loop to check the situation every 1 second.
		Time += 1
		If StruggleBar.Percent >= 1.0
			ResistSuccess(NPCActor)
			Return
		elseif Time > DownedTime
			SLApproachScenePhase.setvalue(5)
			;TouchPussyResistFailed(NPCActor);WIP Female Peeing
			slaexposure += 20
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
			ResistSuccess(NPCActor)
			Return
		elseif Time >= Phase04
			SLApproachScenePhase.setvalue(4)
			slaexposure += 10
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		elseif Time >= Phase03
			SLApproachScenePhase.setvalue(3)
			slaexposure += 8
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		elseif Time >= Phase02
			SLApproachScenePhase.setvalue(2)
			slaexposure += 6
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		elseif Time >= Phase01
			SLApproachScenePhase.setvalue(1)
			slaexposure += 4
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		Endif

	StruggleBar.Alpha = 100.0
	RegisterForSingleUpdate(1.0)
	EndEvent

	Function StopSceneForce();Used in Config
		UnregisterForUpdate()
		ResistSuccess(NPCActor)
	EndFunction

	Function ResistSuccess(actor akactor)
		SLAppPussyPlayScene.stop()
		Self.Restore()
		Parent.AnimationPlays(false)
		Parent.PrecisionCheck(NPCActor, false)
		Parent.RestoreControl(akactor)
		SLApproachPlayPussyAura.cast(PlayerRef, akactor)
		ShowOffBodyEnd(NPCActor, SLApproachScenePhase.getvalue() as int * 10, True, False)
	EndFunction

EndState

State TouchPussy

	Event OnBeginState()
		SLApproachScenePhase.setvalue(0)
		slappUtil.DetectPlayerAttire(NPCActor, 0, 5)
		;slappUtil.UnequipShieldSimple(NPCActor)
		if Parent.AcyclePairedMotion(NPCActor, 180, -10, 45, 6)
			Parent.AnimationPlays(true)
		endif
		utility.wait(3.0)
		SLAppPussyTouchScene.forcestart()
		DownedTime = 30.0 + SLApproachMain.SLAPStruggleDuration
		FillThreshold = 0.5 / SLApproachMain.SLAPStrafeDifficulty
		Phase01 = DownedTime * 0.2
		Phase02 = DownedTime * 0.4
		Phase03 = DownedTime * 0.6
		Phase04 = DownedTime * 0.8
		StruggleBarDisplay(true)
		slaexposure = (sla_Framework as slaFrameworkScr).GetActorExposure(NPCActor)
		RegisterForSingleUpdate(1.0)
	EndEvent
	
	Event OnUpdate() ; Loop to check the situation every 1 second.
		Time += 1
		If StruggleBar.Percent >= 1.0
			ResistSuccess(NPCActor)
			Return
		elseif Time > DownedTime
			SLApproachScenePhase.setvalue(5)
			;TouchPussyResistFailed(NPCActor);WIP Female Peeing
			slaexposure += 20
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
			ResistSuccess(NPCActor)
			Return
		elseif Time >= Phase04
			SLApproachScenePhase.setvalue(4)
			slaexposure += 10
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		elseif Time >= Phase03
			SLApproachScenePhase.setvalue(3)
			slaexposure += 8
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		elseif Time >= Phase02
			SLApproachScenePhase.setvalue(2)
			slaexposure += 6
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		elseif Time >= Phase01
			SLApproachScenePhase.setvalue(1)
			slaexposure += 4
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		Endif

	StruggleBar.Alpha = 100.0
	RegisterForSingleUpdate(1.0)
	EndEvent

	Function StopSceneForce();Used in Config
		UnregisterForUpdate()
		ResistSuccess(NPCActor)
	EndFunction
	
	Function ResistSuccess(actor akactor)
		SLAppPussyTouchScene.stop()
		Self.Restore()
		Parent.AnimationPlays(false)
		Parent.PrecisionCheck(NPCActor, false)
		Parent.RestoreControl(akactor)
		SLApproachTouchPussyAura.cast(PlayerRef, akactor)
		if akactor.isinfaction(slapp_StealArmorFaction) && SLApproachMain.SLAProstitutionpayway == 1
			Parent.ReturnStolenGoods(akactor)
		endif
		ShowOffBodyEnd(NPCActor, SLApproachScenePhase.getvalue() as int * 8, True, False)
	EndFunction

EndState

State PlayPussy

	Event OnBeginState()
		SLApproachScenePhase.setvalue(0)
		slappUtil.DetectPlayerAttire(NPCActor, 0, 5)
		;slappUtil.UnequipShieldSimple(NPCActor)
		if Parent.AcyclePairedMotion(NPCActor, 180, -30, 20, 7)
			Parent.AnimationPlays(true)
		endif
		utility.wait(3.0)
		SLAppPussyPlayScene.forcestart()
		DownedTime = 30.0 + SLApproachMain.SLAPStruggleDuration
		FillThreshold = 0.5 / SLApproachMain.SLAPStrafeDifficulty
		Phase01 = DownedTime * 0.2
		Phase02 = DownedTime * 0.4
		Phase03 = DownedTime * 0.6
		Phase04 = DownedTime * 0.8
		StruggleBarDisplay(true)
		slaexposure = (sla_Framework as slaFrameworkScr).GetActorExposure(NPCActor)
		RegisterForSingleUpdate(1.0)
	EndEvent
	
	Event OnUpdate() ; Loop to check the situation every 1 second.
		Time += 1

		If StruggleBar.Percent >= 1.0
			ResistSuccess(NPCActor)
			Return
		elseif Time > DownedTime
			SLApproachScenePhase.setvalue(5)
			;PlayPussyResistFailed(NPCActor);WIP Female Peeing
			ResistSuccess(NPCActor)
			slaexposure += 10
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
			Return
		elseif Time >= Phase04
			SLApproachScenePhase.setvalue(4)
			slaexposure += 20
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		elseif Time >= Phase03
			SLApproachScenePhase.setvalue(3)
			slaexposure += 15
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		elseif Time >= Phase02
			SLApproachScenePhase.setvalue(2)
			slaexposure += 10
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		elseif Time >= Phase01
			SLApproachScenePhase.setvalue(1)
			slaexposure += 10
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		Endif

	StruggleBar.Alpha = 100.0
	RegisterForSingleUpdate(1.0)
	EndEvent

	Function StopSceneForce();Used in Config
		UnregisterForUpdate()
		ResistSuccess(NPCActor)
	EndFunction

	Function ResistSuccess(actor akactor)
		SLAppPussyPlayScene.stop()
		Self.Restore()
		Parent.AnimationPlays(false)
		Parent.PrecisionCheck(NPCActor, false)
		Parent.RestoreControl(akactor)
		SLApproachPlayPussyAura.cast(PlayerRef, akactor)
		ShowOffBodyEnd(NPCActor, SLApproachScenePhase.getvalue() as int * 10, True, False)
	EndFunction
EndState

State SuckPussy

	Event OnBeginState()
		SLApproachScenePhase.setvalue(0)
		slappUtil.DetectPlayerAttire(NPCActor, 0, 5)
		;slappUtil.UnequipShieldSimple(NPCActor)
		if Parent.AcyclePairedMotion(NPCActor, 180, 0, 50, 8)
			Parent.AnimationPlays(true)
		endif
		utility.wait(3.0)
		SLAppPussySuckScene.forcestart()
		DownedTime = 30.0 + SLApproachMain.SLAPStruggleDuration
		FillThreshold = 0.5 / SLApproachMain.SLAPStrafeDifficulty
		Phase01 = DownedTime * 0.2
		Phase02 = DownedTime * 0.4
		Phase03 = DownedTime * 0.6
		Phase04 = DownedTime * 0.8
		StruggleBarDisplay(true)
		slaexposure = (sla_Framework as slaFrameworkScr).GetActorExposure(NPCActor)
		RegisterForSingleUpdate(1.0)
	EndEvent
	
	Event OnUpdate() ; Loop to check the situation every 1 second.
		Time += 1

		If StruggleBar.Percent >= 1.0
			ResistSuccess(NPCActor)
			Return
		elseif Time > DownedTime
			SLApproachScenePhase.setvalue(5)
			;PlayPussyResistFailed(NPCActor);WIP Female Peeing
			ResistSuccess(NPCActor)
			slaexposure += 10
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
			Return
		elseif Time >= Phase04
			SLApproachScenePhase.setvalue(4)
			slaexposure += 20
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		elseif Time >= Phase03
			SLApproachScenePhase.setvalue(3)
			slaexposure += 15
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		elseif Time >= Phase02
			SLApproachScenePhase.setvalue(2)
			slaexposure += 10
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		elseif Time >= Phase01
			SLApproachScenePhase.setvalue(1)
			slaexposure += 10
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		Endif

	StruggleBar.Alpha = 100.0
	RegisterForSingleUpdate(1.0)
	EndEvent

	Function StopSceneForce();Used in Config
		UnregisterForUpdate()
		ResistSuccess(NPCActor)
	EndFunction

	Function ResistSuccess(actor akactor)
		SLAppPussySuckScene.stop()
		Self.Restore()
		Parent.AnimationPlays(false)
		Parent.PrecisionCheck(NPCActor, false)
		Parent.RestoreControl(akactor)
		SLApproachSuckPussyAura.cast(PlayerRef, akactor)
		ShowOffBodyEnd(NPCActor, SLApproachScenePhase.getvalue() as int * 15, True, False)
	EndFunction

EndState

State TouchBreasts;complete

	Event OnBeginState()
		SLApproachScenePhase.setvalue(0)
		slappUtil.DetectPlayerAttire(NPCActor, 0, 5)
		;slappUtil.UnequipShieldSimple(NPCActor)
		if Parent.AcyclePairedMotion(NPCActor, 180, 0, 50, 12)
			Parent.AnimationPlays(true)
		endif
		utility.wait(3.0)
		SLAppBreastsTouchScene.forcestart()
		DownedTime = 30.0 + SLApproachMain.SLAPStruggleDuration
		FillThreshold = 0.5 / SLApproachMain.SLAPStrafeDifficulty
		Phase01 = DownedTime * 0.2
		Phase02 = DownedTime * 0.4
		Phase03 = DownedTime * 0.6
		Phase04 = DownedTime * 0.8
		StruggleBarDisplay(true)
		slaexposure = (sla_Framework as slaFrameworkScr).GetActorExposure(NPCActor)
		RegisterForSingleUpdate(1.0)
	EndEvent
	
	Event OnUpdate() ; Loop to check the situation every 1 second.
		Time += 1

		If StruggleBar.Percent >= 1.0
			ResistSuccess(NPCActor)
			Return
		elseif Time > DownedTime
			SLApproachScenePhase.setvalue(5)
			ResistSuccess(NPCActor)
			slaexposure += 10
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
			Return
		elseif Time >= Phase04
			SLApproachScenePhase.setvalue(4)
			slaexposure += 20
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		elseif Time >= Phase03
			SLApproachScenePhase.setvalue(3)
			slaexposure += 15
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		elseif Time >= Phase02
			SLApproachScenePhase.setvalue(2)
			slaexposure += 10
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		elseif Time >= Phase01
			SLApproachScenePhase.setvalue(1)
			slaexposure += 10
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		Endif

	StruggleBar.Alpha = 100.0
	RegisterForSingleUpdate(1.0)
	EndEvent

	Function StopSceneForce();Used in Config
		UnregisterForUpdate()
		ResistSuccess(NPCActor)
	EndFunction

	Function ResistSuccess(actor akactor)
		SLAppBreastsTouchScene.stop()
		Self.Restore()
		Parent.AnimationPlays(false)
		Parent.PrecisionCheck(NPCActor, false)
		Parent.RestoreControl(akactor)
		SLApproachTouchBreastsAura.cast(PlayerRef, akactor)
		if akactor.isinfaction(slapp_StealArmorFaction) && SLApproachMain.SLAProstitutionpayway == 1
			Parent.ReturnStolenGoods(akactor)
		endif
		ShowOffBodyEnd(NPCActor, SLApproachScenePhase.getvalue() as int * 4, True, False)
	EndFunction

EndState

State SuckBreasts;complete

	Event OnBeginState()
		SLApproachScenePhase.setvalue(0)
		slappUtil.DetectPlayerAttire(NPCActor, 0, 5)
		;slappUtil.UnequipShieldSimple(NPCActor)
		if Parent.AcyclePairedMotion(NPCActor, 180, -10, 45, 13)
			Parent.AnimationPlays(true)
		endif
		utility.wait(3.0)
		SLAppBreastsSuckScene.forcestart()
		DownedTime = 30.0 + SLApproachMain.SLAPStruggleDuration
		FillThreshold = 0.5 / SLApproachMain.SLAPStrafeDifficulty
		Phase01 = DownedTime * 0.2
		Phase02 = DownedTime * 0.4
		Phase03 = DownedTime * 0.6
		Phase04 = DownedTime * 0.8
		StruggleBarDisplay(true)
		slaexposure = (sla_Framework as slaFrameworkScr).GetActorExposure(NPCActor)
		RegisterForSingleUpdate(1.0)
	EndEvent
	
	Event OnUpdate() ; Loop to check the situation every 1 second.
		Time += 1

		If StruggleBar.Percent >= 1.0
			ResistSuccess(NPCActor)
			Return
		elseif Time > DownedTime
			SLApproachScenePhase.setvalue(5)
			ResistSuccess(NPCActor)
			slaexposure += 10
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
			Return
		elseif Time >= Phase04
			SLApproachScenePhase.setvalue(4)
			slaexposure += 20
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		elseif Time >= Phase03
			SLApproachScenePhase.setvalue(3)
			slaexposure += 15
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		elseif Time >= Phase02
			SLApproachScenePhase.setvalue(2)
			slaexposure += 10
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		elseif Time >= Phase01
			SLApproachScenePhase.setvalue(1)
			slaexposure += 10
			(sla_Framework as slaFrameworkScr).SetActorExposure(NPCActor, slaexposure)
		Endif

	StruggleBar.Alpha = 100.0
	RegisterForSingleUpdate(1.0)
	EndEvent

	Function StopSceneForce();Used in Config
		UnregisterForUpdate()
		ResistSuccess(NPCActor)
	EndFunction

	Function ResistSuccess(actor akactor)
		SLAppBreastsSuckScene.stop()
		Self.Restore()
		Parent.AnimationPlays(false)
		Parent.PrecisionCheck(NPCActor, false)
		Parent.RestoreControl(akactor)
		SLApproachSuckBreastsAura.cast(PlayerRef, akactor)
		if akactor.isinfaction(slapp_StealArmorFaction) && SLApproachMain.SLAProstitutionpayway == 1
			Parent.ReturnStolenGoods(akactor)
		endif
		ShowOffBodyEnd(NPCActor, SLApproachScenePhase.getvalue() as int * 5, True, False)
	EndFunction

EndState

Function SimpleMotionStop(actor akactor)
	Restore()
	Parent.AnimationPlays(false)
	Parent.PrecisionCheck(NPCActor, false)
	Parent.RestoreControl(akactor)
EndFunction

Function TouchPussyResistFailed(actor akactor);WIP
EndFunction

Function PlayPussyResistFailed(actor akactor);WIP
EndFunction

Event OnKeyDown(Int KeyCode)
	If ((KeyCode == StrafeL) && LeftRight)
		LeftRight = False
		FillDifficulty += FillThreshold
		StruggleBar.Percent = (FillDifficulty)
	Elseif ((KeyCode == StrafeR) && !LeftRight)
		LeftRight = True
		FillDifficulty += FillThreshold
		StruggleBar.Percent = (FillDifficulty)
	Endif
EndEvent

Function StruggleBarDisplay(Bool Display = True)
If Display == true
	StruggleBar.Alpha = 100.0
	If ((SLApproach_Config as SLApproachConfigScript).ResistType == "$Attack")
		StrafeL = Input.GetMappedKey("Left Attack/Block")
		StrafeR = Input.GetMappedKey("Right Attack/Block")
	Else
		StrafeL = Input.GetMappedKey("Strafe Left")
		StrafeR = Input.GetMappedKey("Strafe Right")
	Endif
	RegisterForKey(StrafeL)
	RegisterForKey(StrafeR)
Else
	StruggleBar.Alpha = 0.0
	StruggleBar.Percent = 0.0
	FillDifficulty = 0.0
	UnregisterForKey(StrafeL)
	UnregisterForKey(StrafeR)
EndIf

EndFunction

Event Onupdate()
	Time = 0
	StruggleBarDisplay(False)
EndEvent

Function Restore()
	Time = 0
	StruggleBarDisplay(False)
	GotoState("")
	RegisterForSingleUpdate(10.0);Just in case
EndFunction

Function ForceAllocation(actor akactor)
	talkingActor.clear()
	talkingActor.ForceRefTo(akactor)
EndFunction

GlobalVariable Property SLA_DDEquipType Auto

Function EquipDD()
	(SLApproach_ExternalMods as SLApproachExternalScript).DeviousEquip(talkingActor.getreference() as actor, SLA_DDEquipType.value as int)
EndFunction

Function RecoverStolenArmor(actor akactor)
	akactor.removeitem(SLApproachMain.StolenArmor, 1, true, playerref)
	SLA_BStolenArmor.setvalue(0)
EndFunction

;####################################################
;#################### Events  #######################
;####################################################

;################Example###############	
;	Function FireApproach(form akref,int SceneNum)
;		Int handle = ModEvent.Create("SLAPP_FireApproach")
;		ModEvent.PushForm(handle, akref)
;		ModEvent.Pushint(handle, SceneNum)
;		ModEvent.Send(handle)
;	EndFunction

Function RegisterExternalModEvent()
	RegisterForModEvent("SLAPP_FireApproach", "SLAPPFireApproach")
EndFunction

Event SLAPPFireApproach(Form akref, int SceneNum = 1)
	Actor akactor = akref as actor
	Self.FireApproachScene(akactor, SceneNum)
EndEvent

Function FireApproachScene(Actor akactor, int SceneNum)
	if SLApproachMain.debugLogFlag
		Debug.notification("FireApproachScene")
	endif
	Self.StopScene()
	ChanceRollMisc(akactor, PlayerRef, SLApproachMain.baseChanceMultiplier, SceneNum)
EndFunction

;####################################################
;################ JSON Import #######################
;####################################################

Function ImportPlayerStatus()

if SLA_BaboDialogue.getvalue() == 1

	String File = "../BaboDialogue/BaboDialoguePlayerStatus.json"
	String FileB = "../BaboDialogue/BaboDialogueConfig.json"
	
	WhiterunOrcFuckToyTitleRank = JsonUtil.GetintValue(File, "WhiterunOrcFuckToyTitleRank")
	RieklingThirskFuckToyTitleRank = JsonUtil.GetintValue(File, "RieklingThirskFuckToyTitleRank")
	NightgateInnVictoryTitleRank = JsonUtil.GetintValue(File, "NightgateInnVictoryTitleRank")
	NightgateInnFuckedTitleRank = JsonUtil.GetintValue(File, "NightgateInnFuckedTitleRank")
	InvestigationMarkarthTitleRank = JsonUtil.GetintValue(File, "InvestigationMarkarthTitleRank")
	DeviousNobleSonFuckToyTitleRank = JsonUtil.GetintValue(File, "DeviousNobleSonFuckToyTitleRank")
	ChallengerFucktoyTitleRank = JsonUtil.GetintValue(File, "ChallengerFucktoyTitleRank")
	ArgonianDisplayedFuckToyTitleRank = JsonUtil.GetintValue(File, "ArgonianDisplayedFuckToyTitleRank")
	ArgonianDefeatedTitleRank = JsonUtil.GetintValue(File, "ArgonianDefeatedTitleRank")
	LoanSharkSlaveTitleRank = JsonUtil.GetintValue(File, "LoanSharkSlaveTitleRank")
	PitifulHeroineTitleRank = JsonUtil.GetintValue(File, "PitifulHeroineTitleRank")
	boozethatleadstoTitleRank = JsonUtil.GetintValue(File, "boozethatleadstotitlerank")
	
	CreatureCumInside = JsonUtil.GetintValue(File, "babocuminsidecreatures")

	BaboWillPowerint = JsonUtil.GetintValue(File, "babowillpower")
	BaboReputationint = JsonUtil.GetintValue(File, "baboreputation")
	BaboReputationBitchint = JsonUtil.GetintValue(File, "baboreputationbitch")
	BaboPubicHairStyle = JsonUtil.GetintValue(FileB, "babopubichaircheck")

	SLA_WhiterunOrcFuckToyTitleRank.setvalue(WhiterunOrcFuckToyTitleRank)
	SLA_RieklingThirskFuckToyTitleRank.setvalue(RieklingThirskFuckToyTitleRank)
	SLA_NightgateInnVictoryTitleRank.setvalue(NightgateInnVictoryTitleRank)
	SLA_NightgateInnFuckedTitleRank.setvalue(NightgateInnFuckedTitleRank)
	SLA_InvestigationMarkarthTitleRank.setvalue(InvestigationMarkarthTitleRank)
	SLA_DeviousNobleSonFuckToyTitleRank.setvalue(DeviousNobleSonFuckToyTitleRank)
	SLA_ChallengerFucktoyTitleRank.setvalue(ChallengerFucktoyTitleRank)
	SLA_ArgonianDisplayedFuckToyTitleRank.setvalue(ArgonianDisplayedFuckToyTitleRank)
	SLA_ArgonianDefeatedTitleRank.setvalue(ArgonianDefeatedTitleRank)
	SLA_LoanSharkSlaveTitleRank.setvalue(LoanSharkSlaveTitleRank)
	SLA_PitifulHeroineTitleRank.setvalue(PitifulHeroineTitleRank)
	SLA_boozethatleadstoTitleRank.setvalue(boozethatleadstoTitleRank)
	
	SLA_CreatureCumInside.setvalue(CreatureCumInside)

	SLA_BaboWillPower.setvalue(BaboWillPowerint)
	SLA_BaboReputation.setvalue(BaboReputationint)
	SLA_BaboReputationBitch.setvalue(BaboReputationBitchint)
	SLA_BaboPubicHairStyle.setvalue(BaboPubicHairStyle)
endif
if SLA_FillHerUp.getvalue() == 1
	Faction FHUVagfaction = Game.GetFormFromFile(0x00A991, "sr_FillHerUp.esp") as Faction
	Faction FHUOralfaction = Game.GetFormFromFile(0x14204B, "sr_FillHerUp.esp") as Faction
	PlayerRef.setfactionrank(slapp_FillHerUpVagFaction, PlayerRef.getfactionrank(FHUVagfaction))
	PlayerRef.setfactionrank(slapp_FillHerUpOralFaction, PlayerRef.getfactionrank(FHUOralfaction))
endif
EndFunction


int CreatureCumInside

int WhiterunOrcFuckToyTitleRank
int RieklingThirskFuckToyTitleRank
int NightgateInnVictoryTitleRank
int NightgateInnFuckedTitleRank
int InvestigationMarkarthTitleRank
int DeviousNobleSonFuckToyTitleRank
int ChallengerFucktoyTitleRank
int ArgonianDisplayedFuckToyTitleRank
int ArgonianDefeatedTitleRank
int LoanSharkSlaveTitleRank
int PitifulHeroineTitleRank
int boozethatleadstoTitleRank

int BaboPubicHairStyle
int BaboWillPowerint
int BaboReputationint
int BaboReputationBitchint


GlobalVariable Property SLA_CreatureCumInside Auto

GlobalVariable Property SLA_WhiterunOrcFuckToyTitleRank Auto
GlobalVariable Property SLA_RieklingThirskFuckToyTitleRank Auto
GlobalVariable Property SLA_NightgateInnVictoryTitleRank Auto
GlobalVariable Property SLA_NightgateInnFuckedTitleRank Auto
GlobalVariable Property SLA_InvestigationMarkarthTitleRank Auto
GlobalVariable Property SLA_DeviousNobleSonFuckToyTitleRank Auto
GlobalVariable Property SLA_ChallengerFucktoyTitleRank Auto
GlobalVariable Property SLA_ArgonianDisplayedFuckToyTitleRank Auto
GlobalVariable Property SLA_ArgonianDefeatedTitleRank Auto
GlobalVariable Property SLA_LoanSharkSlaveTitleRank Auto
GlobalVariable Property SLA_PitifulHeroineTitleRank Auto
GlobalVariable Property SLA_boozethatleadstoTitleRank Auto

GlobalVariable Property SLA_BaboPubicHairStyle Auto


;----------------------------Properties----------------------------

Armor StolenArmor

Actor NPCtalkingActor
Actor VisitorRef
Scene selectedScene
bool property willRape Auto Hidden Conditional
bool property SLHHwillRape Auto Hidden Conditional
bool property PCApproachOngoing Auto Hidden Conditional
bool property PCVisitingBefore Auto Hidden Conditional
bool property PCVisitingOn Auto Hidden Conditional
bool property PCVisitingAfter Auto Hidden Conditional
bool Property HasDoorKey Auto Hidden conditional
bool Property DoorKeyexist Auto Hidden conditional
float Property ProstitutionAcceptChance = 0.0 Auto Hidden Conditional

Actor NPCActor

keyword property ClothingPoor Auto
keyword property ClothingRich Auto

Miscobject property gold001 Auto
WorldSpace AkWorld
WorldSpace Property Whiterunworld Auto
WorldSpace Property Solitudeworld Auto
Float Property fPlayerSpeechCraft Auto
GlobalVariable Property SlappSpeechAV Auto

SLApproachMainScript Property SLApproachPC auto

Quest property SLApproachScanningPlayerHouse auto
Quest property SLApproachScanningVisitor auto
Quest Property SLApproachAskForSexQuest auto

SLAppSexUtil Property SexUtil Auto

Formlist Property SLApproachDDIList Auto
Formlist Property SLApproachDDIYokeList Auto

Formlist Property SLApproachPlayerHouseCustom01 Auto
Formlist Property SLApproachPlayerHouseCustom02 Auto
Formlist Property SLApproachPlayerHouseCustom03 Auto
Formlist Property SLApproachPlayerHouseCustom04 Auto
Formlist Property SLApproachPlayerHouseCustom05 Auto
Formlist Property SLApproachPlayerHouseCustom06 Auto
Formlist Property SLApproachPlayerHouseCustom07 Auto
Formlist Property SLApproachPlayerHouseCustom08 Auto
Formlist Property SLApproachPlayerHouseCustom09 Auto
Formlist Property SLApproachPlayerHouseCustom10 Auto
formlist Property SLApproachTraitList Auto

GlobalVariable Property SLA_DDI Auto
GlobalVariable Property sla_slsurvival Auto

GlobalVariable Property SLAKnockCount Auto
GlobalVariable Property SLApproachRapeToggle Auto

GlobalVariable Property SLApproachStayingTime Auto
GlobalVariable Property SLApproachRapedTimes Auto
GlobalVariable Property SLApproachAskNameTimes Auto
GlobalVariable Property SLApproachAskSexTimes Auto
GlobalVariable Property SLApproachNormalSexTimes Auto
GlobalVariable Property SLApproachProstitutionTimes Auto
GlobalVariable Property SLApproachProstitutionTryTimes Auto
GlobalVariable Property SLApproachGiftTimes Auto

GlobalVariable Property SLApproachProstitutionMin Auto
GlobalVariable Property SLApproachProstitutionMax Auto
GlobalVariable Property SLApproachProstitutionValue Auto
GlobalVariable Property SLApproachProstitutionValueHalf Auto
GlobalVariable Property SLApproachProstitutionFraudChance Auto

GlobalVariable Property SLApproachCurrentPlayerHouse Auto
GlobalVariable Property SLApproachVisitorStaying Auto
GlobalVariable Property SLApproachSweetKissType Auto

GlobalVariable Property SLApproachSpankTimes Auto
GlobalVariable Property SLApproachMolestTimes Auto
GlobalVariable Property SLApproachAssGropeTimes Auto
GlobalVariable Property SLApproachBackHugTimes Auto
GlobalVariable Property SLApproachBackHugMolestTimes Auto
GlobalVariable Property SLApproachSweetKissTimes Auto
GlobalVariable Property SLApproachForcedKissTimes Auto
Globalvariable Property SLApproachGuardPunishmentTimes Auto
Globalvariable Property slapp_PlayerNakedGlobal Auto
Globalvariable Property slapp_PlayerUnderwearGlobal Auto

GlobalVariable Property GameDaysPassed Auto

Faction Property sla_Arousal  Auto
Faction Property ArousalFaction  Auto
Faction Property slapp_VisitedRapistFaction  Auto
Faction Property slapp_VisitingRapistFaction  Auto
Faction Property slapp_NoVisitFaction  Auto
Faction Property slapp_ThugFaction  Auto
Faction Property slapp_SpoiledKid Auto
Faction Property slapp_TraitAddictfaction Auto
Faction Property slapp_TraitAttitudefaction Auto
;Faction Property slapp_TraitFetishfaction Auto
Faction Property slapp_TraitNormalfaction Auto

ReferenceAlias Property Alias_VisitorRef  Auto  ; SLApproachScanningPlayerHouse
ReferenceAlias Property TalkingActor  Auto
ReferenceAlias Property StayingActor  Auto  

ReferenceAlias Property FollowerRef  Auto  
ReferenceAlias Property ExternalFollowerRef  Auto  

ReferenceAlias Property PlayerHouseCenterMarker Auto
ReferenceAlias Property ExternalPlayerHouseCenterMarker Auto

ReferenceAlias Property PlayerHouseDoor Auto
ReferenceAlias Property ExternalPlayerHouseDoor Auto

ReferenceAlias Property PlayerHouseInteriorStrollA Auto
ReferenceAlias Property PlayerHouseInteriorStrollB Auto
ReferenceAlias Property PlayerHouseExteriorStrollA Auto
ReferenceAlias Property PlayerHouseExteriorStrollB Auto
ReferenceAlias Property PlayerHouseCOC Auto
ReferenceAlias Property ExternalPlayerHouseCOC Auto
ReferenceAlias Property ExternalPlayerHouseInteriorStrollA Auto
ReferenceAlias Property ExternalPlayerHouseInteriorStrollB Auto
ReferenceAlias Property ExternalPlayerHouseExteriorStrollA Auto
ReferenceAlias Property ExternalPlayerHouseExteriorStrollB Auto


Scene Property SLAppHousevisitScene  Auto  
Scene Property SLAppAggressiveBFPCScene  Auto  
Scene Property SLAppViceGuardCaptainScene  Auto  
Scene Property SLAppViceGuardCaptainSpankScene  Auto  
Scene Property SLAppAskingNameToPCScene  Auto  
Scene Property SLAppAskingKidScene  Auto  
Scene Property SLAppSpankingKidScene  Auto  
Scene Property SLAppAskingForSexKidScene  Auto  
Scene Property SLAppAskingKid02Scene  Auto  
Scene Property SLAppAskingMiscScene  Auto  
Scene Property SLAppAskingMiscStayingHouseScene  Auto  
Scene Property SLAppPeekingWhileBathing  Auto  
Scene Property SLAppPeekingWhilePeeing  Auto  
Scene Property SLAppBackHugMolest Auto
Scene Property SLAppBackHugScene Auto
Scene Property SLAppFrontHugScene Auto
Scene Property SLAppFrontHugAbruptScene Auto
Scene Property SLAppBackHugKidScene Auto
Scene Property SLAppFrontHugKidScene Auto
Scene Property SLAppFrontHugAbruptKidScene Auto
Scene Property SLApproachHouseStayScene  Auto  
Scene Property SLApproachHouseStayKidScene  Auto  
Scene Property SLApproachAskForSexQuestScene  Auto  
Scene Property SLApproachResponsetoNudityScene  Auto  
Scene Property SLApproachAskForSexQuestFollowPlayerScene Auto
Scene Property SLAppShowingOffBodyScene Auto
Scene Property SLAppAfterDrink Auto
Scene Property SLAppGuardPunishmentScene Auto
Scene Property SLAppPussyTouchScene Auto
Scene Property SLAppPussyPlayScene Auto
Scene Property SLAppPussySuckScene Auto
Scene Property SLAppDruggedFoodScene Auto
Scene Property SLAppBreastsSuckScene Auto
Scene Property SLAppBreastsTouchScene Auto
GlobalVariable Property SLApproachScenePhase Auto
;Scene Property SLAppHugToPCScene  Auto
;Scene Property SLAppKissToPCScene  Auto  

Armor Property SLAppRingBeast  Auto  

Keyword Property ActorTypeNPC  Auto  
TalkingActivator Property SLAPP_MaleVisitorTalkingActivator  Auto  

Sound Property SLAPPMarker_DoorClose  Auto  
Sound Property SLAPPMarker_DoorKnob  Auto  
Sound Property SLAPPMarker_DoorKnock  Auto  

Message Property SLAPP_KnockingDoorMsg  Auto  
Message Property SLAPP_ForgiveCrimeMsg  Auto  
Message Property SLAPP_ForgiveCrimeDrunkMsg  Auto  
Message Property SLAPP_ForgiveCrimeFoodToxicMsg  Auto  
Message Property SLAPP_ResistToxic  Auto  
Message Property SLAPP_UnderwearTakenAwayMsg  Auto  


actorbase Property VisitorRefBase Auto
ObjectReference[] Property SLAPCustomPlayerHouseXmarker Auto
ObjectReference Property SLAPPTestZoneXmarker Auto
ObjectReference Property SLAPPTemporaryVisitorMarker Auto
ObjectReference Property SLAPPTemporaryVisitorBackMarker Auto
LocationRefType Property SLAppCustomHouseLocKeyword  Auto  
Globalvariable Property SLAMiscDialogueType Auto
Faction Property slapp_PunishingGuard Auto
Topic Property SLApproachTalkAboutWearingsNPCComplainWearingNormal Auto
int slaexposure

Potion Property CureDisease Auto
