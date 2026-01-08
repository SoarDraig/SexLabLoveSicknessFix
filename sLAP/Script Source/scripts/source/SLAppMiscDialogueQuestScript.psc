Scriptname SLAppMiscDialogueQuestScript extends Quest  

SLAppPCSexQuestScript property SLApproachPC auto
SLApproachMainScript property SLApproachMain auto
Actor Property PlayerRef Auto
formlist Property SLAPPAlcoholicDrinksList Auto

Function StartDialogue(Actor akactor, int SceneNum)
	SLApproachPC.StopScene()
	Utility.Wait(1.0)
	SLApproachPC.ChanceRollMisc(akactor, PlayerRef, SLApproachMain.baseChanceMultiplier, SceneNum)
EndFunction

Function StopDialogue(Actor akactor)
	SLApproachPC.NothingEnd(akactor)
EndFunction

Function GetAcquainted(Actor akactor, Bool HadSex)
	SLApproachPC.AcquaintanceForce(akactor, HadSex)
EndFunction

Function GuardSLHHTest(Actor akactor)
	;SLApproachPC.GuardSLHHChoke(akactor)
	;SLApproachPC.ShotaSex(akactor, false)
	SLApproachPC.SimpleForcereference(akactor)
	SLApproachPC.SuckBreastsStart(akactor)
EndFunction

Function EscapePrivateRoom(actor akactor)
	SLApproachPC.GotoPrivateRoom(akactor, false)
EndFunction

Function SweetKiss(actor akactor, int style)
	SLApproachPC.StartSweetKiss(akactor, style)
EndFunction

Function GiveDrink(Actor akactor)
If akactor.ShowGiftMenu(True, SLAPPAlcoholicDrinksList, abShowStolenItems = true) > 0
	SLApproachPC.AcquaintancePlus(akactor, True, False)
;pFavorSimpleDrunksSceneKeyword.SendStoryEvent(akactor)
else
	SLApproachPC.NothingEnd(akactor)
EndIf
EndFunction