;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname SF_SLAppViceGuardCaptainSpan_076BFE4B Extends Scene Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
(Getowningquest() as SLAppPCSexQuestScript).SpankSceneStart(talkingactor.getreference() as actor, 2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
(Getowningquest() as SLAppPCSexQuestScript).SpankSceneStart(talkingactor.getreference() as actor, 3)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SLA_SpankingScenarioGlobal.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
actor talkingactorRef = talkingactor.getreference() as actor
if (PlayerRef.isrunning())
SLA_SpankingScenarioGlobal.setvalue(1)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property SLApproachSpankTimes Auto  
Quest Property SLApproach_Main Auto
ReferenceAlias Property talkingActor  Auto  
GlobalVariable Property SLA_SpankingScenarioGlobal  Auto  
Actor Property PlayerRef  Auto  
Faction Property slapp_NoSpankFaction  Auto  
Faction Property slapp_NoBackHugFaction  Auto  
