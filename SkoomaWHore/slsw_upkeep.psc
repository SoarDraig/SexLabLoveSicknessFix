Scriptname SLSW_Upkeep extends Quest  

SexLabFramework Property SexLab  Auto
GlobalVariable Property LastCheck  Auto  
GlobalVariable Property DrugPool_pd  Auto
GlobalVariable Property DrugPool_md  Auto
GlobalVariable Property DrugPool_mkd  Auto
GlobalVariable Property SLSW_install  Auto
GlobalVariable Property SLSW_AddictionIndicator  Auto
SLSW_mcmConfig Property MCM auto
SLSW_scum Property scum auto
SPELL Property slsw_ISMRemovalSpell auto
SPELL Property pd1 auto
SPELL Property pd2 auto
SPELL Property pd3 auto
SPELL Property pd4 auto
SPELL Property pd5 auto
SPELL Property md1 auto
SPELL Property md2 auto
SPELL Property md3 auto
SPELL Property md4 auto
SPELL Property md5 auto
SPELL Property mkd1 auto
SPELL Property mkd2 auto
SPELL Property mkd3 auto
SPELL Property mkd4 auto
SPELL Property mkd5 auto
Potion Property Skooma auto
Potion Property RoseOfAzura auto
Potion Property BoethiasDeception auto
Potion Property ThiefsDelight auto
Potion Property TheSecondBrain auto
Potion Property ElendrsFlask auto
Potion Property TheContortionist auto
Potion Property MorgulsTouch auto
Potion Property ToughFlesh auto
Potion Property OcatosPallatine auto
Potion Property MagesFriend auto
Potion Property TheArchMage auto
Potion Property VerminasPrice auto
Potion Property LeafSkooma auto
Potion Property SleepingTreeSap auto
Potion Property HerbTea auto
Potion Property PurifingSolution auto
Potion Property DDSkooma auto
Faction Property CreatureFaction  auto
Race Property HorseRace  auto

Keyword Property ActorTypeNPC Auto

Actor PlayerRef

Event OnInit()

PlayerRef = Game.GetPlayer()
RegisterForModEvent("AnimationEnd", "ForcedDrugging")
If (SLSW_install.getValue() as int) == 0
	LastCheck.setValue(Utility.GetCurrentGameTime())
	Debug.Notification("Skooma Whore has been installed")
	SLSW_install.setValue(1)
endif
EndEvent

Function OnGameLoad() ;Called by OnPlayerLoadGame on SLSWscum.psc
	If !PlayerRef
		PlayerRef = Game.GetPlayer()
	Endif
EndFunction

Event OnUpdateGameTime()
Utility.Wait(0.1)
float time = Utility.GetCurrentGameTime()
float LastTime = LastCheck.getValue()
float TimePassed = ((time - LastTime)*24)
float RecoverFactor = (TimePassed/3)

float ModifiedValue_pd = DrugPool_pd.getValue()
ModifiedValue_pd -= (((MCM.reduce/24)*3)*RecoverFactor)

If TimePassed >= 3
	If ModifiedValue_pd <= 0
		DrugPool_pd.setValue(0)
	else
		DrugPool_pd.setValue(ModifiedValue_pd)
	endif
endif

float ModifiedValue_md = DrugPool_md.getValue()
ModifiedValue_md -= (((MCM.reduce/24)*3)*RecoverFactor)

If TimePassed >= 3
	If ModifiedValue_md <= 0
		DrugPool_md.setValue(0)
	else
		DrugPool_md.setValue(ModifiedValue_md)
	endif
endif

float ModifiedValue_mkd = DrugPool_mkd.getValue()
ModifiedValue_mkd -= (((MCM.reduce/24)*3)*RecoverFactor)

If TimePassed >= 3
	If ModifiedValue_mkd <= 0
		DrugPool_mkd.setValue(0)
	else
		DrugPool_mkd.setValue(ModifiedValue_mkd)
	endif
endif

LastCheck.setValue(time)

getclean(DrugPool_pd.getValue(), pd1, pd2, pd3, pd4, pd5)
getclean(DrugPool_md.getValue(), md1, md2, md3, md4, md5)
getclean(DrugPool_mkd.getValue(), mkd1, mkd2, mkd3, mkd4, mkd5)

UpdateIndicator()

EndEvent

Event ForcedDrugging(string eventName, string argString, float argNum, form sender)

actor victim = SexLab.HookVictim(argString)
actor[] actorList = SexLab.HookActors(argString)

