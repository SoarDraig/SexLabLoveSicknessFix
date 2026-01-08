Scriptname SLApproachBaseQuestScript extends Quest

Actor Property PlayerRef Auto
Int Property index = -1 Auto Hidden
Int Property maxTime = 60 Auto Hidden
bool Property approachEnding = false Auto Hidden
bool Property isSkipMode = false Auto Hidden
Globalvariable Property SLAFactorScore Auto
slapp_util Property slappUtil Auto

ObjectReference Property SLAPMiscReferences Auto
Package Property DoNothing Auto
Package Property SLAppDoNothing Auto
Bool Isplaying = false;Unidentifiable
Bool AnimationIsplaying = false

bool Property dhlpSuspendStatus Auto Hidden Conditional
formlist property SLApproachChildRaceList auto
Formlist Property SLApproachExcludeFaction Auto
Armor Property SLAppApproachRing Auto

Function register()
	index = -1
	while(index == -1)
		Utility.Wait(1.0)
		index = SLApproachMain.RegisterQuest(ApproachQuest, self, ApproachName)
	endwhile
EndFunction

Event OnUpdate()
if SLApproachMain.debugLogFlag
	Debug.notification("Parent: Onupdate")
endif
if AnimationIsplaying
	RegisterForSingleUpdate(20)
else
	endApproach()
endif
endEvent

Function ready()
	self.Reset()
	self.SetStage(10)
EndFunction

Function startApproach(Actor akRef)
	;Debug.notification("Start Approach Base")
	RegisterForSingleUpdate(maxTime)
EndFunction

Function startApproachCustom(int multiply)
	;Debug.notification("Start Approach Base")
	RegisterForSingleUpdate(maxTime * multiply)
EndFunction
;#########################
;##########Motion#########
;#########################

Idle Property BaboKissLoveS01_A1 Auto
Idle Property BaboKissLoveS01_A2 Auto
Idle Property BaboKissLoveS02_A1 Auto
Idle Property BaboKissLoveS02_A2 Auto

Idle Property SLAPForcedKiss01_A1_S01 Auto
Idle Property SLAPForcedKiss01_A2_S01 Auto
Idle Property SLAPForcedKiss01_A1_Loop Auto
Idle Property SLAPForcedKiss01_A2_Loop Auto
Idle Property SLAPForcedKiss01_A1_Resist Auto
Idle Property SLAPForcedKiss01_A2_Resist Auto
Idle Property SLAPForcedKiss01_A1_Stop Auto
Idle Property SLAPForcedKiss01_A2_Stop Auto

Faction Property slapp_AnimatingFaction Auto
Faction Property slapp_AnimatingAggFaction Auto
Faction Property slapp_IgnoreUniqueFaction Auto
Faction Property slapp_RapeCountFaction Auto
Faction Property slapp_ConfessRejectCountFaction Auto
Faction Property slapp_ConversationRejectCountFaction Auto
Faction Property slapp_IntroductionRejectCountFaction Auto
Faction Property slapp_SexRejectCountFaction Auto
Faction Property slapp_ProstitutionRejectCountFaction Auto
Faction Property slapp_HadSexCountFaction Auto
Faction Property slapp_HadSexVaginalCountFaction Auto
Faction Property slapp_HadSexAnalCountFaction Auto
Faction Property slapp_HadSexOralCountFaction Auto
Faction Property slapp_TraitPreferenceWeightfaction Auto
Faction Property slapp_TraitWeightfaction Auto
Faction Property slapp_WaitingForSexFaction Auto
Faction Property slapp_WaitingForShowBodyFaction Auto

Faction Property slapp_HaveSeenNudeBodyRecently Auto
Faction Property slapp_HaveSeenNudeBody Auto
Faction Property slapp_HaveSeenNakedBody Auto
Faction Property slapp_IsAnimatingWKidFaction Auto

Actor ActorMale
Scene Property SLApproachSpankingScene Auto
GlobalVariable Property SLA_SpankingScenarioGlobal Auto
Spell Property SLAPPFavorTavernSpell Auto
Spell Property SLAPPFavorSweetsSpell Auto
Spell Property SLApproachSpankAura Auto
Spell Property SLApproachAssGropeAura Auto
Spell Property SLApproachAssGropeBAura Auto
Spell Property SLApproachSuckPussyAura Auto
Spell Property SLApproachTouchBreastsAura Auto
Spell Property SLApproachSuckBreastsAura Auto
Spell Property SLApproachPlayPussyAura Auto
Spell Property SLApproachStealAura Auto
Spell Property SLApproachHugAura Auto
Spell Property SLApproachTouchPussyAura Auto
Spell Property SLApproachSpankAura2nd Auto
Spell Property SLApproachStripShowAura Auto
Spell Property SLApproachAuraBDViceCaptain Auto
Spell Property SLApproachMolestAura Auto
Spell Property SLApproachMolestSAura Auto
Spell Property SLApproachFoodCumAura Auto
Spell Property SLApproachFoodSleepingDrugAura Auto
Spell Property SLApproachHadDialogueSpell Auto
Potion Property Ale Auto

Keyword Property LocTypeInn Auto
Keyword Property LocTypeDwelling Auto
Keyword Property LocTypeCity Auto
Keyword Property LocTypeHabitation Auto
Keyword Property LocTypeTown Auto
Keyword Property SLAppLocType Auto

Function PrecisionCheck(Actor akactor, bool switch)
	Precision_Utility.ToggleDisableActor(PlayerRef, switch);Precision
	Precision_Utility.ToggleDisableActor(akactor, switch);Precision
EndFunction

Function AnimationPlays(Bool Switch)
	AnimationIsplaying = Switch
EndFunction

Bool Function AcyclePairedMotion(Actor akactor, int angle, int Xaxis, int Yaxis, int MotionType)
if !akactor.isinfaction(slapp_AnimatingFaction)
	if akactor.isinfaction(slapp_KidFaction)
		PlayerRef.addtofaction(slapp_IsAnimatingWKidFaction)
		akactor.addtofaction(slapp_IsAnimatingWKidFaction)
	endif

	PrecisionCheck(akactor, true)
 	ActorUtil.AddPackageOverride(akactor, SLAppDoNothing, 100, 1)
	ActorMale = akactor
	akactor.EvaluatePackage()
	akactor.SetRestrained(True)
	akactor.SetDontMove(True)
	;Game.DisablePlayerControls(true, true, true, false, true, true, false, false)
	Game.SetPlayerAIDriven(true)
	if Game.GetCameraState() == 0
		Game.ForceThirdPerson()
	endIf
	if MotionType >= 2
		SLApproachMain.RemoveHeelEffect(PlayerRef)
	endif
	Utility.Wait(0.5)
	Float AngleZ = PlayerRef.GetAngleZ()
	Float rMoveX = (Math.sin(AngleZ) * Yaxis) + (Math.cos(AngleZ) * Xaxis)
	Float rMoveY = (Math.cos(AngleZ) * Yaxis) - (Math.sin(AngleZ) * Xaxis)
	
	SLAPMiscReferences.MoveTo(PlayerRef, rMoveX, rMoveY)
	
	Utility.Wait(0.5)
	akactor.MoveTo(SLAPMiscReferences)
	akactor.setangle(0, 0, AngleZ + angle)
	Utility.Wait(0.5)


	if MotionType == 1
		Debug.sendanimationevent(akactor, "BaboSpankingM")
		Debug.sendanimationevent(PlayerRef, "BaboSpankingF")
		
		SLApproachSpankingScene.stop()
		akactor.SetRestrained(False)
		akactor.SetDontMove(False)
		ActorUtil.RemovePackageOverride(akactor, SLAppDoNothing)
		Utility.wait(3.0)
		If SLApproachMain.enableBDFlag
			if (akactor.isinfaction(SLApproachMain.BaboViceGuardCaptainFaction))
				SLApproachAuraBDViceCaptain.cast(PlayerRef, akactor)
			else
				SLApproachSpankAura.cast(PlayerRef, akactor)
			endif
		else
			SLApproachSpankAura.cast(PlayerRef, akactor)
		endif
		PrecisionCheck(akactor, false)
		PlayerRef.SetVehicle(None)
		Game.EnablePlayerControls()
		Game.SetPlayerAIDriven(false)
		
		if akactor.isinfaction(slapp_KidFaction)
			PlayerRef.RemoveFromfaction(slapp_IsAnimatingWKidFaction)
			akactor.RemoveFromfaction(slapp_IsAnimatingWKidFaction)
		endif

	elseif MotionType == 2
		;Game.EnablePlayerControls(true, false, false, false, false, false, false, false) ; To display the hud
		Debug.sendanimationevent(akactor, "BaboBackHugStartM")
		Debug.sendanimationevent(PlayerRef, "BaboBackHugStartF")
		SLApproachSpankingScene.stop()
	elseif MotionType == 3
		;Game.EnablePlayerControls(true, false, false, false, false, false, false, false) ; To display the hud
		Debug.sendanimationevent(akactor, "BaboBackHugMolestStartM")
		Debug.sendanimationevent(PlayerRef, "BaboBackHugMolestStartF")
		SLApproachSpankingScene.stop()
	elseif MotionType == 4
		;Game.EnablePlayerControls(true, false, false, false, false, false, false, false) ; To display the hud
		Debug.sendanimationevent(akactor, "BaboFrontHugStartM")
		Debug.sendanimationevent(PlayerRef, "BaboFrontHugStartF")
	elseif MotionType == 5
		;Game.EnablePlayerControls(true, false, false, false, false, false, false, false) ; To display the hud
		Debug.sendanimationevent(akactor, "BaboShowingOffBodyA2")
		Debug.sendanimationevent(PlayerRef, "BaboShowingOffBodyA1")
	elseif MotionType == 6
		;Game.EnablePlayerControls(true, false, false, false, false, false, false, false) ; To display the hud
		Debug.sendanimationevent(akactor, "BaboExaminePussyA2")
		Debug.sendanimationevent(PlayerRef, "BaboExaminePussyA1")
	elseif MotionType == 7
		;Game.EnablePlayerControls(true, false, false, false, false, false, false, false) ; To display the hud
		Debug.sendanimationevent(akactor, "BaboPlayingPussyA2")
		Debug.sendanimationevent(PlayerRef, "BaboPlayingPussyA1")
	elseif MotionType == 8
		;Game.EnablePlayerControls(true, false, false, false, false, false, false, false) ; To display the hud
		Debug.sendanimationevent(akactor, "BaboSuckingPussyA02")
		Debug.sendanimationevent(PlayerRef, "BaboSuckingPussyA01")
	elseif MotionType == 9
		;Debug.sendanimationevent(akactor, "BaboAssGropeM");WIP
		;Debug.sendanimationevent(PlayerRef, "BaboAssGropeF")
		int iAnimVar = GetDiceRoll()
		if iAnimVar > 30
			SLApproachAssGropeAura.cast(PlayerRef, akactor)
		else
			SLApproachAssGropeBAura.cast(PlayerRef, akactor)
		endif

		Debug.sendanimationevent(akactor, "BaboSpankingM")
		Debug.sendanimationevent(PlayerRef, "BaboSpankingF")
		
		SLApproachSpankingScene.stop()
		akactor.SetRestrained(False)
		akactor.SetDontMove(False)
		ActorUtil.RemovePackageOverride(akactor, SLAppDoNothing)
		Utility.wait(3.0)
		PrecisionCheck(akactor, false)
		PlayerRef.SetVehicle(None)
		Game.EnablePlayerControls()
		Game.SetPlayerAIDriven(false)
		
		if akactor.isinfaction(slapp_KidFaction)
			PlayerRef.RemoveFromfaction(slapp_IsAnimatingWKidFaction)
			akactor.RemoveFromfaction(slapp_IsAnimatingWKidFaction)
		endif
	elseif MotionType == 10
		;x -45 y -20
		Debug.sendanimationevent(akactor, "Babo_DruggedFoodConsumptionM")
		Debug.sendanimationevent(PlayerRef, "Babo_DruggedFoodConsumptionF")
	elseif MotionType == 11
		;x 0 y 0
		Debug.sendanimationevent(akactor, "Babo_Flirt_A02D")
		Debug.sendanimationevent(PlayerRef, "Babo_Flirt_A01")
	elseif MotionType == 12
		;y 50
		Debug.sendanimationevent(akactor, "Babo_TouchingBreasts_A02")
		Debug.sendanimationevent(PlayerRef, "Babo_TouchingBreasts_A01")
	elseif MotionType == 13
		;x -10 y 45
		Debug.sendanimationevent(akactor, "Babo_SuckingBreasts_A02")
		Debug.sendanimationevent(PlayerRef, "Babo_SuckingBreasts_A01")
	endif


	if SLApproachMain.debugLogFlag
		Debug.notification("SLAP Motion Starts")
	endif

	Return true
