Scriptname SLAPPPrivateRoomDoorScript extends ObjectReference  

SLAppPCSexQuestScript property SLApproachPC auto
SLApproachMainScript property SLApproachMain auto
Actor Property PlayerRef Auto
Message Property SLAPP_PrivateRoomDoorMsg Auto
Message Property SLAPP_PrivateRoomDoorOutMsg Auto
ReferenceAlias Property talkingActor Auto

Event Onactivate(ObjectReference akActionRef)
if SLApproachPC.PCApproachOngoing
	SLAPP_PrivateRoomDoorMsg.show()
else
	int choice = SLAPP_PrivateRoomDoorOutMsg.show()
	if choice == 0
		SLApproachPC.GotoPrivateRoom(talkingActor.getreference() as actor, false)
	else
		;Nothing
	endif
endif
EndEvent