;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname SF_SLAppAskingKidScene_07502375 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
(Getowningquest() as SLAppPCSexQuestScript).endApproachForce();
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
SLApproachAskNameKidTimes.setvalue(SLApproachAskNameKidTimes.getvalue() + 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
SLApproachAskNameKidTimes.setvalue(SLApproachAskNameKidTimes.getvalue() + 1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property SLApproachAskNameTimes  Auto  
SLAppPCSexQuestScript Property SQuest Auto
GlobalVariable Property SLApproachAskNameKidTimes  Auto  
