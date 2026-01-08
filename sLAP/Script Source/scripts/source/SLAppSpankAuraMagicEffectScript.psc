Scriptname SLAppSpankAuraMagicEffectScript extends ActiveMagicEffect  

Quest Property SLApproachAskForSexQuest Auto
Actor Property PlayerRef Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	(SLApproachAskForSexQuest as SLAppPCSexQuestScript).HeSpanked(akTarget)
	Game.EnablePlayerControls()
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	(SLApproachAskForSexQuest as SLAppPCSexQuestScript).SpankTimeOut(akTarget)
EndEvent