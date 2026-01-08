Scriptname SLHH_Upkeep extends Quest Conditional

Import debug

Int StripCount = 0 Conditional
Int StripSuccessCount = 0 Conditional
int Property SLHHStripPossibility = 80 Auto;This is default value
slhh_Monitor Property SLHHMonitor  Auto
SLAppPCSexQuestScript Property SLAPPPCQuest Auto
Quest Property SLHHMonitorScript Auto

Bool BackHugStage01
Bool BackHugStage02
Bool BackHugStage03
Bool BackHugStage04

Bool IsCreature
int ViableRace
int property BackAttack auto Hidden
;0: NPC human
;1: Troll
;2: Riekling

Bool Property NegotiatingSuccess Auto conditional
Bool IsFemale

SLHH_MCM Property MCM auto
SexLabFramework Property SexLab Auto
ReferenceAlias Property Player auto
ReferenceAlias Property Aggressor auto
ReferenceAlias Property ThirdOne auto
ReferenceAlias Property companion auto
Quest Property SLHH_companion auto
int property iCuirassCount auto
int property iCount auto hidden
int property EscapeCountCriterion = 12 auto conditional
int property AVdivision = 20 auto
int property NegoArmorStripint = 2 auto conditional
bool property RemoveHeelEffect = true auto

Message Property SLHHResistMessagebox auto
Message Property SLHHResistCreatureMessagebox auto
Message Property SLHHFailedMessagebox auto
Message Property SLHHChokeFailedMessagebox  auto
Message Property SLHHDrunkFailedMessagebox  auto
Message Property SLHHFailedCreatureMessagebox auto
GlobalVariable Property SLHH_EscapeChance Auto
GlobalVariable Property SLHH_ResistMethodGlobal Auto

Keyword Property SLA_ArmorPretty Auto
Keyword Property SLA_ArmorSpendex Auto
Keyword Property EroticArmor Auto
Keyword Property SLA_ArmorHalfNakedBikini Auto
Keyword Property SLA_ArmorHalfNaked Auto
Keyword Property SLA_ArmorLewdLeotard auto
Keyword Property SLA_ArmorCurtain auto
Keyword Property SLA_ArmorTransparent auto

Keyword Property SLA_Brabikini Auto

Keyword Property SLA_PantyNormal Auto
Keyword Property SLA_ThongCString auto
Keyword Property SLA_ThongLowleg auto
Keyword Property SLA_ThongT auto
Keyword Property SLA_ThongGstring auto
Keyword Property SLA_MicroHotpants auto
Keyword Property SLA_PantsNormal auto

Keyword Property SLA_PastiesCrotch auto
Keyword Property SLA_PastiesNipple auto

Keyword Property SLA_PelvicCurtain auto
Keyword Property SLA_ShowgirlSkirt auto
Keyword Property SLA_FullSkirt auto
Keyword Property SLA_MiniSkirt auto
Keyword Property SLA_MicroSkirt auto

Scene Property SLHHSceneRunningaway Auto

String Property GAVCustom Auto;It could be stamina or magicka. But base will be stamina
String Property GAVCustom2 Auto;It could be stamina or magicka. But base will be none
ActorBase BaboWhiterunViceCaptainImperial
ActorBase BaboWhiterunViceCaptainStormcloack
Faction Property BaboEncounter01Faction Auto Hidden
Faction Property BaboEncounter02Faction Auto Hidden
Faction Property BaboChangeLocationEvent06Faction Auto Hidden
Faction Property BaboCurrentHireling Auto Hidden
Faction Property BaboDialogueFaction Auto Hidden
Faction Property BaboWasHireling Auto Hidden
Quest Property BaboChangeLocationEvent05 Auto Hidden
Quest Property BaboDialogueWhiterun Auto Hidden

Race Property TrollRace Auto
Race Property TrollFrostRace Auto
Keyword Property ActorTypeNPC Auto
Keyword Property ActorTypeCreature Auto

GlobalVariable Property SLHH_DamageActorValueGlobal Auto

GlobalVariable Property SLHH_ScriptEvent Auto
GlobalVariable Property SLHH_ScriptEventBC Auto
GlobalVariable Property SLHH_ScriptEventDrunk Auto
GlobalVariable Property SLHH_AssualtType Auto
GlobalVariable Property SLHH_ViableRace Auto

Perk Property SLHHDebuffPerk Auto
Perk Property SLHHNPCDebuffPerk Auto
Actor Property PlayerRef Auto

int iVictimLevel
int iAggressorLevel
Armor BodyPart
String RapistName
int BaseEscapeChance
int EscapeChance
float fVictimValue
float fVictimValue2
float fAggressorValue
float fAggressorValue2
Actor Property VictimNow Auto
Actor Property RapistNow Auto
int NegoArmorStripinstant
Bool MessageboxLoading
Faction Property SLHH_IgnoreFaction Auto

String Property OnSLHHEndEventString Auto Hidden
String Property SLHHRemoveArmorFormList = "slhh.removearmor" autoreadonly hidden
;################################################################
;########################For Modders Note########################
;################################################################

;OnMyCustomEvent = OnSLHHEndEventString
;You can send string data to SLHH and make it trigger your event.
;Register your own modevent first like below and then send string data along with activation of SLHH event.

;RegisterForModEvent("OnSLHHEnd_myCustomEvent", "OnMyCustomEvent")
;Event OnMyCustomEvent(form akform)
;Endevent

;int handle = ModEvent.Create("SLHH_AddOnEndEvent")
;if handle
;	ModEvent.PushString(handle, "OnMyCustomEvent")
;	ModEvent.Send(handle)
;endif


;################################################################
;################################################################


Event OnInit()
	SLHHRegisterAnimationEvent()
	SLHHRegisterForModEvent()
EndEvent

Function SLHHRegisterForModEvent()
	RegisterForModEvent("ON_SLHH_AddOnEndEvent", "SLHH_AddOnEndEvent")
	RegisterForModEvent("ON_SLHH_AddtoFilterEvent", "SLHH_AddtoFilterEvent")
	RegisterForModEvent("ON_SLHH_RemoveFromFilterEvent", "SLHH_RemoveFromFilterEvent")
	RegisterForModEvent("StageStart_More", "HeWantsMore")
	RegisterForModEvent("AnimationEnd_More", "Finished")
EndFunction

Event SLHH_AddOnEndEvent(String akstring);This will register your custom event name. This only will be triggered when it is non-sex SLHH events.
	OnSLHHEndEventString = akstring
EndEvent

Event SLHH_AddtoFilterEvent(Form akRef);This will filter out the actor from SLHH
	(akRef as actor).addtofaction(SLHH_IgnoreFaction)
EndEvent

Event SLHH_RemoveFromFilterEvent(Form akRef)
	(akRef as actor).removefromfaction(SLHH_IgnoreFaction)
EndEvent

