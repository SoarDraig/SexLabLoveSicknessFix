Scriptname lvskMain extends Quest Conditional

lvskMCM Property MCM auto
Actor Property Player auto
SexLabFramework Property SexLab auto
ImageSpaceModifier Property FadeIn auto
GlobalVariable Property GameDaysPassed auto
GlobalVariable Property TimeScale auto
GlobalVariable Property GlobalTest auto
Spell Property LoveSickness auto
Spell Property Hearts auto
MagicEffect Property LoveSicknessEffect auto
Perk Property PerkBarterBuy auto
Perk Property PerkBarterSell auto
Perk Property PerkIncomingDamage auto
Perk Property PerkOutgoingDamage auto
Perk Property PerkIntimidation auto
Perk Property PerkMagicCost auto
Perk Property PerkXP auto

float Property Saturation auto
int Property ResistanceLoss auto
int Property PerkDebt auto

float Expiration; spell end time as game days passed
float LastUpdate; last hourly update as game days passed
string[] SkillList
bool hasSLSO

Event OnInit()
	Maintenance()
EndEvent

Function Maintenance()
	if !IsRunning()
		return
	endif

	RegisterForEvents()
	InitSkillList()
	Utility.Wait(1)
	SetEffects()
	hasSLSO = (Quest.GetQuest("SLSO") != none)
EndFunction

Function RegisterForEvents()
	RegisterForModEvent("PlayerOrgasmEnd", "OnPlayerOrgasmStart")
	RegisterForModEvent("PlayerTrack_End", "OnPlayerSexEnd"); was RegisterForModEvent("PlayerSex_End", "OnPlayerSexEnd")
	RegisterForModEvent("LVSK_Boost", "OnBoost")
EndFunction

Function End()
	Saturation = 0.0
	StorageUtil.SetFloatValue(Player, "LVSK_Euphoria", Saturation)
	ResistanceLoss = 0
	Expiration = 0.0
	UnRegisterForUpdateGameTime()
	Player.DispelSpell(LoveSickness)
	Stop()
EndFunction

Event OnUpdateGameTime()
	int hoursPassed = Math.Floor((GameDaysPassed.GetValue() - LastUpdate + 0.001) * 24)
	LastUpdate = GameDaysPassed.GetValue()
	Saturation -= hoursPassed * MCM.SaturationDecay
	if Saturation < 0.0
		Saturation = 0.0
	endif
	StorageUtil.SetFloatValue(Player, "LVSK_Euphoria", Saturation)
EndEvent

Event OnPlayerOrgasmStart(string eventName, string argString, float argNum, form sender)
	if !IsRunning()
		return
	endif
	
	if MCM.WhenToUpdate == 0
		HandleSex(SexLab.HookController(argString))
	endif
EndEvent

Event OnPlayerSexEnd(Form FormRef, int tid)
	if !IsRunning()
		return
	endif

	if MCM.WhenToUpdate == 1
		HandleSex(SexLab.GetController(tid))
	endif
EndEvent

; LVSK_Boost mod event.
; eventName:  Name of your event, only used for notifications.
; magnitude:  Amount of euphoria to add.  Must be > 0.
; type:  0 if normal, 1 if simple.  A normal euphoria event can give love sickness and cause overload (and skill loss).  Magnitude is
;        multiplied by the appropriate MCM setting for major or minor increase amount.  Hearts effect is played if enabled in the MCM.
;        A simple event just gives existing euphoria a quiet bump.  It has no effect if the player isn't already love sick.  It cannot
;        cause love sickness or overload.  The magnitude is added to euphoria without multpliers.  Hearts effect is not used.  Euphoria
;        cannot be raised above 99%.
Event OnBoost(string eventName, float magnitude, int type)
	if !IsRunning() || (magnitude <= 0.0) || (type < 0) || (type > 1)
		return
	endif

	string eventString = eventName
	if eventName == ""
		eventString = "(unnamed)"
	endif
	string typeStr = "normal"
	if type == 1
		typeStr = "simple"
	endif
	string msg = "LVSK " + typeStr + " event " + eventString + " for " + magnitude
	NotifyTest(msg)
	MiscUtil.PrintConsole(msg)
	
	if type == 0; normal event
		Try(magnitude)
	else; simple event
		if IsLoveSick()
			if Saturation + magnitude < 99.0
				Saturation += magnitude
			else
				Saturation = 99.0
			endif
		endif
		StorageUtil.SetFloatValue(Player, "LVSK_Euphoria", Saturation)
	endif
