Scriptname SLSW_LillysTurn extends Quest  

Quest Property SLSW_Lilly Auto
SexLabFramework Property SexLab Auto
ReferenceAlias Property LillysClient Auto
ReferenceAlias Property Lilly Auto

Function Action()

RegisterForModEvent("AnimationEnd_Lilly", "LillyClient")

Int Random = Utility.RandomInt(1, 6)

actor[] sexActors = new actor[2]
sexActors[0] = Lilly.getRef() as Actor
sexActors[1] = LillysClient.getRef() as Actor

sslBaseAnimation[] anims

If Random == 1
	anims = SexLab.GetAnimationsByTags(2, "Aggressive, Anal")
elseIf Random == 2
	anims = SexLab.GetAnimationsByTags(2, "Aggressive, Blowjob")
elseIf Random == 3
	anims = SexLab.GetAnimationsByTags(2, "Aggressive, Vaginal")
elseIf Random == 4
	anims = SexLab.GetAnimationsByTags(2, "Vaginal")
elseIf Random == 5
	anims = SexLab.GetAnimationsByTags(2, "Blowjob")
else
	anims = SexLab.GetAnimationsByTags(2, "Anal")
endif

SexLab.StartSex(sexActors, anims, allowBed=true, hook="Lilly")

Return
endFunction

Event LillyClient(string eventName, string argString, float argNum, form sender)

SLSW_Lilly.SetStage(20)

UnregisterforModEvent("AnimationEnd_Lilly")

endevent
