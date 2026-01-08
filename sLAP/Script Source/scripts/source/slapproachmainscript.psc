Scriptname SLApproachMainScript extends Quest Conditional

SLAppPCSexQuestScript Property SLAppPCSex Auto

;####################################################
;###############Sexlab BaboDialogue######################
;####################################################
Faction Property BaboAggressiveBoyFriend Auto Hidden
Faction Property BaboDialogueFaction Auto Hidden
Faction Property BaboViceGuardCaptainFaction Auto Hidden
Faction Property BaboWasHireling Auto Hidden
Faction Property BaboPotentialHireling Auto Hidden
Faction Property BaboCurrentHireling Auto Hidden
Faction Property BaboKidnapCaptiveFaction Auto Hidden 
Faction Property BaboAnonymousSlaverGuardFaction Auto Hidden
Faction Property BaboAnonymousSlaverFaction Auto Hidden 

Faction Property slapp_AquaintedFaction Auto
Faction Property slapp_DislikeFaction Auto
Faction Property slapp_RapeFailFaction Auto
Faction Property slapp_ReconciliationFaction Auto

ObjectReference Property BaboChestWhiterunRef Auto Hidden
Keyword Property SLHHScriptEventKeyword Auto

Actor Property PlayerRef Auto
;Spell Property SLApproachCloakAbility Auto
int Property SLApproachTimelimit = 30 Auto Hidden
int Property cloakFrequency = 70 Auto Hidden
float Property baseChanceMultiplier = 0.7 Auto Hidden
;int Property totalAwarnessRange = 256 Auto; no longer used

float Property ProstitutionAcceptChance = 0.0 Auto Hidden Conditional

Armor Property StolenArmor Auto Hidden Conditional

bool Property enableSLSFFlag = true Auto Hidden Conditional
bool Property enableSLHHFlag = true Auto Hidden Conditional
bool Property enableBDFlag = true Auto Hidden Conditional
bool Property enableFHUFlag = true Auto Hidden Conditional
bool Property enableSexlabSurvivalFlag = false Auto Hidden Conditional
bool Property enableDDIFlag = true Auto Hidden Conditional
bool Property enablePAF = true Auto Hidden Conditional

bool Property debugLogFlag = false Auto Hidden
bool Property enablePromiseFlag = false Auto  Hidden
bool Property enableRapeFlag = true Auto Hidden
bool Property enableForceThirdPersonHug = true Auto Hidden
;bool Property enableRelationChangeFlag = false Auto ; no longer used
bool Property enableElderRaceFlag = true Auto Hidden Conditional
bool Property enableFollowerFlag = false Auto Hidden Conditional
bool Property enableHirelingFlag = true Auto Hidden Conditional
bool Property enableGuardFlag = false Auto Hidden Conditional
bool Property enableDremoraFlag = false Auto Hidden Conditional
bool Property enableChildFlag = true Auto Hidden Conditional
bool Property enableThalmorFlag = false Auto Hidden
bool Property enableVisitorFlag = false Auto Hidden Conditional
bool Property enableRieklingFlag = false Auto Hidden Conditional

bool Property enableConsumeAlcholFlag = false Auto Hidden
bool Property enableApproachNakedFlag = false Auto Hidden

bool Property enablePetsFlag = false Auto Hidden ; Temporarily locked
bool Property enablePlayerHorseFlag = false Auto Hidden ; Temporarily locked

GlobalVariable Property SLAStandardLevelMaximumNPCGlobal Auto
GlobalVariable Property SLAStandardLevelMinimumNPCGlobal Auto

bool property SLALowerLevelNPC = true Auto Hidden
bool property SLAHigherLevelNPC = true Auto Hidden
bool property SLAStandardLevelNPC = true Auto Hidden

int property SLASpoilBase = 5 Auto Hidden
int property SLASpoilMult = 1 Auto Hidden

int property SLANPCUniqueCharacterMin = 0 Auto Hidden
int property SLANPCUniqueCharacterMax = 2 Auto Hidden
int property SLANPCCharacterMin = 0 Auto Hidden Conditional
int property SLANPCCharacterMax = 3 Auto Hidden Conditional

int property SLAHouseVisitChance = 5 Auto Hidden