else
	Return false
endif
EndFunction

Bool Function PreparePairedmotion(Actor akactor, int angle)

if !akactor.isinfaction(slapp_AnimatingFaction)
	PrecisionCheck(akactor, true)
 	ActorUtil.AddPackageOverride(akactor, SLAppDoNothing, 100, 1)
	akactor.EvaluatePackage()
	akactor.SetRestrained(True)
	akactor.SetDontMove(True)
	Game.DisablePlayerControls(true, true, true, false, true, true, false, false)
	Game.SetPlayerAIDriven(); 
	if Game.GetCameraState() == 0
		Game.ForceThirdPerson()
	endIf
	SLApproachMain.RemoveHeelEffect(PlayerRef)
	SLAPMiscReferences.MoveTo(PlayerRef)
	Float AngleZ = PlayerRef.GetAngleZ()
		
	PlayerRef.SetVehicle(SLAPMiscReferences) ; PosRef
	akactor.SetVehicle(SLAPMiscReferences) ; PosRef
	akactor.MoveTo(PlayerRef)
	Utility.Wait(1.0)
	akactor.setangle(0, 0, AngleZ + angle)
	Utility.Wait(1.0)
	
	PlayerRef.addtofaction(slapp_AnimatingFaction)
	akactor.addtofaction(slapp_AnimatingFaction)
	
	Game.EnablePlayerControls(true, false, false, false, false, false, false, false) ; To display the hud
endif

Return true;Always concludes in True even if the actors are not aligned properly
EndFunction

Function FlirtAnim(Actor akactor, Bool FirstTrigger, int Animnum)
if FirstTrigger == true
	if PreparePairedmotion(akactor, 0)
		FlirtAnimPlay(akactor, Animnum)
	endif
else	
	FlirtAnimPlay(akactor, Animnum)
endif
EndFunction

Function FlirtAnimPlay(Actor akactor, int Animnum)
	if Animnum == 1
		Debug.SendAnimationEvent(PlayerRef, "Babo_Flirt_A01")
		Debug.SendAnimationEvent(akactor, "Babo_Flirt_A02D")
	elseif Animnum == 2
		Debug.SendAnimationEvent(PlayerRef, "Babo_FlirtBreast_A01")
		Debug.SendAnimationEvent(akactor, "Babo_FlirtBreast_A02")
	elseif Animnum == 3
		Debug.SendAnimationEvent(PlayerRef, "Babo_FlirtPussy_A01")
		Debug.SendAnimationEvent(akactor, "Babo_FlirtPussy_A02")
	elseif Animnum == 4
		Debug.SendAnimationEvent(PlayerRef, "Babo_FlirtFace_A01")
		Debug.SendAnimationEvent(akactor, "Babo_FlirtFace_A02")	
	elseif Animnum == 5
		Debug.SendAnimationEvent(PlayerRef, "Babo_FlirtFaceEnd_A01")
		Debug.SendAnimationEvent(akactor, "Babo_FlirtFaceEnd_A02")
	else
		Debug.SendAnimationEvent(akactor, "Babo_Flirt_A02D")
	endif
EndFunction

Function KissAnim(Actor akactor, int AnimType)
;Animtype 1: ForcedKiss
;Animtype 2: Not Ready
;Animtype 3: SweetKiss01
;Animtype 4: SweetKiss02
	If PreparePairedmotion(akactor, 180)
		if AnimType == 1
			PlayerRef.Playidle(SLAPForcedKiss01_A1_S01)
			akactor.Playidle(SLAPForcedKiss01_A2_S01)
		elseif AnimType == 2
			PlayerRef.Playidle(SLAPForcedKiss01_A1_S01)
			akactor.Playidle(SLAPForcedKiss01_A2_S01)
		elseif AnimType == 3
			PlayerRef.Playidle(BaboKissLoveS01_A1)
			akactor.Playidle(BaboKissLoveS01_A2)
		elseif AnimType == 4
			PlayerRef.Playidle(BaboKissLoveS02_A1)
			akactor.Playidle(BaboKissLoveS02_A2)
		endif
	endif
	PlayKissSound()
EndFunction

Function KissAnimResist(Actor akactor)
	PlayerRef.Playidle(SLAPForcedKiss01_A1_Resist)
	akactor.Playidle(SLAPForcedKiss01_A2_Resist)
	Utility.Wait(3.0)
	RestoreControl(akactor)
EndFunction

Function KissAnimStop(Actor akactor)
	PlayerRef.Playidle(SLAPForcedKiss01_A1_Stop)
	akactor.Playidle(SLAPForcedKiss01_A2_Stop)
	Utility.Wait(3.0)
	RestoreControl(akactor)
EndFunction

Function PlayKissSound()
	SLAPPMarker_DeepKiss.play(PlayerRef)
EndFunction

Function RestoreControl(actor akactor)
	PrecisionCheck(akactor, false)
	PlayerRef.SetVehicle(None)
	akactor.SetVehicle(None)
	Game.EnablePlayerControls()
	Game.SetPlayerAIDriven(false)
	Game.ForceThirdPerson()
	PlayerRef.SetRestrained(False)
	PlayerRef.SetDontMove(False)
	akactor.SetRestrained(False)
	akactor.SetDontMove(False)
	ActorUtil.RemovePackageOverride(akactor, SLAppDoNothing)
	Debug.SendAnimationEvent(akactor, "IdleForceDefaultState")
	Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	SLApproachMain.ResetHeelEffect(PlayerRef)
	PlayerRef.RemoveFromfaction(slapp_AnimatingFaction)
	PlayerRef.RemoveFromfaction(slapp_IsAnimatingWKidFaction)
	akactor.RemoveFromfaction(slapp_AnimatingFaction)
	akactor.RemoveFromfaction(slapp_IsAnimatingWKidFaction)
EndFunction

bool Function isSituationValid(Actor akRef);Check if the situation is valid for a npc approach
	ActorBase akRefbase = akRef.GetLeveledActorBase()

;#########################
;##########Add-on#########
;#########################
	If (dhlpSuspendStatus)	;lg added to respect scenes
		slappUtil.log("isSituationValid: false - dhlpSuspendStatus")
		return false
	endif
	
	int iindex
	iindex = SLApproachExcludeFaction.getsize()
	While iindex > 0
		iindex -= 1
		if akRef.isinfaction(SLApproachExcludeFaction.GetAt(iindex) as faction)
			return false
		endif
	EndWhile
	
	
	if SLApproachMain.enableSexlabSurvivalFlag
		(SLApproach_ExternalMods as SLApproachExternalScript).SLSurvivalLicenseCheck()
		if  (akRef.isinfaction((SLApproach_ExternalMods as SLApproachExternalScript).SLTollCollectorFaction) || akRef.isinfaction((SLApproach_ExternalMods as SLApproachExternalScript).SLKennelKeeperFaction) || akRef.isinfaction((SLApproach_ExternalMods as SLApproachExternalScript).SLLicenseQuarterMasterFaction))
			return false
		endif
	endif

	if SLApproachMain.enableBDFlag
		if (SLApproachMain.enableHirelingFlag == false)
			if  (akRef.isinfaction(SLApproachMain.BaboPotentialHireling))
				return false
			endif
		endif

		if akRef.isinfaction(SLApproachMain.BaboWasHireling)
			akRef.addtofaction(slapp_washiringfaction)
			BaboDialogueMercenaryCall(akRef)
			return false
		elseif !akRef.isinfaction(SLApproachMain.BaboWasHireling) && akRef.isinfaction(slapp_washiringfaction)
			akRef.removefromfaction(slapp_washiringfaction)
			return false
		endif

		if akRef.isinfaction(SLApproachMain.BaboDialogueFaction)
			if (akRef.isinfaction(SLApproachMain.BaboViceGuardCaptainFaction))
				if akRef.getactorvalue("Variable06") == 5
					return true
				endif
			endif
			return false
		endif

		if SLApproachMain.enableFollowerFlag == false
			if (akRef.isinfaction(SLApproachMain.BaboCurrentHireling))
				return false
			endif
		endif
	endif

	if (SLApproachMain.enableHirelingFlag == false)
		if (akRef.isinfaction(CurrentHireling)) || (akRef.isinfaction(PotentialHireling))
			return false
		endif
	endif
	if SLApproachMain.enableFollowerFlag == false
		if (akref.isinfaction(CurrentFollowerFaction)) || (akRef.isinfaction(CurrentHireling)) || (akref.IsPlayerTeammate())
			return false
		endif
	endif