EndEvent

Function NotifyTest(string msg)
	if GlobalTest.GetValue() > 0.0
		Debug.Notification(msg)
	endif
EndFunction

Function PrintTest(string msg)
	if GlobalTest.GetValue() > 0.0
		MiscUtil.PrintConsole(msg)
	endif
EndFunction

bool Function IsLoveSick()
	return Player.HasMagicEffect(LoveSicknessEffect)
EndFunction

bool Function Swallowed(bool raped)
	if MCM.SwallowOnNonRape && !raped
		return true
	elseif MCM.SwallowOnRape && raped
		return true
	elseif MCM.SwallowWhenLovesick && IsLoveSick()
		return true
	elseif (MCM.ArousalFaction != none) && (Player.GetFactionRank(MCM.ArousalFaction) >= MCM.SwallowArousal)
		return true
	elseif MCM.SwallowWhenWorking
		Form armorForm = Player.GetWornForm(0x00000004)
		if (armorForm != none) && ((armorForm as Armor) == MCM.WorkingClothes)
			return true
		endif
	endif
	return false
EndFunction

Function SetEffects()
	LoveSickness.SetNthEffectMagnitude(1, MCM.StaminaReduction); stamina
	LoveSickness.SetNthEffectMagnitude(2, MCM.ThiefReduction); sneak
	LoveSickness.SetNthEffectMagnitude(3, MCM.ThiefReduction); locks & pickpocket
	LoveSickness.SetNthEffectMagnitude(4, MCM.AlchemyReduction); alchemy
	
	PerkBarterBuy.SetNthEntryValue(0, 0, MCM.BarterFactor)
	PerkBarterSell.SetNthEntryValue(0, 0, (1 / MCM.BarterFactor))
	PerkIncomingDamage.SetNthEntryValue(0, 0, MCM.IncomingDamage)
	PerkOutgoingDamage.SetNthEntryValue(0, 0, MCM.OutgoingDamage)
	PerkIntimidation.SetNthEntryValue(0, 0, MCM.IntimidationFactor)
	PerkMagicCost.SetNthEntryValue(0, 0, MCM.MagicCost)
	PerkXP.SetNthEntryValue(0, 0, MCM.ExpFactor)
EndFunction

Function SetDuration(int extraSeconds=0)
	float now = GameDaysPassed.GetValue()
	float endTime = Expiration
	if endTime == 0.0
		endTime = now
	endif
	float secondsPerGameDay = 3600.0 * 24.0 / TimeScale.GetValue()

	Expiration = endTime + (extraSeconds / secondsPerGameDay)

	float timeLeft = endTime - now
	int durationSeconds = ((timeLeft * secondsPerGameDay) as int) + extraSeconds
	int i = LoveSickness.GetNumEffects()
	While i > 0
		i -= 1
		LoveSickness.SetNthEffectDuration(i, durationSeconds)
	EndWhile
EndFunction

Function GiveSickness(float magnitude, bool hide)
	SetEffects()
	Expiration = 0.0
	SetDuration(MCM.BaseDuration * 3600 / (TimeScale.GetValue() as int)); real seconds
	LoveSickness.Cast(Player, Player)
	PlayEffects(true, hide)
	IncreaseSaturation(magnitude * MCM.SaturationIncrement)
	LastUpdate = GameDaysPassed.GetValue()
	RegisterForUpdateGameTime(1)
EndFunction

Function ExtendSickness(float magnitude, bool hide)
	Player.DispelSpell(LoveSickness)
	SetEffects()
	SetDuration(MCM.ExtensionDuration * 3600 / (TimeScale.GetValue() as int)); real seconds
	LoveSickness.Cast(Player, Player)
	PlayEffects(false, hide)
	IncreaseSaturation(magnitude * MCM.SaturationIncrement)
