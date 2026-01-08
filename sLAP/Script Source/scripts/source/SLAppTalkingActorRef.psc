Scriptname SLAppTalkingActorRef extends ReferenceAlias  

Event OnCellDetach()
	(GetOwningQuest() as SLApproachBaseQuestScript).endApproachDetachCell()
EndEvent

Event OnDetachedFromCell()
	(GetOwningQuest() as SLApproachBaseQuestScript).endApproachDetachCell()
EndEvent