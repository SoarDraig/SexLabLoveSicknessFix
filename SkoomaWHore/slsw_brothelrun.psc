Scriptname SLSW_brothelrun extends Quest  

ObjectReference Property WorkersHouseMarker Auto
ObjectReference Property Marker Auto
SexLabFramework Property SexLab Auto
ReferenceAlias Property Client Auto
GlobalVariable Property ClientCount auto
Quest Property SLSW_Brothel auto
Quest Property SLSW_Lilly auto
Quest Property SLSW_Twig auto
Cell Property holdingCell auto
ReferenceAlias Property Lilly Auto
ReferenceAlias Property Twig Auto
ReferenceAlias Property LilliesClient Auto
ReferenceAlias Property TwigsClient Auto

Actor Property Pimp Auto

Actor Property Client01 Auto
Actor Property Client02 Auto
Actor Property Client03 Auto
Actor Property Client04 Auto
Actor Property Client05 Auto
Actor Property Client06 Auto
Actor Property Client07 Auto
Actor Property Client08 Auto
Actor Property Client09 Auto
Actor Property Client10 Auto

Actor Property Client11 Auto
Actor Property Client12 Auto
Actor Property Client13 Auto
Actor Property Client14 Auto
Actor Property Client15 Auto
Actor Property Client16 Auto
Actor Property Client17 Auto
Actor Property Client18 Auto
Actor Property Client19 Auto
Actor Property Client20 Auto

Actor Property Client21 Auto
Actor Property Client22 Auto
Actor Property Client23 Auto
Actor Property Client24 Auto
Actor Property Client25 Auto
Actor Property Client26 Auto
Actor Property Client27 Auto
Actor Property Client28 Auto
Actor Property Client29 Auto
Actor Property Client30 Auto

Function GetClient()

;Debug.Notification("Getting Client")

Utility.Wait(Utility.RandomInt(20, 40))

If SLSW_Brothel.getstage() == 10
return
endif

Int Random = Utility.RandomInt(1, 30)

Client.Clear()

If Random == 1
	Client01.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client01)
ElseIf Random == 2
	Client02.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client02)
ElseIf Random == 3
	Client03.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client03)
ElseIf Random == 4
	Client04.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client04)
ElseIf Random == 5
	Client05.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client05)
ElseIf Random == 6
	Client06.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client06)
ElseIf Random == 7
	Client07.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client07)
ElseIf Random == 8
	Client08.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client08)
ElseIf Random == 9
	Client09.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client09)
ElseIf Random == 10
	Client10.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client10)
ElseIf Random == 11
	Client11.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client11)
ElseIf Random == 12
	Client12.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client12)
ElseIf Random == 13
	Client13.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client13)
ElseIf Random == 14
	Client14.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client14)
ElseIf Random == 15
	Client15.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client15)
ElseIf Random == 16
	Client16.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client16)
ElseIf Random == 17
	Client17.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client17)
ElseIf Random == 18
	Client18.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client18)
ElseIf Random == 19
	Client19.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client19)
ElseIf Random == 20
	Client20.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client20)
ElseIf Random == 21
	Client21.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client21)
ElseIf Random == 22
	Client22.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client22)
ElseIf Random == 23
	Client23.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client23)
ElseIf Random == 24
	Client24.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client24)
ElseIf Random == 25
	Client25.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client25)
ElseIf Random == 26
	Client26.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client26)
ElseIf Random == 27
	Client27.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client27)
ElseIf Random == 28
	Client28.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client28)
ElseIf Random == 29
	Client29.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client29)
Else
	Client30.MoveTo(WorkersHouseMarker)
	Client.ForceRefTo(Client30)
endif

if SLSW_Lilly.getStage() == 0 
Lilly(Random)
endif

if SLSW_Twig.getStage() == 0
Twig(Random)
endif

Return
endFunction

Function Action()

RegisterForModEvent("AnimationEnd_Next", "NextClient")

Int Random = Utility.RandomInt(1, 6)

	actor[] sexActors = new actor[2]
	sexActors[0] = Game.GetPlayer()
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

	SexLab.StartSex(sexActors, anims, allowBed=true, hook="Next")

float Count = ClientCount.getValue()
Count += 1
ClientCount.setValue(Count)

Return
endFunction

Event NextClient(string eventName, string argString, float argNum, form sender)
;Debug.Notification("Next!")
SLSW_Brothel.SetStage(40)
UnregisterforModEvent("AnimationEnd_Next")
endevent

function cleanup()

If Client01.getparentcell() != holdingCell
	Client01.MoveTo(Marker)
endif
If Client02.getparentcell() != holdingCell
	Client02.MoveTo(Marker)
endif
If Client03.getparentcell() != holdingCell
	Client03.MoveTo(Marker)
endif
If Client04.getparentcell() != holdingCell
	Client04.MoveTo(Marker)
endif
If Client05.getparentcell() != holdingCell
	Client05.MoveTo(Marker)
endif
If Client06.getparentcell() != holdingCell
	Client06.MoveTo(Marker)
endif
If Client07.getparentcell() != holdingCell
	Client07.MoveTo(Marker)
endif
If Client08.getparentcell() != holdingCell
	Client08.MoveTo(Marker)
endif
If Client09.getparentcell() != holdingCell
	Client09.MoveTo(Marker)
endif
If Client10.getparentcell() != holdingCell
	Client10.MoveTo(Marker)
endif
If Client11.getparentcell() != holdingCell
	Client11.MoveTo(Marker)
endif
If Client12.getparentcell() != holdingCell
	Client12.MoveTo(Marker)