if victim == PlayerRef && !(StorageUtil.GetIntValue(PlayerRef, "xpoPCArrestStart") || StorageUtil.GetIntValue(PlayerRef, "xpoPCArrested") || StorageUtil.GetIntValue(PlayerRef, "xpoPCinJail"))

	if actorlist[1].HasKeyword(ActorTypeNPC)  ;actorlist[1].IsInFaction(CreatureFaction) == false && actorlist[1].getRace() != HorseRace
		If MCM.forcefeed == true && Utility.RandomInt(1,100) <= MCM.forcefeedchance

			int Drug = Utility.RandomInt(1,14)

		if Drug == 1
			PlayerRef.EquipItem(Skooma)
		elseif Drug == 2
			PlayerRef.EquipItem(RoseOfAzura )
		elseif Drug == 3
			PlayerRef.EquipItem(BoethiasDeception )
		elseif Drug == 4
			PlayerRef.EquipItem(ThiefsDelight )
		elseif Drug == 5
			PlayerRef.EquipItem(TheSecondBrain )
		elseif Drug == 6
			PlayerRef.EquipItem(ElendrsFlask )
		elseif Drug == 7
			PlayerRef.EquipItem(TheContortionist )
		elseif Drug == 8
			PlayerRef.EquipItem(MorgulsTouch )
		elseif Drug == 9
			PlayerRef.EquipItem(OcatosPallatine )
		elseif Drug == 10
			PlayerRef.EquipItem(MagesFriend )
		elseif Drug == 11
			PlayerRef.EquipItem(TheArchMage )
		elseif Drug == 12
			PlayerRef.EquipItem(VerminasPrice )
		elseif Drug == 13
			PlayerRef.EquipItem(LeafSkooma )
		else	
			PlayerRef.EquipItem(DDSkooma )
		endif
		EndIf
	EndIf
EndIf

EndEvent

function getclean(float NewValue, SPELL AS1, SPELL AS2, SPELL AS3, SPELL AS4, SPELL AS5)

If PlayerRef.HasSpell(AS1)
		
	If MCM.speed == "Fast"
		If NewValue < 30
			PlayerRef.RemoveSpell(AS1)
			Return
		endif
	elseif MCM.speed == "Medium"
		If NewValue < 60
			PlayerRef.RemoveSpell(AS1)
			Return
		endif	
	else
		If NewValue < 90
			PlayerRef.RemoveSpell(AS1)
			Return
		endif
	endif
		
elseif PlayerRef.HasSpell(AS2)

	If MCM.speed == "Fast"
		If NewValue < 70
			PlayerRef.RemoveSpell(AS2)
			PlayerRef.AddSpell(AS1)
			Return
		endif
	elseif MCM.speed == "Medium"
		If NewValue < 140
			PlayerRef.RemoveSpell(AS2)
			PlayerRef.AddSpell(AS1)
			Return
		endif	
	else
		If NewValue < 210
			PlayerRef.RemoveSpell(AS2)
			PlayerRef.AddSpell(AS1)
			Return
		endif
	endif

elseif PlayerRef.HasSpell(AS3)

	If MCM.speed == "Fast"
		If NewValue < 120
			PlayerRef.RemoveSpell(AS3)
			PlayerRef.AddSpell(AS2)
			Return
		endif
	elseif MCM.speed == "Medium"
		If NewValue < 240
			PlayerRef.RemoveSpell(AS3)
			PlayerRef.AddSpell(AS2)
			Return
		endif	
	else
		If NewValue < 360
			PlayerRef.RemoveSpell(AS3)
			PlayerRef.AddSpell(AS2)
			Return
		endif
	endif

elseif PlayerRef.HasSpell(AS4)

	If MCM.speed == "Fast"
		If NewValue < 180
			PlayerRef.RemoveSpell(AS4)
			PlayerRef.AddSpell(AS3)
			Return
		endif
	elseif MCM.speed == "Medium"
		If NewValue < 360
			PlayerRef.RemoveSpell(AS4)
			PlayerRef.AddSpell(AS3)
			Return
		endif	
	else
		If NewValue >= 540
			PlayerRef.RemoveSpell(AS4)
			PlayerRef.AddSpell(AS3)
			Return
		endif
	endif

elseif PlayerRef.HasSpell(AS5)

	If MCM.speed == "Fast"
		If NewValue < 250
			PlayerRef.RemoveSpell(AS5)
			PlayerRef.AddSpell(AS4)
			Return
		endif
	elseif MCM.speed == "Medium"
		If NewValue < 500
			PlayerRef.RemoveSpell(AS5)
			PlayerRef.AddSpell(AS4)
			Return
		endif	
	else
		If NewValue < 750
			PlayerRef.RemoveSpell(AS5)
			PlayerRef.AddSpell(AS4)
			Return
		endif
	endif

