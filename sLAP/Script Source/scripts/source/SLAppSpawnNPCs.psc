Scriptname SLAppSpawnNPCs extends Quest  

;Riverwood
Function SpawnBullyNPCRiverwood()
	if (maleriverwood01 == None) && (maleriverwood02 == None)
		Actor actor1 = SLARiverwoodCentermarker.placeatme(SLA_ThugMaleRiverwood01) as actor
		Actor actor2 = SLARiverwoodCentermarker.placeatme(SLA_ThugMaleRiverwood02) as actor
		maleriverwood01.forcerefto(actor1)
		maleriverwood02.forcerefto(actor2)

		SLA_BullyNPCRiverwood.setvalue(SLA_BullyNPCRiverwood.getvalue() + 2)
	endif
EndFunction

Function DespawnBullyNPCRiverwood()
	(maleriverwood01.getreference() as actor).delete()
	(maleriverwood02.getreference() as actor).delete()
	maleriverwood01.clear()
	maleriverwood02.clear()
EndFunction

Function DeploySpoiledBoys(Bool DeploySwitch)
if DeploySwitch
	slapp_Kayleref.moveto(SLA_MarkarthXmarker01)
	slapp_Eraldref.moveto(SLA_WhiterunXmarker01)
	slapp_Dareusref.moveto(SLA_SolitudeXmarker01)
	slapp_Kainref.moveto(SLA_RiftenXmarker01)
	slapp_Andyref.moveto(SLA_RiverwoodXmarker01)
else
	slapp_Kayleref.moveto(SLAPCustomMarkersPoint)
	slapp_Eraldref.moveto(SLAPCustomMarkersPoint)
	slapp_Dareusref.moveto(SLAPCustomMarkersPoint)
	slapp_Kainref.moveto(SLAPCustomMarkersPoint)
	slapp_Andyref.moveto(SLAPCustomMarkersPoint)
endif

EndFunction
Function DeployBoys(Bool DeploySwitch)

if DeploySwitch
	Actor actor1 = SLA_FalkreathXmarker01.PlaceActorAtMe(SLApproachTownKidList.GetAt(0) as actorbase, 4) as actor
	Actor actor2 = SLA_RiverwoodXmarker01.PlaceActorAtMe(SLApproachTownKidList.GetAt(1) as actorbase, 4) as actor
	Actor actor3 = SLA_WhiterunXmarker01.PlaceActorAtMe(SLApproachTownKidList.GetAt(2) as actorbase, 4) as actor
	Actor actor4 = SLA_WindhelmXmarker01.PlaceActorAtMe(SLApproachTownKidList.GetAt(3) as actorbase, 4) as actor
	Actor actor5 = SLA_WinterholdXmarker01.PlaceActorAtMe(SLApproachTownKidList.GetAt(4) as actorbase, 4) as actor
	Actor actor6 = SLA_MarkarthXmarker01.PlaceActorAtMe(SLApproachTownKidList.GetAt(5) as actorbase, 4) as actor
	Actor actor7 = SLA_MarkarthXmarker01.PlaceActorAtMe(SLApproachTownKidList.GetAt(6) as actorbase, 4) as actor
	Actor actor8 = SLA_SolitudeXmarker01.PlaceActorAtMe(SLApproachTownKidList.GetAt(7) as actorbase, 4) as actor
	Actor actor9 = SLA_SolitudeXmarker01.PlaceActorAtMe(SLApproachTownKidList.GetAt(8) as actorbase, 4) as actor
	Actor actor10 = SLA_MorthalXmarker01.PlaceActorAtMe(SLApproachTownKidList.GetAt(9) as actorbase, 4) as actor
	Actor actor11= SLA_RiftenXmarker01.PlaceActorAtMe(SLApproachTownKidList.GetAt(10) as actorbase, 4) as actor
	Actor actor12 = SLA_DragonBridgeXmarker01.PlaceActorAtMe(SLApproachTownKidList.GetAt(11) as actorbase, 4) as actor
	Actor actor13 = SLA_NightgateinnXmarker01.PlaceActorAtMe(SLApproachTownKidList.GetAt(12) as actorbase, 4) as actor
	Actor actor14 = SLA_IvarsteadXmarker01.PlaceActorAtMe(SLApproachTownKidList.GetAt(13) as actorbase, 4) as actor
	
	SLApproachTownKidSummonedList.AddForm(actor1)
	SLApproachTownKidSummonedList.AddForm(actor2)
	SLApproachTownKidSummonedList.AddForm(actor3)
	SLApproachTownKidSummonedList.AddForm(actor4)
	SLApproachTownKidSummonedList.AddForm(actor5)
	SLApproachTownKidSummonedList.AddForm(actor6)
	SLApproachTownKidSummonedList.AddForm(actor7)
	SLApproachTownKidSummonedList.AddForm(actor8)
	SLApproachTownKidSummonedList.AddForm(actor9)
	SLApproachTownKidSummonedList.AddForm(actor10)
	SLApproachTownKidSummonedList.AddForm(actor11)
	SLApproachTownKidSummonedList.AddForm(actor12)
	SLApproachTownKidSummonedList.AddForm(actor13)
	SLApproachTownKidSummonedList.AddForm(actor14)

else

actor akactor

	Int iIndex = SLApproachTownKidSummonedList.GetSize()
		While iIndex > 0
			iIndex -= 1
			akactor = SLApproachTownKidSummonedList.GetAt(iIndex) as actor
			akactor.delete()
		EndWhile
	SLApproachTownKidSummonedList.Revert()
endif

EndFunction

Actorbase Property SLA_ThugMaleRiverwood01  Auto  
Actorbase Property SLA_ThugMaleRiverwood02  Auto  

Referencealias Property maleriverwood01 auto
Referencealias Property maleriverwood02 auto

ObjectReference Property SLARiverwoodCentermarker Auto

GlobalVariable Property SLA_BullyNPCRiverwood Auto
GlobalVariable Property SLA_BullyNPCWhiterun Auto
GlobalVariable Property SLA_BullyNPCFalkreath Auto

Formlist Property SLApproachTownKidList Auto
Formlist Property SLApproachTownKidSummonedList Auto

ObjectReference Property SLA_DragonBridgeXmarker01 Auto
ObjectReference Property SLA_FalkreathXmarker01 Auto
ObjectReference Property SLA_MarkarthXmarker01 Auto
ObjectReference Property SLA_MorthalXmarker01 Auto
ObjectReference Property SLA_NightgateinnXmarker01 Auto
ObjectReference Property SLA_RiverwoodXmarker01 Auto
ObjectReference Property SLA_SolitudeXmarker01 Auto
ObjectReference Property SLA_WhiterunXmarker01 Auto
ObjectReference Property SLA_WindhelmXmarker01 Auto
ObjectReference Property SLA_WinterholdXmarker01 Auto
ObjectReference Property SLA_RiftenXmarker01 Auto
ObjectReference Property SLA_IvarsteadXmarker01 Auto

ObjectReference Property SLAPCustomMarkersPoint Auto

Actor Property slapp_Kayleref Auto
Actor Property slapp_Eraldref Auto
Actor Property slapp_Dareusref Auto
Actor Property slapp_Kainref Auto
Actor Property slapp_Andyref Auto