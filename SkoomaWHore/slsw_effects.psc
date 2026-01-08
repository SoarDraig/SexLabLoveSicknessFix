Scriptname SLSW_Effects extends Quest  

SLSW_mcmconfig property MCM auto
SexLabFramework Property SexLab auto

MagicEffect property WithdrawalSuppression auto

Idle Property idleStop_Loose auto
Idle Property BleedOutStart auto
Idle Property BleedOutStop auto
Idle Property IdleDrinkPotion auto

GlobalVariable Property SLSW_AddictionIndicator auto

ImageSpaceModifier Property slsw_BlurryISM auto

Actor Property PlayerRef auto 

Formlist Property SLSW_DrugsWOcure Auto

Keyword zad_DeviousYoke = none
Keyword zad_DeviousArmbinder = none

Event OnInit()
	RegisterForUpdateGameTime(MCM.EffectInterval)
	zad_DeviousArmbinder = Keyword.GetKeyword("zad_DeviousArmbinder")
	zad_DeviousYoke = Keyword.GetKeyword("zad_DeviousYoke") 
EndEvent

Event OnUpdateGameTime()
	Utility.Wait(0.1)
	If MCM.Effects == True && SLSW_AddictionIndicator.getValue() >= 3 && !PlayerRef.HasMagicEffect(WithdrawalSuppression)
		slsw_BlurryISM.apply(1.0)
		Utility.Wait(3)
		If !Sexlab.IsActorActive(PlayerRef) && !IsPlayerBound() && !PlayerRef.IsInCombat() && !PlayerRef.IsOnMount() && !PlayerRef.IsSwimming() && PlayerRef.GetDialogueTarget() == none
			If Utility.RandomInt(1,100) < 60 && IsPlayerCarrying()
				;Drink
				int i = SLSW_DrugsWOcure.GetSize()
				Form[] Stash
				while i > 0
					i -=1 
					if PlayerRef.GetItemCount(SLSW_DrugsWOcure.GetAt(i) as Potion)
						Stash = sslUtility.PushForm(SLSW_DrugsWOcure.GetAt(i), Stash)
					endif
				endwhile
				i = Stash.Length - 1
				PlayerRef.EquipItem(Stash[Utility.RandomInt(0, i)] as Potion)
				PlayerRef.SheatheWeapon()
				PlayerRef.PlayIdle(idleStop_Loose)
				PlayerRef.PlayIdle(IdleDrinkPotion)
			else
				;Trip
				PlayerRef.PlayIdle(idleStop_Loose)
				PlayerRef.PlayIdle(BleedOutStart)
				Utility.Wait(2)
				PlayerRef.PlayIdle(BleedOutStop)
			EndIf
		EndIf
	EndIF
EndEvent

bool function IsPlayerCarrying()  
	return (PlayerRef.GetItemCount(SLSW_DrugsWOcure) > 0)
endfunction

bool function IsPlayerBound()
	return ( PlayerRef.WornHasKeyword(zad_DeviousArmbinder) || PlayerRef.WornHasKeyword(zad_DeviousYoke) || !Game.IsActivateControlsEnabled() )
endfunction

Function EffectsOff()
	UnregisterForUpdateGameTime()
EndFunction

Function EffectsOn()
	zad_DeviousArmbinder = Keyword.GetKeyword("zad_DeviousArmbinder")
	zad_DeviousYoke = Keyword.GetKeyword("zad_DeviousYoke")
	RegisterForUpdateGameTime(MCM.EffectInterval)
EndFunction