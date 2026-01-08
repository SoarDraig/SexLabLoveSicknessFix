Scriptname SLAppExcludeFactionScript extends ActiveMagicEffect  

Faction Property slapp_NoMoreApproach Auto
Quest Property SLApproach_Config Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akTarget.isinfaction(slapp_NoMoreApproach)
		akTarget.removefromfaction(slapp_NoMoreApproach)
		(SLApproach_Config as slapproachconfigscript).ApproachSpellMessage(akTarget, false)
	else
		akTarget.setfactionrank(slapp_NoMoreApproach, 1)
		(SLApproach_Config as slapproachconfigscript).ApproachSpellMessage(akTarget, true)
	endif
EndEvent