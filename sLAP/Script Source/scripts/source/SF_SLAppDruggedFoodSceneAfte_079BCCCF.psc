;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SF_SLAppDruggedFoodSceneAfte_079BCCCF Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Game.SetPlayerAIDriven(true)
Debug.sendanimationevent(Playerref, "BaboFaintFStart")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
(GetOwningQuest() as SLAppPCSexQuestScript).GotoPrivateRoomOnlyNPC(talkingactor.getreference() as actor, false)
(GetOwningQuest() as SLAppPCSexQuestScript).ToxicFoodRapedbyEnd(talkingactor.getreference() as actor)
Game.SetPlayerAIDriven(false)
Utility.wait(2.0)
Debug.sendanimationevent(Playerref, "BaboFaintFEnd")
stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property talkingActor  Auto  

Actor Property PlayerRef  Auto  
