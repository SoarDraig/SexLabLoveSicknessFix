Scriptname SLSW_RLtrigger extends ObjectReference  

Quest Property RedlightQuest Auto

Event OnTriggerEnter(ObjectReference akActionRef)
if (RedlightQuest.GetStage() == 10) && (akActionRef == Game.GetPlayer())
	RedlightQuest.SetStage(15)
endif
EndEvent