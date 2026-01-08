;================================================================================
; lvskMain.psc - Love Sickness 核心逻辑脚本
;================================================================================
; 说明：
;   这是 Love Sickness 模组的核心脚本，负责管理恋爱病的所有主要逻辑
;   包括：恋爱病触发、亢奋系统、技能丢失、等级丢失等
;================================================================================
; 主要功能：
;   1. 监听 SexLab 事件（性交开始/结束）
;   2. 处理精液效果和恋爱病触发
;   3. 管理亢奋值（Euphoria）系统
;   4. 处理技能丢失和等级丢失
;   5. 管理恋爱病持续时间
;================================================================================

Scriptname lvskMain extends Quest Conditional

; ==================== 属性定义 ====================
; 外部依赖和配置
lvskMCM Property MCM auto              ; MCM 配置脚本引用
Actor Property Player auto              ; 玩家角色引用
SexLabFramework Property SexLab auto     ; SexLab 框架引用
ImageSpaceModifier Property FadeIn auto  ; 屏幕淡入效果
GlobalVariable Property GameDaysPassed auto  ; 游戏经过天数
GlobalVariable Property TimeScale auto       ; 时间缩放因子
GlobalVariable Property GlobalTest auto      ; 测试模式开关

; 恋爱病相关的魔法效果
Spell Property LoveSickness auto       ; 恋爱病主动法术
Spell Property Hearts auto             ; 爱心视觉效果法术
MagicEffect Property LoveSicknessEffect auto ; 恋病魔法效果引用

; 各种负面效果的 Perk
Perk Property PerkBarterBuy auto       ; 买入价格加成
Perk Property PerkBarterSell auto      ; 卖出价格加成
Perk Property PerkIncomingDamage auto   ; 受到伤害加成
Perk Property PerkOutgoingDamage auto   ; 输出伤害加成
Perk Property PerkIntimidation auto     ; 威慑成功率加成
Perk Property PerkMagicCost auto        ; 魔法消耗加成
Perk Property PerkXP auto               ; 经验获取加成

; ==================== 状态变量 ====================
float Property Saturation auto          ; 亢奋值（0-100），越高越容易触发恋爱病
int Property ResistanceLoss auto        ; 抵抗力损失（0-100），永久损失，值越高越容易触发恋爱病
int Property PerkDebt auto              ; Perk点债务（因为等级丢失但没可用的perk点）

; ==================== 内部变量 ====================
float Expiration                        ; 恋爱病结束时间（以游戏天数表示）
float LastUpdate                        ; 上次更新时间（以游戏天数表示，用于计算亢奋衰减）
string[] SkillList                      ; 技能名称数组（18种技能）
bool hasSLSO                            ; 是否安装了 SLSO（Separate Orgasms）模组

;================================================================================
; OnInit - 脚本初始化事件
;================================================================================
; 说明：
;   当 Quest 启动时调用，执行初始化维护
;================================================================================
Event OnInit()
	Maintenance()
EndEvent

;================================================================================
; Maintenance - 维护函数
;================================================================================
; 说明：
;   初始化模组，注册事件，设置技能列表，检测依赖模组
;   在游戏加载时也会调用此函数
;================================================================================
Function Maintenance()
	; 如果 Quest 未运行，直接返回
	if !IsRunning()
		return
	endif

	; 注册 SexLab 事件监听器
	RegisterForEvents()
	
	; 初始化技能名称列表
	InitSkillList()
	
	; 等待1秒确保其他模组加载完成
	Utility.Wait(1)
	
	; 根据当前 MCM 设置更新恋爱病效果
	SetEffects()
	
	; 检测是否安装了 SLSO 模组（支持独立的性高潮）
	hasSLSO = (Quest.GetQuest("SLSO") != none)
EndFunction

;================================================================================
; RegisterForEvents - 注册事件监听器
;================================================================================
; 说明：
;   注册 SexLab 和自定义模组事件
;
; 事件说明：
;   - PlayerOrgasmEnd: 玩家性高潮结束时触发
;   - PlayerTrack_End: 性交场景结束时触发
;   - LVSK_Boost: 自定义事件，用于其他模组添加亢奋值
;================================================================================
Function RegisterForEvents()
	; 注册玩家性高潮结束事件
	RegisterForModEvent("PlayerOrgasmEnd", "OnPlayerOrgasmStart")
	
	; 注册性交场景结束事件
	; 注意：旧版本使用 "PlayerSex_End"，现在改用 "PlayerTrack_End"
	RegisterForModEvent("PlayerTrack_End", "OnPlayerSexEnd")
	
	; 注册自定义 Boost 事件（供其他模组调用）
	RegisterForModEvent("LVSK_Boost", "OnBoost")
EndFunction

;================================================================================
; End - 停止模组
;================================================================================
; 说明：
;   完全重置模组状态，移除所有效果
;   通常在用户禁用模组时调用
;================================================================================
Function End()
	; 重置亢奋值
	Saturation = 0.0
	StorageUtil.SetFloatValue(Player, "LVSK_Euphoria", Saturation)
	
	; 重置抵抗力损失
	ResistanceLoss = 0
	
	; 重置过期时间
	Expiration = 0.0
	
	; 取消游戏时间更新注册
	UnRegisterForUpdateGameTime()
	
	; 移除恋爱病法术
	Player.DispelSpell(LoveSickness)
	
	; 停止 Quest
	Stop()
EndFunction

;================================================================================
; OnUpdateGameTime - 游戏时间更新事件
;================================================================================
; 说明：
;   每小时（游戏时间）调用一次，处理亢奋值的自然衰减
;
; 计算逻辑：
;   - 计算经过的小时数
;   - 根据配置的衰减率减少亢奋值
;   - 更新存储的亢奋值
;================================================================================
Event OnUpdateGameTime()
	; 计算自上次更新以来经过的游戏小时数
	; +0.001 是为了防止浮点数精度问题导致的计算错误
	int hoursPassed = Math.Floor((GameDaysPassed.GetValue() - LastUpdate + 0.001) * 24)
	
	; 更新最后更新时间
	LastUpdate = GameDaysPassed.GetValue()
	
	; 根据经过的小时数和衰减率减少亢奋值
	Saturation -= hoursPassed * MCM.SaturationDecay
	
	; 确保亢奋值不低于0
	if Saturation < 0.0
		Saturation = 0.0
	endif
	
	; 更新存储的亢奋值（供其他脚本访问）
	StorageUtil.SetFloatValue(Player, "LVSK_Euphoria", Saturation)
EndEvent

;================================================================================
; OnPlayerOrgasmStart - 玩家性高潮结束事件
;================================================================================
; 说明：
;   当玩家性高潮结束时触发
;   如果 MCM 设置为"在玩家高潮时更新"，则处理精液效果
;
; 参数：
;   eventName: 事件名称
;   argString: SexLab 线

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