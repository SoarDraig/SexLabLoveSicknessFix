Scriptname SLSW_EnterBrothel extends ObjectReference  

Quest Property SLSW_Bordell Auto

Event OnTriggerEnter(ObjectReference akActionRef)

If akActionRef == Game.GetPlayer() && SLSW_Bordell.getStage() == 10

SLSW_Bordell.setStage(20)

endif

EndEvent

Event OnTriggerLeave(ObjectReference akActionRef)

If akActionRef == Game.GetPlayer() && SLSW_Bordell.getStage() >= 20

; Debug.Notification("Player Left Triggerbox")

SLSW_Bordell.reset()
SLSW_Bordell.setStage(10)

endif

EndEvent