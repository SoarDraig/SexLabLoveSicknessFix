Scriptname SLSW_Redlight extends Quest Conditional 

ReferenceAlias Property Client Auto
ReferenceAlias Property Hooker Auto
Actor Property SLSW_Client1 Auto 
Actor Property SLSW_Client2 Auto
Actor Property SLSW_Client3 Auto
Actor Property SLSW_Client4 Auto
Actor Property SLSW_Client5 Auto
Actor Property SLSW_Client6 Auto
Actor Property SLSW_Client7 Auto
Actor Property SLSW_Client8 Auto
Actor Property SLSW_Client9 Auto
Actor Property SLSW_Client10 Auto
Actor Property SLSW_Client11 Auto
Actor Property SLSW_Client12 Auto
Actor Property SLSW_Client13 Auto
Actor Property SLSW_Client14 Auto
Actor Property SLSW_Client15 Auto
Actor Property SLSW_Client16 Auto
Actor Property SLSW_Client17 Auto
Actor Property SLSW_Client18 Auto
Actor Property SLSW_Client19 Auto
Actor Property SLSW_Client20 Auto
Actor Property SLSW_Client21 Auto
Actor Property SLSW_Client22 Auto
Actor Property SLSW_Client23 Auto
Actor Property SLSW_Client24 Auto
Actor Property SLSW_Client25 Auto
Actor Property SLSW_Client26 Auto
Actor Property SLSW_Client27 Auto
Actor Property SLSW_Client28 Auto
Actor Property SLSW_Client29 Auto
Actor Property SLSW_Client30 Auto
Actor Property SLSW_Client31 Auto
Actor Property SLSW_Client32 Auto
Actor Property SLSW_Client33 Auto
Actor Property SLSW_Client34 Auto
Actor Property SLSW_Client35 Auto
Actor Property SLSW_Client36 Auto
Actor Property SLSW_Client37 Auto
Actor Property SLSW_Client38 Auto
Actor Property SLSW_Client39 Auto
Actor Property SLSW_Client40 Auto
ObjectReference Property WRMarker Auto
ObjectReference Property WHMarker Auto
ObjectReference Property SOMarker Auto
ObjectReference Property RIMarker Auto
ObjectReference Property MKMarker Auto
ObjectReference Property WRPosition Auto
ObjectReference Property WHPosition Auto
ObjectReference Property SOPosition Auto
ObjectReference Property RIPosition Auto
ObjectReference Property MKPosition Auto
Int Property iAction Auto conditional
SexLabFramework Property SexLab Auto
Float Property Gold = 0.0 Auto
Float Property Pay = 0.0 Auto conditional
Int Property iChoice Auto
Int Property Random auto

Event OnUpdate()
GetClient()
endevent

Function GetClient()
;Debug.Notification("Getting Client!")
Client.Clear()

If GetStage() == 15
random = Utility.RandomInt(1,40)
	if random == 1
		Client.ForceRefTo(SLSW_Client1)
	elseif random == 2
		Client.ForceRefTo(SLSW_Client2)
	elseif random == 3
		Client.ForceRefTo(SLSW_Client3)
	elseif random == 4
		Client.ForceRefTo(SLSW_Client4)
	elseif random == 5
		Client.ForceRefTo(SLSW_Client5)
	elseif random == 6
		Client.ForceRefTo(SLSW_Client6)
	elseif random == 7
		Client.ForceRefTo(SLSW_Client7)
	elseif random == 8
		Client.ForceRefTo(SLSW_Client8)
	elseif random == 9
		Client.ForceRefTo(SLSW_Client9)
	elseif random == 10
		Client.ForceRefTo(SLSW_Client10)
	elseif random == 11
		Client.ForceRefTo(SLSW_Client11)
	elseif random == 12
		Client.ForceRefTo(SLSW_Client12)
	elseif random == 13
		Client.ForceRefTo(SLSW_Client13)
	elseif random == 14
		Client.ForceRefTo(SLSW_Client14)
	elseif random == 15
		Client.ForceRefTo(SLSW_Client15)
	elseif random == 16
		Client.ForceRefTo(SLSW_Client16)
	elseif random == 17
		Client.ForceRefTo(SLSW_Client17)
	elseif random == 18
		Client.ForceRefTo(SLSW_Client18)
	elseif random == 19
		Client.ForceRefTo(SLSW_Client19)
	elseif random == 20
		Client.ForceRefTo(SLSW_Client20)
	elseif random == 21
		Client.ForceRefTo(SLSW_Client21)
	elseif random == 22
		Client.ForceRefTo(SLSW_Client23)
	elseif random == 23
		Client.ForceRefTo(SLSW_Client23)
	elseif random == 24
		Client.ForceRefTo(SLSW_Client24)
	elseif random == 25
		Client.ForceRefTo(SLSW_Client25)
	elseif random == 26
		Client.ForceRefTo(SLSW_Client26)
	elseif random == 27
		Client.ForceRefTo(SLSW_Client27)
	elseif random == 28
		Client.ForceRefTo(SLSW_Client28)
	elseif random == 29
		Client.ForceRefTo(SLSW_Client29)
	elseif random == 30
		Client.ForceRefTo(SLSW_Client30)
	elseif random == 31
		Client.ForceRefTo(SLSW_Client31)
	elseif random == 32
		Client.ForceRefTo(SLSW_Client32)
	elseif random == 33
		Client.ForceRefTo(SLSW_Client33)
	elseif random == 34
		Client.ForceRefTo(SLSW_Client34)
	elseif random == 35
		Client.ForceRefTo(SLSW_Client35)
	elseif random == 36
		Client.ForceRefTo(SLSW_Client36)
	elseif random == 37
		Client.ForceRefTo(SLSW_Client37)
	elseif random == 38
		Client.ForceRefTo(SLSW_Client38)
	elseif random == 39
		Client.ForceRefTo(SLSW_Client39)
	elseif random == 40
		Client.ForceRefTo(SLSW_Client40)
	endif

	iAction = Utility.RandomInt(1, 5)

	If Game.getPlayer().getDistance(WRPosition) <= 1500