Function SLHHActorRegisterForexternalmods()
	BaboWhiterunViceCaptainImperial = Game.GetFormFromFile(0xB67C33, "BaboInteractiveDia.esp") as ActorBase
	BaboWhiterunViceCaptainStormcloack = Game.GetFormFromFile(0xB71E3D, "BaboInteractiveDia.esp") as ActorBase
	BaboEncounter01Faction = Game.GetFormFromFile(0xC8EBFF, "BaboInteractiveDia.esp") as Faction
	BaboEncounter02Faction = Game.GetFormFromFile(0x382562, "BaboInteractiveDia.esp") as Faction
	BaboChangeLocationEvent06Faction = Game.GetFormFromFile(0x1066E3, "BaboInteractiveDia.esp") as Faction
	BaboCurrentHireling = Game.GetFormFromFile(0xC92D9D, "BaboInteractiveDia.esp") as Faction
	BaboDialogueFaction = Game.GetFormFromFile(0xD58522, "BaboInteractiveDia.esp") as Faction
	BaboWasHireling = Game.GetFormFromFile(0xD6272A, "BaboInteractiveDia.esp") as Faction
	BaboChangeLocationEvent05 = Game.GetFormFromFile(0xC287AB, "BaboInteractiveDia.esp") as Quest
	BaboDialogueWhiterun = Game.GetFormFromFile(0xB67C31, "BaboInteractiveDia.esp") as Quest
EndFunction

Function SLHHRegisterAnimationEvent()
	;RegisterForAnimationEvent(PlayerRef, "BaboBackhugStruggling01G")
	;RegisterForAnimationEvent(PlayerRef, "BaboBackhugStruggling02G")
	;RegisterForAnimationEvent(PlayerRef, "BaboBackhugStruggling01PG")
	RegisterForAnimationEvent(PlayerRef, "Babo_Struggle_S02_A01")
	RegisterForAnimationEvent(PlayerRef, "Babo_Struggle_S03_A01")
	RegisterForAnimationEvent(PlayerRef, "Babo_Struggle_S05_A01")
	RegisterForAnimationEvent(PlayerRef, "Babo_DeathStart")
	;Debug.notification("Registering SLHH Animation Events...")
EndFunction

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if (akSource == PlayerRef) && (asEventName == "Babo_DeathStart")
		Debug.Trace("SLHH_DeathStart Played")
	endIf
endEvent

Function Action()
iCount = 0
sslBaseAnimation[] anims
sslBaseAnimation[] animsCompanion
actor[] sexActorsCompanion
actor[] sexActors
actor NPC
int random = Utility.RandomInt(0, 100)

if MCM.Companion == true
	SLHH_Companion.Start()
endif
if random <= mcm.threesome
	NPC = SexLab.FindAvailableActor(CenterRef = PlayerRef, Radius = 2048.0, FindGender = 0, IgnoreRef1 = PlayerRef, IgnoreRef2 = Aggressor.GetActorRef(), IgnoreRef3 = Companion.GetActorRef(), IgnoreRef4 = none)
	ThirdOne.ForceRefTo(NPC)
	If NPC != none
		sexActors = new actor[3]
		sexActors[0] = PlayerRef
		sexActors[1] = Aggressor.GetRef() as Actor
		sexActors[2] = NPC
		
		If MCM.anim == "Bound/Forced"
			;debug.messagebox ("1")
			anims = SexLab.GetAnimationsByTags(3, "Forced", "Binding", "Bound")
		else
			;debug.messagebox ("2")
			anims = SexLab.GetAnimationsByTags(3, "Aggressive", TagSuppress = "MFF")
		endif	
			
	else
		sexActors = new actor[2]
		sexActors[0] = PlayerRef
		sexActors[1] = Aggressor.GetRef() as Actor
		
		If MCM.anim == "Sleeping/Faint"
			;debug.messagebox ("3")
			anims = SexLab.GetAnimationsByTags(2, "Necro", "Sleeping", "Faint")
		elseIf MCM.anim == "Bound/Forced"
			;debug.messagebox ("4")
			anims = SexLab.GetAnimationsByTags(2, "Forced", "Bound", "Binding")
		else
			;debug.messagebox ("5")
			anims = SexLab.GetAnimationsByTags(2, "Aggressive")
		endif	
	endif
else
		sexActors = new actor[2]
		sexActors[0] = PlayerRef
		sexActors[1] = Aggressor.GetRef() as Actor

		If MCM.anim == "Sleeping/Faint"
			;debug.messagebox ("6")
			anims = SexLab.GetAnimationsByTags(2, "Necro", "Sleeping", "Faint")
		elseIf MCM.anim == "Bound/Forced"
			;debug.messagebox ("7")
			anims = SexLab.GetAnimationsByTags(2, "Forced", "Bound", "Binding")
		else
			;debug.messagebox ("8")
			anims = SexLab.GetAnimationsByTags(2, "Aggressive")
		endif
endif

SexLab.StartSex(sexActors, anims, victim=PlayerRef, allowBed=false, hook="More")
Utility.wait(10.0)
AnimationStart(60)
return
endFunction

Event HeWantsMore(string eventName, string argString, float argNum, form sender)
sslThreadController thread = SexLab.HookController("HeWantsMore")
If iCount > 0 && iCount < 4
	If (iCount == 1 && Utility.RandomInt(0, 100) <= MCM.StageChance) || (iCount == 2 && Utility.RandomInt(0, 100) <= (MCM.StageChance * 0.67)) || (iCount == 3 && Utility.RandomInt(0, 100) <= (MCM.StageChance * 0.34))
		thread.AdvanceStage(true)
		;Debug.Notification("9")
		iCount += 1
	endif
else
	iCount += 1
endif
endEvent

Event Finished(string eventName, string argString, float argNum, form sender)
Actor Victim = SexLab.HookActors(argString)[0]
Actor Rapist = SexLab.HookActors(argString)[1]
If SLHH_Companion.isRunning() == true
	SLHH_Companion.Stop()
endif
If BaboDialogueVerification(Rapist) == true
	BaboDialogueTrigger(Rapist, True)
endif
SetStage(150)
endEvent

Function FinishedBackAttack(Actor akactor)
If SLHH_Companion.isRunning() == true
	SLHH_Companion.Stop()
endif
If BaboDialogueVerification(akactor) == true
	BaboDialogueTrigger(akactor, True)
endif

if OnSLHHEndEventString != ""
	int handle = ModEvent.Create(OnSLHHEndEventString)
	if handle
		ModEvent.PushForm(handle, akactor as form)
		ModEvent.Send(handle)
	endif
	OnSLHHEndEventString = "";reset
endif
SetStage(150)
EndFunction

Bool Function BaboDialogueVerification(Actor akactor)
if (akactor.getactorbase() == BaboWhiterunViceCaptainImperial) || (akactor.getactorbase() == BaboWhiterunViceCaptainStormcloack)
	Return True
elseif akactor.isinfaction(BaboDialogueFaction)
	Return True
elseif akactor.isinfaction(BaboCurrentHireling)
	Return True
elseif akactor.isinfaction(BaboChangeLocationEvent06Faction)
	Return True