;#########################
;######Unique Actor#######
;#########################

	if akref.isinfaction(slapp_IgnoreUniqueFaction) || akref.getitemcount(SLAppApproachRing) >= 1
		return true
	endif

	if (SLApproachMain.SLAUniqueActor == true) && (akRefbase.isUnique());Check if an actor happens to be unique.
		return true
	elseif (SLApproachMain.SLAUniqueActor == false) && (akRefbase.isUnique())
		if SLApproachMain.enableBDFlag
			if (akref.isinfaction(SLApproachMain.BaboViceGuardCaptainFaction))
				return true
			endif
		endif
		return false
	EndIf

;#########################
;#Humanoid identification#
;#########################
;	if (SLApproachMain.enableVisitorFlag == false) && (akRef.isinfaction(slapp_VisitingFaction))
;		return false
;	endif

;#########################
;########Creature######### WIP
;#########################
;		if (SLApproachMain.enablePetsFlag && akRef.IsPlayerTeammate()) ; WIP disabled
;			return true
;		elseif (akRace == HorseRace)
;			if (SLApproachMain.enablePlayerHorseFlag && slappUtil.ValidateHorse(akRef))
;				return true
;			else
;				return false
;			endif
;		endif

	return true
EndFunction

bool Function chanceRoll(Actor akRef, Actor akActor, float baseChanceMultiplier)
	return false
EndFunction

Function isPrecheckValid(Actor akRef, Actor akRef2, bool isplayer = false)
;	if (!slappUtil.ValidatePromise(akRef, akRef2) || !slappUtil.ValidateShyness(akRef, akRef2))
;		string debugstr = akRef.GetActorBase().GetName() + " => " + akRef2.GetActorBase().GetName()
;		slappUtil.log(ApproachName + " blocked by Promise or Shyness: " + debugstr)
;		return false
;	if !(slappUtil.ValidateGender(akRef, akRef2, isplayer))
;		string debugstr = akRef.GetActorBase().GetName() + " => " + akRef2.GetActorBase().GetName()
;		slappUtil.log(ApproachName + " blocked by Gender check: " + debugstr)
;		return false
;	endif
EndFunction
	
Bool Function PrecheckShota(Actor akRef)
	int i = SLApproachChildRaceList.getsize()
	
	if akRef.ischild()
		SLApproachMain.SLACurrentActorisChild = true
		if SLApproachMain.debugLogFlag
			debug.notification("SLACurrentActorisChild: True")
		endif
		return true
	else
		While i > 0
			i -= 1
			if akRef.GetLeveledActorBase().getrace() == SLApproachChildRaceList.getat(i) as race
				SLApproachMain.SLACurrentActorisChild = true
				if SLApproachMain.debugLogFlag
					debug.notification("SLACurrentActorisChild: True")
				endif
				return true
			endif
		Endwhile
	endif
	if SLApproachMain.debugLogFlag
		debug.notification("SLACurrentActorisChild: False")
	endif
	SLApproachMain.SLACurrentActorisChild = false
	return false
EndFunction

bool Function isSceneValid(Actor akRef)
	Scene aks = akRef.GetCurrentScene()
	
	if (aks)
		string akscene = aks.GetOwningQuest().GetId()
		string log = ApproachName + ": blocked by another Scene: "
		slappUtil.log(log + akRef.GetActorBase().GetName() + " : " + akscene)
		return false
	endif
	
	return true
EndFunction

int Function GetResult(int chance, int extpoint, float baseChanceMultiplier)
int result
	if extpoint > 0
		result = slappUtil.ValidateChance((chance * baseChanceMultiplier) as Int)
		result += extpoint*2
	else
		result = 0
	endif
	return result
EndFunction

int Function GetDiceRoll()
	return Utility.RandomInt(0, 100)
EndFunction

bool Function endApproach(bool force = false)
	if SLApproachMain.debugLogFlag
		Debug.notification("Parent: endApproach")
	endif
	ChangeStateStage(0)
	SLApproachMain.EndtInitOfQuestByIndex(index)
EndFunction

Function endApproachForce(ReferenceAlias akRef = None) ; for debug and Sex To PC's follow Scene
	slappUtil.log(ApproachName + ": endApproachForce!!")
	if (akRef)
		Actor fordebugact = akRef.GetReference() as Actor
		if (fordebugact)
			ActorBase fordebugname = fordebugact.GetActorBase()
			if (fordebugname)
				slappUtil.log(ApproachName + " Force Stop: " + fordebugname.GetName())
			endif
		endif
	endif
	self.endApproach(true)
EndFunction

Function endApproachDetachCell()
	self.endApproach(true)
EndFunction

Function sexRelationshipDown(Actor akRef, Actor akActor, int Possibility)
int relationship = akRef.GetRelationshipRank(akActor) - 1
Int DiceRoll = Self.GetDiceRoll()
; debug.notification("[slapp] " + relationship)
	If DiceRoll <= possibility
		if (relationship < -2)
			relationship = -2
		endif
		akRef.SetRelationshipRank(akActor, relationship)
	EndIf
EndFunction

Function sexRelationshipUp(Actor akRef, Actor akActor, int Possibility)
int relationship = akRef.GetRelationshipRank(akActor) + 1
Int DiceRoll = Self.GetDiceRoll()
	If DiceRoll <= possibility
		if (relationship > 4)
			relationship = 4
		endif
		akRef.SetRelationshipRank(akActor, relationship)
	endif
EndFunction

Function AddtoReconciliationFaction(actor akRef)
bool infaction = akRef.isinfaction(slapp_ReconciliationFaction)
Int DiceRoll = Self.GetDiceRoll()
Int Rank = akRef.GetfactionRank(slapp_ReconciliationFaction)
		If infaction == false
			akRef.addtofaction(slapp_ReconciliationFaction)
			akRef.setfactionrank(slapp_ReconciliationFaction, 0)
		Elseif (Rank == 0)
			akRef.setfactionrank(slapp_ReconciliationFaction, 1)
		ElseIf (Rank == 1)
			akRef.setfactionrank(slapp_ReconciliationFaction, 2)
		Elseif (Rank == 2)
			akRef.setfactionrank(slapp_ReconciliationFaction, 3)
		;Elseif (Rank == 3)
			;akRef.setfactionrank(slapp_ReconciliationFaction, 4)
		Endif
EndFunction

Function AddtoAskedForSexFaction(actor akRef);WIP
bool infaction = akRef.isinfaction(slapp_AskedForSexFaction)
	If infaction == false
		akRef.addtofaction(slapp_AskedForSexFaction)
		akRef.setfactionrank(slapp_AskedForSexFaction, 0);DislikeFaction
	Else
		Int Rank = akRef.GetfactionRank(slapp_StayedFaction)
		akRef.setfactionrank(slapp_AskedForSexFaction, Rank + 1)
	Endif
EndFunction

Function AddtoNoSpankFaction(actor akRef)
	akRef.addtofaction(slapp_NoSpankFaction)
EndFunction

Function AddtoNoMolestFaction(actor akRef)
	akRef.addtofaction(slapp_NoMolestFaction)
EndFunction

Function AddtoNoBackHugFaction(actor akRef)
	akRef.addtofaction(slapp_NoBackHugFaction)
EndFunction

int Function RankDownDislikeFaction(actor akRef)

if akRef.isinfaction(slapp_DislikeFaction)
	Int Rank = akRef.GetfactionRank(slapp_DislikeFaction)
	if Rank
		akRef.setfactionrank(slapp_DislikeFaction, Rank - 1)
	else
		akRef.removefromfaction(slapp_DislikeFaction)
	endif
	return Rank
endif

Return 0
EndFunction

Function AddtoVisitiedFaction(actor akRef)

bool infaction = akRef.isinfaction(slapp_VisitedFaction)
Int Rank = akRef.GetfactionRank(slapp_VisitedFaction)
	If infaction == false
		akRef.addtofaction(slapp_VisitedFaction)
		akRef.setfactionrank(slapp_VisitedFaction, 0);DislikeFaction
	Else
		akRef.setfactionrank(slapp_VisitedFaction, Rank + 1)
	Endif
EndFunction

Function AddtoStayedFaction(actor akRef)

bool infaction = akRef.isinfaction(slapp_StayedFaction)
Int Rank = akRef.GetfactionRank(slapp_StayedFaction)
	If infaction == false
		akRef.addtofaction(slapp_StayedFaction)
		akRef.setfactionrank(slapp_StayedFaction, 0);DislikeFaction
	Else
		akRef.setfactionrank(slapp_StayedFaction, Rank + 1)
	Endif
EndFunction

Function AddtoVisitiedFailedFaction(actor akRef)

bool infaction = akRef.isinfaction(slapp_VisitedFailedFaction)
Int Rank = akRef.GetfactionRank(slapp_VisitedFailedFaction)
	If infaction == false
		akRef.addtofaction(slapp_VisitedFailedFaction)
		akRef.setfactionrank(slapp_VisitedFailedFaction, 0);DislikeFaction
	Else
		akRef.setfactionrank(slapp_VisitedFailedFaction, Rank + 1)
	Endif
EndFunction

Function AddtoFirstImpressionFaction(actor akRef, int Rank);Remove FirstImpression? WIP / Affect favor system?
	akRef.addtofaction(slapp_FirstImpressionFaction)
	akRef.setfactionrank(slapp_FirstImpressionFaction, Rank)
	if Rank == 9
		BaboDialogueReputationBitchMod(2.0)
	endif
EndFunction

Function ManageThinkAboutPlayerFaction(actor akRef, int iindex, int Rank = 0, bool bfac = true, bool bRank = false)
int ichoice
	if iindex == 1
		ichoice = ManageFaction(akRef, slapp_ThinkNoVirginFaction, Rank, bfac, bRank)
		if ichoice == 1 && Rank > 0
			BaboDialogueReputationBitchMod(Rank * 3.0)
		elseif ichoice == 2
			BaboDialogueReputationBitchMod(-4.0)
		endif
	elseif iindex == 2
		ichoice = ManageFaction(akRef, slapp_ThinkBitchFaction, Rank, bfac, bRank)
		if ichoice == 1 && Rank > 0
			BaboDialogueReputationBitchMod(Rank * 4.0)
		elseif ichoice == 2
			BaboDialogueReputationBitchMod(-5.0)
		endif
	elseif iindex == 3
		ichoice = ManageFaction(akRef, slapp_ThinkRichFaction, Rank, bfac, bRank)
		if ichoice == 1 && Rank > 0
			BaboDialogueReputationBitchMod(Rank * -4.0)
		endif
	elseif iindex == 4
		ichoice = ManageFaction(akRef, slapp_ThinkExhibitionistFaction, Rank, bfac, bRank)
		if ichoice == 1 && Rank > 0
			BaboDialogueReputationBitchMod(Rank * 5.0)
		elseif ichoice == 2
			BaboDialogueReputationBitchMod(-6.0)
		endif
	elseif iindex == 5
		ManageFaction(akRef, slapp_ThinkPickyFaction, Rank, bfac, bRank)
	elseif iindex == 6
		ManageFaction(akRef, slapp_ThinkFemmeFataleFaction, Rank, bfac, bRank)
	elseif iindex == 7
		ManageFaction(akRef, slapp_ThinkJobFaction, Rank, bfac, bRank)
	elseif iindex == 8
		ManageFaction(akRef, slapp_ThinkPersonalityFaction, Rank, bfac, bRank)
	elseif iindex == 9
		ManageFaction(akRef, slapp_ThinkChracterFaction, Rank, bfac, bRank)
	endif
