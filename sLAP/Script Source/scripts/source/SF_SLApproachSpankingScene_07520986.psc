;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname SF_SLApproachSpankingScene_07520986 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
(Getowningquest() as SLAppPCSexQuestScript).SpankSceneStart(talkingactor.getreference() as actor, 0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SLA_SpankingScenarioGlobal.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
actor talkingactorRef = talkingactor.getreference() as actor
if !(PlayerRef.isrunning())
if talkingactorRef.isinfaction(slapp_NoSpankFaction) && talkingactorRef.isinfaction(slapp_NoBackHugFaction)
SLA_SpankingScenarioGlobal.setvalue(0);NoBackHugFaction can only be acquired after the actor acquires NoSpankFaction
else
SLA_SpankingScenarioGlobal.setvalue(1)
endif
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
SLApproachAskNameTimes.setvalue(SLApproachAskNameTimes.getvalue() + 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
(Getowningquest() as SLAppPCSexQuestScript).AddtoAskedForSexFaction(talkingActor.getreference() as actor)
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

GlobalVariable Property SLApproachAskNameTimes  Auto  
