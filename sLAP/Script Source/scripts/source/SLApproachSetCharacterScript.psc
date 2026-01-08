Scriptname SLApproachSetCharacterScript extends ActiveMagicEffect  

Quest Property SLApproachAskForSexQuest Auto
Faction Property slapp_Characterfaction Auto
Faction Property slapp_IgnoreUniqueFaction Auto
Message Property SLAPP_SetCharacterMsg Auto
Message Property SLAPP_ReSetCharacterMsg Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int characterint
	int choice

	if akTarget.isinfaction(slapp_Characterfaction)
		choice = SLAPP_ReSetCharacterMsg.Show()
		if (choice == 0)
			akTarget.removefromfaction(slapp_Characterfaction)
			(SLApproachAskForSexQuest as SLAppPCSexQuestScript).SetTraits(akTarget, 0, 0, true)
		Elseif (choice == 1)
			return
		endif
	else
	choice = SLAPP_SetCharacterMsg.Show()

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
		return
	Endif

akTarget.setfactionrank(slapp_Characterfaction, characterint)

	endif

EndEvent