int property SLARelationshipChance = 40 Auto Hidden
int property SLAAquaintanceChance = 30 Auto Hidden
int property SLADislikeChance = 40 Auto Hidden

int property SLADeviationLevel = 5 Auto Hidden

int property SLAPCAppearance = 50 Auto Hidden
int property SLAPCBreasts = 50 Auto Hidden
int property SLAPCButts = 50 Auto Hidden

int property SLAPStrafeDifficulty = 2 Auto Hidden
int property SLAPStruggleDuration = 5 Auto Hidden

bool Property SLANakedArmor = false Auto Hidden

bool Property SLAOnlyInTown = false Auto Hidden
bool Property SLAUniqueActor = false Auto Hidden

bool Property SLAProstitution = false Auto Hidden Conditional
bool Property SLAProstitutionFollow = false Auto Hidden Conditional

int Property SLAProstitutionpayway Auto Hidden Conditional; 0 means prepaid and 1 means postpaid
int Property SLApproachSpankAuraDuration = 30 Auto Hidden

int Property lowestArousalPC = 0 Auto Hidden
int Property lowestArousalNPC = 10 Auto Hidden

int Property userAddingPointPc = 20 Auto Hidden;-150~100
int Property userAddingPointNpc = 10 Auto Hidden

int Property userAddingRapePointPc = 10 Auto Hidden
int Property userAddingRapePointNpc = 0 Auto Hidden

int Property userAddingHugPointPc = 0 Auto Hidden
int Property userAddingHugPointNpc = 0 Auto Hidden

bool Property SLACurrentActorisChild Auto Hidden

int Property userAddingSpankingAssPointPc = 10 Auto Hidden
int Property userAddingaskingnamePointPc = 10 Auto Hidden
int Property userAddingVisitorPointPc = 10 Auto Hidden
int Property userAddingKissPointPc = 10 Auto Hidden
int Property userAddingKissPointNpc = 10 Auto Hidden

bool property hasfoundtheactor = false Auto Hidden
bool property isDuringCloakPulse = false Auto Hidden
int Property actorsEffectStarted = 0 Auto Hidden
int Property actorsEffectFinished = 0 Auto Hidden

bool Property isSkipUpdateMode = false Auto
bool Property SLALocktheDoor = false Auto
bool Property SLARemoveHeelEffect = true Auto

slapp_util Property slappUtil Auto

ObjectReference Property SLAPPSexCellRecoverMarkerRef Auto
ObjectReference Property SLAPPSexCellMarkerRef01 Auto
ObjectReference Property SLAPPSexCellMarkerRef02 Auto

ObjectReference Property SLAPPXmarkerFrontDoorWhiterunRef Auto
ObjectReference Property SLAPPXmarkerFrontDoorBYOH01Ref Auto
ObjectReference Property SLAPPXmarkerFrontDoorBYOH02Ref Auto
ObjectReference Property SLAPPXmarkerFrontDoorBYOH03Ref Auto
ObjectReference Property SLAPPXmarkerFrontDoorSolitudeRef Auto
ObjectReference Property SLAPPXmarkerFrontDoorMarkarthRef Auto
ObjectReference Property SLAPPXmarkerFrontDoorRiftenRef Auto
ObjectReference Property SLAPPXmarkerFrontDoorWindhelmRef Auto

Keyword Property zad_Lockable Auto Hidden
Keyword Property zad_DeviousCollar Auto Hidden
Keyword Property zad_DeviousBelt Auto Hidden
Keyword Property zad_DeviousArmbinder Auto Hidden
Keyword Property zad_DeviousHarness Auto Hidden
Keyword Property zad_DeviousBra Auto Hidden
Keyword Property zad_DeviousSuit Auto Hidden
Keyword Property zad_DeviousYoke Auto Hidden
Keyword Property zad_DeviousGag Auto Hidden
Keyword Property zad_DeviousPlug Auto Hidden
Keyword Property zad_DeviousBlindfold Auto Hidden
Keyword Property zad_DeviousPiercingsVaginal Auto Hidden
Keyword Property zad_DeviousPlugVaginal Auto Hidden
Keyword Property zad_DeviousPlugAnal Auto Hidden
Keyword Property zad_DeviousBoots Auto Hidden
Keyword Property zad_DeviousHood Auto Hidden
Keyword Property zad_DeviousCorset Auto Hidden
Keyword Property zad_DeviousPiercingsNipple Auto Hidden