elseif akactor.isinfaction(BaboEncounter01Faction)
	Return True
elseif akactor.isinfaction(BaboEncounter02Faction)
	Return True
else
	Return False
endif
EndFunction

Event OnUpdateGameTime()
;Debug.notification("SLHH_Upkeep Updatetime...")
Utility.Wait(0.1)
If GetStage() == 150 || 136
	If SLHHMonitorScript.getstage() >= 10 && SLHHMonitorScript.getstage() < 100
		AnimationStart(100, true)
	EndIf
	SLHHSceneRunningaway.stop()
	StripCount = 0
	StripSuccessCount = 0
	SetStage(160)
endif
EndEvent

Function AnimationStart(int nextstage, bool settodefault = false)
	SLHHMonitorScript.setstage(nextstage)
	if settodefault
	BackHugStage01 = True
	BackHugStage02 = True
	BackHugStage03 = True
	BackHugStage04 = True
	endif
EndFunction

String Function GetCreatureRaceKey(Actor Target)
	String RaceKey = sslCreatureAnimationSlots.GetRaceKey(Target.GetLeveledActorBase().GetRace())
	if RaceKey
		Return RaceKey
	endif
EndFunction

Function SLHHAnimStart(Actor Victim, Actor akactor, int AttackType);needs to add creature

SLHHRemoveHeelEffect(Victim)

race rr = akactor.getrace()

if (rr.HasKeyword(ActorTypeNPC)) && !(rr.HasKeyword(ActorTypeCreature))
	iscreature = false
	ViableRace = 0
elseif rr.HasKeyword(ActorTypeCreature)
iscreature = true
String RaceName = GetCreatureRaceKey(akactor)
	If RaceName == "Trolls"
		ViableRace = 1
	Elseif RaceName == "Rieklings"
		ViableRace = 2
	else
		Debug.trace("No Creature Race")
	endif
endif

StorageUtil.FormListClear(akactor, SLHHRemoveArmorFormList)
SLHH_ViableRace.setvalue(ViableRace)
akactor.AddPerk(SLHHNPCDebuffPerk)
Victim.AddPerk(SLHHDebuffPerk)

BackAttack = AttackType
SLHH_AssualtType.setvalue(AttackType)
Getstats(Victim, akactor)

StruggleAnimCheckRace(Victim, akactor, 1)
SLHHMonitor.RegisterAlias(akactor, true)
AnimationStart(10, true)


if ViableRace == 1
	GotoState("AttackTypeCreatureTroll")
elseif ViableRace == 2
	GotoState("AttackTypeCreatureRiekling")
Else
	if AttackType == 1
		GotoState("AttackType1")
	elseif AttackType == 2
		GotoState("AttackType2")
	elseif AttackType == 3
		GotoState("AttackType3")
	endif
endif
EndFunction

Function StruggleAnimCheckRace(Actor Victim, Actor akactor, int stage)
if ViableRace == 0;Human
	if BackAttack == 1
		if stage == 1
			SLHHMonitor.StruggleAnim(Victim, akactor, True, "Babo_Struggle_S01_A01", "Babo_Struggle_S01_A02", false)
		elseif stage == 2
			SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_Struggle_S02_A01", "Babo_Struggle_S02_A02")
		elseif stage == 3
			SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_Struggle_S03_A01", "Babo_Struggle_S03_A02")
		elseif stage == 4
			SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_Struggle_S04_A01", "Babo_Struggle_S04_A02")
		elseif stage == 5
			SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_Struggle_S05_A01", "Babo_Struggle_S05_A02")
		endif
	Elseif BackAttack == 2
		if stage == 1
			SLHHMonitor.StruggleAnim(Victim, akactor, True, "Babo_ChokeHug_S01_A01", "Babo_ChokeHug_S01_A02", false)
		elseif stage == 2
			SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_ChokeHug_S02_A01", "Babo_ChokeHug_S02_A02")
		elseif stage == 3
			SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_ChokeHug_S03_A01", "Babo_ChokeHug_S03_A02")
		elseif stage == 4
			SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_ChokeHug_S04_A01", "Babo_ChokeHug_S04_A02")
		elseif stage == 5
			SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_ChokeHug_S05_A01", "Babo_ChokeHug_S05_A02")
		endif
	Elseif BackAttack == 3
		if stage == 1
			SLHHMonitor.StruggleAnim(Victim, akactor, True, "Babo_Drunk_S01_A01", "Babo_Drunk_S01_A02", false)
		elseif stage == 2
			SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_Drunk_S02_A01", "Babo_Drunk_S02_A02")
		elseif stage == 3
			SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_Drunk_S03_A01", "Babo_Drunk_S03_A02")
		elseif stage == 4
			SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_Drunk_S04_A01", "Babo_Drunk_S04_A02")
		elseif stage == 5
			SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_Drunk_S05_A01", "Babo_Drunk_S05_A02")
		endif
	Endif
Expression(Victim, false, true)
Expression(akactor, false, false)
elseif ViableRace == 1;Troll
	if stage == 1
		SLHHMonitor.StruggleAnim(Victim, akactor, True, "Babo_Troll_S01_A01", "Babo_Troll_S01_A02", true)
	elseif stage == 2
		SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_Troll_S02_A01", "Babo_Troll_S02_A02")
	elseif stage == 3
		SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_Troll_S03_A01", "Babo_Troll_S03_A02")
	elseif stage == 4
		SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_Troll_S04_A01", "Babo_Troll_S04_A02")
	elseif stage == 5
		SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_Troll_S05_A01", "Babo_Troll_S05_A02")
	endif
	Expression(Victim, false, true)
elseif ViableRace == 2;Riekling
	if stage == 1
		SLHHMonitor.StruggleAnim(Victim, akactor, True, "Babo_Riekling_S01_A01", "Babo_Riekling_S01_A02", true)
	elseif stage == 2
		SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_Riekling_S02_A01", "Babo_Riekling_S02_A02")
	elseif stage == 3
		SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_Riekling_S03_A01", "Babo_Riekling_S03_A02")
	elseif stage == 4
		SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_Riekling_S04_A01", "Babo_Riekling_S04_A02")
	elseif stage == 5
		SLHHMonitor.StruggleAnimNext(Victim, akactor, "Babo_RieklingQTE_S02_A01", "Babo_RieklingQTE_S02_A02")
	endif
	Expression(Victim, false, true)
endif
EndFunction

Function Getstats(Actor Victim, Actor akactor);Need to place
	VictimNow = Victim
	RapistNow = akactor
	iVictimLevel = Victim.getlevel()
	iAggressorLevel = akactor.getlevel()
	BaseEscapeChance = SLHH_EscapeChance.getvalue() as int
	RapistName = akactor.getbaseobject().getname();Need to fix
	NegoArmorStripinstant = NegoArmorStripint
EndFunction

