;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SF_SLAppShowingOffBodyScene_078134AE Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
actor akactor = talkingactor.getreference() as actor
if akactor.getfactionrank(slapp_HaveSeenNakedBody) <= 1
(Getowningquest() as SLAppPCSexQuestScript).StripShowEnd(0, true)
else
(Getowningquest() as SLAppPCSexQuestScript).StripShowEnd(0, false)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property talkingActor  Auto  

Faction Property slapp_HaveSeenNakedBody  Auto  