Formlist Property SLApproachDDIList Auto
Formlist Property SLApproachDDIBeltList Auto
Formlist Property SLApproachDDIBraList Auto
Formlist Property SLApproachDDICollarList Auto
Formlist Property SLApproachDDICorsetList Auto
Formlist Property SLApproachDDIGagList Auto
Formlist Property SLApproachDDIPiercingNList Auto
Formlist Property SLApproachDDIPiercingVList Auto
Formlist Property SLApproachDDIPlugAList Auto
Formlist Property SLApproachDDIPlugVList Auto
Formlist Property SLApproachDDIYokeList Auto

Key Property zad_ChastityKey Auto Hidden
Key Property zad_PiercingsRemovalTool Auto Hidden
Key Property zad_RestraintsKey Auto Hidden

int my_cloakRange = 100
Bool IsFemale

;/ int Property cloakRange Hidden /;
	;/ int Function get() /;
		;/ return my_cloakRange /;
	;/ EndFunction /;
	;/ Function set(int value) /;
		;/ my_cloakRange = value /;
		;/ SLApproachCloakAbility.SetNthEffectMagnitude(0, value as float) /;
	;/ EndFunction /;
;/ EndProperty /;
;Obsolete

bool initilized = false

int registeredQuestsAmount
bool[] approachQuestsInitilizationArray
Quest[] approachQuests
string[] approachQuestNames
SLApproachBaseQuestScript[] approachQuestScripts

Event OnInit()
	Maintenance()
EndEvent

Function Maintenance()
	if (!initilized)
		initApproachQuestRegister()
	endif
	
	initilized = true
	;PlayerRef.RemoveSpell(SLApproachCloakAbility)
	UnregisterForAllModEvents()
EndFunction

Function initApproachQuestRegister()
	registeredQuestsAmount = 0

	approachQuestsInitilizationArray = New bool[8]
	int counter = 8

	while counter
		counter -= 1
		approachQuestsInitilizationArray[counter] = false
	endwhile

	approachQuests = New Quest[8]
	approachQuestNames = new string[8]
	approachQuestScripts = new SLApproachBaseQuestScript[8]
EndFunction

bool Function StartInitOfQuestByIndex(int index)
	if (approachQuestsInitilizationArray[index])
		return false
	else
		slappUtil.log("START index = " + index + " appQuestInitArray => " + approachQuestsInitilizationArray[index])
		approachQuestsInitilizationArray[index] = true
		return true
	endif
EndFunction

Function EndtInitOfQuestByIndex(int index)
	if (index >= 0)
		slappUtil.log("END index = " + index + " appQuestInitArray => " + approachQuestsInitilizationArray[index])
		approachQuestsInitilizationArray[index] = false
	endif
EndFunction

Function clearQuestStatus()
	int idx = approachQuestsInitilizationArray.Length
	while (idx > 0)
		idx -= 1
		approachQuestsInitilizationArray[idx] = false
	endwhile
	
	int qidx = getregisteredAmount()
	while (qidx > 0)
		qidx -= 1
		approachQuestScripts[qidx].endApproachForce()
	endwhile
EndFunction

int Function RegisterQuest(Quest newQuest, SLApproachBaseQuestScript newQuestScript, string newQuestName)
	if(!initilized)
		return -1
	endif
	
	int indexCounter = registeredQuestsAmount - 1
	while (indexCounter >= 0)
		if (approachQuestNames[indexCounter] == newQuestName)
			approachQuests[indexCounter] = newQuest
			approachQuestScripts[indexCounter] = newQuestScript
			; debug.notification("Sexlab Approach: Approach named " + newQuestName + " is running.")
			return indexCounter
		endif
		indexCounter = indexCounter - 1
	endwhile
	
	if (registeredQuestsAmount < 8)
		int newIndex = registeredQuestsAmount
		registeredQuestsAmount = registeredQuestsAmount + 1
		
		approachQuests[newIndex] = newQuest
		approachQuestScripts[newIndex] = newQuestScript
		approachQuestNames[newIndex] = newQuestName
		debug.notification("Sexlab Approach: Approach named " + newQuestName + " registered.")

		if(!newQuest.isRunning())
			newQuest.Start()
			debug.notification("SexLab Approach: " + newQuestName + " - Quest Init")
		endif

		return newIndex
	endif
	
	debug.notification("Sexlab Approach: Quest registration failed due to exceeding max approach quest limit.")
	return -1
