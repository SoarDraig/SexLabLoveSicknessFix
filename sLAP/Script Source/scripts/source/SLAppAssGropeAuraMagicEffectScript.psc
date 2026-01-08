Scriptname SLAppAssGropeAuraMagicEffectScript extends ActiveMagicEffect  

Quest Property SLApproachAskForSexQuest Auto
Actor Property PlayerRef Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	(SLApproachAskForSexQuest as SLAppPCSexQuestScript).HeAssGroped(akTarget)
	Game.EnablePlayerControls()
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	(SLApproachAskForSexQuest as SLAppPCSexQuestScript).AssGropeTimeOut(akTarget)
EndEvent