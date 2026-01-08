;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SF_SLApproachResponsetoNudit_07A407AB Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
int irank = 0
if (talkingActor.getreference() as actor).isinfaction(slapp_ThinkExhibitionistFaction)
irank = (talkingActor.getreference() as actor).getfactionrank(slapp_ThinkExhibitionistFaction) + 1
else
irank = 0
endif
(Getowningquest() as SLAppPCSexQuestScript).ThinkAboutPlayer(talkingActor.getreference() as actor, 4, irank, true)
stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property talkingActor  Auto  

Faction Property slapp_ThinkExhibitionistFaction  Auto  
