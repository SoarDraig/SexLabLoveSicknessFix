;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname SF_SLApproachAskForSexQuestS_0700895A Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SLApproachAskSexTimes.setvalue(SLApproachAskSexTimes.getvalue() + 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
(Getowningquest() as SLAppPCSexQuestScript).AddtoAskedForSexFaction(talkingActor.getreference() as actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
(Getowningquest() as SLAppPCSexQuestScript).AddtoAskedForSexFaction(talkingActor.getreference() as actor)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property SLApproachAskSexTimes  Auto  

ReferenceAlias Property talkingActor  Auto  
