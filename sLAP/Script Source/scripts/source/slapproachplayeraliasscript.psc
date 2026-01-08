Scriptname SLApproachPlayerAliasScript extends ReferenceAlias

SLAppPCSexQuestScript property SLApproachPC auto
SLApproachBaseQuestScript property SLApproachBase auto
SLApproachMainScript property SLApproachMain auto
SLApproachScanQuest Property ApproachScan Auto
Quest Property SLApproach_ExternalMods Auto
Quest Property SLApproach_Config Auto
spell property CloakAbility auto
perk property SLAPPDoorLockPerk auto
quest property SLApproachScanningPlayerHouse auto
Int iVersion = 0
String sVersion = ""
int FailSafe = 0

;This is only used right now to ensure ApproachScan is set if upgrading from a previous version
Function SetVersion()
	iVersion = 330
	sVersion = "3.30"
EndFunction

Int Function IntVersion()
	return iVersion
EndFunction

String Function StringVersion()
	return sVersion
EndFunction

Event OnPlayerLoadGame()
	;Move this to SLApproachQuestAliasScript or vice versa?
	SLApproachBase.PlayerRef = Game.GetPlayer()
	ApproachScan = Game.GetFormFromFile(0x39078E, "SexLab Approach.esp") as SLApproachScanQuest
	SLApproachMain.Maintenance()
	SLApproachBase.RegisterExternalModEvent()
	SLApproachPC.RegisterExternalModEvent()
	(SLApproach_ExternalMods as SLApproachExternalScript).ReadJsonExcludeFaction()
	(SLApproach_Config as SLApproachConfigScript).VerifyMods()
	(GetReference() as Actor).AddPerk(SLAPPDoorLockPerk)
	RegisterForSingleUpdate(1)
	FailSafe = 0
	SetVersion()
	;debug.notification("Sexlab Approach Redux Version " + StringVersion())
EndEvent

Event OnInit()
	SetVersion()
	RegisterForSingleUpdate(1)
EndEvent

Event OnUpdate()
	if !SLApproachMain.isSkipUpdateMode && !SLApproachBase.isSkipMode
		if SLApproachPC.PCApproachOngoing == false
			DebugLog("SexLab Approach: Cloak!")

			SLApproachMain.isDuringCloakPulse = true;scanning

			Int actorCount = ApproachScan.GetApproachActors()
			If actorCount > 0
				Actor[] approachActors = ApproachScan.approachActors
				Actor randomApproach = approachActors[Utility.RandomInt(0, actorCount - 1)]

				If randomApproach != None
					int indexCounter = SLApproachMain.getRegisteredAmount();Not used anymore, Keep this just in case I'll add more content
					while indexCounter > 0
						indexCounter -= 1
						if SLApproachMain.getApproachQuestScript(indexCounter).isSituationValid(randomApproach)
							DebugLog("SituationValid " + SLApproachMain.StartInitOfQuestByIndex(indexCounter))
							if SLApproachPC.chanceRoll(randomApproach, GetReference() as Actor, SLApproachMain.baseChanceMultiplier)
								SLApproachBase.RegisterAnimationEvent()
								SLApproachPC.ready()
								indexCounter = 0; break while loop
								SLApproachPC.startApproach(randomApproach)
								DebugLog(randomApproach.GetBaseObject().GetName() + " is approaching")
							else
								SLApproachMain.EndtInitOfQuestByIndex(indexCounter)
							endif
						endif
					endwhile
				EndIf
			EndIf

			SLApproachMain.isDuringCloakPulse = false

			if SLApproachPC.iGetFormIndex() && SLApproachPC.PCApproachOngoing == false && SLApproachMain.SLAHouseVisitChance > 0 && SLApproachScanningPlayerHouse.getstage() == 5
				SLApproachPC.KnockKnock()
				DebugLog("Knock Knock...")
			endIf
		else
			DebugLog("SexLab Approach: Cloak Failed!")
			FailSafe += 1
			if FailSafe > 4
				Failsafe = 0
				SLApproachPC.StopScene()
				;SLApproachPC.StopSceneForce()
			endif
		endIf
	endIf
	(SLApproach_ExternalMods as SLApproachExternalScript).ExportStatSettings()
	RegisterForSingleUpdate(SLApproachMain.cloakFrequency)
EndEvent

Function DebugLog(String msg)
	if (SLApproachMain.debugLogFlag)
		Debug.Notification(msg)
	endif
EndFunction
