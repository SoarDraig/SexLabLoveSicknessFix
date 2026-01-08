Scriptname SLAppFoodToxicAuraMagicEffectScript extends ActiveMagicEffect  

Int Property iToxic Auto
{1: Cum 2: Sleeping Drug}
Quest Property SLApproachAskForSexQuest Auto

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	(SLApproachAskForSexQuest as SLAppPCSexQuestScript).FoodToxicTimeOut(akTarget, iToxic)
EndEvent