EndFunction

Function Reapply(bool hide)
	Player.DispelSpell(LoveSickness)
	SetEffects()
	SetDuration(0)
	LoveSickness.Cast(Player, Player)
	PlayEffects(true, hide)
EndFunction

Function PlayEffects(bool isBegin, bool hide)
	if hide
		return
	endif
	
	bool doNotify = true
	if (isBegin && (MCM.DoHearts < 2)) || (!isBegin && (MCM.DoHearts == 0))
		Hearts.Cast(Player, Player)
		doNotify = false
	endif
	if (isBegin && (MCM.DoFade < 2)) || (!isBegin && (MCM.DoFade == 0))
		PlayFade()
		doNotify = false
	endif
	if doNotify
		Debug.Notification("You're affected by love sickness")
	endif
EndFunction

Function PlayFade(bool fullMeter=false, bool isVictim=false)
	FadeIn.applyCrossFade(2.0)
	
	int strength = 30
	if fullMeter
		strength = 100
	endif
	SexLab.PickVoice(Player).Moan(Player, strength, isVictim)
	
	Utility.Wait(2.0)
	ImageSpaceModifier.RemoveCrossFade()
EndFunction

Function IncreaseSaturation(float increment)
	Saturation += increment
	if Saturation > 100.0
		Saturation = 100.0
	endif
	StorageUtil.SetFloatValue(Player, "LVSK_Euphoria", Saturation)

	; Check for overload
	if (Saturation >= 100.0) && ((Utility.RandomInt(0, 99) < MCM.OverloadChance) || (increment > 99999.0))
		MCM.TotalOverloads = MCM.TotalOverloads + 1
		if MCM.ShakeCamera > 0.0
			Game.ShakeCamera(afStrength = MCM.ShakeCamera, afDuration=1.25)
		endif
		Saturation = 100.0 - MCM.SaturationReset
		StorageUtil.SetFloatValue(Player, "LVSK_Euphoria", Saturation)
		if MCM.ResistanceIncrement > 0
			ResistanceLoss += MCM.ResistanceIncrement
			ResistanceLoss = MinInt(ResistanceLoss, 100)
			Debug.Notification("Love sickness resistance decreased")
		endif
		if MCM.SkillLossNumber > 0
			if LoseSkills()
				SexLab.PickVoice(Player).Moan(Player, 50, true)
			endif
		endif
	endif
EndFunction

Function RepayPerkDebt()
	int points = MinInt(PerkDebt, Game.GetPerkPoints())
	Game.ModPerkPoints(-1 * points)
	PerkDebt -= points
EndFunction

