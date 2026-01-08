Scriptname slsw_HerbTeaMonitor extends activemagiceffect  

Actor Property PlayerRef Auto
Spell Property SLSW_HerbTeaSpell Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If akTarget.HasSpell(SLSW_HerbTeaSpell)
		akTarget.RemoveSpell(SLSW_HerbTeaSpell)
		Utility.WaitMenuMode(0.5)
	Endif
	akTarget.AddSpell(SLSW_HerbTeaSpell, false)
EndEvent