Function GetCurrentStats(Actor Victim, Actor akactor)
	BodyPart = Victim.GetWornForm(0x00000004) as armor
	fVictimValue = Victim.getactorvalue(GAVCustom)
	fVictimValue2 = Victim.getactorvalue(GAVCustom2)
	fAggressorValue = akactor.getactorvalue(GAVCustom)
	fAggressorValue2 = akactor.getactorvalue(GAVCustom2)
EndFunction

Event Onupdate()

EndEvent

State Pending

Event Onbeginstate()
	RegisterForSingleUpdate(5.0)
endEvent

Event Onupdate()
	if MessageboxLoading
		RegisterForSingleUpdate(5.0)
	else
		if ViableRace == 1
			GotoState("AttackTypeCreatureTroll")
		elseif ViableRace == 2
			GotoState("AttackTypeCreatureRiekling")
		Else
			if BackAttack == 1
				GotoState("AttackType1")
			elseif BackAttack == 2
				GotoState("AttackType2")
			elseif BackAttack == 3
				GotoState("AttackType3")
			endif
		endif
	endif
endEvent

EndState

State AttackType1

Event Onbeginstate()
	GetCurrentStats((Player.getRef() as Actor), (Aggressor.getRef() as Actor))
	ResistSelection((Player.getRef() as Actor), (Aggressor.getRef() as Actor))
endEvent

Function StrugglingAgain()
	GotoState("Pending")
EndFunction

Function StruggleAnimCheckRace(Actor Victim, Actor Rapist, int stage)
	if stage == 1
		SLHHMonitor.StruggleAnim(Victim, Rapist, True, "Babo_Struggle_S01_A01", "Babo_Struggle_S01_A02", false)
	elseif stage == 2
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_Struggle_S02_A01", "Babo_Struggle_S02_A02")
	elseif stage == 3
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_Struggle_S03_A01", "Babo_Struggle_S03_A02")
	elseif stage == 4
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_Struggle_S04_A01", "Babo_Struggle_S04_A02")
	elseif stage == 5
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_Struggle_S05_A01", "Babo_Struggle_S05_A02")
	endif
Expression(Victim, false, true)
Expression(Rapist, false, false)

EndFunction

Function DebuffDifficulty()
;Nothing now
EndFunction

Function DialogueStatus(int num)
	MCM.MCMDialogueAttack1(num)
endfunction

EndState

State AttackType2

Event Onbeginstate()
	GetCurrentStats((Player.getRef() as Actor), (Aggressor.getRef() as Actor))
	ResistSelection((Player.getRef() as Actor), (Aggressor.getRef() as Actor))
endEvent

Function StrugglingAgain()
	GotoState("Pending")
EndFunction

Function StruggleAnimCheckRace(Actor Victim, Actor Rapist, int stage)
	if stage == 1
		SLHHMonitor.StruggleAnim(Victim, Rapist, True, "Babo_ChokeHug_S01_A01", "Babo_ChokeHug_S01_A02", false)
	elseif stage == 2
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_ChokeHug_S02_A01", "Babo_ChokeHug_S02_A02")
	elseif stage == 3
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_ChokeHug_S03_A01", "Babo_ChokeHug_S03_A02")
	elseif stage == 4
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_ChokeHug_S04_A01", "Babo_ChokeHug_S04_A02")
	elseif stage == 5
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_ChokeHug_S05_A01", "Babo_ChokeHug_S05_A02")
	endif
Expression(Victim, false, true)
Expression(Rapist, false, false)

EndFunction

Function DebuffDifficulty()
	fAggressorValue += fAggressorValue*0.4
	iAggressorLevel += iAggressorLevel*0.4 as int
EndFunction

Function DialogueStatus(int num)
	MCM.MCMDialogueAttack2(num)
endfunction

EndState

State AttackType3

Event Onbeginstate()
	GetCurrentStats((Player.getRef() as Actor), (Aggressor.getRef() as Actor))
	ResistSelection((Player.getRef() as Actor), (Aggressor.getRef() as Actor))
endEvent

Function StrugglingAgain()
	GotoState("Pending")
EndFunction

Function StruggleAnimCheckRace(Actor Victim, Actor Rapist, int stage)
	if stage == 1
		SLHHMonitor.StruggleAnim(Victim, Rapist, True, "Babo_Drunk_S01_A01", "Babo_Drunk_S01_A02", false)
	elseif stage == 2
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_Drunk_S02_A01", "Babo_Drunk_S02_A02")
	elseif stage == 3
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_Drunk_S03_A01", "Babo_Drunk_S03_A02")
	elseif stage == 4
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_Drunk_S04_A01", "Babo_Drunk_S04_A02")
	elseif stage == 5
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_Drunk_S05_A01", "Babo_Drunk_S05_A02")
	endif
Expression(Victim, false, true)
Expression(Rapist, false, false)
EndFunction

Function DebuffDifficulty()
	fAggressorValue += fAggressorValue*0.7
	iAggressorLevel += iAggressorLevel*0.7 as int	
EndFunction

Function DialogueStatus(int num)
	MCM.MCMDialogueAttack3(num)
endfunction

EndState

State AttackTypeCreatureRiekling

Event Onbeginstate()
	GetCurrentStats((Player.getRef() as Actor), (Aggressor.getRef() as Actor))
	ResistSelection((Player.getRef() as Actor), (Aggressor.getRef() as Actor))
endEvent

Function StrugglingAgain()
	GotoState("Pending")
EndFunction

Function StruggleAnimCheckRace(Actor Victim, Actor Rapist, int stage)
	if stage == 1
		SLHHMonitor.StruggleAnim(Victim, Rapist, True, "Babo_Riekling_S01_A01", "Babo_Riekling_S01_A02", true)
	elseif stage == 2
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_Riekling_S02_A01", "Babo_Riekling_S02_A02")
	elseif stage == 3
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_Riekling_S03_A01", "Babo_Riekling_S03_A02")
	elseif stage == 4
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_Riekling_S04_A01", "Babo_Riekling_S04_A02")
	elseif stage == 5
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_RieklingQTE_S02_A01", "Babo_RieklingQTE_S02_A02")
	endif
Expression(Victim, false, true)

EndFunction

Function DebuffDifficulty()
	fAggressorValue += fAggressorValue*0.6
	iAggressorLevel += iAggressorLevel*0.6 as int
EndFunction

Function DialogueStatus(int num)
	MCM.MCMDialogueAttackTypeCreatureRiekling(num)
endfunction

EndState

State AttackTypeCreatureTroll

Event Onbeginstate()
	GetCurrentStats((Player.getRef() as Actor), (Aggressor.getRef() as Actor))
	ResistSelection((Player.getRef() as Actor), (Aggressor.getRef() as Actor))
endEvent

Function StrugglingAgain()
	GotoState("Pending")
EndFunction