Function HandleSex(sslThreadController tc)
	; Ignore solo acts or acts with player using a strap-on
	if (tc.ActorCount == 1) || tc.IsUsingStrapon(Player)
		return
	endif

	sslBaseAnimation anim = tc.Animation
	bool isVaginal = anim.HasTag("Vaginal")
	bool isAnal = anim.HasTag("Anal")
	bool isOral = anim.HasTag("Oral")
	bool isRape = tc.IsVictim(Player)
	
	int nMales = tc.Males + tc.MaleCreatures; Assume no mixing of human and creatue males
	if SexLab.GetGender(Player) == 0
		nMales -= 1
	endif
	if nMales < 1
		return; no insemination
	endif

	; Determine locations.  Handle animations that start oral and finish vaginal or anal.
	; If there are too many orifice tags, assume no oral insemination.
	; This is guesswork, since some animations have 2 men doing a spitroast while a third male masturbates.
	if (nMales == 2)
		if isOral && isVaginal && isAnal
			isOral = false
		endif
	elseif (nMales == 1)
		if isOral && isVaginal && isAnal
			isOral = false
			isAnal = false
		elseif isOral && (isVaginal || isAnal)
			isOral = false
		elseif isVaginal && isAnal
			isAnal = false
		endif
	endif
	
	bool didSwallow = false
	if MCM.ShowMessages
		if isVaginal
			Debug.Notification("Semen fills your womb")
		endif
		if isAnal
			Debug.Notification("Semen pumps into your ass")
		endif
		if isOral
			didSwallow = Swallowed(isRape)
			if didSwallow
				Debug.Notification("Semen squirts into your mouth.  You swallow it all.")
			else
				Debug.Notification("Semen fills your mouth, but you hold it back.")
			endif
		endif
	endif
	
	; Calculate effectiveness
	float magnitude = 0.0
	
	; Base effectiveness (additive factors)
	if isVaginal
		magnitude += MCM.VaginalFactor
	endif
	if isAnal
		magnitude += MCM.AnalFactor
	endif
	if isOral
		if didSwallow
			magnitude += MCM.OralFactor
		else
			magnitude += (MCM.OralFactor * 0.1)
		endif
	endif
	
	; Multiplicative factors
	if MCM.ArousalFaction != none
		magnitude *= 1.0 + (MCM.ArousalFactor * (Player.GetFactionRank(MCM.ArousalFaction) / 100))
	endif
	if tc.HasCreature
		magnitude *= MCM.CreatureFactor
	endif
	if tc.IsVictim(Player)
		magnitude *= MCM.RapeFactor
	endif
	
	; If this is on end of sex, count male partner orgasms and adjust the magnitude
	if MCM.WhenToUpdate == 1
		int nOrgasms = 0
		int i = tc.ActorCount
		While i > 0
			i -= 1
			sslActorAlias partner = tc.ActorAlias[i]
			;NotifyTest(partner.ActorRef.GetBaseObject().GetName() + " gender is " + partner.GetGender())
			if (partner.ActorRef != Player) && (partner.GetGender() != 1)
				if hasSLSO
					nOrgasms += partner.GetOrgasmCount()
				else
					nOrgasms += 1
				endif
			endif
		EndWhile
		NotifyTest(nMales + " males had " + nOrgasms + " orgasms")
		magnitude *= nOrgasms / nMales
	endif
	
	Try(magnitude)
EndFunction

Function Try(float magnitude)
	NotifyTest("Magnitude is " + magnitude)

	; Was love sickness triggered?
	if IsLoveSick()
		if Utility.RandomFloat() < ((MCM.ExtensionChance + Saturation + ResistanceLoss) / 100.0) * magnitude
			ExtendSickness(magnitude, false)
		else
			IncreaseSaturation(magnitude * MCM.SaturationMinorIncrement)
		endif
	elseif Utility.RandomFloat() < ((MCM.BaseChance + Saturation + ResistanceLoss) / 100.0) * magnitude
		GiveSickness(magnitude, false)
	endif
EndFunction