endif

endfunction

function drugged(float NewValue, SPELL AS1, SPELL AS2, SPELL AS3, SPELL AS4)

	If MCM.speed == "Fast"
		If NewValue < 70
			AS1.Cast(PlayerRef, PlayerRef)
			Return
		elseif NewValue >= 70 && NewValue < 120
			AS2.Cast(PlayerRef, PlayerRef)
			Return
		elseif NewValue >= 120 && NewValue < 180
			AS3.Cast(PlayerRef, PlayerRef)
			Return
		elseif NewValue >= 180 && NewValue < 250
			AS4.Cast(PlayerRef, PlayerRef)
			Return
		else
			AS4.Cast(PlayerRef, PlayerRef)
			Return
		endif
	
	elseif MCM.speed == "Medium"
		If NewValue < 140
			AS1.Cast(PlayerRef, PlayerRef)
			Return
		elseif NewValue >= 140 && NewValue < 240
			AS2.Cast(PlayerRef, PlayerRef)
			Return
		elseif NewValue >= 240 && NewValue < 360	
			AS3.Cast(PlayerRef, PlayerRef)
			Return
		elseif NewValue >= 360 && NewValue < 500
			AS4.Cast(PlayerRef, PlayerRef)
			Return
		else
			AS4.Cast(PlayerRef, PlayerRef)
			Return
		endif

	else
		If NewValue < 210
			AS1.Cast(PlayerRef, PlayerRef)
			Return
		elseif NewValue >= 210 && NewValue < 360
			AS2.Cast(PlayerRef, PlayerRef)
			Return
		elseif NewValue >= 360 && NewValue < 540	
			AS3.Cast(PlayerRef, PlayerRef)
			Return
		elseif NewValue >= 540 && NewValue < 750
			AS4.Cast(PlayerRef, PlayerRef)
			Return
		else
			AS4.Cast(PlayerRef, PlayerRef)
			Return
		endif

	endif
endfunction

function suppression_pd(float NewValue)

PlayerRef.RemoveSpell(pd1)
PlayerRef.RemoveSpell(pd2)
PlayerRef.RemoveSpell(pd3)
PlayerRef.RemoveSpell(pd4)
PlayerRef.RemoveSpell(pd5)
endfunction

function suppression_md(float NewValue)

PlayerRef.RemoveSpell(md1)
PlayerRef.RemoveSpell(md2)
PlayerRef.RemoveSpell(md3)
PlayerRef.RemoveSpell(md4)
PlayerRef.RemoveSpell(md5)
endfunction

function suppression_mkd(float NewValue)

PlayerRef.RemoveSpell(mkd1)
PlayerRef.RemoveSpell(mkd2)
PlayerRef.RemoveSpell(mkd3)
PlayerRef.RemoveSpell(mkd4)
PlayerRef.RemoveSpell(mkd5)
endfunction

function withdrawal(float NewValue, SPELL AS1, SPELL AS2, SPELL AS3, SPELL AS4, SPELL AS5)

	If MCM.speed == "Fast"
		If NewValue >= 30 && NewValue < 70
			PlayerRef.AddSpell(AS1)
			Return
		elseif NewValue >= 70 && NewValue < 120
			PlayerRef.AddSpell(AS2)
			Return
		elseif NewValue >= 120 && NewValue < 180
			PlayerRef.AddSpell(AS3)
			Return
		elseif NewValue >= 180 && NewValue < 250
			PlayerRef.AddSpell(AS4)
			Return
		elseif NewValue >= 250
			PlayerRef.AddSpell(AS5)
			Return
		endif
	
	elseif MCM.speed == "Medium"
		If NewValue >= 60 && NewValue < 140
			PlayerRef.AddSpell(AS1)
			Return
		elseif NewValue >= 140 && NewValue < 240
			PlayerRef.AddSpell(AS2)
			Return
		elseif NewValue >= 240 && NewValue < 360	
			PlayerRef.AddSpell(AS3)
			Return
		elseif NewValue >= 360 && NewValue < 500
			PlayerRef.AddSpell(AS4)
			Return
		elseif NewValue >= 500
			PlayerRef.AddSpell(AS5)
			Return
		endif

	else
		If NewValue >= 90 && NewValue < 210
			PlayerRef.AddSpell(AS1)
			Return
		elseif NewValue >= 210 && NewValue < 360
			PlayerRef.AddSpell(AS2)
			Return
		elseif NewValue >= 360 && NewValue < 540	
			PlayerRef.AddSpell(AS3)
			Return
		elseif NewValue >= 540 && NewValue < 750
			PlayerRef.AddSpell(AS4)
			Return
		elseif NewValue >= 750
			PlayerRef.AddSpell(AS5)
			Return
		endif
