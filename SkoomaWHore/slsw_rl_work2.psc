Scriptname SLSW_RL_Work2 extends Quest  

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
SLSW_Redlight Property Redlight auto
ReferenceAlias Property Client Auto
ReferenceAlias Property Whore1 Auto
ObjectReference Property SOPosition Auto
ObjectReference Property MKPosition Auto
ObjectReference Property WHPosition Auto
ObjectReference Property WRPosition Auto
ObjectReference Property RIPosition Auto
ObjectReference Property SOMarker Auto
ObjectReference Property MKMarker Auto
ObjectReference Property WHMarker Auto
ObjectReference Property WRMarker Auto
ObjectReference Property RIMarker Auto
SexLabFramework Property SexLab auto
ObjectReference Property SLSW_COCmarker Auto
SLSW_scum Property scum auto
Quest Property RedlightQuest auto

Event OnUpdate()
if RedlightQuest.getStage() >= 70
	Reset()
	setStage(0)
else
;	Debug.Notification("Update: Get Client")
	GetClient()
endif
EndEvent

Function GetClient()

int Roll = scum.RanInt
If Roll == Redlight.random
	If Redlight.random == 40
		Roll -= 1
	else
		Roll += 1
	endif
endif

;Debug.Notification("Hooker Client!")
Client.Clear()

	if roll == 1
		Client.ForceRefTo(SLSW_Client1)
	elseif roll == 2
		Client.ForceRefTo(SLSW_Client2)
	elseif roll == 3
		Client.ForceRefTo(SLSW_Client3)
	elseif roll == 4
		Client.ForceRefTo(SLSW_Client4)
	elseif roll == 5
		Client.ForceRefTo(SLSW_Client5)
	elseif roll == 6
		Client.ForceRefTo(SLSW_Client6)
	elseif roll == 7
		Client.ForceRefTo(SLSW_Client7)
	elseif roll == 8
		Client.ForceRefTo(SLSW_Client8)
	elseif roll == 9
		Client.ForceRefTo(SLSW_Client9)
	elseif roll == 10
		Client.ForceRefTo(SLSW_Client10)
	elseif roll == 11
		Client.ForceRefTo(SLSW_Client11)
	elseif roll == 12
		Client.ForceRefTo(SLSW_Client12)
	elseif roll == 13
		Client.ForceRefTo(SLSW_Client13)
	elseif roll == 14
		Client.ForceRefTo(SLSW_Client14)
	elseif roll == 15
		Client.ForceRefTo(SLSW_Client15)
	elseif roll == 16
		Client.ForceRefTo(SLSW_Client16)
	elseif roll == 17
		Client.ForceRefTo(SLSW_Client17)
	elseif roll == 18
		Client.ForceRefTo(SLSW_Client18)
	elseif roll == 19
		Client.ForceRefTo(SLSW_Client19)
	elseif roll == 20
		Client.ForceRefTo(SLSW_Client20)
	elseif roll == 21
		Client.ForceRefTo(SLSW_Client21)
	elseif roll == 22
		Client.ForceRefTo(SLSW_Client23)
	elseif roll == 23
		Client.ForceRefTo(SLSW_Client23)
	elseif roll == 24
		Client.ForceRefTo(SLSW_Client24)
	elseif roll == 25
		Client.ForceRefTo(SLSW_Client25)
	elseif roll == 26
		Client.ForceRefTo(SLSW_Client26)
	elseif roll == 27
		Client.ForceRefTo(SLSW_Client27)
	elseif roll == 28
		Client.ForceRefTo(SLSW_Client28)
	elseif roll == 29
		Client.ForceRefTo(SLSW_Client29)
	elseif roll == 30
		Client.ForceRefTo(SLSW_Client30)
	elseif roll == 31
		Client.ForceRefTo(SLSW_Client31)
	elseif roll == 32
		Client.ForceRefTo(SLSW_Client32)
	elseif roll == 33
		Client.ForceRefTo(SLSW_Client33)
	elseif roll == 34
		Client.ForceRefTo(SLSW_Client34)
	elseif roll == 35
		Client.ForceRefTo(SLSW_Client35)
	elseif roll == 36
		Client.ForceRefTo(SLSW_Client36)
	elseif roll == 37
		Client.ForceRefTo(SLSW_Client37)
	elseif roll == 38
		Client.ForceRefTo(SLSW_Client38)
	elseif roll == 39
		Client.ForceRefTo(SLSW_Client39)
	elseif roll == 40
		Client.ForceRefTo(SLSW_Client40)
	endif

	If (Whore1.getRef() as Actor).getDistance(WRPosition) <= 1500
		(Client.getRef() as Actor).MoveTo(WRMarker)
		SetStage(20)
	elseif (Whore1.getRef() as Actor).getDistance(WHPosition) <= 1500
		(Client.getRef() as Actor).MoveTo(WHMarker)
		SetStage(20)
	elseif (Whore1.getRef() as Actor).getDistance(SOPosition) <= 1500
		(Client.getRef() as Actor).MoveTo(SOMarker)
		SetStage(20)
	elseif (Whore1.getRef() as Actor).getDistance(RIPosition) <= 1500
		(Client.getRef() as Actor).MoveTo(RIMarker)
		SetStage(20)
	elseif (Whore1.getRef() as Actor).getDistance(MKPosition) <= 1500
		(Client.getRef() as Actor).MoveTo(MKMarker)
		SetStage(20)
	endif