EndFunction

int Function ManageFaction(actor akRef, faction akfac, int Rank, bool bfac, bool bRank = false)
	if bfac
		if !akRef.isinfaction(akfac) || bRank
			akRef.setfactionrank(akfac, Rank)
			return 1
		endif
	else
		akRef.removefromfaction(akfac)
		return 2
	endif
return 0
EndFunction

Function AddtoDislikeFaction(actor akRef, int possibility, bool HadRape = false);Reputation
bool infaction = akRef.isinfaction(slapp_DislikeFaction)
bool inafaction = akRef.isinfaction(slapp_AquaintedFaction)
	if !infaction && !inafaction;This prevents DislikeFaction is added before AcquaintedFaction.
		return
	endif
;Int DiceRoll = Self.GetDiceRoll()
Int Rank = akRef.GetfactionRank(slapp_DislikeFaction)
Int FavorDown = -1 * possibility

	if RankDownAquaintanceFaction(akRef, FavorDown)
;		If DiceRoll <= possibility
			If infaction == false
				akRef.addtofaction(slapp_DislikeFaction)
				akRef.setfactionrank(slapp_DislikeFaction, 0);DislikeFaction
				BaboDialogueReputationMod(-1.0)
			Elseif (Rank >= 0) && (Rank < 2)
				akRef.setfactionrank(slapp_DislikeFaction, 1);HateFaction
				BaboDialogueReputationMod(-2.0)
			EndIf
			
			If (Rank < 2) && (HadRape == True)
				akRef.setfactionrank(slapp_DislikeFaction, 2);RapistFaction
			Elseif (Rank == 2) && (HadRape == True)
				akRef.setfactionrank(slapp_DislikeFaction, 3);ConstantRapistFaction
			;Elseif (Rank == 3) && (HadRape == True);WIP
				;akRef.setfactionrank(slapp_DislikeFaction, 4);SlaveMasterFaction not yet
			Endif
;		EndIf
	endif
EndFunction

Function AddtoHopeGetDressedFaction(actor akRef, int Rank);WIP
	If akRef.isinfaction(slapp_HopeGetDressedFaction) == false
		akRef.addtofaction(slapp_HopeGetDressedFaction)
	endif
	akRef.setfactionrank(slapp_HopeGetDressedFaction, Rank)
EndFunction

Function AddtoDisappointedFaction(actor akRef, int possibility, int Rank)

bool infaction = akRef.isinfaction(slapp_DisappointedFaction)
;Int DiceRoll = Self.GetDiceRoll()
Int FavorDown = -1 * possibility
Int DRank = akRef.GetfactionRank(slapp_DisappointedFaction)

;	If DiceRoll <= possibility

		If infaction == false
			akRef.addtofaction(slapp_DisappointedFaction)
		endif
		
	if Rank > 1
		akRef.setfactionrank(slapp_DisappointedFaction, Rank)
	else
		if FavorCalculation(akRef, FavorDown, true)
			akRef.setfactionrank(slapp_DisappointedFaction, DRank + 1)
		endif
	endif
EndFunction

Function AddtoProstitutionFaction(actor akRef);Reputation Bitch
bool infaction = akRef.isinfaction(slapp_ProstitutionFaction)
	If infaction == false
		akRef.addtofaction(slapp_ProstitutionFaction)
	else
		akRef.SetfactionRank(slapp_ProstitutionFaction, akRef.Getfactionrank(slapp_ProstitutionFaction) + 1)
	EndIf
	BaboDialogueReputationbitchMod(1.0)
EndFunction

Function AddtoAquaintanceFactionSimple(actor akRef, int possibility);Reputation
bool infaction = akRef.isinfaction(slapp_AquaintedFaction)
Int DiceRoll = Self.GetDiceRoll()
	If DiceRoll <= possibility
		If infaction == false
			akRef.addtofaction(slapp_AquaintedFaction)
			akRef.setfactionrank(slapp_AquaintedFaction, 0);Aquaintance
			BaboDialogueReputationMod(1.0)
		EndIf
	EndIf
EndFunction

Bool Function RankDownAquaintanceFaction(actor akRef, int iFavor = -10)
Int Rank = akRef.GetfactionRank(slapp_AquaintedFaction)
Bool RankDown = false

	if FavorCalculation(akRef, iFavor, true)
		if Rank == 0
			RankDown = true
		elseif Rank == 1
			Rank = 0
			RankDown = true
		elseif Rank == 2
			Rank = 1
			RankDown = true
		elseif Rank == 3
			RankDown = true
		elseif Rank == 4
			Rank = 3
			RankDown = true
		elseif Rank == 5
			Rank = 4
			RankDown = true
		endif
	endif
	
akRef.setfactionrank(slapp_AquaintedFaction, Rank)
Return RankDown

EndFunction

Function AddtoAquaintanceFaction(actor akRef, int possibility, bool HadSex = false);Reputation

bool infaction = akRef.isinfaction(slapp_AquaintedFaction)
Int DiceRoll = Self.GetDiceRoll()
Int Rank = akRef.GetfactionRank(slapp_AquaintedFaction)
int Divisioni = (possibility * 0.1) as int
Int Randomi = Utility.randomint((-1 * Divisioni), Divisioni)
possibility += Randomi
	if infaction == false
		akRef.addtofaction(slapp_AquaintedFaction)
		akRef.setfactionrank(slapp_AquaintedFaction, 0);Aquaintance
		if HadSex
			ManageFaction(akRef, slapp_ThinkNoVirginFaction, 0, true, true)
			ManageFaction(akRef, slapp_ThinkBitchFaction, 1, true, true)
			AddtoFirstImpressionFaction(akRef, Utility.randomint(8,9))
		else
			BaboDialogueReputationMod(1.0)
		endif
	elseIf DiceRoll <= 50 && Rank < 5
		if (Rank == 0)
			akRef.setfactionrank(slapp_AquaintedFaction, 1);AleFriend
			BaboDialogueReputationMod(1.0)
		Elseif (Rank <= 2)
			If FavorCalculation(akRef, possibility, true)
				akRef.setfactionrank(slapp_AquaintedFaction, Rank + 1);Affectionate and FallinLove
				BaboDialogueReputationMod(2.0)
			endif
		EndIf
		If (HadSex == True)
			FavorCalculation(akRef, possibility, false)
			If (Rank < 3)
				if FavorCalculation(akRef, 10, false)
					akRef.setfactionrank(slapp_AquaintedFaction, Rank + 1);Affectionate
				endif
			Elseif (Rank == 3)
				if FavorCalculation(akRef, 10, false)
					akRef.setfactionrank(slapp_AquaintedFaction, 4);SexPartner
				endif
			Elseif (Rank == 4)
				if FavorCalculation(akRef, possibility + (Divisioni * 2), true);Sex Favor
					akRef.setfactionrank(slapp_AquaintedFaction, 5);Lover
					BaboDialogueReputationMod(5.0)
				endif
			Endif
		else
			if (Rank == 2)
				FavorCalculation(akRef, possibility - Divisioni, false)
			elseif (Rank == 3)
				FavorCalculation(akRef, possibility + Divisioni, false)
			Elseif (Rank == 4)
				if FavorCalculation(akRef, 10, true);Normal Favor
					akRef.setfactionrank(slapp_AquaintedFaction, 5);Lover
				endif
			Endif
		endif
	elseif Rank == 5;Stack Affection
		If (HadSex == True)
			If FavorCalculation(akRef, possibility, true)
				akRef.setfactionrank(slapp_AquaintedFaction, 6)
			endif
		else
			If FavorCalculation(akRef, possibility - Divisioni, true)
				akRef.setfactionrank(slapp_AquaintedFaction, 6)
			endif
		endif
	elseif Rank == 6
		If (HadSex == True)
			FavorCalculation(akRef, possibility, false)
		else
			FavorCalculation(akRef, possibility - Divisioni, false)
		endif
	EndIf
EndFunction

Bool Function FavorCalculation(actor akRef, int iFavor = 10, bool RankChange = false)
bool infaction = akRef.isinfaction(slapp_FavorMeasureFaction)
If infaction == false
	akRef.addtofaction(slapp_FavorMeasureFaction)
endif

Int FavorRank = akRef.GetfactionRank(slapp_FavorMeasureFaction)
FavorRank += iFavor


if FavorRank >= 100
	if RankChange
		akRef.SetfactionRank(slapp_FavorMeasureFaction, 0)
		Return true
	else
		akRef.SetfactionRank(slapp_FavorMeasureFaction, 100)
		Return false
	endif
elseif FavorRank <= 0
	if RankChange
		akRef.SetfactionRank(slapp_FavorMeasureFaction, 100)
		Return true
	else
		akRef.SetfactionRank(slapp_FavorMeasureFaction, 0)
		Return false
	endif
else
	akRef.SetfactionRank(slapp_FavorMeasureFaction, FavorRank)
	Return false
endif

EndFunction

Function AddtoAquaintanceLover();WIP

EndFunction

Function AddtoFoodPreferencefaction(actor akRef, int iRank = 0)
	akRef.setfactionrank(slapp_ThinkFoodPreferenceFaction, iRank)
EndFunction

Function RemoveFoodPreferencefaction(actor akRef)
	akRef.removefromfaction(slapp_ThinkFoodPreferenceFaction)
EndFunction

