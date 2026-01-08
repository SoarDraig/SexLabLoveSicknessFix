Scriptname SLSW_TwigsTurn extends Quest  

Quest Property SLSW_Twig Auto
SexLabFramework Property SexLab Auto
ReferenceAlias Property TwigsClient Auto
ReferenceAlias Property Twig Auto

Function Action()

RegisterForModEvent("AnimationEnd_Twig", "TwigClient")

Int Random = Utility.RandomInt(1, 6)

actor[] sexActors = new actor[2]
sexActors[0] = Twig.getRef() as Actor
sexActors[1] = TwigsClient.getRef() as Actor

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

SexLab.StartSex(sexActors, anims, allowBed=true, hook="Twig")

Return
endFunction

Event TwigClient(string eventName, string argString, float argNum, form sender)

SLSW_Twig.SetStage(20)

UnregisterforModEvent("AnimationEnd_Twig")

endevent
