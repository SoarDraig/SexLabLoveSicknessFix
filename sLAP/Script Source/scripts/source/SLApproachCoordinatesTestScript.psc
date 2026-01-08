Scriptname SLApproachCoordinatesTestScript extends ActiveMagicEffect  

Quest Property SLApproach_Main Auto
Actor Property SLAPPMaleTestRef Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	(SLApproach_Main as SLApproachBaseQuestScript).AcyclePairedMotion(SLAPPMaleTestRef, 0, -54, -27, 1)
EndEvent
