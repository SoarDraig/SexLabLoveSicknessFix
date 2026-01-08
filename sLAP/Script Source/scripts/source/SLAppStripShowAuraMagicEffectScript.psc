Scriptname SLAppStripShowAuraMagicEffectScript extends ActiveMagicEffect  

Quest Property SLApproachAskForSexQuest Auto
Actor Property PlayerRef Auto
Bool Property TouchPussy = false Auto
Bool Property TouchBoobs = false Auto
Bool Property StripShow = false Auto
Bool Property PlayPussy = false Auto
Bool Property SuckPussy = false Auto
Bool Property SuckBoobs = false Auto
Event OnEffectFinish(Actor akTarget, Actor akCaster)
	if StripShow
		(SLApproachAskForSexQuest as SLAppPCSexQuestScript).StripShowTimeOut(akTarget)
		return
	endif

	if TouchBoobs
		(SLApproachAskForSexQuest as SLAppPCSexQuestScript).TouchBreastsTimeOut(akTarget)
		return
	endif


	if SuckBoobs
		(SLApproachAskForSexQuest as SLAppPCSexQuestScript).SuckBreastsTimeOut(akTarget)
		return
	endif

	if TouchPussy
		(SLApproachAskForSexQuest as SLAppPCSexQuestScript).TouchPussyTimeOut(akTarget)
		return
	endif

	if PlayPussy
		(SLApproachAskForSexQuest as SLAppPCSexQuestScript).PlayPussyTimeOut(akTarget)
		return
	endif

	if SuckPussy
		(SLApproachAskForSexQuest as SLAppPCSexQuestScript).SuckPussyTimeOut(akTarget)
		return
	endif
EndEvent