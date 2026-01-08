Scriptname lvskEffect extends ActiveMagicEffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int i = Perks.GetSize()
	While i > 0
		i -= 1
		Player.AddPerk(Perks.GetAt(i) as Perk)
	EndWhile
	StorageUtil.SetIntValue(Player, "LVSK_IsLovesick", 1)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	int i = Perks.GetSize()
	While i > 0
		i -= 1
		Player.RemovePerk(Perks.GetAt(i) as Perk)
	EndWhile
	StorageUtil.SetIntValue(Player, "LVSK_IsLovesick", 0)
EndEvent

Actor Property Player auto
FormList Property Perks auto