Function AddtoStripShowFaction(actor akRef, int Rankint, bool Uprank = false)
bool infaction = akRef.isinfaction(slapp_HaveSeenNakedBody)
Int Rank = akRef.GetfactionRank(slapp_HaveSeenNakedBody)
	If infaction == false
		akRef.addtofaction(slapp_HaveSeenNakedBody)
		akRef.setfactionrank(slapp_HaveSeenNakedBody, 0)
	else
		if Uprank
			akRef.setfactionrank(slapp_HaveSeenNakedBody, Rank + 1)
		endif
		
		if Rankint
			akRef.setfactionrank(slapp_HaveSeenNakedBody, Rankint)
		endif
	endif
EndFunction

Function RankUpTraitFetish(actor akRef, int possibility = 0, int RankLimit);WIP
possibility += slappUtil.AppearanceCalc()
Int DiceRoll = Self.GetDiceRoll()
Int Rank = akRef.GetfactionRank(slapp_TraitFetishfaction)
	if Rank >= RankLimit
		return
	endif
	if DiceRoll <= possibility
		akRef.SetfactionRank(slapp_TraitFetishfaction, Rank + 1)
	endif

EndFunction

Function AddtoNoApproachFaction(actor akactor, int iRank = 0)
	akactor.SetfactionRank(slapp_NoMoreApproach, iRank)
EndFunction

Function AddtoHaveSeenArmorFaction(actor akRef, int Rankint)
	if Rankint < 6
		akRef.Removefromfaction(slapp_HaveSeenNudeBodyRecently)
	endif
	akRef.setfactionrank(slapp_HaveSeenBody, Rankint)
EndFunction

Function AddtoHaveSeenRecentArmorFaction(actor akRef, int Rankint)
	akRef.setfactionrank(slapp_HaveSeenBodyRecently, Rankint)
EndFunction

Faction Property slapp_HaveSeenBodyRecently Auto

Function AddtoHaveSeenNudeFaction(actor akRef, int Rankint, bool Uprank = false)
bool infaction = akRef.isinfaction(slapp_HaveSeenNudeBody)
Int Rank = akRef.GetfactionRank(slapp_HaveSeenNudeBody)
	akRef.addtofaction(slapp_HaveSeenNudeBodyRecently)
	If infaction == false
		akRef.addtofaction(slapp_HaveSeenNudeBody)
		akRef.setfactionrank(slapp_HaveSeenNudeBody, 0)
	else
		if Uprank
			akRef.setfactionrank(slapp_HaveSeenNudeBody, Rank + 1)
		endif
		
		if Rankint
			akRef.setfactionrank(slapp_HaveSeenNudeBody, Rankint)
		endif
	endif
EndFunction

Function CountSexTime(actor akRef)
bool infaction = akRef.isinfaction(slapp_HadSexCountFaction)
	If infaction == false
		akRef.addtofaction(slapp_HadSexCountFaction)
		akRef.setfactionrank(slapp_HadSexCountFaction, 1)
	else
		akRef.setfactionrank(slapp_HadSexCountFaction, akRef.getfactionrank(slapp_HadSexCountFaction) + 1)
	endif
EndFunction

Function CountSexVaginalTime(actor akRef)
bool infaction = akRef.isinfaction(slapp_HadSexVaginalCountFaction)
	If infaction == false
		akRef.addtofaction(slapp_HadSexVaginalCountFaction)
		akRef.setfactionrank(slapp_HadSexVaginalCountFaction, 1)
	else
		akRef.setfactionrank(slapp_HadSexVaginalCountFaction, akRef.getfactionrank(slapp_HadSexVaginalCountFaction) + 1)
	endif
EndFunction

Function CountSexOralTime(actor akRef)
bool infaction = akRef.isinfaction(slapp_HadSexOralCountFaction)
	If infaction == false
		akRef.addtofaction(slapp_HadSexOralCountFaction)
		akRef.setfactionrank(slapp_HadSexOralCountFaction, 1)
	else
		akRef.setfactionrank(slapp_HadSexOralCountFaction, akRef.getfactionrank(slapp_HadSexOralCountFaction) + 1)
	endif
EndFunction

Function CountSexAnalTime(actor akRef)
bool infaction = akRef.isinfaction(slapp_HadSexAnalCountFaction)
	If infaction == false
		akRef.addtofaction(slapp_HadSexAnalCountFaction)
		akRef.setfactionrank(slapp_HadSexAnalCountFaction, 1)
	else
		akRef.setfactionrank(slapp_HadSexAnalCountFaction, akRef.getfactionrank(slapp_HadSexAnalCountFaction) + 1)
	endif
EndFunction

Function CountRapeTime(actor akRef)
bool infaction = akRef.isinfaction(slapp_RapeCountFaction)
	If infaction == false
		akRef.addtofaction(slapp_RapeCountFaction)
		akRef.setfactionrank(slapp_RapeCountFaction, 1)
	else
		akRef.setfactionrank(slapp_RapeCountFaction, akRef.getfactionrank(slapp_RapeCountFaction) + 1)
	endif
EndFunction

Function ResetRapeCount(actor akRef)
	akRef.setfactionrank(slapp_RapeCountFaction, 0)
EndFunction

Function CountConfessRejectTime(actor akRef, int count = 1)
bool infaction = akRef.isinfaction(slapp_ConfessRejectCountFaction)
	If infaction == false
		akRef.addtofaction(slapp_ConfessRejectCountFaction)
		akRef.setfactionrank(slapp_ConfessRejectCountFaction, 1)
	else
		int factionrank = akRef.getfactionrank(slapp_ConfessRejectCountFaction)
		akRef.setfactionrank(slapp_ConfessRejectCountFaction, factionrank + count)
	endif
EndFunction

Function AddtoLoverFaction(actor akRef, int irank)
	akRef.setfactionrank(slapp_LoveConfessionFaction, irank)
EndFunction

Function CountIntroductionRejectTime(actor akRef, int count = 1)
bool infaction = akRef.isinfaction(slapp_IntroductionRejectCountFaction)
	If infaction == false
		akRef.addtofaction(slapp_IntroductionRejectCountFaction)
		akRef.setfactionrank(slapp_IntroductionRejectCountFaction, 1)
	else
		int factionrank = akRef.getfactionrank(slapp_IntroductionRejectCountFaction)
		akRef.setfactionrank(slapp_IntroductionRejectCountFaction, factionrank + count)
	endif
EndFunction

Function CountConversationRejectTime(actor akRef, int count = 1)
bool infaction = akRef.isinfaction(slapp_ConversationRejectCountFaction)
	If infaction == false
		akRef.addtofaction(slapp_ConversationRejectCountFaction)
		akRef.setfactionrank(slapp_ConversationRejectCountFaction, 1)
	else
		int factionrank = akRef.getfactionrank(slapp_ConversationRejectCountFaction)
		if count > 0 && factionrank >= 15
			return
		elseif count < 0 && factionrank <= -15
			return
		else
			akRef.setfactionrank(slapp_ConversationRejectCountFaction, factionrank + count)
		endif
	endif
EndFunction

Function CountSexRejectTime(actor akRef, bool bProstitution = false, int count = 1)
bool infaction
	if bProstitution
		infaction = akRef.isinfaction(slapp_ProstitutionRejectCountFaction)
		If infaction == false
			akRef.addtofaction(slapp_ProstitutionRejectCountFaction)
			akRef.setfactionrank(slapp_ProstitutionRejectCountFaction, 1)
		else
			int factionrank = akRef.getfactionrank(slapp_ProstitutionRejectCountFaction)
			if count > 0
				akRef.setfactionrank(slapp_ProstitutionRejectCountFaction, factionrank + count)
			else
				if factionrank > -1
					akRef.setfactionrank(slapp_ProstitutionRejectCountFaction, factionrank + count)
				endif
			endif
		endif
	else
		infaction = akRef.isinfaction(slapp_SexRejectCountFaction)
		If infaction == false
			akRef.addtofaction(slapp_SexRejectCountFaction)
			akRef.setfactionrank(slapp_SexRejectCountFaction, 1)
		else
			int factionrank = akRef.getfactionrank(slapp_SexRejectCountFaction)
			if count > 0
				akRef.setfactionrank(slapp_SexRejectCountFaction, factionrank + count)
			else
				if factionrank > -1
					akRef.setfactionrank(slapp_SexRejectCountFaction, factionrank + count)
				endif
			endif
		endif
	endif
EndFunction

Function ResetSexRejectCount(actor akRef)
	akRef.removefromfaction(slapp_SexRejectCountFaction)
EndFunction

Function AddtoKissFaction(actor akRef, int rank)
bool infaction = akRef.isinfaction(slapp_KissFaction)
	If infaction == false
		akRef.addtofaction(slapp_KissFaction)
	endif
EndFunction

Function AddtoRapeFailFaction(actor akRef, int possibility, bool Uprank = false)

bool infaction = akRef.isinfaction(slapp_RapeFailFaction)
Int DiceRoll = Self.GetDiceRoll()
Int Rank = akRef.GetfactionRank(slapp_RapeFailFaction)

	If DiceRoll <= possibility
		If infaction == false
			akRef.addtofaction(slapp_RapeFailFaction)
			akRef.setfactionrank(slapp_RapeFailFaction, 1);RapeFail Once
		else
			akRef.setfactionrank(slapp_RapeFailFaction, Rank + 1);AleFriend
		EndIf
		
	Else
	EndIf
EndFunction

Function GiftFaction(actor akRef, int possibility)
Int Rank = akRef.GetfactionRank(slapp_GiftGiverFaction)
int Divisioni = (possibility * 0.1) as int
Int Randomi = Utility.randomint((-1 * Divisioni), Divisioni)
possibility += Randomi

	if (Rank == 0)
		akRef.setfactionrank(slapp_GiftGiverFaction, 1)
		FavorCalculation(akRef, possibility + Divisioni, false)
	Elseif (Rank >= 1)
		akRef.setfactionrank(slapp_GiftGiverFaction, (Rank + 1))
		FavorCalculation(akRef, possibility, false)
	EndIf
EndFunction

Bool Function DrinkEvent(Actor Woman, Actor akref, Bool Rape, int possibility)

int Divisioni = (possibility * 0.1) as int
Int Randomi = Utility.randomint((-1 * Divisioni), Divisioni)
possibility += Randomi

if SLApproachMain.enableConsumeAlcholFlag
	Woman.equipitem(ale)
endif

	if Rape
		Woman.playidle(BaboDrinkBlackOut)
		FavorCalculation(akRef, (possibility * -1), false)
		Return True
	else
		Woman.Playidle(BaboDrinkNormal)
		FavorCalculation(akRef, possibility + (Divisioni * 5), false)
		Return False
	endif
EndFunction

Event OnInit() ; RegisteringModEvent
	RegisterExternalModEvent()
EndEvent

Bool Function KnockKnock()
Return False
EndFunction

Bool Function iGetFormIndex()
Return False
EndFunction