endif
If Client13.getparentcell() != holdingCell
	Client13.MoveTo(Marker)
endif
If Client14.getparentcell() != holdingCell
	Client14.MoveTo(Marker)
endif
If Client15.getparentcell() != holdingCell
	Client15.MoveTo(Marker)
endif
If Client16.getparentcell() != holdingCell
	Client16.MoveTo(Marker)
endif
If Client17.getparentcell() != holdingCell
	Client17.MoveTo(Marker)
endif
If Client18.getparentcell() != holdingCell
	Client18.MoveTo(Marker)
endif
If Client19.getparentcell() != holdingCell
	Client19.MoveTo(Marker)
endif
If Client20.getparentcell() != holdingCell
	Client20.MoveTo(Marker)
endif
If Client21.getparentcell() != holdingCell
	Client21.MoveTo(Marker)
endif
If Client22.getparentcell() != holdingCell
	Client22.MoveTo(Marker)
endif
If Client23.getparentcell() != holdingCell
	Client23.MoveTo(Marker)
endif
If Client24.getparentcell() != holdingCell
	Client24.MoveTo(Marker)
endif
If Client25.getparentcell() != holdingCell
	Client25.MoveTo(Marker)
endif
If Client26.getparentcell() != holdingCell
	Client26.MoveTo(Marker)
endif
If Client27.getparentcell() != holdingCell
	Client27.MoveTo(Marker)
endif
If Client28.getparentcell() != holdingCell
	Client28.MoveTo(Marker)
endif
If Client29.getparentcell() != holdingCell
	Client29.MoveTo(Marker)
endif
If Client30.getparentcell() != holdingCell
	Client30.MoveTo(Marker)
endif
If Pimp.getparentcell() != holdingCell
	pimp.MoveTo(Marker)
endif
return

Endfunction

Function Lilly(int random)
if utility.randomint(1, 2) == 1
if random == 30
random -=1
else
random += 1
endif

LilliesClient.Clear() 

If Random == 1
	Client01.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client01)
ElseIf Random == 2
	Client02.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client02)
ElseIf Random == 3
	Client03.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client03)
ElseIf Random == 4
	Client04.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client04)
ElseIf Random == 5
	Client05.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client05)
ElseIf Random == 6
	Client06.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client06)
ElseIf Random == 7
	Client07.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client07)
ElseIf Random == 8
	Client08.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client08)
ElseIf Random == 9
	Client09.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client09)
ElseIf Random == 10
	Client10.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client10)
ElseIf Random == 11
	Client11.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client11)
ElseIf Random == 12
	Client12.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client12)
ElseIf Random == 13
	Client13.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client13)
ElseIf Random == 14
	Client14.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client14)
ElseIf Random == 15
	Client15.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client15)
ElseIf Random == 16
	Client16.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client16)
ElseIf Random == 17
	Client17.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client17)
ElseIf Random == 18
	Client18.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client18)
ElseIf Random == 19
	Client19.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client19)
ElseIf Random == 20
	Client20.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client20)
ElseIf Random == 21
	Client21.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client21)
ElseIf Random == 22
	Client22.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client22)
ElseIf Random == 23
	Client23.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client23)
ElseIf Random == 24
	Client24.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client24)
ElseIf Random == 25
	Client25.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client25)
ElseIf Random == 26
	Client26.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client26)
ElseIf Random == 27
	Client27.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client27)
ElseIf Random == 28
	Client28.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client28)
ElseIf Random == 29
	Client29.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client29)
Else
	Client30.MoveTo(WorkersHouseMarker)
	LilliesClient.ForceRefTo(Client30)
endif

Return
endif
return
endfunction

Function twig(int random)
if utility.randomint(1, 2) == 1
if random == 30
random -=2
elseif random == 29
random -= 1
else
random += 2
endif

TwigsClient.Clear() 

If Random == 1
	Client01.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client01)
ElseIf Random == 2
	Client02.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client02)
ElseIf Random == 3
	Client03.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client03)
ElseIf Random == 4
	Client04.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client04)
ElseIf Random == 5
	Client05.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client05)
ElseIf Random == 6
	Client06.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client06)
ElseIf Random == 7
	Client07.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client07)
ElseIf Random == 8
	Client08.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client08)
ElseIf Random == 9
	Client09.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client09)
ElseIf Random == 10
	Client10.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client10)
ElseIf Random == 11
	Client11.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client11)
ElseIf Random == 12
	Client12.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client12)
ElseIf Random == 13
	Client13.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client13)
ElseIf Random == 14
	Client14.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client14)
ElseIf Random == 15
	Client15.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client15)
ElseIf Random == 16
	Client16.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client16)
ElseIf Random == 17
	Client17.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client17)
ElseIf Random == 18
	Client18.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client18)
ElseIf Random == 19
	Client19.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client19)
ElseIf Random == 20
	Client20.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client20)
ElseIf Random == 21
	Client21.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client21)
ElseIf Random == 22
	Client22.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client22)
ElseIf Random == 23
	Client23.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client23)
ElseIf Random == 24
	Client24.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client24)
ElseIf Random == 25
	Client25.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client25)
ElseIf Random == 26
	Client26.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client26)
ElseIf Random == 27
	Client27.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client27)
ElseIf Random == 28
	Client28.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client28)
ElseIf Random == 29
	Client29.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client29)
Else
	Client30.MoveTo(WorkersHouseMarker)
	TwigsClient.ForceRefTo(Client30)
endif

Return
endif
return
endfunction