;		Debug.Notification("WR!")
		(Client.getRef() as Actor).MoveTo(WRMarker)
		SetStage(20)
	elseif Game.getPlayer().getDistance(WHPosition) <= 1500
;		Debug.Notification("WH!")
		(Client.getRef() as Actor).MoveTo(WHMarker)
		SetStage(20)
	elseif Game.getPlayer().getDistance(SOPosition) <= 1500
;		Debug.Notification("SO!")
		(Client.getRef() as Actor).MoveTo(SOMarker)
		SetStage(20)
	elseif Game.getPlayer().getDistance(RIPosition) <= 1500
;		Debug.Notification("RI!")
		(Client.getRef() as Actor).MoveTo(RIMarker)
		SetStage(20)
	elseif Game.getPlayer().getDistance(MKPosition) <= 1500
;		Debug.Notification("MK!")
		(Client.getRef() as Actor).MoveTo(MKMarker)
		SetStage(20)
	endif

endif
return
endfunction

Function Action()

SetStage(50)
RegisterForModEvent("AnimationEnd_Finish", "Finished")

	actor[] sexActors = new actor[2]
	sexActors[0] = Game.GetPlayer()
	sexActors[1] = Client.getRef() as Actor

	sslBaseAnimation[] anims

If iAction == 2
	anims = SexLab.GetAnimationsByTags(2, "Anal")
elseIf iAction == 3
	anims = SexLab.GetAnimationsByTags(2, "Blowjob")
elseIf iAction == 1
	anims = SexLab.GetAnimationsByTags(2, "Vaginal")
elseIf iAction == 4
	anims = SexLab.GetAnimationsByTags(2, "Boobjob")
else
	anims = SexLab.GetAnimationsByTags(2, "Footjob")
endif

	SexLab.StartSex(sexActors, anims, allowBed=true, hook="Finish")

Return
endFunction

Event Finished(string eventName, string argString, float argNum, form sender)
;Debug.Notification("Finished")
SetStage(60)
UnregisterforModEvent("AnimationEnd_Finish")
endevent

Function HookerAction()

SetStage(90)
RegisterForModEvent("AnimationEnd_HookerFinish", "FinishedHooker")

	actor[] sexActors = new actor[2]
	sexActors[0] = (Hooker.getRef() as Actor)
	sexActors[1] = Game.GetPlayer() 

	sslBaseAnimation[] anims

If iChoice == 2
	anims = SexLab.GetAnimationsByTags(2, "Anal")
elseIf iChoice == 3
	anims = SexLab.GetAnimationsByTags(2, "Blowjob")
elseIf iChoice == 1
	anims = SexLab.GetAnimationsByTags(2, "Vaginal")
elseIf iChoice == 4
	anims = SexLab.GetAnimationsByTags(2, "Boobjob")
else
	anims = SexLab.GetAnimationsByTags(2, "Footjob")
endif

	SexLab.StartSex(sexActors, anims, allowBed=true, hook="HookerFinish")

Return
endFunction

Event FinishedHooker(string eventName, string argString, float argNum, form sender)
;Debug.Notification("FinishedHooker")
Hooker.Clear()
Reset()
SetStage(0)
UnregisterforModEvent("AnimationEnd_HookerFinish")
endevent