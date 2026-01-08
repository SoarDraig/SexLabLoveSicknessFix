Scriptname SLAppMolestAuraMagicEffectScript extends ActiveMagicEffect  


Quest Property SLApproachAskForSexQuest Auto
Actor Property PlayerRef Auto

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	(SLApproachAskForSexQuest as SLAppPCSexQuestScript).MolestTimeOut(akTarget)
EndEvent