Function ChangeStateStage(int StateStage)
if StateStage == 1
	gotostate("SearchingPlace")
else
	gotostate("")
endif
EndFunction

State SearchingPlace

Function endApproachDetachCell()
	return
EndFunction

EndState


;-----------------External ModEvent---------------------

;####################################################
;################### SLHH MOD #######################
;####################################################

Faction Property slapp_StealArmorFaction Auto
String Property slapRemoveArmorFormList = "slap.removearmor" autoreadonly hidden

Event SLHHEnd_Stealarmor(actor akactor)
	form[] wornForms = StorageUtil.FormListToArray(PlayerRef, "slhh.removearmor")
	int i = wornForms.length
	int iFormId = akactor.GetFormID()
	if i > 0
		AddtoStealArmorFaction(akactor, i)
		;akactor.addtofaction(slapp_StealArmorFaction)
	endif
	While i > 0 
		i -= 1
		PlayerRef.RemoveItem(wornForms[i], 1, false, akactor)
		StorageUtil.FormListAdd(akactor, slapRemoveArmorFormList + iFormId, wornForms[i])
	EndWhile
	SLApproachStealAura.cast(PlayerRef, akactor)
EndEvent

Function UpdateStealArmor(actor akactor)
	;int iFormId = akactor.GetFormID()
	;form[] wornForms = StorageUtil.FormListToArray(PlayerRef, slapRemoveArmorFormList + iFormId)
	int i = (StorageUtil.FormListToArray(PlayerRef, slapRemoveArmorFormList + akactor.GetFormID())).length
	;int i = wornForms.length
	if i > 0
		AddtoStealArmorFaction(akactor, i)
		;akactor.addtofaction(slapp_StealArmorFaction)
	endif
EndFunction

Function AddtoStealArmorFaction(actor akactor, int icount = 1)
	if akactor.isinfaction(slapp_StealArmorFaction) == false
		akactor.addtofaction(slapp_StealArmorFaction)
	endif
	akactor.setfactionrank(slapp_StealArmorFaction, icount)
	;Rank 0 means nothing
EndFunction

Function ReturnStolenGoods(actor akactor)
	form[] wornForms = StorageUtil.FormListToArray(akactor, slapRemoveArmorFormList)
	int i = wornForms.length
	int iFormId = akactor.GetFormID()
	While i > 0 
		i -= 1
		akactor.RemoveItem(wornForms[i], 1, false, PlayerRef)
	EndWhile
	StorageUtil.FormListClear(akactor, slapRemoveArmorFormList + iFormId)
	akactor.removefromfaction(slapp_StealArmorFaction)
EndFunction

Function ClearStolenGoods(actor akactor)
	int iFormId = akactor.GetFormID()
	StorageUtil.FormListClear(akactor, slapRemoveArmorFormList + iFormId)
	akactor.removefromfaction(slapp_StealArmorFaction)
EndFunction

Function SLHHActivate(Actor pTarget, Actor pTargetFriend = None, int Sex = 0); Basically you don't need pTargetFriend. pTarget will become a criminal, who will try to rape you.
	Keyword SLHHScriptEventKeyword = Game.GetFormFromFile(0x0000C510, "SexLabHorribleHarassment.esp") as Keyword
    SLHHScriptEventKeyword.SendStoryEvent(None, pTarget, pTargetFriend, Sex, 0)
endFunction

Function SLHHChokeActivate(Actor pTarget, Actor pTargetFriend = None, int Sex)
    Keyword SLHHScriptEventBCKeyword = Game.GetFormFromFile(0x0233C6, "SexLabHorribleHarassment.esp") as Keyword
	SLHHScriptEventBCKeyword.SendStoryEvent(None, pTarget, pTargetFriend, Sex, 0)
endFunction 

Function SLHHDrinkActivate(Actor pTarget, Actor pTargetFriend = None, int Sex);When escape fail -> 0 = Sex 1 = NoSex, only knockout animation
    Keyword SLHHScriptEventDrinkKeyword = Game.GetFormFromFile(0x02495B, "SexLabHorribleHarassment.esp") as Keyword
	SLHHScriptEventDrinkKeyword.SendStoryEvent(None, pTarget, pTargetFriend, Sex, 0)
endFunction 

Function SLHHSendOnEndEvent(String akstring)
	int handle = ModEvent.Create("SLHH_AddOnEndEvent")
	if handle
		ModEvent.PushString(handle, "akstring")
		ModEvent.Send(handle)
	endif
EndFunction

;####################################################
;################# BABODIALOGUE #####################
;####################################################


;Faction Function BDBaboAggressiveBoyFriend()
;	Faction BaboAggressiveBoyFriend = Game.GetFormFromFile(0x00BA9DDA, "BabointeractiveDia.esp") as Faction
;Return BaboAggressiveBoyFriend
;EndFunction


;Faction Function BDBaboViceGuardCaptainFaction()
;	Faction BaboViceGuardCaptainFaction = Game.GetFormFromFile(0x00B71E3E, "BabointeractiveDia.esp") as Faction
;Return BaboViceGuardCaptainFaction
;EndFunction


Function BaboAggressiveBoyFriendStack(Actor pTarget)
If !(pTarget.isinfaction(slapp_AggressiveBFFaction))
	pTarget.addtofaction(slapp_AggressiveBFFaction)
Endif
EndFunction

Function BaboDialogueTrigger(Actor Rapist, Bool Worse = false, int Possibility)
int Randomi = Utility.randomint(1,100)
	If Worse
		if Possibility >= Randomi
			BaboDialogueEventRegister(Rapist, True); SLHHConsequneceWorse, Rape
		endif
	Else
		if Possibility >= Randomi
			BaboDialogueEventRegister(Rapist, False); SLHHConsequneceBad, No Rape
		endif
	EndIf
EndFunction

Function BaboDialogueSLAPPTrigger(Actor Rapist, Bool Worse = false, int Possibility)
int Randomi = Utility.randomint(1,100)
	If Worse
		if Possibility >= Randomi
			BaboDialogueSLAPPEventRegister(Rapist, True)
		endif
	Else
		if Possibility >= Randomi
			BaboDialogueSLAPPEventRegister(Rapist, False)
		endif
	EndIf
EndFunction

Function BaboDialogueEventRegister(Actor Rapist, Bool Worse)
	int handle = ModEvent.Create("BaboDialogue_ConsequenceEvent")
	if (handle)
		ModEvent.Pushform(handle, Rapist)
		ModEvent.PushBool(handle, Worse)
		ModEvent.PushString(handle, "SLAPP activated BaboDialogueConsequence")
		ModEvent.Send(handle)
	endIf
EndFunction

Function BaboDialogueSLAPPEventRegister(Actor Rapist, Bool Worse)
	int handle = ModEvent.Create("BaboDialogue_SLAPPConsequenceEvent")
	if (handle)
		ModEvent.Pushform(handle, Rapist)
		ModEvent.PushBool(handle, Worse)
		ModEvent.PushString(handle, "SLAPP activated SLAPPConsequenceEvent")
		ModEvent.Send(handle)
	endIf
EndFunction


Function RegisterAnimationEvent()
	;RegisterForAnimationEvent(PlayerRef, "BaboSpankingF")
	;RegisterForModEvent("SLAPP_SpankingEvent", "SLAPPSpankingEvent")
EndFunction

Function RegisterExternalModEvent()
	RegisterForModEvent("SLAPP_ConsequenceEvent", "SLAPPConsequenceEvent")
	RegisterForModEvent("SLAPP_ConsequenceChokeEvent", "SLAPPConsequenceChokeEvent")
	RegisterForModEvent("SLAPP_ConsequenceChokeNREvent", "SLAPPConsequenceChokeNREvent")
	RegisterForModEvent("SLAPP_AcquaintanceEvent", "SLAPPAcquaintanceEvent")
	RegisterForModEvent("SLAPP_HateEvent", "SLAPPHateEvent")
	RegisterForModEvent("HookAnimationStart", "SLAPPSexlabStart")
	RegisterForModEvent("HookAnimationEnd", "SLAPPSexlabEnd")
	RegisterForModEvent("dhlp-Suspend", "OnSuspend")	;lg added
	RegisterForModEvent("dhlp-Resume", "OnResume")
	RegisterForModEvent("ON_SLHHEnd_Stealarmor", "SLHHEnd_Stealarmor")
	(SLApproach_ExternalMods as SLApproachExternalScript).RegisterSLAPPEvent()
	RegisterAnimationEvent()
EndFunction

event SLAPPSexlabStart(int tid, bool HasPlayer)
	Actor[] actors = sexlab.HookActors(tid)
	sslBaseAnimation anim = sexlab.HookAnimation(tid)

	if HasPlayer
		int i = actors.length
		while i > 1
			i -= 1
			CountSexTime(actors[i])
		endwhile
	endif
endevent

event SLAPPSexlabEnd(int tid, bool HasPlayer)
	Actor[] actors = sexlab.HookActors(tid)
	sslBaseAnimation anim = sexlab.HookAnimation(tid)

	if HasPlayer
		int al = actors.length
		int i = al
		If anim.hasTag("Vaginal")
			while i > 1
				i -= 1
				CountSexVaginalTime(actors[i])
			endwhile
			
			i = al
		endif
				
		If anim.hasTag("Anal")
			while i > 1
				i -= 1
				CountSexAnalTime(actors[i])
			endwhile
			
			i = al
		endif

		If anim.hasTag("Oral")
			while i > 1
				i -= 1
				CountSexOralTime(actors[i])
			endwhile
		endif

	endif
endevent

Event OnSuspend(string eventName, string strArg, float numArg, Form sender)
	dhlpSuspendStatus = true
EndEvent
Event OnResume(string eventName, string strArg, float numArg, Form sender)
	dhlpSuspendStatus = false
EndEvent

Event SLAPPHateEvent(form akSpeakerform, Bool HadSex = false, string results)
Actor akspeaker = akspeakerform as actor
int Chance = SLApproachMain.SLADislikeChance + 20
	AddtoDislikeFaction(akSpeaker, Chance, Hadsex)
	sexRelationshipDown(akSpeaker, PlayerRef, SLApproachMain.SLARelationshipChance)
EndEvent

Event SLAPPAcquaintanceEvent(Form akSpeakerform, Bool HadSex = false, string results)
Actor akspeaker = akspeakerform as actor
Int AcquaintanceChance = SLApproachMain.SLAAquaintanceChance + 20
Int RelationshipChance = SLApproachMain.SLARelationshipChance + 20
	AddtoAquaintanceFaction(akSpeaker, AcquaintanceChance, Hadsex)
	SexRelationshipUp(akSpeaker, PlayerRef, RelationshipChance)
