Scriptname SLAppRegisterPlayerHouseScript extends Quest  

Message Property SLAPP_DisableCustomHouseMsg Auto
ReferenceAlias Property CustomHouseXmarkerRef Auto
ReferenceAlias Property CenterLocationMarker Auto
ReferenceAlias Property CustomPlayerHouseDoorRef Auto;Just  in case
ReferenceAlias Property HouseMainDoorRef Auto
ReferenceAlias Property PlayerHouseCOC Auto
Formlist Property SLApproachCustomPlayerHouseList Auto
Keyword Property LocTypePlayerHouse auto
ObjectReference[] Property SLAPCustomPlayerHouseXmarker Auto
ObjectReference Property SLAPCustomMarkersPoint Auto

Actor Property PlayerRef Auto

Function RegisterCustomHouseStart()

Start()
Utility.wait(1.0)
if CustomHouseXmarkerRef.getreference()
	Debug.Notification("$SLAPPHouseRegisterAlreadyFilled")
	int choice = SLAPP_DisableCustomHouseMsg.show()
	
	if choice == 0
		CustomHouseXmarkerRef.getreference().moveto(SLAPCustomMarkersPoint)
		SLApproachCustomPlayerHouseList.RemoveAddedForm(CustomHouseXmarkerRef.getreference())
	endif

	Reset()
	stop()
	Return;already registered
endif
	
if CenterLocationMarker.getreference() && PlayerHouseCOC.getreference() && (CustomPlayerHouseDoorRef.getreference() || HouseMainDoorRef.getreference())
	int ip = 0
	While ip < 10 
	if SLApproachCustomPlayerHouseList.find(SLAPCustomPlayerHouseXmarker[ip]) == -1
		SLAPCustomPlayerHouseXmarker[ip].moveto(PlayerRef)
		SLApproachCustomPlayerHouseList.addform(SLAPCustomPlayerHouseXmarker[ip])
		ip = 10		
	else
		IP += 1
	endif
	Endwhile

	if ip == 10
		Debug.Notification("$SLAPPHouseRegister")
	else
		Debug.Notification("$SLAPPHouseRegisterNoSlot")
	endif
else
	Debug.Notification("$SLAPPHouseRegisterFail")
endif
	Reset()
	Stop()
EndFunction