Function StruggleAnimCheckRace(Actor Victim, Actor Rapist, int stage)
	if stage == 1
		SLHHMonitor.StruggleAnim(Victim, Rapist, True, "Babo_Troll_S01_A01", "Babo_Troll_S01_A02", true)
	elseif stage == 2
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_Troll_S02_A01", "Babo_Troll_S02_A02")
	elseif stage == 3
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_Troll_S03_A01", "Babo_Troll_S03_A02")
	elseif stage == 4
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_Troll_S04_A01", "Babo_Troll_S04_A02")
	elseif stage == 5
		SLHHMonitor.StruggleAnimNext(Victim, Rapist, "Babo_Troll_S05_A01", "Babo_Troll_S05_A02")
	endif
Expression(Victim, false, true)

EndFunction

Function DebuffDifficulty()
	fAggressorValue += fAggressorValue*0.6
	iAggressorLevel += iAggressorLevel*0.6 as int
EndFunction

Function DialogueStatus(int num)
	MCM.MCMDialogueAttackTypeCreatureTroll(num)
endfunction

EndState

Function debuffdifficulty()
;Nothing
EndFunction

Function DialogueStatus(int num)
;Nothing
endfunction

Function StrugglingAgain()
	GotoState("Pending")
EndFunction

Function StripArmor(actor akactor, Armor TargetPart)
	StorageUtil.FormListAdd(akactor, SLHHRemoveArmorFormList, TargetPart)
	akactor.UnequipItem(TargetPart)
EndFunction

Function ResistSelection(Actor Victim, Actor akactor)
	MessageboxLoading = true
	int choice
	DebuffDifficulty()
	EscapeChance = EscapeChanceCalculation(BaseEscapeChance, iVictimLevel, iAggressorLevel, fVictimValue, fAggressorValue)
	
	int random = Utility.RandomInt(1, 100)
	int randomstripchance = Utility.RandomInt(1, 100)
	Armor TargPart = SLHHMonitor.FindArmor(Victim, akactor, False, None)
	
	if iscreature
		choice = SLHHResistCreatureMessagebox.Show()
	else
		choice = SLHHResistMessagebox.Show()
	endif
	
	if (choice == 0);Struggling
	
		If random <= EscapeChance
			Escapesucess()
			return
		Elseif random > EscapeChance
			ValueDiminish(Victim, akactor, AVdivision)
			If (StripCount < EscapeCountCriterion) && BodyPart
				If TargPart
					If randomstripchance <= SLHHStripPossibility
						;Victim.UnequipItem(TargPart)
						StripArmor(Victim, TargPart)
						Utility.wait(2.0)
						DialogueStatus(1)
						StripSuccessCount += 1
					Else
						DialogueStatus(2)
					EndIf
					StripCount += 1
					self.AnimationCheck(victim, akactor)
				Else
					If randomstripchance <= SLHHStripPossibility
						StripSuccessCount = StripSuccessCount + 1
						if SLHHMonitor.FindKeywordArmor(Victim, iscreature)
							DialogueStatus(3)
							Utility.wait(2.0)
							If BackHugStage04
								StruggleAnimCheckRace(Victim, akactor, 4)
								AnimationStart(25)
								BackHugStage02 = false
								BackHugStage03 = false
								BackHugStage04 = false
							EndIf
						else
							DialogueStatus(4)
						endif
					else
						DialogueStatus(5)
					EndIf
					StripCount += 1
					self.AnimationCheck(victim, akactor)
				EndIf
			ElseIf (StripCount < EscapeCountCriterion) && BodyPart == False
				Utility.wait(2.0)
				If TargPart
					If randomstripchance <= SLHHStripPossibility
						StripSuccessCount = StripSuccessCount + 1
						;Victim.UnequipItem(TargPart)
						StripArmor(Victim, TargPart)
						self.AnimationCheck(victim, akactor)
						DialogueStatus(6)
					else
						DialogueStatus(7)
					endif
				else
					If randomstripchance <= SLHHStripPossibility
						EscapeFail()
						return
					else
						DialogueStatus(8)
					endif
				EndIf
				StripCount += 1
				self.AnimationCheck(victim, akactor)
			ElseIf (StripCount >= EscapeCountCriterion)
				EscapeSucess()
				return
			Else
				StripCount += 1
			EndIf
		EndIf
		StrugglingAgain()
	Elseif (choice == 1);Donothing
		If BodyPart
			If TargPart
				;Victim.UnequipItem(TargPart)
				StripArmor(Victim, TargPart)
				Utility.wait(2.0)
				DialogueStatus(9)
			Else
				;Victim.UnequipItem(BodyPart)
				if SLHHMonitor.FindKeywordArmor(Victim, iscreature)
					Utility.wait(2.0)
					If BackHugStage04
						StruggleAnimCheckRace(Victim, akactor, 4)
						AnimationStart(25)
						BackHugStage02 = false
						BackHugStage03 = false
						BackHugStage04 = false
						DialogueStatus(10)
					Else
						DialogueStatus(11)
					EndIf
				else
					DialogueStatus(12)
				endif
			EndIf
			StripCount += 1
			StripSuccessCount += 1
			self.AnimationCheck(victim, akactor)
		ElseIf BodyPart == False
			Utility.wait(2.0)
			If TargPart
				;Victim.UnequipItem(TargPart)
				StripArmor(Victim, TargPart)
					DialogueStatus(13)
			Else
				Utility.wait(2.0)
				EscapeFail()
				return
			EndIf
			StripCount += 1
			StripSuccessCount += 1
			self.AnimationCheck(victim, akactor)
		Else
			StripCount += 1
			StripSuccessCount += 1
			self.AnimationCheck(victim, akactor)
		EndIf
		StrugglingAgain()
	Elseif (choice == 2);Negotiating Start
		int randomNego = Utility.RandomInt(0, 99)
		int SpeechValue = PlayerRef.getactorvalue("Speechcraft") as int
		EscapeChance = ((SpeechValue + EscapeChance) * 0.5) as int
		EscapeChance += akactor.getrelationshiprank(Victim)
		EscapeChance -= StripCount
		EscapeChance += akactor.getactorvalue("Morality") as int
	
		if randomNego <= EscapeChance;success
			NegotiatingSuccess = True
			StripCount += 3
			StripSuccessCount += 3
			self.AnimationCheck(victim, akactor)
		else
			NegotiatingSuccess = false
			StripCount += 1
			StripSuccessCount += 1
			self.AnimationCheck(victim, akactor)
		endif
		if iscreature
			SLHHMonitor.ShuffleScenarioes(NegotiatingSuccess, EscapeChance, 2)
		else
			SLHHMonitor.ShuffleScenarioes(NegotiatingSuccess, EscapeChance, 1)
		endif
	Elseif (choice == 3);GivingUp
		Utility.wait(2.0)
		EscapeFail()
		return
	EndIf
MessageboxLoading = false
EndFunction

