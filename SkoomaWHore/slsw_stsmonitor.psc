Scriptname SLSW_STSmonitor extends activemagiceffect  

GlobalVariable Property DrugPool  Auto
SLSW_mcmConfig Property MCM  Auto  
SPELL Property AS1  Auto
SPELL Property AS2  Auto
SPELL Property AS3  Auto
SPELL Property AS4  Auto
SPELL Property AS5  Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

Actor Player = Game.GetPlayer()

float CurrentValue = DrugPool.getValue()
CurrentValue += 5
DrugPool.setValue(CurrentValue)
float NewValue = DrugPool.getValue()

If Player.HasSpell(AS1)

	If MCM.speed == "Fast"
		If NewValue >= 70
			Player.RemoveSpell(AS1)
			Player.AddSpell(AS2)
		endif
	elseif MCM.speed == "Medium"
		If NewValue >= 140
			Player.RemoveSpell(AS1)
			Player.AddSpell(AS2)
		endif	
	else
		If NewValue >= 210
			Player.RemoveSpell(AS1)
			Player.AddSpell(AS2)
		endif
	endif

elseif Player.HasSpell(AS2)

	If MCM.speed == "Fast"
		If NewValue >= 120
			Player.RemoveSpell(AS2)
			Player.AddSpell(AS3)
		endif
	elseif MCM.speed == "Medium"
		If NewValue >= 240
			Player.RemoveSpell(AS2)
			Player.AddSpell(AS3)
		endif	
	else
		If NewValue >= 360
			Player.RemoveSpell(AS2)
			Player.AddSpell(AS3)
		endif
	endif

elseif Player.HasSpell(AS3)

	If MCM.speed == "Fast"
		If NewValue >= 180
			Player.RemoveSpell(AS3)
			Player.AddSpell(AS4)
		endif
	elseif MCM.speed == "Medium"
		If NewValue >= 360
			Player.RemoveSpell(AS3)
			Player.AddSpell(AS4)
		endif	
	else
		If NewValue >= 540
			Player.RemoveSpell(AS3)
			Player.AddSpell(AS4)
		endif
	endif

elseif Player.HasSpell(AS4)

	If MCM.speed == "Fast"
		If NewValue >= 250
			Player.RemoveSpell(AS4)
			Player.AddSpell(AS5)
		endif
	elseif MCM.speed == "Medium"
		If NewValue >= 500
			Player.RemoveSpell(AS4)
			Player.AddSpell(AS5)
		endif	
	else
		If NewValue >= 750
			Player.RemoveSpell(AS4)
			Player.AddSpell(AS5)
		endif
	endif

elseif Player.HasSpell(AS5)

	; there is no Stage 6

else

	If MCM.speed == "Fast"
		If NewValue >= 30
			Player.AddSpell(AS1)
		endif
	elseif MCM.speed == "Medium"
		If NewValue >= 60
			Player.AddSpell(AS1)
		endif	
	else
		If NewValue >= 90
			Player.AddSpell(AS1)
		endif
	endif

endif

EndEvent