EndEvent

Event SLAPPConsequenceEvent(Form akRef, Bool Worse, string results)
if SLApproachMain.debugLogFlag
	Debug.notification(results)
endif
	SLAppPCSex.ExternalTrigger(akRef, Worse, 1)
EndEvent

Event SLAPPConsequenceChokeEvent(Form akRef, Bool Worse, string results)
if SLApproachMain.debugLogFlag
	Debug.notification(results)
endif
	SLAppPCSex.ExternalTrigger(akRef, Worse, 2)
EndEvent

Event SLAPPConsequenceChokeNREvent(Form akRef, Bool Worse, string results)
if SLApproachMain.debugLogFlag
	Debug.notification(results)
endif
	SLAppPCSex.ExternalTrigger(akRef, Worse, 3)
EndEvent


Function BaboDialogueReputationMod(float fstat, float ffavor = 0.0)
;GlobalVariable BaboReputation
	int handle = ModEvent.Create("BaboDia_OnRStatChangeEvent")
	if (handle)
		ModEvent.Pushfloat(handle, fstat)
		ModEvent.Pushfloat(handle, ffavor)
		ModEvent.Send(handle)
	endIf
;if SLA_BaboDialogue.getvalue() == 1
;	BaboReputation = Game.GetFormFromFile(0x00772769, "BaboInteractiveDia.esp") as GlobalVariable
;	float BR = BaboReputation.getvalue()
;	BaboReputation.setvalue(BR + iMod)
;	SLA_BaboReputation.setvalue(BR + iMod)
;endif	
EndFunction

Function BaboDialogueReputationBitchMod(float fstat)

	int handle = ModEvent.Create("BaboDia_OnRBStatChangeEvent")
	if (handle)
		ModEvent.Pushfloat(handle, fstat)
		ModEvent.Send(handle)
	endIf

;GlobalVariable BaboReputationBitch
;if SLA_BaboDialogue.getvalue() == 1
;	BaboReputationBitch = Game.GetFormFromFile(0x003CD6F1, "BaboInteractiveDia.esp") as GlobalVariable
;	float BR = BaboReputationBitch.getvalue()
;	BaboReputationBitch.setvalue(BR + iMod)
;	SLA_BaboReputationBitch.setvalue(BR + iMod)
;endif	
EndFunction

Function BaboDialogueMercenaryCall(actor MercenaryRef); Instead call the function from SLAPP, BaboDialogue will handle a mercenary.
	int handle = ModEvent.Create("Babo_SLAPPMercenaryEvent")
	form MercenaryRefFrom = MercenaryRef as form
	if (handle)
		ModEvent.PushForm(handle, MercenaryRef)
		ModEvent.Send(handle)
	endIf
EndFunction

Function TakeArmor(Actor Victim, Actor Pervert, Keyword ArmorKeyword)
	Armor ThisArmor = FindArmor(Victim, True, ArmorKeyword)
	;BaboPropertyRegister()
	Victim.removeitem(ThisArmor, 1, SLApproachMain.BaboChestWhiterunRef)
EndFunction

Armor Function FindArmor(Actor target, Bool Keywordswitch = False, Keyword TargetArmor)
	int slotsChecked
	slotsChecked += 0x00100000
	slotsChecked += 0x00200000 ;ignore reserved slots
	slotsChecked += 0x80000000

	int thisSlot = 0x01
	while (thisSlot < 0x80000000)
		if (Math.LogicalAnd(slotsChecked, thisSlot) != thisSlot)
			Armor thisArmor = target.GetWornForm(thisSlot) as Armor
			if (thisArmor && thisArmor.HasKeyword(TargetArmor))
				return thisarmor
			Else
				slotsChecked += thisSlot
			EndIf
		endif
		thisSlot *= 2 ;double the number to move on to the next slot
	endWhile
EndFunction

;Function BaboPropertyRegister()
;	BaboChestWhiterunRef = Game.GetFormFromFile(0x00e46567, "BabointeractiveDia.esp") as objectreference
;Endfunction

;======================================
;===============Expression================
;======================================
Function Backtoinitial(Actor act)
	MfgConsole.ResetOverrides(act)
	;act.ClearExpressionOverride()
EndFunction

Function RandomAheMenu(Actor act)
	int Random = Utility.Randomint(1, 6)
	AheMenu(act, random)
EndFunction

Function RandomPainMenu(Actor act)
	int Random = Utility.Randomint(1, 8)
	PainMenu(act, random)
EndFunction

Function GagPhoneme(Actor akactor, int index)
	if index > 0
		MfgConsoleFunc.SetPhoneme(akActor, 1, 100)
		MfgConsoleFunc.SetPhoneme(akActor, 11, 70)
	else
		MfgConsoleFunc.ResetPhonemeModifier(akActor)
	endif
EndFunction

Function PainMenu(Actor act, Int index)
	if index == 1
		act.SetExpressionOverride(3, 50)
		mfgconsolefunc.SetModifier(act, 2, 10)
		mfgconsolefunc.SetModifier(act, 3, 10)
		mfgconsolefunc.SetModifier(act, 6, 50)
		mfgconsolefunc.SetModifier(act, 7, 50)
		mfgconsolefunc.SetModifier(act, 11, 30)
		mfgconsolefunc.SetModifier(act, 12, 30)
		mfgconsolefunc.SetModifier(act, 13, 30)
		mfgconsolefunc.SetPhoneme(act, 0, 20)
	elseIf index == 2
		act.SetExpressionOverride(8, 50)
		mfgconsolefunc.SetModifier(act, 0, 100)
		mfgconsolefunc.SetModifier(act, 1, 100)
		mfgconsolefunc.SetModifier(act, 2, 100)
		mfgconsolefunc.SetModifier(act, 3, 100)
		mfgconsolefunc.SetModifier(act, 4, 100)
		mfgconsolefunc.SetModifier(act, 5, 100)
		mfgconsolefunc.SetPhoneme(act, 2, 100)
		mfgconsolefunc.SetPhoneme(act, 5, 100)
		mfgconsolefunc.SetPhoneme(act, 11, 40)
	elseIf index == 3
		act.SetExpressionOverride(9, 50)
		mfgconsolefunc.SetModifier(act, 2, 100)
		mfgconsolefunc.SetModifier(act, 3, 100)
		mfgconsolefunc.SetModifier(act, 4, 100)
		mfgconsolefunc.SetModifier(act, 5, 100)
		mfgconsolefunc.SetModifier(act, 11, 90)
		mfgconsolefunc.SetPhoneme(act, 0, 100)
		mfgconsolefunc.SetPhoneme(act, 2, 100)
		mfgconsolefunc.SetPhoneme(act, 11, 40)
	elseIf index == 4
		act.SetExpressionOverride(8, 50)
		mfgconsolefunc.SetModifier(act, 0, 100)
		mfgconsolefunc.SetModifier(act, 1, 100)
		mfgconsolefunc.SetModifier(act, 2, 100)
		mfgconsolefunc.SetModifier(act, 3, 100)
		mfgconsolefunc.SetModifier(act, 4, 100)
		mfgconsolefunc.SetModifier(act, 5, 100)
		mfgconsolefunc.SetPhoneme(act, 2, 100)
		mfgconsolefunc.SetPhoneme(act, 5, 40)
	elseIf index == 5
		act.SetExpressionOverride(9, 50)
		mfgconsolefunc.SetModifier(act, 2, 100)
		mfgconsolefunc.SetModifier(act, 3, 100)
		mfgconsolefunc.SetModifier(act, 4, 100)
		mfgconsolefunc.SetModifier(act, 5, 100)
		mfgconsolefunc.SetModifier(act, 11, 90)
		mfgconsolefunc.SetPhoneme(act, 0, 30)
		mfgconsolefunc.SetPhoneme(act, 2, 30)
	elseIf index == 6
		act.SetExpressionOverride(3, 50)
		mfgconsolefunc.SetModifier(act, 11, 50)
		mfgconsolefunc.SetModifier(act, 13, 14)
		mfgconsolefunc.SetPhoneme(act, 2, 50)
		mfgconsolefunc.SetPhoneme(act, 13, 20)
		mfgconsolefunc.SetPhoneme(act, 15, 40)
	elseIf index == 7
		act.SetExpressionOverride(1, 50)
		mfgconsolefunc.SetModifier(act, 0, 30)
		mfgconsolefunc.SetModifier(act, 1, 20)
		mfgconsolefunc.SetModifier(act, 12, 90)
		mfgconsolefunc.SetModifier(act, 13, 90)
		mfgconsolefunc.SetPhoneme(act, 2, 100)
		mfgconsolefunc.SetPhoneme(act, 5, 80)
	elseIf index == 8
		act.SetExpressionOverride(3, 50)
		mfgconsolefunc.SetModifier(act, 0, 30)
		mfgconsolefunc.SetModifier(act, 1, 30)
		mfgconsolefunc.SetModifier(act, 4, 80)
		mfgconsolefunc.SetModifier(act, 5, 80)
		mfgconsolefunc.SetPhoneme(act, 2, 100)
		mfgconsolefunc.SetPhoneme(act, 4, 50)
		mfgconsolefunc.SetPhoneme(act, 5, 100)
	elseIf index == 9;Faint
		act.SetExpressionOverride(3, 50)
		mfgconsolefunc.SetModifier(act, 0, 80)
		mfgconsolefunc.SetModifier(act, 1, 80)
		mfgconsolefunc.SetPhoneme(act, 1, 30)
	endIf
endFunction