Function NegotiatingOver(Bool Success)

	Armor TargPart = SLHHMonitor.FindArmor(VictimNow, RapistNow, False, None)
	int RSCAfterNegotiation = Utility.RandomInt(1, 100)
	ValueDiminish(VictimNow, RapistNow, AVdivision)
	
	If Success
		If (StripCount < EscapeCountCriterion) && BodyPart
			If TargPart
				If RSCAfterNegotiation <= SLHHStripPossibility
					while NegoArmorStripinstant > 0 
						;VictimNow.UnequipItem(TargPart)
						StripArmor(VictimNow, TargPart)
						TargPart = SLHHMonitor.FindArmor(VictimNow, RapistNow, False, None)
						NegoArmorStripinstant -= 2
					endwhile
					DialogueStatus(14)
				else
					DialogueStatus(15)
				endif
				self.AnimationCheck(VictimNow, RapistNow)
			Else
				If RSCAfterNegotiation <= SLHHStripPossibility
					if SLHHMonitor.FindKeywordArmor(VictimNow, iscreature)
						Utility.wait(2.0)
						If BackHugStage04
							StruggleAnimCheckRace(VictimNow, RapistNow, 4)
							AnimationStart(25)
							BackHugStage02 = false
							BackHugStage03 = false
							BackHugStage04 = false
							DialogueStatus(16)
						EndIf
					else
						DialogueStatus(17)
					endif
				else
					DialogueStatus(18)
				endif
				self.AnimationCheck(VictimNow, RapistNow)
			EndIf
		ElseIf (StripCount < EscapeCountCriterion) && !BodyPart
			Utility.wait(2.0)
			If TargPart
				If RSCAfterNegotiation <= SLHHStripPossibility
					while NegoArmorStripinstant > 0 
						;VictimNow.UnequipItem(TargPart)
						StripArmor(VictimNow, TargPart)
						TargPart = SLHHMonitor.FindArmor(VictimNow, RapistNow, False, None)
						NegoArmorStripinstant -= 2
					endwhile
					DialogueStatus(19)
				else
					DialogueStatus(20)
				endif
			else
				If RSCAfterNegotiation <= SLHHStripPossibility
					DialogueStatus(21)
					EscapeFail()
					return
				else
					DialogueStatus(22)
				endif
			EndIf
			self.AnimationCheck(VictimNow, RapistNow)
		ElseIf (StripCount >= EscapeCountCriterion)
			EscapeSucess()
			return
		EndIf
		StrugglingAgain()
	Else
		If BodyPart
			If TargPart
				while NegoArmorStripinstant > 0 
					;VictimNow.UnequipItem(TargPart)
					StripArmor(VictimNow, TargPart)
					TargPart = SLHHMonitor.FindArmor(VictimNow, RapistNow, False, None)
					NegoArmorStripinstant -= 1
				endwhile
				Utility.wait(2.0)
				
				if SLHHMonitor.RemoveLower(VictimNow) > 0
					DialogueStatus(23)
				else
					DialogueStatus(24)
				endif
			Else
				if SLHHMonitor.FindKeywordArmor(VictimNow, iscreature)
					Utility.wait(2.0)
					If BackHugStage04
						StruggleAnimCheckRace(VictimNow, RapistNow, 4)
						AnimationStart(25)
						BackHugStage02 = false
						BackHugStage03 = false
						BackHugStage04 = false
						DialogueStatus(25)
					Else
						DialogueStatus(26)
					EndIf
				else
					DialogueStatus(27)
				endif
			EndIf
			self.AnimationCheck(VictimNow, RapistNow)
		ElseIf BodyPart == False
			Utility.wait(2.0)
			If TargPart
				while NegoArmorStripinstant > 0 
					;VictimNow.UnequipItem(TargPart)
					StripArmor(VictimNow, TargPart)
					TargPart = SLHHMonitor.FindArmor(VictimNow, RapistNow, False, None)
					NegoArmorStripinstant -= 1
				endwhile
				
				if SLHHMonitor.RemoveLower(VictimNow) > 0
					DialogueStatus(28)
				else
					DialogueStatus(29)
				endif
			Else
				Utility.wait(2.0)
				DialogueStatus(30)
				EscapeFail()
				return
			EndIf
			self.AnimationCheck(VictimNow, RapistNow)
		EndIf
		StrugglingAgain()
	Endif
	MessageboxLoading = false
Endfunction

int Function AnimationCheck(actor victim, actor raper)
	If (StripCount > (EscapeCountCriterion * 0.2) as int) && (StripCount < (EscapeCountCriterion * 0.4) as int) && BackHugStage02
		StruggleAnimCheckRace(Victim, Raper, 2)
		AnimationStart(15)
		BackHugStage02 = False
	Elseif (StripCount >= (EscapeCountCriterion * 0.5) as int) && BackHugStage03
		StruggleAnimCheckRace(Victim, Raper, 3)
		AnimationStart(20)
		BackHugStage03 = False
	ElseIf (StripCount >= (EscapeCountCriterion * 0.8) as int) && BackHugStage04
		StruggleAnimCheckRace(Victim, Raper, 4)
		AnimationStart(25)
		BackHugStage02 = false
		BackHugStage03 = false
		BackHugStage04 = false
	Else
		;Nothing
	EndIf
Endfunction

Function EscapeFail()
	MessageboxLoading = false
	Gotostate("")
	int choice
	Actor rapist = Aggressor.getReference() as Actor
	rapist.RemovePerk(SLHHNPCDebuffPerk)
	PlayerRef.RemovePerk(SLHHDebuffPerk)
	SLHHMonitor.NegotiationSuccessPossibility = 0
	SLHHMonitor.RegisterAlias(none, false)
	SLHHResetHeelEffect(PlayerRef)
	if iscreature
		choice = SLHHFailedCreatureMessagebox.Show()
	else
		if BackAttack == 1
			choice = SLHHFailedMessagebox.Show()
		elseif BackAttack == 2
			choice = SLHHChokeFailedMessagebox.Show()
		elseif BackAttack == 3
			choice = SLHHDrunkFailedMessagebox.Show()
		endif
	endif
	if (choice == 0);Nochoice
		SLAPPTrigger(rapist, True, BackAttack)
		AnimationStart(30)
		if viablerace == 0
			if BackAttack == 1 
				if SLHH_ScriptEvent.getvalue() == 0;Sex
					SLHHMonitor.StruggleAnim(PlayerRef, rapist, False, None, None, false)
				else;No sex
					SLHHMonitor.StruggleAnim(PlayerRef, rapist, False, None, None, false)
					Utility.wait(0.5)
					Debug.SendAnimationEvent(PlayerRef, "Babo_DeathStart")
					FinishedBackAttack(rapist)
					Return
				endif
			elseif BackAttack == 2
				if SLHH_ScriptEventBC.getvalue() == 0;Sex
					SLHHMonitor.StruggleAnim(PlayerRef, rapist, False, None, None, false)
					Utility.wait(0.5);wait for the script
					Debug.SendAnimationEvent(PlayerRef, "Babo_DeathStart")
				else
					SLHHMonitor.StruggleAnim(PlayerRef, rapist, False, None, None, false)
					Utility.wait(0.5);wait for the script
					;PlayerRef.Playidle(SLHH_DeathStart)
					Debug.SendAnimationEvent(PlayerRef, "Babo_DeathStart")
					FinishedBackAttack(rapist)
					Return
				endif
			elseif BackAttack == 3
				if SLHH_ScriptEventDrunk.getvalue() == 0
					SLHHMonitor.StruggleAnim(PlayerRef, rapist, False, None, None, false)
				else
					Utility.wait(0.5);wait for the script
					SLHHMonitor.StruggleAnim(PlayerRef, rapist, True, "Babo_Drunk_SBD_A01Start", "Babo_Drunk_SBD_A02Start", false)
					FinishedBackAttack(rapist)
					Utility.wait(10.0)
					SLHHMonitor.StruggleAnim(PlayerRef, rapist, False, None, None, false)
					Return
				endif
			else;just in case
				SLHHMonitor.StruggleAnim(PlayerRef, rapist, False, None, None, false)
			endif
		else
			SLHHMonitor.StruggleAnim(PlayerRef, rapist, False, None, None, true)
		endif
		setstage(140)
	EndIf