EndFunction

int Function getregisteredAmount()
	return registeredQuestsAmount
EndFunction

;quest Function getApproachQuest(int index)
;	if (index < registeredQuestsAmount && index >= 0)
;		return approachQuests[index]
;	endif
;	
;	debug.notification("Sexlab Approach: Quest retrival failed - invalid index " + index)
;	debug.trace("Sexlab Approach: Quest retrival failed - invalid index " + index)
;
;	return None
;EndFunction

SLApproachBaseQuestScript Function getApproachQuestScript(int index)
	if (index < registeredQuestsAmount && index >= 0)
		return approachQuestScripts[index]
	endif
	
	debug.notification("Sexlab Approach: Script retrival failed - invalid index " + index)
	debug.trace("Sexlab Approach: Script retrival failed - invalid index " + index)
	
	return None
EndFunction

string Function getApproachQuestName(int index)
	if (index < registeredQuestsAmount && index >= 0)
		return approachQuestNames[index]
	endif
	
	debug.notification("Sexlab Approach: Quest Name retrival failed - invalid index " + index)
	debug.trace("Sexlab Approach: Quest Name retrival failed - invalid index " + index)

	return None
EndFunction

Function addActorEffectStarted() ; When the Cloak Effect Starts.
	actorsEffectStarted += 1
EndFunction

Function addActorEffectFinished() ; When the Cloak Effect Finished.
	actorsEffectFinished += 1
EndFunction

Function Openthedoor(ObjectReference ref)
	SLAppPCSex.PreVisitorEntering()
EndFunction

Function Lockthedoor(ObjectReference ref, bool lockdoor) ; No more used
	Key door_key = ref.GetKey()
	if PlayerRef.GetItemCount(door_key) >= 1 && (lockdoor == true)
		ref.lock(true, true)
		debug.notification("I locked the door")
	elseif PlayerRef.GetItemCount(door_key) >= 1 && (lockdoor == false)
		ref.lock(false, true)
		debug.notification("I unlocked the door")
	else
		debug.notification("I don't have the key to lock the door.")
	endif
EndFunction

Function TeleporttoSexCellOnlyNPC(actor akactor, bool ToSexCell)
if ToSexCell
	SLAPPSexCellRecoverMarkerRef.moveto(akactor)
	akactor.moveto(SLAPPSexCellMarkerRef02)
else
	akactor.moveto(SLAPPSexCellRecoverMarkerRef)
endif
EndFunction

Function TeleporttoSexCell(actor akactor, bool ToSexCell)
if ToSexCell
	SLAPPSexCellRecoverMarkerRef.moveto(PlayerRef)
	PlayerRef.moveto(SLAPPSexCellMarkerRef01)
	akactor.moveto(SLAPPSexCellMarkerRef02)
else
	PlayerRef.moveto(SLAPPSexCellRecoverMarkerRef)
	akactor.moveto(SLAPPSexCellRecoverMarkerRef)
endif
EndFunction

Function RemoveHeelEffect(actor ActorRef)
IsFemale = IdentifySex(ActorRef) as bool
	if IsFemale && SLARemoveHeelEffect && ActorRef.GetWornForm(0x00000080)
		; Remove NiOverride High Heels
		if NiOverride.HasNodeTransformPosition(ActorRef, false, true, "NPC", "internal")
			float[] pos = NiOverride.GetNodeTransformPosition(ActorRef, false, IsFemale, "NPC", "internal")
			pos[0] = -pos[0]
			pos[1] = -pos[1]
			pos[2] = -pos[2]
			NiOverride.AddNodeTransformPosition(ActorRef, false, IsFemale, "NPC", "SexLab Approach.esp", pos)
			NiOverride.UpdateNodeTransform(ActorRef, false, IsFemale, "NPC")
		endIf
	endIf
EndFunction

Function ResetHeelEffect(actor ActorRef)
	if SLARemoveHeelEffect && NiOverride.RemoveNodeTransformPosition(ActorRef, false, IsFemale, "NPC", "SexLab Approach.esp")
		NiOverride.UpdateNodeTransform(ActorRef, false, IsFemale, "NPC")
	endIf
