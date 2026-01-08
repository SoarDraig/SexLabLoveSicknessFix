;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 40
Scriptname SF_SLApproach_DetectPlayerOu_0772A45E Extends Scene Hidden

;BEGIN FRAGMENT Fragment_21
Function Fragment_21()
;BEGIN CODE
SLADetectOutfitGlobal.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
Actor akactor = TalkingActorRef.Getreference() as actor
SLBaseScript.AddtoHaveSeenArmorFaction(akactor, 6)
SLBaseScript.AddtoHaveSeenNudeFaction(akactor, 0, true)
SLBaseScript.RankUpTraitFetish(akactor, 30, 6)
SLPCScript.ThinkAboutPlayer(akactor, 4, true, true, iFavorPoint)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN CODE
SLADetectOutfitGlobal.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_29
Function Fragment_29()
;BEGIN CODE
SLADetectOutfitGlobal.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
Actor akactor = TalkingActorRef.Getreference() as actor
SLBaseScript.AddtoHaveSeenArmorFaction(akactor, 2)
SLBaseScript.RankUpTraitFetish(akactor, 20, 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_28
Function Fragment_28()
;BEGIN CODE
SLADetectOutfitGlobal.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
Actor akactor = TalkingActorRef.Getreference() as actor
SLBaseScript.AddtoHaveSeenArmorFaction(akactor, 4)
SLBaseScript.RankUpTraitFetish(akactor, 20, 4)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_32
Function Fragment_32()
;BEGIN CODE
SLADetectOutfitGlobal.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_38
Function Fragment_38()
;BEGIN CODE
SLBaseScript.AddtoHaveSeenRecentArmorFaction(TalkingActorRef.Getreference() as actor, 2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
Actor akactor = TalkingActorRef.Getreference() as actor
SLBaseScript.AddtoHaveSeenArmorFaction(akactor, 0)
;SLBaseScript.RankUpTraitFetish(akactor, 0, 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_27
Function Fragment_27()
;BEGIN CODE
SLADetectOutfitGlobal.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN CODE
SLADetectOutfitGlobal.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_30
Function Fragment_30()
;BEGIN CODE
Actor akactor = TalkingActorRef.Getreference() as actor
SLBaseScript.AddtoHaveSeenArmorFaction(akactor, 6)
SLBaseScript.AddtoHaveSeenNudeFaction(akactor, 0, true)
SLBaseScript.RankUpTraitFetish(akactor, 30, 6)
SLPCScript.ThinkAboutPlayer(akactor, 4, true, true, iFavorPoint)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22()
;BEGIN CODE
SLADetectOutfitGlobal.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_33
Function Fragment_33()
;BEGIN CODE
SLADetectOutfitGlobal.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
Actor akactor = TalkingActorRef.Getreference() as actor
SLBaseScript.AddtoHaveSeenArmorFaction(akactor, 1)
SLBaseScript.RankUpTraitFetish(akactor, 0, 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_36
Function Fragment_36()
;BEGIN CODE
SLBaseScript.AddtoHaveSeenRecentArmorFaction(TalkingActorRef.Getreference() as actor, 4)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN CODE
Actor akactor = TalkingActorRef.Getreference() as actor
SLBaseScript.AddtoHaveSeenArmorFaction(akactor, 4)
SLBaseScript.RankUpTraitFetish(akactor, 30, 5)
SLPCScript.ThinkAboutPlayer(akactor, 4, true, true, iFavorPoint)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_31
Function Fragment_31()
;BEGIN CODE
SLADetectOutfitGlobal.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
if SLApproachMain.debugLogFlag
Debug.notification("Detecting Player Attire")
endif
Actor akactor = TalkingActorRef.Getreference() as actor
if !akactor.isinfaction(slapp_HaveSeenBody)
akactor.addtofaction(slapp_HaveSeenBody)
endif
iFavorPoint = (akactor.getfactionrank(slapp_AquaintedFaction)) * 8
SLADetectOutfitGlobal.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN CODE
SLADetectOutfitGlobal.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN CODE
SLADetectOutfitGlobal.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Actor akactor = TalkingActorRef.Getreference() as actor
SLBaseScript.AddtoHaveSeenArmorFaction(akactor, 5)
SLBaseScript.AddtoHaveSeenNudeFaction(akactor, 0, true)
SLBaseScript.RankUpTraitFetish(akactor, 30, 5)
SLPCScript.ThinkAboutPlayer(akactor, 4, true, true, iFavorPoint)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
Actor akactor = TalkingActorRef.Getreference() as actor
SLBaseScript.AddtoHaveSeenArmorFaction(akactor, 2)
SLBaseScript.RankUpTraitFetish(akactor, 20, 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_39
Function Fragment_39()
;BEGIN CODE
SLBaseScript.AddtoHaveSeenRecentArmorFaction(TalkingActorRef.Getreference() as actor, 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
Actor akactor = TalkingActorRef.Getreference() as actor
SLBaseScript.AddtoHaveSeenArmorFaction(akactor, 3)
SLBaseScript.RankUpTraitFetish(akactor, 10, 2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
GetOwningQuest().SetStage(255)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
Actor akactor = TalkingActorRef.Getreference() as actor
SLBaseScript.AddtoHaveSeenArmorFaction(akactor, 2)
SLBaseScript.RankUpTraitFetish(akactor, 20, 4)
SLPCScript.ThinkAboutPlayer(akactor, 4, true, true, iFavorPoint)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_34
Function Fragment_34()
;BEGIN CODE
SLBaseScript.AddtoHaveSeenRecentArmorFaction(TalkingActorRef.Getreference() as actor, 0);
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
Actor akactor = TalkingActorRef.Getreference() as actor
SLBaseScript.AddtoHaveSeenArmorFaction(akactor, 4)
SLBaseScript.RankUpTraitFetish(akactor, 10, 2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_35
Function Fragment_35()
;BEGIN CODE
SLBaseScript.AddtoHaveSeenRecentArmorFaction(TalkingActorRef.Getreference() as actor, 5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_37
Function Fragment_37()
;BEGIN CODE
SLBaseScript.AddtoHaveSeenRecentArmorFaction(TalkingActorRef.Getreference() as actor, 3)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property slapp_HaveSeenBody  Auto  

ReferenceAlias Property TalkingActorRef  Auto  

SLApproachBaseQuestScript Property SLBaseScript Auto

SLApproachMainScript Property SLApproachMain auto

SLAppPCSexQuestScript Property SLPCScript Auto  

Int Property iFavorPoint  Auto Hidden 

Faction Property slapp_AquaintedFaction  Auto  

GlobalVariable Property SLADetectOutfitGlobal  Auto  