EndFunction

Function EscapeSucess()
	Gotostate("")
	MessageboxLoading = false
	Actor rapist = Aggressor.getRef() as Actor
	rapist.RemovePerk(SLHHNPCDebuffPerk)
	PlayerRef.RemovePerk(SLHHDebuffPerk)
		SLAPPTrigger(rapist, false, BackAttack)
			If BaboDialogueVerification(rapist) == true
				BaboDialogueTrigger(rapist, false)
			Endif
		SLHHMonitor.NegotiationSuccessPossibility = 0
		SLHHMonitor.RegisterAlias(none, false)
		StruggleAnimCheckRace(PlayerRef, rapist, 5)
		Utility.wait(2.0)
		if viablerace == 0
			SLHHMonitor.StruggleAnim(PlayerRef, rapist, False, None, None, false)
		elseif viablerace > 0
			SLHHMonitor.StruggleAnim(PlayerRef, rapist, False, None, None, true)
		endif
		SLHHResetHeelEffect(PlayerRef)
		setstage(134)
EndFunction

Function Expression(Actor akActor, Bool Removal = false, Bool Victim = True)

If !Removal

MfgConsoleFunc.ResetPhonemeModifier(akActor) ; Remove any previous modifiers and phonemes
	Int random = Utility.RandomInt(0, 99)
	If Victim

	If random < 22

		akActor.SetExpressionOverride(14,100)	; Disgusted!
		MfgConsoleFunc.SetPhoneme(akActor,0,60)
	
	ElseIf random < 44 && random >= 22
	
		akActor.SetExpressionOverride(9,100)	; Fear!
		MfgConsoleFunc.SetModifier(akActor,0,15)
		MfgConsoleFunc.SetModifier(akActor,1,15)
		MfgConsoleFunc.SetModifier(akActor,4,70)
		MfgConsoleFunc.SetModifier(akActor,5,70)
		MfgConsoleFunc.SetPhoneme(akActor,4,30)
		MfgConsoleFunc.SetPhoneme(akActor,7,30)
		MfgConsoleFunc.SetPhoneme(akActor,11,30)
		
	ElseIf random < 66 && random >= 44

		akActor.SetExpressionOverride(8,100)	; Don't touch me! Angry
		MfgConsoleFunc.SetPhoneme(akActor,1,60)
		
	ElseIf random < 88 && random >= 66
	
		akActor.SetExpressionOverride(11,100)	; Sad! Don't!
		MfgConsoleFunc.SetModifier(akActor,0,70)
		MfgConsoleFunc.SetModifier(akActor,1,70)
		MfgConsoleFunc.SetPhoneme(akActor,11,50)
		
	Else

		akActor.SetExpressionOverride(11,100)	; Sad! Don't!
		MfgConsoleFunc.SetModifier(akActor,0,30)
		MfgConsoleFunc.SetModifier(akActor,1,30)
		MfgConsoleFunc.SetPhoneme(akActor,11,50)
	
	EndIf
	EndIf
	
	If !Victim
	
	If random < 22

		akActor.SetExpressionOverride(14,100)	; Disgusted!
		MfgConsoleFunc.SetPhoneme(akActor,0,60)
	
	ElseIf random < 44 && random >= 22
	
		akActor.SetExpressionOverride(0,100)	; Angry!
		MfgConsoleFunc.SetPhoneme(akActor,4,30)
		MfgConsoleFunc.SetPhoneme(akActor,7,30)
		
	ElseIf random < 66 && random >= 44

		akActor.SetExpressionOverride(8,100)	; Angry!!
		MfgConsoleFunc.SetPhoneme(akActor,1,60)
		
	ElseIf random < 88 && random >= 66
	
		akActor.SetExpressionOverride(6,100)	; Don't Move! Disgusted
		MfgConsoleFunc.SetPhoneme(akActor,1,30)
		
	Else

		akActor.SetExpressionOverride(8,100)
		MfgConsoleFunc.SetModifier(akActor,0,30)
		MfgConsoleFunc.SetModifier(akActor,1,30)
		MfgConsoleFunc.SetPhoneme(akActor,7,50)
	
	EndIf
	
	EndIf
	
Else
	MfgConsoleFunc.ResetPhonemeModifier(akActor) ; Remove any previous modifiers and phonemes
EndIf

Endfunction

Function ValueDiminish(Actor Victim, Actor rapist, int division)
float Vvalue = GetMaximumActorValue(Victim, GAVCustom)
float Vvalue2 = GetMaximumActorValue(Victim, GAVCustom2)
float Rvalue = GetMaximumActorValue(rapist, GAVCustom)
float Rvalue2 = GetMaximumActorValue(rapist, GAVCustom2)

Int DamageVvalue = ((Vvalue / 100) * division) as int
Int DamageVvalue2 = ((Vvalue2 / 100) * division) as int
Int DamageRvalue = ((Rvalue / 100) * division) as int
Int DamageRvalue2 = ((Rvalue2 / 100) * division) as int
int ADvalue
int ADvalue2

If DamageVvalue >= DamageRvalue
	ADvalue = DamageVvalue
Else
	ADvalue = DamageRvalue
EndIf

If DamageVvalue2 >= DamageRvalue2
	ADvalue2 = DamageVvalue2
Else
	ADvalue2 = DamageRvalue2
EndIf

Victim.DamageActorValue(GAVCustom, ADvalue)
Victim.DamageActorValue(GAVCustom2, ADvalue2)
rapist.DamageActorValue(GAVCustom, ADvalue)
rapist.DamageActorValue(GAVCustom2, ADvalue2)
EndFunction

Float Function GetMaximumActorValue(Actor akActor, String asValueName)
    ; returns the maximum value for this actor value, buffs are accounted for.
    Float BaseValue = akActor.GetBaseActorValue(asValueName)
    Float CurrentMaxValue = Math.Ceiling(akActor.GetActorValue(asValueName) / akActor.GetActorValuePercentage(asValueName))
 
    if BaseValue < CurrentMaxValue
        return BaseValue
    else
        return CurrentMaxValue
    endif
