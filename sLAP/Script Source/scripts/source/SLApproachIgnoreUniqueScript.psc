Scriptname SLApproachIgnoreUniqueScript extends ActiveMagicEffect  

Quest Property SLApproachAskForSexQuest Auto
Faction Property slapp_Characterfaction Auto
Faction Property slapp_IgnoreUniqueFaction Auto
Message Property SLAPP_SetCharacterMsg Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
;Debug.notification("SLAPP Ignore Unique Script")
;if !akTarget.isinfaction(slapp_IgnoreUniqueFaction)
	akTarget.addtofaction(slapp_IgnoreUniqueFaction)

	int characterint
	int choice = SLAPP_SetCharacterMsg.Show()

	if (choice == 0)
		characterint = 0
	Elseif (choice == 1)
		characterint = 1
	Elseif (choice == 2)
		characterint = 2
	elseif (choice == 3)
		characterint = 3
	elseif (choice == 4)
		(SLApproachAskForSexQuest as SLAppPCSexQuestScript).SetCharacter(akTarget)
	Endif

akTarget.setfactionrank(slapp_Characterfaction, characterint)

;endif

EndEvent