; Return true if any skills were actually lost
bool Function LoseSkills()
	float xpPerRank = Game.GetGameSettingFloat("fXPPerSkillRank")
	string msg = "You lost a rank in "
	string[] lostSkillNames = new string[20]
	int nLostSkills = 0
	int skillFloor = MCM.SkillFloor
	bool lostLevel = false; true if a character level was lost
	int nAttempts = 0
	While nAttempts < MCM.SkillLossNumber
		; Calculate skill ranks.  Although it's slow, we must do this every pass.
		; A skill might lose a rank and no longer be eligible.
		; Also, mods that change XP gain per skill can cause a skill rank to be "lost" without actually dropping a full rank.
		int[] skillRanks = new int[18]; Number of ranks is that skill's weight
		int[] skillIndexes = new int[18]; Indexes of eligible skills
		int nSkills = 0; number of eligible skills
		int totalRanks = 0
		int i = 0
		While i < 18
			if MCM.AffectedSkills[i]
				ActorValueInfo avi = ActorValueInfo.GetActorValueInfobyID(6 + i); skills are 6 to 23
				int nRanks = (avi.GetBaseValue(Player) as int) - skillFloor
				;Debug.Notification(avi.GetName() + ": " + nRanks)
				if nRanks > 0; an eligible skill
					if MCM.NoSkillWeight
						nRanks = 1
					endif
					skillIndexes[nSkills] = i
					skillRanks[nSkills] = nRanks
					totalRanks += nRanks
					nSkills += 1
				endif
			endif
			i += 1
		EndWhile
		
		if nSkills == 0; All skills are too low
			NotifySkillsLost(nLostSkills, lostSkillNames, lostLevel)
			return (nLostSkills > 0)
		endif
	
		; Choose a skill to lose
		int rank = Utility.RandomInt(1, totalRanks)
		int skillIndex = -1
		i = 0
		While (i < nSkills) && (skillIndex == -1)
			if rank <= skillRanks[i]
				skillIndex = i; Found it
			endif
			rank -= skillRanks[i]
			i += 1
		EndWhile
		
		if skillIndex == -1; This should never happen
			NotifySkillsLost(nLostSkills, lostSkillNames, lostLevel)
			MiscUtil.PrintConsole("LVSK: Bad skill lookup")
			return (nLostSkills > 0)
		endif
		
		; Try to lose one rank in the chosen skill.
		ActorValueInfo avi = ActorValueInfo.GetActorValueInfobyID(6 + skillIndexes[skillIndex])
		int skillRank = avi.GetBaseValue(Player) as int
		PrintTest("Selected skill: " + skillIndexes[skillIndex] + " - " + avi.GetName() + " rank " + skillRank)
		float playerXP = Game.GetPlayerExperience()
		float xpCost = skillRank * xpPerRank
		; Test for bottom of character level situation, if level loss is disabled or impossible.
		int playerLevel = Player.GetLevel()
		if (xpCost > playerXP) && (!MCM.AllowLevelLoss || playerLevel == 1)
			; Player lacks enough level XP to lose this skill.
			; We could abort here, but keep trying for a lower-cost skill for the full number of allowed attempts.
		else
			; Player loses a skill rank
			MCM.TotalSkillsLost = MCM.TotalSkillsLost + 1
			float xp = avi.GetExperienceForLevel(skillRank - 1) * (avi.GetSkillExperience() / avi.GetExperienceForLevel(skillRank))
			PrintTest("Old XP " + avi.GetSkillExperience() + ".  New XP " + xp)
			avi.SetSkillExperience(xp)
			PrintTest("Setting " + SkillList[skillIndexes[skillIndex]] + " to " + (skillRank - 1))
			Player.SetActorValue(SkillList[skillIndexes[skillIndex]], skillRank - 1)
			if nAttempts > 0
				if (MCM.SkillLossNumber == 2)
					msg += " and "
				else
					msg += ", "
					if (MCM.SkillLossNumber > 2) && (i == MCM.SkillLossNumber - 1)
						msg += "and "
					endif
				endif
			endif
			msg += avi.GetName()
			lostSkillNames[nLostSkills] = avi.GetName()
			nLostSkills += 1
			
			if xpCost <= playerXP
				Game.SetPlayerExperience(playerXP - xpCost)
			else
				; Player loses a level
				lostLevel = true
				LoseLevel(playerLevel - 1, xpCost - playerXP)
			endif
		endif
		nAttempts += 1
	EndWhile
	
	NotifySkillsLost(nLostSkills, lostSkillNames, lostLevel)
	return (nLostSkills > 0)
EndFunction

Function NotifySkillsLost(int nSkills, string[] skillNames, bool lostLevel)
	if nSkills == 0
		Debug.Notification("No skills were lost")
		return
	endif
	
	; Sort skill names
	int index1 = 0
	int index2 = nSkills - 1
	While index2 > 0
		index1 = 0
		While index1 < index2
			if skillNames[index1] > skillNames[index1 + 1]
				string temp = skillNames[index1]
				skillNames[index1] = skillNames[index1 + 1]
				skillNames[index1 + 1] = temp
			endif
			index1 += 1
		EndWhile
		index2 -= 1
	EndWhile

	string msg = "You lost a rank in "
	int i = 0
	While i < nSkills
		msg += skillNames[i]
		if i < (nSkills - 1)
			if nSkills > 2
				msg += ", "
			endif
			if i == (nSkills - 2)
				if i == 0
					msg += " and "
				else
					msg += "and "
				endif
			endif
		endif
		i += 1
	EndWhile
	msg += "."
	
	if lostLevel
		Debug.MessageBox("You lost a level.  You're now level " + Player.GetLevel() + ".\n\n" + msg)
	else
		Debug.MessageBox(msg)
	endif