Function AheMenu(Actor act, Int index)
	if index == 1
		act.SetExpressionOverride(4, 50)
		mfgconsolefunc.SetModifier(act, 0, 30)
		mfgconsolefunc.SetModifier(act, 1, 30)
		mfgconsolefunc.SetModifier(act, 4, 30)
		mfgconsolefunc.SetModifier(act, 5, 30)
		mfgconsolefunc.SetModifier(act, 6, 10)
		mfgconsolefunc.SetModifier(act, 7, 10)
		mfgconsolefunc.SetModifier(act, 11, 80)
		mfgconsolefunc.SetModifier(act, 12, 70)
		mfgconsolefunc.SetModifier(act, 13, 80)
		mfgconsolefunc.SetPhoneme(act, 3, 50)
		mfgconsolefunc.SetPhoneme(act, 11, 50)
		mfgconsolefunc.SetPhoneme(act, 15, 50)
	elseIf index == 2
		act.SetExpressionOverride(4, 50)
		mfgconsolefunc.SetModifier(act, 0, 50)
		mfgconsolefunc.SetModifier(act, 1, 30)
		mfgconsolefunc.SetModifier(act, 2, 100)
		mfgconsolefunc.SetModifier(act, 4, 30)
		mfgconsolefunc.SetModifier(act, 5, 30)
		mfgconsolefunc.SetModifier(act, 7, 10)
		mfgconsolefunc.SetModifier(act, 11, 90)
		mfgconsolefunc.SetModifier(act, 12, 30)
		mfgconsolefunc.SetPhoneme(act, 3, 50)
		mfgconsolefunc.SetPhoneme(act, 8, 50)
		mfgconsolefunc.SetPhoneme(act, 14, 50)
	elseIf index == 3
		act.SetExpressionOverride(2, 60)
		mfgconsolefunc.SetPhoneme(act, 0, 43)
		mfgconsolefunc.SetPhoneme(act, 4, 7)
		mfgconsolefunc.SetPhoneme(act, 14, 90)
		mfgconsolefunc.SetModifier(act, 11, 180)
		mfgconsolefunc.SetModifier(act, 9, 43)
	elseIf index == 4
		act.SetExpressionOverride(2, 60)
		mfgconsolefunc.SetPhoneme(act, 0, 20)
		mfgconsolefunc.SetPhoneme(act, 1, 100)
		mfgconsolefunc.SetPhoneme(act, 14, 3)
		mfgconsolefunc.SetModifier(act, 7, 77)
		mfgconsolefunc.SetModifier(act, 11, 180)
		mfgconsolefunc.SetModifier(act, 11, 60)
	elseIf index == 5
		act.SetExpressionOverride(2, 70)
		mfgconsolefunc.SetPhoneme(act, 1, 7)
		mfgconsolefunc.SetPhoneme(act, 5, 100)
		mfgconsolefunc.SetPhoneme(act, 11, 33)
		mfgconsolefunc.SetPhoneme(act, 12, 3)
		mfgconsolefunc.SetPhoneme(act, 15, 16)
		mfgconsolefunc.SetModifier(act, 4, 100)
		mfgconsolefunc.SetModifier(act, 5, 100)
		mfgconsolefunc.SetModifier(act, 6, 100)
		mfgconsolefunc.SetModifier(act, 7, 100)
		mfgconsolefunc.SetModifier(act, 10, 100)
		mfgconsolefunc.SetModifier(act, 11, 100)
	elseIf index == 6
		act.SetExpressionOverride(4, 70)
		mfgconsolefunc.SetPhoneme(act, 1, 20)
		mfgconsolefunc.SetPhoneme(act, 8, 70)
		mfgconsolefunc.SetPhoneme(act, 13, 30)
		mfgconsolefunc.SetPhoneme(act, 15, 4)
		mfgconsolefunc.SetModifier(act, 3, 70)
		mfgconsolefunc.SetModifier(act, 11, 100)
		mfgconsolefunc.SetModifier(act, 13, 50)
	endIf
endFunction


SexLabFramework Property SexLab  Auto  
SLApproachMainScript Property SLApproachMain auto
SLAppPCSexQuestScript Property SLAppPCSex auto

; overwrite by real approach quests
Quest Property ApproachQuest  Auto
string Property ApproachName Auto
Quest Property HelperQuest  Auto
Quest Property SLApproach_ExternalMods auto
ReferenceAlias Property HelperRef  Auto  
ReferenceAlias Property HelpRaperRef  Auto  
;------

Location Property BYOHHouse1LocationInterior Auto
Location Property BYOHHouse2LocationInterior Auto
Location Property BYOHHouse3LocationInterior Auto
Location Property WhiterunBreezehomelocation Auto
Location Property SolitudeProudspireManorLocation Auto
Location Property MarkarthVlindrelHallLocation Auto
Location Property RiftenHoneysideLocation Auto
Location Property WindhelmHjerimLocation Auto

Keyword Property LocTypePlayerHouse Auto
Formlist Property SLApproachPlayerHouse Auto
Formlist Property SLApproachPlayerHouseBYOH01 Auto
Formlist Property SLApproachPlayerHouseBYOH02 Auto
Formlist Property SLApproachPlayerHouseBYOH03 Auto
Formlist Property SLApproachPlayerHouseWhiterun Auto
Formlist Property SLApproachPlayerHouseMarkarth Auto
Formlist Property SLApproachPlayerHouseRiften Auto
Formlist Property SLApproachPlayerHouseSolitude Auto
Formlist Property SLApproachPlayerHouseWindhelm Auto
Formlist Property SLApproachPotentialHouseVisitors Auto

Faction Property isguardfaction  Auto  
Race Property ElderRace  Auto  
Race Property HorseRace  Auto  
Race Property ManakinRace  Auto  
Race Property DremoraRace  Auto  

Armor Property SLAppRingShame  Auto  
Armor Property SLAppRingFamily  Auto  

Faction Property JobJarlFaction  Auto
Faction Property Banditfaction  Auto
Faction Property WINeverFillAliasesFaction  Auto

Faction Property slapp_ProstitutionFaction Auto
Faction Property slapp_Characterfaction Auto
Faction Property SLAX_AggressiveFaction Auto
Faction Property slapp_washiringfaction Auto
Faction Property slapp_AquaintedFaction Auto
Faction Property slapp_FavorMeasureFaction Auto
Faction Property slapp_DislikeFaction Auto
Faction property slapp_DisappointedFaction auto
Faction Property slapp_RapeFailFaction Auto
Faction Property slapp_ReconciliationFaction Auto
Faction Property slapp_NoSpankFaction Auto
Faction Property slapp_NoMolestFaction Auto
Faction Property slapp_NoBackHugFaction Auto
Faction Property slapp_GiftGiverFaction Auto
Faction Property slapp_GiftFoodGiverFaction Auto
Faction Property slapp_VisitedFaction Auto
Faction Property slapp_StayedFaction Auto
Faction Property slapp_VisitedFailedFaction Auto
Faction Property SexLabAnimatingFaction Auto
Faction Property ThalmorFaction Auto
Faction Property CurrentFollowerFaction Auto
Faction Property PlayerFaction Auto
Faction Property PlayerMarriedFaction Auto
Faction Property CurrentHireling Auto
Faction Property PotentialHireling Auto
Faction Property slapp_VisitingFaction Auto
Faction Property slapp_VisitingEventFaction Auto
Faction Property slapp_VisitingScenePlayFaction Auto
Faction property slapp_KissFaction Auto
Faction Property sla_Exposure Auto
Faction Property GuardDialogueFaction Auto
Faction Property slapp_SpankFaction Auto
Faction Property slapp_MolestFaction Auto
Faction Property slapp_AssGropeFaction Auto
Faction Property slapp_DidSpankFaction Auto
Faction Property slapp_AggressiveBFFaction  Auto
Faction Property slapp_KidFaction  Auto
Faction Property slapp_HaveSeenBody  Auto
Faction Property slapp_NoStripFaction  Auto
Faction Property slapp_FirstImpressionFaction Auto
Faction Property slapp_ThinkBitchFaction Auto
Faction Property slapp_ThinkExhibitionistFaction Auto
Faction Property slapp_ThinkPickyFaction Auto
Faction Property slapp_ThinkJobFaction Auto
Faction Property slapp_ThinkPersonalityFaction Auto
Faction Property slapp_ThinkChracterFaction Auto
Faction Property slapp_ThinkFemmeFataleFaction Auto
Faction Property slapp_ThinkRichFaction Auto
Faction Property slapp_ThinkNoVirginFaction Auto
Faction Property slapp_ThinkRapeAllowedFaction Auto
Faction Property slapp_LoveConfessionFaction Auto
Faction Property slapp_TraitPreferenceBreastfaction Auto
Faction Property slapp_TraitPreferenceHairfaction Auto
Faction Property slapp_TraitPreferenceFoodfaction Auto
Faction Property slapp_ThinkFoodPreferenceFaction Auto
Faction Property slapp_FoodToxicTriedFaction Auto
Faction Property slapp_FoodCumTriedFaction Auto
Faction Property slapp_FoodCumTriedDetectedFaction Auto
Faction Property slapp_FoodSleepingDrugTriedDetectedFaction Auto
Faction Property slapp_NeedMoneyFaction Auto
Faction Property slapp_NeedMoneyReadyFaction Auto
Faction Property slapp_FillHerUpVagFaction Auto
Faction Property slapp_FillHerUpOralFaction Auto
Faction Property slapp_AskedForSexFaction Auto
Faction Property slapp_NoMoreApproach Auto
Faction Property slapp_TraitFetishfaction Auto
Faction Property slapp_HopeGetDressedFaction Auto

GlobalVariable Property SLApproachStayingStartingTime Auto
GlobalVariable Property SLApproachStayingElapsedTime Auto


LeveledItem Property SLAPPAffectionMiscLVL Auto
LeveledItem Property SLAPPLItemInnRuralDrink Auto
LeveledItem Property SLAPPLItemRuralSweets Auto

GlobalVariable Property SLApproachProstitutionNPCMoney Auto
GlobalVariable Property SLAStandardLevelMaximumNPCGlobal Auto
GlobalVariable Property SLAStandardLevelMinimumNPCGlobal Auto
GlobalVariable Property SLApproachMoralGlobal Auto
GlobalVariable Property SLA_BaboReputation Auto
GlobalVariable Property SLA_BaboWillPower Auto
GlobalVariable Property SLA_BaboReputationBitch Auto
GlobalVariable Property SLA_BaboDialogue Auto
GlobalVariable Property SLA_FillHerUp Auto
GlobalVariable Property SLABreastsSlide Auto
GlobalVariable Property SLAAppearanceSlide Auto
GlobalVariable Property SLAButtsSlide Auto
GlobalVariable Property SLApproachDetectCumFood Auto
GlobalVariable Property SLApproachDetectDruggedFood Auto
GlobalVariable Property SLA_BStolenArmor Auto
GlobalVariable Property SLA_Peeing Auto;XXA1D070
GlobalVariable Property SLApproachEventGlobal Auto
{0 - Normal Sex, 1 - Showoff}
GlobalVariable Property SLApproachSexualInsultTimes Auto

Idle property BaboDrinkNormal auto
Idle property BaboDrinkBlackOut auto
Idle property BaboDrinkBlackOutLoop auto
Sound Property SLAPPMarker_DeepKiss  Auto  

Quest Property sla_Framework Auto
;Quest Property SLApproachAskForSexQuest Auto

ImageSpaceModifier Property FadeToBlackImod  Auto  
ImageSpaceModifier Property FadeToBlackHoldImod  Auto  
ImageSpaceModifier Property FadeToBlackBackImod  Auto  