return
endFunction

Function Action()

RegisterForModEvent("AnimationEnd_Whore1", "Whore1Client")

Int Random = Utility.RandomInt(1, 6)

actor[] sexActors = new actor[2]
sexActors[0] = Whore1.getRef() as Actor
sexActors[1] = Client.getRef() as Actor

sslBaseAnimation[] anims

If Random == 1
	anims = SexLab.GetAnimationsByTags(2, "Aggressive, Anal")
elseIf Random == 2
	anims = SexLab.GetAnimationsByTags(2, "Aggressive, Blowjob")
elseIf Random == 3
	anims = SexLab.GetAnimationsByTags(2, "Aggressive, Vaginal")
elseIf Random == 4
	anims = SexLab.GetAnimationsByTags(2, "Vaginal")
elseIf Random == 5
	anims = SexLab.GetAnimationsByTags(2, "Blowjob")
else
	anims = SexLab.GetAnimationsByTags(2, "Anal")
endif

SexLab.StartSex(sexActors, anims, allowBed=true, hook="Whore1")

Return
endFunction

Event Whore1Client(string eventName, string argString, float argNum, form sender)

SetStage(40)

UnregisterforModEvent("AnimationEnd_Whore1")

endevent

Function CleanUp()

SLSW_Client1.moveto(SLSW_COCmarker)
SLSW_Client2.moveto(SLSW_COCmarker)
SLSW_Client3.moveto(SLSW_COCmarker)
SLSW_Client4.moveto(SLSW_COCmarker)
SLSW_Client5.moveto(SLSW_COCmarker)
SLSW_Client6.moveto(SLSW_COCmarker)
SLSW_Client7.moveto(SLSW_COCmarker)
SLSW_Client8.moveto(SLSW_COCmarker)
SLSW_Client9.moveto(SLSW_COCmarker)
SLSW_Client10.moveto(SLSW_COCmarker)
SLSW_Client11.moveto(SLSW_COCmarker)
SLSW_Client12.moveto(SLSW_COCmarker)
SLSW_Client13.moveto(SLSW_COCmarker)
SLSW_Client14.moveto(SLSW_COCmarker)
SLSW_Client15.moveto(SLSW_COCmarker)
SLSW_Client16.moveto(SLSW_COCmarker)
SLSW_Client17.moveto(SLSW_COCmarker)
SLSW_Client18.moveto(SLSW_COCmarker)
SLSW_Client19.moveto(SLSW_COCmarker)
SLSW_Client20.moveto(SLSW_COCmarker)
SLSW_Client21.moveto(SLSW_COCmarker)
SLSW_Client22.moveto(SLSW_COCmarker)
SLSW_Client23.moveto(SLSW_COCmarker)
SLSW_Client24.moveto(SLSW_COCmarker)
SLSW_Client25.moveto(SLSW_COCmarker)
SLSW_Client26.moveto(SLSW_COCmarker)
SLSW_Client27.moveto(SLSW_COCmarker)
SLSW_Client28.moveto(SLSW_COCmarker)
SLSW_Client29.moveto(SLSW_COCmarker)
SLSW_Client30.moveto(SLSW_COCmarker)
SLSW_Client31.moveto(SLSW_COCmarker)
SLSW_Client32.moveto(SLSW_COCmarker)
SLSW_Client33.moveto(SLSW_COCmarker)
SLSW_Client34.moveto(SLSW_COCmarker)
SLSW_Client35.moveto(SLSW_COCmarker)
SLSW_Client36.moveto(SLSW_COCmarker)
SLSW_Client37.moveto(SLSW_COCmarker)
SLSW_Client38.moveto(SLSW_COCmarker)
SLSW_Client39.moveto(SLSW_COCmarker)
SLSW_Client40.moveto(SLSW_COCmarker)
;Debug.Notification("Cleaned Up!")
return
EndFunction