EndFunction


int Function IdentifySex(actor ActorRef)
int Sex
	Sex = ActorRef.getactorbase().getsex()
	Return Sex
EndFunction

Function InflationwithInjectorEvent(actor akactor, actor akinjector, int poolmask = 1, float famount = 0.1, int itime = 1)
		SendFHUInflationwithInjectorEvent(akactor as form, akinjector as form, true, poolmask, famount, itime, "")
EndFunction

Function InflationEvent(actor akactor, int poolmask = 1, float famount = 0.1, int itime = 1)
		SendFHUInflationEvent(akactor as form, true, poolmask, famount, itime, "")
EndFunction

Function SendFHUInflationEvent(form inflater, Bool Inflation, int poolmask, float amount, int time, string callback)
	if enableFHUFlag
		Int handle = ModEvent.Create("SR_InflateEvent")
		ModEvent.PushForm(handle, inflater)
		ModEvent.PushBool(handle, Inflation)
		ModEvent.PushInt(handle, poolmask)
		ModEvent.PushFloat(handle, amount)
		ModEvent.PushInt(handle, time)
		ModEvent.PushString(handle, callback)
		ModEvent.Send(handle)
	endif
EndFunction

Function SendFHUInflationwithInjectorEvent(form inflater, form injector, Bool Inflation, int poolmask, float amount, int inftime, string callback)
	Int handle = ModEvent.Create("SRInflateEventWithInjector")
	ModEvent.PushForm(handle, inflater)
	ModEvent.PushForm(handle, injector)
	ModEvent.PushBool(handle, Inflation)
	ModEvent.PushInt(handle, poolmask)
	ModEvent.PushFloat(handle, amount)
	ModEvent.PushInt(handle, inftime)
	ModEvent.PushString(handle, callback)
	ModEvent.Send(handle)
EndFunction

Function SendSLSFEvent(String EventString = "", String LocationString = "Current", Int MinFame = 0, Int MaxFame = 100)
if enableSLSFFlag
	Int EventHandle = ModEvent.Create("SLSF_Reloaded_SendFameGain")
	ModEvent.PushString(EventHandle, EventString)
	ModEvent.PushString(EventHandle, LocationString)
	ModEvent.PushInt(EventHandle, MinFame)
	ModEvent.PushInt(EventHandle, MaxFame)
	ModEvent.Send(EventHandle)
endif
EndFunction

;/
=====================
========NOTES========
=====================

You may un-comment the debug lines (remove ";") and recompile this script for testing and debugging purposes
If you wish, you may also add your own debug functions.

!!!!!!!!!DO NOT MESS WITH ANYTHING ELSE!!!!!!!!!


============================================
========VALID LOCATION LIST (STRING)========
============================================
[Default Locations - In no particular order]

[Major Locations]
Whiterun
Windhelm |or| Eastmarch
Winterhold
Markarth |or| the Reach
Riften |or| the Rift
Solitude |or| Haafingar
Morthal |or| Hjaalmarch
Dawnstar |or| the Pale
Falkreath

[Minor Locations]
Raven Rock
Riverwood
Rorikstead
Ivarstead
Shor's Stone
Dragon Bridge
Karthwasten
Skaal Village
Largashbur
Dushnikh Yal
Mor Khazgur
Narzulbur

[Custom Locations need to be specified by their location name string.]
[Use SLSF_Reloaded_RequestLocation to find and verify that information,
or manually register the location with SLSF_Reloaded_SendLocationRegister]
[Recommend extensive testing for custom locations.]

==============================================
========VALID FAME CATEGORIES (STRING)========
==============================================
[In no particular order]

Slut
Whore
Exhibitionist
Oral
Anal
Nasty
Pregnant
Group
Dominant
Submissive
Sadist
Masochist
Gentle
Likes Men
Likes Women
Likes Orc
Likes Khajiit
Likes Argonian
Bestiality
Bound - Requires Devious Devices
Tattoo - Requires Slave Tats
Cum Dump - Requires Fill Her Up Baka Edition
Unfaithful - Requires Fame Comments
Cuck - Requires Fame Comments
Airhead - Requires Bimbos of Skyrim
/;