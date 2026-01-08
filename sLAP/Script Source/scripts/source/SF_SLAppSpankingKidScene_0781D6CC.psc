;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname SF_SLAppSpankingKidScene_0781D6CC Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
actor talkingactorRef = talkingactor.getreference() as actor
if !(PlayerRef.isrunning())
if talkingactorRef.isinfaction(slapp_NoSpankFaction) && talkingactorRef.isinfaction(slapp_NoMolestFaction)
SLA_SpankingScenarioGlobal.setvalue(1)
else
SLA_SpankingScenarioGlobal.setvalue(0)
endif
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
actor akref = talkingactor.getreference() as actor
;if akref.getfactionrank(slapp_Characterfaction) <= 2
(Getowningquest() as SLAppPCSexQuestScript).SpankSSceneStart(talkingactor.getreference() as actor, 0)
;elseif akref.getfactionrank(slapp_Characterfaction) > 2
;(Getowningquest() as SLAppPCSexQuestScript).SpankSSceneStart(talkingactor.getreference() as actor, 1)
;endif
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

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


GlobalVariable Property SLApproachSpankTimes Auto  
Quest Property SLApproach_Main Auto
ReferenceAlias Property talkingActor  Auto  
GlobalVariable Property SLA_SpankingScenarioGlobal  Auto  
Actor Property PlayerRef  Auto  
Faction Property slapp_NoSpankFaction  Auto  
Faction Property slapp_NoBackHugFaction  Auto  

Faction Property slapp_Characterfaction  Auto  

Faction Property slapp_NoMolestFaction  Auto  