endif
endfunction

function UpdateIndicator()
float[] DrugPools = new float[3]
DrugPools[0] = DrugPool_pd.getValue()
DrugPools[1] = DrugPool_md.getValue()
DrugPools[2] = DrugPool_mkd.getValue()

SortPool(DrugPools)

float DecisivePool = DrugPools[2]

	If MCM.speed == "Fast"
		If DecisivePool < 30
			SLSW_AddictionIndicator.setValue(0)
			Return
		elseif DecisivePool >= 30 && DecisivePool < 70
			SLSW_AddictionIndicator.setValue(1)
			Return
		elseif DecisivePool >= 70 && DecisivePool < 120
			SLSW_AddictionIndicator.setValue(2)
			Return
		elseif DecisivePool >= 120 && DecisivePool < 180
			SLSW_AddictionIndicator.setValue(3)
			Return
		elseif DecisivePool >= 180 && DecisivePool < 250
			SLSW_AddictionIndicator.setValue(4)
			Return
		elseif DecisivePool >= 250
			SLSW_AddictionIndicator.setValue(5)
			Return
		endif
	
	elseif MCM.speed == "Medium"
		If DecisivePool < 60
			SLSW_AddictionIndicator.setValue(0)
			Return
		elseif DecisivePool >= 60 && DecisivePool < 140
			SLSW_AddictionIndicator.setValue(1)
			Return
		elseif DecisivePool >= 140 && DecisivePool < 240
			SLSW_AddictionIndicator.setValue(2)
			Return
		elseif DecisivePool >= 240 && DecisivePool < 360	
			SLSW_AddictionIndicator.setValue(3)
			Return
		elseif DecisivePool >= 360 && DecisivePool < 500
			SLSW_AddictionIndicator.setValue(4)
			Return
		elseif DecisivePool >= 500
			SLSW_AddictionIndicator.setValue(5)
			Return
		endif

	else
		If DecisivePool < 90
			SLSW_AddictionIndicator.setValue(0)
			Return
		elseif DecisivePool >= 90 && DecisivePool < 210
			SLSW_AddictionIndicator.setValue(1)
			Return
		elseif DecisivePool >= 210 && DecisivePool < 360
			SLSW_AddictionIndicator.setValue(2)
			Return
		elseif DecisivePool >= 360 && DecisivePool < 540	
			SLSW_AddictionIndicator.setValue(3)
			Return
		elseif DecisivePool >= 540 && DecisivePool < 750
			SLSW_AddictionIndicator.setValue(4)
			Return
		elseif DecisivePool >= 750
			SLSW_AddictionIndicator.setValue(5)
			Return
		endif
	endif

endfunction

function SortPool(float[] MyArray)
Int Index1
Int Index2 = MyArray.Length - 1
 
	While (Index2 > 0)
		Index1 = 0
		While (Index1 < Index2)
			If (MyArray [Index1] > MyArray [Index1 + 1])
				Float SwapDummy = MyArray [Index1]
				MyArray [Index1] = MyArray [Index1 + 1]
				MyArray [Index1 + 1] = SwapDummy
			EndIf
			Index1 += 1
		EndWhile
		Index2 -= 1
	EndWhile

EndFunction

Function RemoveAllDrugs()
	PlayerRef.removeItem(Skooma, 1000)
	PlayerRef.removeItem(RoseOfAzura, 1000)
	PlayerRef.removeItem(BoethiasDeception, 1000)
	PlayerRef.removeItem(ThiefsDelight, 1000)
	PlayerRef.removeItem(TheSecondBrain, 1000)
	PlayerRef.removeItem(ElendrsFlask, 1000)
	PlayerRef.removeItem(TheContortionist, 1000)
	PlayerRef.removeItem(MorgulsTouch, 1000)
	PlayerRef.removeItem(ToughFlesh, 1000)
	PlayerRef.removeItem(OcatosPallatine, 1000)
	PlayerRef.removeItem(MagesFriend, 1000)
	PlayerRef.removeItem(TheArchMage, 1000)
	PlayerRef.removeItem(VerminasPrice, 1000)
	PlayerRef.removeItem(LeafSkooma, 1000)
	PlayerRef.removeItem(DDSkooma, 1000)
	PlayerRef.removeItem(SleepingTreeSap, 1000)
return
endfunction

Event OnSleepStop(bool abInterrupted)
slsw_ISMRemovalSpell.Cast(PlayerRef, PlayerRef)
Scum.SleepItOff()
EndEvent