EndFunction

Function LoseLevel(int newLevel, float xpDeficit)
	; Reduce the level
	MCM.TotalLevelsLost = MCM.TotalLevelsLost + 1
	Game.SetPlayerLevel(newLevel)
	float xpForTopOfLevel = Game.GetExperienceForLevel(newLevel); the XP to level up
	Game.SetPlayerExperience(xpForTopOfLevel - xpDeficit)
	
	; Deduct a perk point (or add to perk debt)
	if Game.GetPerkPoints() > 0
		Game.ModPerkPoints(-1)
		RepayPerkDebt(); If there's also a previous perk debt, pay that down, if possible
	else
		PerkDebt += 1
	endif
	
	; Lose Health, Magicka, or Stamina
	int hmsLevelUp = Game.GetGameSettingInt("iAVDhmsLevelup"); amount of increase on level up
	if hmsLevelUp == 0; unusual, but player might have set this to zero
		return
	endif
	
	float health = Player.GetBaseActorValue("Health")
	float magicka = Player.GetBaseActorValue("Magicka")
	float stamina = Player.GetBaseActorValue("Stamina")
	
	string statName = ""
	if (MCM.StatLossOption == 1) && (health > 100)
		statName = "Health"
	elseif (MCM.StatLossOption == 2) && (magicka > 100)
		statName = "Magicka"
	elseif (MCM.StatLossOption == 3) && stamina > 100
		statName = "Stamina"
	else; "Highest value"
		if stamina > 100
			statName = "Stamina"
		endif
		if (magicka > stamina) && (magicka > 100)
			statName = "Magicka"
		endif
		if (health > magicka) && (health > 100)
			statName = "Health"
		endif
	endif
	
	if statName == ""
		Debug.MessageBox("Love Sickness error: Unable to reduce Health, Magicka, or Stamina for level loss because all three are at or below 100.")
		return
	endif
	
	Player.SetActorValue(statName, Player.GetBaseActorValue(statName) - hmsLevelUp)
	if statName == "Stamina"; lose carrying capacity too
		Player.SetActorValue("CarryWeight", Player.GetBaseActorValue("CarryWeight") - Game.GetGameSettingFloat("fLevelUpCarryWeightMod"))
	endif
EndFunction

int Function MaxInt(int v1, int v2)
	if v1 >= v2
		return v1
	endif
	return v2
EndFunction

int Function MinInt(int v1, int v2)
	if v1 <= v2
		return v1
	endif
	return v2
EndFunction

float Function MinFloat(float v1, float v2)
	if v1 <= v2
		return v1
	endif
	return v2
EndFunction

; ActorValueInfo GetName() returns the player-friendly name, not the reference name.
; Why is there no vanilla lookup for reference name by ID?  So we need this ugly thing.
Function InitSkillList()
	SkillList = new string[18]
	SkillList[0]  = "OneHanded"
	SkillList[1]  = "TwoHanded"
	SkillList[2]  = "Marksman"
	SkillList[3]  = "Block"
	SkillList[4]  = "Smithing"
	SkillList[5]  = "HeavyArmor"
	SkillList[6]  = "LightArmor"
	SkillList[7]  = "Pickpocket"
	SkillList[8]  = "Lockpicking"
	SkillList[9]  = "Sneak"
	SkillList[10] = "Alchemy"
	SkillList[11] = "Speechcraft"
	SkillList[12] = "Alteration"
	SkillList[13] = "Conjuration"
	SkillList[14] = "Destruction"
	SkillList[15] = "Illusion"
	SkillList[16] = "Restoration"
	SkillList[17] = "Enchanting"
EndFunction