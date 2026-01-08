;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLSW_PimpSO_Salery Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
pFDS.Persuade(akSpeaker)
GetOwningQuest().reset()
GetOwningQuest().SetStage(0)
Redlight.Gold = Redlight.Gold * 0.9
Game.GetPlayer().AddItem(Gold001, (Redlight.Gold as Int))
Redlight.Gold = 0
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

FavorDialogueScript Property pFDS  Auto  

SLSW_Redlight Property Redlight  Auto  

MiscObject Property Gold001  Auto  