EndFunction

int Function EscapeChanceCalculation(int BaseChance, int Vlevel, int Rlevel, float Vvalue, float Rvalue)
If BaseChance == 101
	Return 100;which means it will result in 100% escape chance
ElseIf Basechance == -1
	Return 0
EndIf
int FinalEscapeChance
int FinalValue
int Dlevel = Vlevel - Rlevel
int Dvalue = ((Vvalue - Rvalue) / 10) as int
FinalEscapeChance = BaseChance


If SLHH_DamageActorValueGlobal.getvalue() == 0
	GAVCustom = "None"
	GAVCustom2 = "None"
Elseif SLHH_DamageActorValueGlobal.getvalue() == 1
	GAVCustom = "Stamina"
	GAVCustom2 = "None"
Elseif SLHH_DamageActorValueGlobal.getvalue() == 2
	GAVCustom = "Magicka"
	GAVCustom2 = "None"
Elseif SLHH_DamageActorValueGlobal.getvalue() == 3
	GAVCustom = "Stamina"
	GAVCustom2 = "Magicka"
Endif
	
	
If SLHH_ResistMethodGlobal.getvalue() == 0
	Return FinalEscapeChance
Elseif SLHH_ResistMethodGlobal.getvalue() == 1
	FinalEscapeChance += Dvalue
Elseif SLHH_ResistMethodGlobal.getvalue() == 2
	FinalEscapeChance += Dlevel
Elseif SLHH_ResistMethodGlobal.getvalue() == 3
	FinalEscapeChance += Dlevel
	FinalEscapeChance += Dvalue
Endif
	If FinalEscapeChance > 100
		FinalEscapeChance = 100
	Endif

	Return FinalEscapeChance

EndFunction

Int Function CheckHundred(int value)
If value > 100
	value = 100
	return value
else
return value
EndIf
EndFunction

;---------------------------Highheel Effect-----------------------------------

Function SLHHRemoveHeelEffect(actor ActorRef)
IsFemale = IdentifySex(ActorRef) as bool
	if IsFemale && RemoveHeelEffect && ActorRef.GetWornForm(0x00000080)
		; Remove NiOverride High Heels
		if NiOverride.HasNodeTransformPosition(ActorRef, false, true, "NPC", "internal")
			float[] pos = NiOverride.GetNodeTransformPosition(ActorRef, false, IsFemale, "NPC", "internal")
			pos[0] = -pos[0]
			pos[1] = -pos[1]
			pos[2] = -pos[2]
			NiOverride.AddNodeTransformPosition(ActorRef, false, IsFemale, "NPC", "SexLabHorribleHarassment.esp", pos)
			NiOverride.UpdateNodeTransform(ActorRef, false, IsFemale, "NPC")
		endIf
	endIf
EndFunction

Function SLHHResetHeelEffect(actor ActorRef)
	if RemoveHeelEffect && NiOverride.RemoveNodeTransformPosition(ActorRef, false, IsFemale, "NPC", "SexLabHorribleHarassment.esp")
		NiOverride.UpdateNodeTransform(ActorRef, false, IsFemale, "NPC")
	endIf
EndFunction

int Function IdentifySex(actor ActorRef)
int Sex
	Sex = ActorRef.getactorbase().getsex()
	Return Sex
EndFunction

;---------------------------SLAPP Related-----------------------------------

Function SLAPPTrigger(Actor akactor, Bool Worse = false, int Type)
Form akRef = akactor as form
if Type == 1
	If Worse
		SLAPPEventRegister(akRef, True); SLHHConsequneceWorse, Rape Success
	Else
		SLAPPEventRegister(akRef, False); SLHHConsequneceBad, Rape Failed
	EndIf
elseif Type == 2
	if SLHH_ScriptEventBC.getvalue() == 1
		If Worse
			SLAPPEventChokeNoRapeRegister(akRef, True); SLHHConsequneceWorse, Rape Success
		Else
			SLAPPEventChokeNoRapeRegister(akRef, False); SLHHConsequneceBad, Rape Failed
		EndIf
		return
	endif
	
	If Worse
		SLAPPEventChokeRegister(akRef, True); SLHHConsequneceWorse, Rape Success
	Else
		SLAPPEventChokeRegister(akRef, False); SLHHConsequneceBad, Rape Failed
	EndIf
elseif Type == 3
	If Worse
		SLAPPEventRegister(akRef, True); SLHHConsequneceWorse, Rape Success
	Else
		SLAPPEventRegister(akRef, False); SLHHConsequneceBad, Rape Failed
	EndIf
endif
EndFunction

Function SLAPPEventChokeNoRapeRegister(form akform, Bool Worse)
	int handle = ModEvent.Create("SLAPP_ConsequenceChokeNREvent")
	if (handle)
		ModEvent.PushForm(handle, akform)
		ModEvent.PushBool(handle, Worse)
		ModEvent.PushString(handle, "SLHH activated SLAPPConsequenceChokeNR")
		ModEvent.Send(handle)
	endIf
EndFunction

Function SLAPPEventChokeRegister(form akform, Bool Worse)
	int handle = ModEvent.Create("SLAPP_ConsequenceChokeEvent")
	if (handle)
		ModEvent.PushForm(handle, akform)
		ModEvent.PushBool(handle, Worse)
		ModEvent.PushString(handle, "SLHH activated SLAPPConsequenceChoke")
		ModEvent.Send(handle)
	endIf
EndFunction

Function SLAPPEventRegister(form akform, Bool Worse)
	int handle = ModEvent.Create("SLAPP_ConsequenceEvent")
	if (handle)
		ModEvent.PushForm(handle, akform)
		ModEvent.PushBool(handle, Worse)
		ModEvent.PushString(handle, "SLHH activated SLAPPConsequence")
		ModEvent.Send(handle)
	endIf
EndFunction

;---------------------------BaboDialogue Related-----------------------------------

Function BaboDialogueTrigger(Actor Raper, Bool Worse = false)
Debug.Trace("BaboDialogueTrigger Function started")
	If Worse
		BaboDialogueEventRegister(Raper, True); SLHHConsequneceWorse, Rape Success
	;	Debug.notification("Worse")
	Else
		BaboDialogueEventRegister(Raper, False); SLHHConsequneceBad, Rape Failed
	;	Debug.notification("Worse false")
	EndIf
EndFunction

Function BaboDialogueEventRegister(Actor Raper, Bool Worse)
	String RaperName = Raper.getactorbase() as string
	;Debug.Notification(RaperName + " raped Player")
	Debug.Trace(Raper.getactorbase() + " raped Player" + Worse as Bool)
	int handle = ModEvent.Create("BaboDialogue_ConsequenceEvent")
	Form Raperform = Raper as form
	if (handle)
		ModEvent.Pushform(handle, Raper)
		ModEvent.PushBool(handle, Worse)
		ModEvent.PushString(handle, "SLHH activated BaboDialogueConsequence")
		ModEvent.Send(handle)
	endIf
EndFunction