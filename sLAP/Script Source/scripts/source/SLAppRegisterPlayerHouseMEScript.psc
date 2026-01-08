Scriptname SLAppRegisterPlayerHouseMEScript extends ActiveMagicEffect  

Keyword Property LocTypePlayerHouse auto
Actor Property PlayerRef auto
Quest Property SLApproachRegisterPlayerHouse Auto


Event OnEffectStart(Actor akTarget, Actor akCaster)
If PlayerRef.GetCurrentLocation().HasKeyword(LocTypePlayerHouse)
	(SLApproachRegisterPlayerHouse as SLAppRegisterPlayerHouseScript).RegisterCustomHouseStart()
else
	Debug.Notification("Sexlab Approach: It should be Player's house to register")
endif

EndEvent
