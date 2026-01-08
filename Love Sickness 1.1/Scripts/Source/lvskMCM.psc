;================================================================================
; lvskMCM.psc - Love Sickness MCM 配置界面脚本
;================================================================================
; 说明：
;   这是 Love Sickness 模组的 MCM（Mod Configuration Menu）配置界面脚本
;   继承自 SKI_ConfigBase，提供完整的用户界面来配置模组所有参数
;================================================================================
; 主要功能：
;   1. 创建三个配置页面：设置、技能影响、系统
;   2. 提供各种控件：滑块、开关、菜单、按钮、文本
;   3. 处理用户输入和状态管理
;   4. 版本控制和升级逻辑
;================================================================================

Scriptname lvskMCM extends SKI_ConfigBase

; ==================== 属性定义 ====================
; 核心引用
lvskMain Property MQ auto           ; 主脚本引用，用于调用核心功能
Actor Property Player auto          ; 玩家角色引用
Armor Property TavernClothes auto   ; 酒馆服装（默认工作服装）

; 可配置属性
Armor Property WorkingClothes auto   ; 工作服装（用于判断是否为妓女）
Faction Property ArousalFaction auto  ; 性唤醒阵营（SexLab Aroused）

; ==================== 精液吞咽配置 ====================
bool

int RepayButton
int ReapplyButton
int SwallowArousalOID
int WhenToUpdateOIDM
int BaseChanceOID
int ExtensionChanceOID
int BaseDurationOID
int ExtensionDurationOID
int VaginalFactorOID
int OralFactorOID
int AnalFactorOID
int ArousalFactorOID
int RapeFactorOID
int CreatureFactorOID
int OverloadChanceOID
int SaturationIncrementOID
int SaturationMinorIncrementOID
int SaturationDecayOID
int ResistanceIncrementOID
int SaturationOID
int ResistanceLossOID
int IncomingDamageOID
int OutgoingDamageOID
int MagicCostOID
int StaminaReductionOID
int IntimidationFactorOID
int ExpFactorOID
int BarterFactorOID
int AlchemyReductionOID
int ThiefReductionOID 
int WorkingClothesButton
int SkillLossNumberOID
int SaturationResetOID
int SkillFloorOID
int TotalOverloadsOID
int TotalSkillsLostOID
int TotalLevelsLostOID
int StatLossOIDM
int DoFadeOIDM
int DoHeartsOIDM
int ShakeCameraOID
int GiveSicknessButton
int ForceOverloadButton

bool IsEnabled=true
bool InitializedAffectedSkills=false
float VersionNum
string[] WhenToUpdateOptions
string[] AinList
string[] StatLossOptions

Event OnConfigOpen()
	if VersionNum < 1.0; Newly installed
		if Quest.GetQuest("SLSO") != none
			WhenToUpdate = 1
			SetMenuOptionValue(WhenToUpdateOIDM, WhenToUpdateOptions[WhenToUpdate])
		endif
	endif
	;
	if !InitializedAffectedSkills
		InitializedAffectedSkills = true
		AffectedSkills = new bool[18]
		int i = 0
		While i < 18
			AffectedSkills[i] = true
			i += 1
		EndWhile
	endif	
	; Increase the version number (yymm.dd) to force a single update the next time the player opens the MCM
	if VersionNum < 2310.15
		VersionNum = 2310.15
		MiscUtil.PrintConsole("Updating Love Sickness MCM")
		if WorkingClothes == none
			WorkingClothes = TavernClothes
		endif
		InitLists()
		ForcePageReset()
	endif
	
	if ArousalFaction == none
		Form slaForm = Game.GetFormFromFile(0x0003FC36, "SexLabAroused.esm")
		if slaForm != none
			ArousalFaction = slaForm as Faction
		endif
	endif

	Pages = new string[3]
	Pages[0] = "Settings"
	Pages[1] = "Skills Affected"
	Pages[2] = "System"
EndEvent

Event OnPageReset(string page)
	SetCursorFillMode(TOP_TO_BOTTOM)
	
	if (page == "Settings") || (page == "")
		ReapplyButton = AddTextOption("Reapply love sickness", "Click", DisplayOnFor(IsEnabled && MQ.IsLoveSick()))
		RepayButton = AddTextOption("Perk point debt: " + MQ.PerkDebt, "Pay", DisplayOnFor((MQ.PerkDebt > 0) && (Game.GetPerkPoints() > 0)))
		
		AddHeaderOption(" Conditions")
		WhenToUpdateOIDM = AddMenuOption(" When to check", WhenToUpdateOptions[WhenToUpdate])
		BaseChanceOID = AddSliderOption(" Base chance", BaseChance, "{0}%")
		ExtensionChanceOID = AddSliderOption( " Extension chance", ExtensionChance, "{0}%")
		
		VaginalFactorOID = AddSliderOption(" Vaginal factor", VaginalFactor, "{2}")
		OralFactorOID = AddSliderOption(" Oral factor", OralFactor, "{2}")
		AnalFactorOID = AddSliderOption(" Anal factor", AnalFactor, "{2}")
		ArousalFactorOID = AddSliderOption(" Arousal factor", ArousalFactor, "{2}")
		RapeFactorOID = AddSliderOption(" Rape factor", RapeFactor, "{2}")
		CreatureFactorOID = AddSliderOption(" Creature potency", CreatureFactor, "{2}")
		
		AddHeaderOption(" Swallowing")
		SwallowArousalOID = AddSliderOption(" At arousal threshold", SwallowArousal, "{0}")
		AddToggleOptionST("st_SwallowWhenLovesick", " When love sick", SwallowWhenLovesick)
		AddToggleOptionST("st_SwallowOnRape", " When a victim", SwallowOnRape)
		AddToggleOptionST("st_SwallowOnNonRape", " When not a victim", SwallowOnNonRape)
		AddToggleOptionST("st_SwallowWhenWorking", " When working", SwallowWhenWorking)
		WorkingClothesButton = AddTextOption(" Set working clothes", WorkingClothes.GetName())

		AddHeaderOption(" Visible Effects")
		DoFadeOIDM = AddMenuOption(" Fade to pink", AinList[DoFade])
		DoHeartsOIDM = AddMenuOption(" Hearts", AinList[DoHearts])
		AddToggleOptionST("st_ShowMessages", " Display insemination notifications", ShowMessages)
		ShakeCameraOID = AddSliderOption(" Camera shake strength on overload", ShakeCamera, "{1}")
		
		SetCursorPosition(1); --------------
		SaturationOID = AddTextOption(" Euphoria", RoundAsString(MQ.Saturation, 1)+"%")
		ResistanceLossOID = AddTextOption(" Resistance loss", MQ.ResistanceLoss+"%")
		
		AddHeaderOption(" Euphoria")
		SaturationIncrementOID = AddSliderOption(" Major increase amount", SaturationIncrement, "{0}")
		SaturationMinorIncrementOID = AddSliderOption(" Minor increase amount", SaturationMinorIncrement, "{0}")
		SaturationDecayOID = AddSliderOption(" Decay rate", SaturationDecay, "{0}")
		OverloadChanceOID = AddSliderOption(" Overload chance", OverloadChance, "{0}%")
		SaturationResetOID = AddSliderOption(" Reduction on overload", SaturationReset, "{0}%")
		ResistanceIncrementOID = AddSliderOption(" Resistance loss on overload", ResistanceIncrement, "{0}")
		
		AddHeaderOption(" Love sickness effects")
		BaseDurationOID = AddSliderOption(" Base duration (game hours)", BaseDuration, "{0}")
		ExtensionDurationOID = AddSliderOption(" Extension duration (game hours)", ExtensionDuration, "{0}")
		
		ExpFactorOID = AddSliderOption(" Experience gain", ExpFactor, "{2}")
		IncomingDamageOID = AddSliderOption(" Incoming damage", IncomingDamage, "{2}")
		OutgoingDamageOID = AddSliderOption(" Weapon damage", OutgoingDamage, "{2}")
		MagicCostOID = AddSliderOption(" Spell cost", MagicCost, "{2}")
		StaminaReductionOID = AddSliderOption(" Stamina reduction", StaminaReduction, "{0}")
		IntimidationFactorOID = AddSliderOption(" Intimidation", IntimidationFactor, "{2}")
		BarterFactorOID = AddSliderOption(" Bartering prices", BarterFactor, "{2}")
		AlchemyReductionOID = AddSliderOption(" Alchemy reduction", AlchemyReduction, "{0}%")
		ThiefReductionOID = AddSliderOption(" Thief skill reduction", ThiefReduction, "{0}")
		
		AddHeaderOption(" Skill Loss")
		SkillLossNumberOID = AddSliderOption(" Number of skills to lose", SkillLossNumber, "{0}")
		SkillFloorOID = AddSliderOption(" Minimum skill level", SkillFloor, "{0}")
		AddToggleOptionST("st_NoSkillWeight", " No skill weighting", NoSkillWeight)
		AddToggleOptionST("st_AllowLevelLoss", " Character level loss (recommended ON)", AllowLevelLoss)
		StatLossOIDM = AddMenuOption(" Stat to lose", StatLossOptions[StatLossOption])
	elseif page == "Skills Affected"
		AddToggleOptionST("st_Smithing", " " + GetSkillName(4), AffectedSkills[4])
		AddToggleOptionST("st_Alchemy", " " + GetSkillName(10), AffectedSkills[10])
		AddToggleOptionST("st_Enchanting", " " + GetSkillName(17), AffectedSkills[17])
		AddEmptyOption()
		AddToggleOptionST("st_OneHanded", " " + GetSkillName(0), AffectedSkills[0])
		AddToggleOptionST("st_TwoHanded", " " + GetSkillName(1), AffectedSkills[1])
		AddToggleOptionST("st_Marksman", " " + GetSkillName(2), AffectedSkills[2])
		AddToggleOptionST("st_Block", " " + GetSkillName(3), AffectedSkills[3])
		AddToggleOptionST("st_HeavyArmor", " " + GetSkillName(5), AffectedSkills[5])
		AddToggleOptionST("st_LightArmor", " " + GetSkillName(6), AffectedSkills[6])
		SetCursorPosition(1); --------------
		AddToggleOptionST("st_Lockpicking", " " + GetSkillName(8), AffectedSkills[8])
		AddToggleOptionST("st_Sneak", " " + GetSkillName(9), AffectedSkills[9])
		AddToggleOptionST("st_Pickpocket", " " + GetSkillName(7), AffectedSkills[7])
		AddEmptyOption()
		AddToggleOptionST("st_Speechcraft", " " + GetSkillName(11), AffectedSkills[11])
		AddToggleOptionST("st_Alteration", " " + GetSkillName(12), AffectedSkills[12])
		AddToggleOptionST("st_Conjuration", " " + GetSkillName(13), AffectedSkills[13])
		AddToggleOptionST("st_Destruction", " " + GetSkillName(14), AffectedSkills[14])
		AddToggleOptionST("st_Illusion", " " + GetSkillName(15), AffectedSkills[15])
		AddToggleOptionST("st_Restoration", " " + GetSkillName(16), AffectedSkills[16])
	elseif page == "System"
		AddToggleOptionST("st_Enable", " Enable", IsEnabled)
		AddEmptyOption()
		GiveSicknessButton = AddTextOption(" Give me love sickness", "Click", DisplayOnFor(IsEnabled && !MQ.IsLoveSick()))
		if (IsEnabled && MQ.GlobalTest.GetValue() > 0); Test functions
			ForceOverloadButton = AddTextOption(" Force overload", "Click")
		else
			ForceOverloadButton = AddTextOption("", "", DisplayOnFor(false))
		endif
		SetCursorPosition(1)
		TotalOverloadsOID = AddTextOption(" Number of overloads", TotalOverloads)
		TotalSkillsLostOID = AddTextOption(" Total skills lost", TotalSkillsLost)
		TotalLevelsLostOID = AddTextOption(" Times levels were lost", TotalLevelsLost)
	endif
EndEvent

; States ==================================================

State st_Enable
	Event OnSelectST()
		if IsEnabled 
			if !ShowMessage("Turning this off will shut down the mod, removing any love sickness and resetting all progress (euphoria and resistance loss), though any perk point debt will still be remembered.  Do you want to proceed?")
				return
			else
				if ((MQ.Saturation + MQ.ResistanceLoss) > 0.0) && !ShowMessage("Are you sure?  If you continue, not only will any love sickness be removed, but the euphoria and resistance levels will also be reset to zero.")
					return
				endif
			endif
		endif
		IsEnabled = !IsEnabled
		SetToggleOptionValueST(IsEnabled)
	
		if IsEnabled
			Debug.MessageBox("Exit the MCM")
			MQ.Start()
		else
			Debug.MessageBox("Removing effects and resetting all progress.\nExit the MCM.")
			SetTextOptionValue(SaturationOID, "0%")
			SetTextOptionValue(ResistanceLossOID, "0%")
			MQ.End()
		endif
	EndEvent

	Event OnHighlightST()
		SetInfoText("Enable Love Sickness.  Turning this off will remove effects and reset all progress.")
	EndEvent
EndState

State st_SwallowOnNonRape
	Event OnSelectST()
		SwallowOnNonRape = !SwallowOnNonRape
		SetToggleOptionValueST(SwallowOnNonRape)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Your character will swallow during oral sex if sex is consensual (when not a rape victim). \nRape is defined by the SexLab victim flag, NOT by animation tags. \nIf not swallowed, semen will still have 10% of normal effectiveness.")
	EndEvent
EndState

State st_SwallowOnRape
	Event OnSelectST()
		SwallowOnRape = !SwallowOnRape
		SetToggleOptionValueST(SwallowOnRape)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Your character will swallow during oral sex when a rape victim. \nRape is defined by the SexLab victim flag, NOT by animation tags. \nIf not swallowed, semen will still have 10% of normal effectiveness.")
	EndEvent
EndState

State st_SwallowWhenLovesick
	Event OnSelectST()
		SwallowWhenLovesick = !SwallowWhenLovesick
		SetToggleOptionValueST(SwallowWhenLovesick)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Your character will swallow during oral sex when love sick. \nIf not swallowed, semen will still have 10% of normal effectiveness.")
	EndEvent
EndState

State st_SwallowWhenWorking
	Event OnSelectST()
		SwallowWhenWorking = !SwallowWhenWorking
		SetToggleOptionValueST(SwallowWhenWorking)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Your character will swallow during oral sex when working as a prostitute.  Define your working clothes below. \nIf not swallowed, semen will still have 10% of normal effectiveness.")
	EndEvent
EndState

State st_ShowMessages
	Event OnSelectST()
		ShowMessages = !ShowMessages
		SetToggleOptionValueST(ShowMessages)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Display a notification whenever your character is inseminated.")
	EndEvent
EndState

State st_NoSkillWeight
	Event OnSelectST()
		NoSkillWeight = !NoSkillWeight
		SetToggleOptionValueST(NoSkillWeight)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Normally, skills are selected for loss with a chance based on the level of the skill, so that highly developed skills have a greater chance of being selected.  Enabling this option will cause all skills to have an equal chance to be lost.")
	EndEvent
EndState

State st_AllowLevelLoss
	Event OnSelectST()
		AllowLevelLoss = !AllowLevelLoss
		SetToggleOptionValueST(AllowLevelLoss)
	EndEvent

	Event OnHighlightST()
		SetInfoText("Losing skills reduces character level progress.  Normally, skill loss stops at the bottom of a character level.  This option lets you lose levels so you can keep losing skills.  If you lose a level, you'll lose one unspent perk point.  If you have no free points, you keep all your perks but you'll have a perk point debt to repay after you regain a level.")
	EndEvent
EndState

State st_Smithing
	Event OnSelectST()
		AffectedSkills[4] = !AffectedSkills[4]
		SetToggleOptionValueST(AffectedSkills[4])
	EndEvent
EndState

State st_Alchemy
	Event OnSelectST()
		AffectedSkills[10] = !AffectedSkills[10]
		SetToggleOptionValueST(AffectedSkills[10])
	EndEvent
EndState

State st_Enchanting
	Event OnSelectST()
		AffectedSkills[17] = !AffectedSkills[17]
		SetToggleOptionValueST(AffectedSkills[17])
	EndEvent
EndState

State st_OneHanded
	Event OnSelectST()
		AffectedSkills[0] = !AffectedSkills[0]
		SetToggleOptionValueST(AffectedSkills[0])
	EndEvent
EndState

State st_TwoHanded
	Event OnSelectST()
		AffectedSkills[1] = !AffectedSkills[1]
		SetToggleOptionValueST(AffectedSkills[1])
	EndEvent
EndState

State st_Marksman
	Event OnSelectST()
		AffectedSkills[2] = !AffectedSkills[2]
		SetToggleOptionValueST(AffectedSkills[2])
	EndEvent
EndState

State st_Block
	Event OnSelectST()
		AffectedSkills[3] = !AffectedSkills[3]
		SetToggleOptionValueST(AffectedSkills[3])
	EndEvent
EndState

State st_HeavyArmor
	Event OnSelectST()
		AffectedSkills[5] = !AffectedSkills[5]
		SetToggleOptionValueST(AffectedSkills[5])
	EndEvent
EndState

State st_LightArmor
	Event OnSelectST()
		AffectedSkills[6] = !AffectedSkills[6]
		SetToggleOptionValueST(AffectedSkills[6])
	EndEvent
EndState

State st_Lockpicking
	Event OnSelectST()
		AffectedSkills[8] = !AffectedSkills[8]
		SetToggleOptionValueST(AffectedSkills[8])
	EndEvent
EndState

State st_Sneak
	Event OnSelectST()
		AffectedSkills[9] = !AffectedSkills[9]
		SetToggleOptionValueST(AffectedSkills[9])
	EndEvent
EndState

State st_Pickpocket
	Event OnSelectST()
		AffectedSkills[7] = !AffectedSkills[7]
		SetToggleOptionValueST(AffectedSkills[7])
	EndEvent
EndState

State st_Speechcraft
	Event OnSelectST()
		AffectedSkills[11] = !AffectedSkills[11]
		SetToggleOptionValueST(AffectedSkills[11])
	EndEvent
EndState

State st_Alteration
	Event OnSelectST()
		AffectedSkills[12] = !AffectedSkills[12]
		SetToggleOptionValueST(AffectedSkills[12])
	EndEvent
EndState

State st_Conjuration
	Event OnSelectST()
		AffectedSkills[13] = !AffectedSkills[13]
		SetToggleOptionValueST(AffectedSkills[13])
	EndEvent
EndState

State st_Destruction
	Event OnSelectST()
		AffectedSkills[14] = !AffectedSkills[14]
		SetToggleOptionValueST(AffectedSkills[14])
	EndEvent
EndState

State st_Illusion
	Event OnSelectST()
		AffectedSkills[15] = !AffectedSkills[15]
		SetToggleOptionValueST(AffectedSkills[15])
	EndEvent
EndState

State st_Restoration
	Event OnSelectST()
		AffectedSkills[16] = !AffectedSkills[16]
		SetToggleOptionValueST(AffectedSkills[16])
	EndEvent
EndState

; Menus ===================================================

Event OnOptionMenuOpen(int option)
	if option == WhenToUpdateOIDM
		SetMenuDialogOptions(WhenToUpdateOptions)
		SetMenuDialogStartIndex(WhenToUpdate)
		SetMenuDialogDefaultIndex(0)
	elseif option == DoFadeOIDM
		SetMenuDialogOptions(AinList)
		SetMenuDialogStartIndex(DoFade)
		SetMenuDialogDefaultIndex(0)
	elseif option == DoHeartsOIDM
		SetMenuDialogOptions(AinList)
		SetMenuDialogStartIndex(DoHearts)
		SetMenuDialogDefaultIndex(0)
	elseif option == StatLossOIDM
		SetMenuDialogOptions(StatLossOptions)
		SetMenuDialogStartIndex(StatLossOption)
		SetMenuDialogDefaultIndex(0)
	endif
EndEvent

Event OnOptionMenuAccept(int option, int index)
	if option == WhenToUpdateOIDM
		WhenToUpdate = index
		SetMenuOptionValue(option, WhenToUpdateOptions[WhenToUpdate])
	elseif option == DoFadeOIDM
		DoFade = index
		SetMenuOptionValue(option, AinList[DoFade])
	elseif option == DoHeartsOIDM
		DoHearts = index
		SetMenuOptionValue(option, AinList[DoHearts])
	elseif option == StatLossOIDM
		StatLossOption = index
		SetMenuOptionValue(option, StatLossOptions[StatLossOption])
	endif
EndEvent

; Buttons =================================================

Event OnOptionSelect(int option)
	if option == WorkingClothesButton
		Form armorForm = Player.GetWornForm(0x00000004)
		if armorForm != none
			WorkingClothes = armorForm as Armor
		else
			WorkingClothes = TavernClothes
		endif
		SetTextOptionValue(WorkingClothesButton, WorkingClothes.GetName())
	elseif option == ReapplyButton
		Debug.MessageBox("Exit the MCM")
		MQ.Reapply(false)
	elseif option == RepayButton
		MQ.RepayPerkDebt()
		ForcePageReset()
	elseif option == GiveSicknessButton
		if ShowMessage("You will get love sickness for the base duration (" + BaseDuration + " hours).  Are you sure that you want to do this?")
			Debug.MessageBox("Exit the MCM")
			Utility.Wait(0.5)
			MQ.GiveSickness(1.0, false)
		endif
	elseif option == ForceOverloadButton
		if (MQ.GlobalTest.GetValue() > 0) && ShowMessage("This is a TEST function to force an overload.  Proceed?")
			Debug.MessageBox("Exit the MCM")
			Utility.Wait(0.5)
			MQ.IncreaseSaturation(100000.0)
		endif
	endif
EndEvent

; Sliders =================================================

Event OnOptionSliderOpen(int option)
	if option == BaseChanceOID
		SetSliderDialogStartValue(BaseChance)
		SetSliderDialogDefaultValue(12)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif option == ExtensionChanceOID
		SetSliderDialogStartValue(ExtensionChance)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif option == BaseDurationOID
		SetSliderDialogStartValue(BaseDuration)
		SetSliderDialogDefaultValue(8)
		SetSliderDialogRange(1, 100)
		SetSliderDialogInterval(1)
	elseif option == ExtensionDurationOID
		SetSliderDialogStartValue(ExtensionDuration)
		SetSliderDialogDefaultValue(6)
		SetSliderDialogRange(1, 100)
		SetSliderDialogInterval(1)
	elseif option == VaginalFactorOID
		SetSliderDialogStartValue(VaginalFactor)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	elseif option == OralFactorOID
		SetSliderDialogStartValue(OralFactor)
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	elseif option == AnalFactorOID
		SetSliderDialogStartValue(AnalFactor)
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	elseif option == ArousalFactorOID
		SetSliderDialogStartValue(ArousalFactor)
		SetSliderDialogDefaultValue(0.25)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	elseif option == RapeFactorOID
		SetSliderDialogStartValue(RapeFactor)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	elseif option == CreatureFactorOID
		SetSliderDialogStartValue(CreatureFactor)
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	elseif option == SwallowArousalOID
		SetSliderDialogStartValue(SwallowArousal)
		SetSliderDialogDefaultValue(60.0)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseif option == SaturationIncrementOID
		SetSliderDialogStartValue(SaturationIncrement)
		SetSliderDialogDefaultValue(4)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif option == SaturationMinorIncrementOID
		SetSliderDialogStartValue(SaturationMinorIncrement)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif option == SaturationDecayOID
		SetSliderDialogStartValue(SaturationDecay)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, 100)
		SetSliderDialogInterval(1)
	elseif option == OverloadChanceOID
		SetSliderDialogStartValue(OverloadChance)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif option == ResistanceIncrementOID
		SetSliderDialogStartValue(ResistanceIncrement)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(0, 10)
		SetSliderDialogInterval(1)
	elseif option == IncomingDamageOID
		SetSliderDialogStartValue(IncomingDamage)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 4.0)
		SetSliderDialogInterval(0.01)
	elseif option == OutgoingDamageOID
		SetSliderDialogStartValue(OutgoingDamage)
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	elseif option == MagicCostOID
		SetSliderDialogStartValue(MagicCost)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(0.01)
	elseif option == StaminaReductionOID
		SetSliderDialogStartValue(StaminaReduction)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(10)
	elseif option == ExpFactorOID
		SetSliderDialogStartValue(ExpFactor)
		SetSliderDialogDefaultValue(0.75)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	elseif option == IntimidationFactorOID
		SetSliderDialogStartValue(IntimidationFactor)
		SetSliderDialogDefaultValue(0.1)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	elseif option == BarterFactorOID
		SetSliderDialogStartValue(BarterFactor)
		SetSliderDialogDefaultValue(1.25)
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(0.1)
	elseif option == AlchemyReductionOID
		SetSliderDialogStartValue(AlchemyReduction)
		SetSliderDialogDefaultValue(25)
		SetSliderDialogRange(0, 200)
		SetSliderDialogInterval(1)
	elseif option == ThiefReductionOID
		SetSliderDialogStartValue(ThiefReduction)
		SetSliderDialogDefaultValue(40)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif option == SkillLossNumberOID
		SetSliderDialogStartValue(SkillLossNumber)
		SetSliderDialogDefaultValue(3)
		SetSliderDialogRange(0, 12)
		SetSliderDialogInterval(1)
	elseif option == SkillFloorOID
		SetSliderDialogStartValue(SkillFloor)
		SetSliderDialogDefaultValue(15)
		SetSliderDialogRange(0, 50)
		SetSliderDialogInterval(1)
	elseif option == SaturationResetOID
		SetSliderDialogStartValue(SaturationReset)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif option == ShakeCameraOID
		SetSliderDialogStartValue(ShakeCamera)
		SetSliderDialogDefaultValue(0.1)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.1)
	endif
EndEvent

Event OnOptionSliderAccept(int option, float value)
	if option == BaseChanceOID
		BaseChance = value as int
		SetSliderOptionValue(option, BaseChance, "{0}%")
	elseif option == ExtensionChanceOID
		ExtensionChance = value as int
		SetSliderOptionValue(option, ExtensionChance, "{0}%")
	elseif option == BaseDurationOID
		BaseDuration = value as int
		SetSliderOptionValue(option, BaseDuration, "{0}")
	elseif option == ExtensionDurationOID
		ExtensionDuration = value as int
		SetSliderOptionValue(option, ExtensionDuration, "{0}")
	elseif option == VaginalFactorOID
		VaginalFactor = value
		SetSliderOptionValue(option, VaginalFactor, "{2}")
	elseif option == OralFactorOID
		OralFactor = value
		SetSliderOptionValue(option, OralFactor, "{2}")
	elseif option == AnalFactorOID
		AnalFactor = value
		SetSliderOptionValue(option, AnalFactor, "{2}")
	elseif option == ArousalFactorOID
		ArousalFactor = value
		SetSliderOptionValue(option, ArousalFactor, "{2}")
	elseif option == RapeFactorOID
		RapeFactor = value
		SetSliderOptionValue(option, RapeFactor, "{2}")
	elseif option == CreatureFactorOID
		CreatureFactor = value
		SetSliderOptionValue(option, CreatureFactor, "{2}")
	elseif option == SwallowArousalOID
		SwallowArousal = value
		SetSliderOptionValue(option, SwallowArousal, "{0}")
	elseif option == SaturationIncrementOID
		SaturationIncrement = value as int
		SetSliderOptionValue(option, SaturationIncrement, "{0}")
	elseif option == SaturationMinorIncrementOID
		SaturationMinorIncrement = value as int
		SetSliderOptionValue(option, SaturationMinorIncrement, "{0}")
	elseif option == SaturationDecayOID
		SaturationDecay = value as int
		SetSliderOptionValue(option, SaturationDecay, "{0}")
	elseif option == OverloadChanceOID
		OverloadChance = value as int
		SetSliderOptionValue(option, OverloadChance, "{0}%")
	elseif option == ResistanceIncrementOID
		ResistanceIncrement = value as int
		SetSliderOptionValue(option, ResistanceIncrement, "{0}")
	elseif option == IncomingDamageOID
		IncomingDamage = value
		SetSliderOptionValue(option, IncomingDamage, "{2}")
	elseif option == OutgoingDamageOID
		OutgoingDamage = value
		SetSliderOptionValue(option, OutgoingDamage, "{2}")
	elseif option == MagicCostOID
		MagicCost = value
		SetSliderOptionValue(option, MagicCost, "{2}")
	elseif option == StaminaReductionOID
		StaminaReduction = value as int
		SetSliderOptionValue(option, StaminaReduction, "{0}")
	elseif option == ExpFactorOID
		ExpFactor = value
		SetSliderOptionValue(option, ExpFactor, "{2}")
	elseif option == IntimidationFactorOID
		IntimidationFactor = value
		SetSliderOptionValue(option, IntimidationFactor, "{2}")
	elseif option == BarterFactorOID
		BarterFactor = value
		SetSliderOptionValue(option, BarterFactor, "{2}")
	elseif option == AlchemyReductionOID
		AlchemyReduction = value as int
		SetSliderOptionValue(option, AlchemyReduction, "{0}%")
	elseif option == ThiefReductionOID
		ThiefReduction = value as int
		SetSliderOptionValue(option, ThiefReduction, "{0}")
	elseif option == SkillLossNumberOID
		SkillLossNumber = value as int
		SetSliderOptionValue(option, SkillLossNumber, "{0}")
	elseif option == SkillFloorOID
		SkillFloor = value as int
		SetSliderOptionValue(option, SkillFloor, "{0}")
	elseif option == SaturationResetOID
		SaturationReset = value as int
		SetSliderOptionValue(option, SaturationReset, "{0}%")
	elseif option == ShakeCameraOID
		ShakeCamera = value
		SetSliderOptionValue(option, ShakeCamera, "{1}")
	endif
EndEvent

; Info text ===============================================

Event OnOptionHighlight(int option)
	if option == ReapplyButton
		SetInfoText("Update the love sickness effects.  Does NOT affect current duration. \nOnly needed if you've changed settings for debuffs and want to apply them now. \nEffects are automatically updated to match MCM settings whenever you load a game.")
	elseif option == RepayButton
		SetInfoText("You have a perk point debt because you lost a level without having unspent perk points to deduct.  You got to keep the perks you had, but regaining levels gives you new perk points that you should give back to avoid having more points than you earned.  Clicking here will repay as much of the debt as possible.")
	elseif option == GiveSicknessButton
		SetInfoText("Get love sickness for the base duration, using current MCM settings.")
	elseif option == TotalOverloadsOID
		SetInfoText("The number of times that you've experienced a euphoria overload")
	elseif option == TotalSkillsLostOID
		SetInfoText("The total number of skill ranks that you have lost due to love sickness.  (Mods that change experience gain per skill can cause a skill rank to be \"lost\" without actually dropping a full rank.  This statistic counts the number of times the mod tried to drop a skill a full rank, even if the skill didn't decrease that much.)")
	elseif option == TotalLevelsLostOID
		SetInfoText("The number of times you lost a level due to love sickness")
	elseif option == SaturationOID
		SetInfoText("Euphoria measures progress toward an \"overload\" reaction.  Its level is added to the chance for love sickness.")
	elseif option == ResistanceLossOID
		SetInfoText("The amount of resistance you've permanently lost.  It raises the chance for love sickness.  This can lead to a downward spiral as high resistance loss causes the euphoria level to rise rapidly, resulting in more resistance loss.  If resistance loss is very high, love sickness will occur with every insemination.")
	elseif option == WhenToUpdateOIDM
		SetInfoText("The time during sex with a male partner when insemination occurs and the mod checks for love sickness. \n\"On player orgasm\" assumes insemination when the player orgasms.  \"On sex end\" counts insemination regardless of whether the player orgasms.  If you use separate orgasms, this option works best.")
	elseif option == BaseChanceOID
		string info = "The base chance that insemination will cause love sickness. \nEuphoria, resistance loss, and insemination effectiveness all affect the total chance."
		SetInfoText(info)
	elseif option == ExtensionChanceOID
		SetInfoText("The chance that the duration of active love sickness will be extended when new insemination occurs. \nEuphoria, resistance loss, and insemination effectiveness all affect the total chance.")
	elseif option == VaginalFactorOID
		SetInfoText("Effectiveness of vaginal insemination.  Love sickness chance and euphoria increase are multiplied by this factor for vaginal sex.")
	elseif option == OralFactorOID
		SetInfoText("Effectiveness of oral insemination.  Love sickness chance and euphoria increase are multiplied by this factor for oral sex.")
	elseif option == AnalFactorOID
		SetInfoText("Effectiveness of anal insemination.  Love sickness chance and euphoria increase are multiplied by this factor for anal sex.")
	elseif option == ArousalFactorOID
		SetInfoText("The degree to which player arousal increases insemination effectiveness.  Requires any version of SexLab Aroused. \nExample: Player arousal is 80% and arousal factor is 0.25.  Insemination effectiveness is increased by 20%. \nLove sickness chance and euphoria increase are increased by this factor.  At a setting of zero, arousal has no effect.")
	elseif option == RapeFactorOID
		SetInfoText("Effectiveness of insemination during rape, which is defined by the SexLab victim flag, NOT by animation tags. \nLove sickness chance and euphoria increase are multiplied by this factor for rape sex.")
	elseif option == CreatureFactorOID
		SetInfoText("Effectiveness of creature semen compared to human semen (at 1, they're the same).  Creature size is not a factor. \nLove sickness chance and euphoria increase are multiplied by this factor for creature sex.")
	elseif option == SwallowArousalOID
		SetInfoText("Your character will swallow during oral sex when arousal is at least this high.  Requires any version of SexLab Aroused.\nIf not swallowed, semen will still have 10% of normal effectiveness.")
	elseif option == BaseDurationOID
		SetInfoText("The base duration of love sickness in game hours")
	elseif option == ExtensionDurationOID
		SetInfoText("The game hours added to the duration of active love sickness if it gets triggered again.\nChanging your game's time scale after you get love sickness can confuse the calculation for extending the duration.")
	elseif option == SaturationIncrementOID
		SetInfoText("When love sickness begins or is extended, euphoria increases by this amount times the insemination effectiveness.")
	elseif option == SaturationMinorIncrementOID
		SetInfoText("During love sickness, when insemination occurs and the chance to extend the duration does NOT trigger, euphoria increases by this amount times the insemination effectiveness.  It is intended that this value be less than the major increase amount, since it is the less bad thing that happens when you avoid extending the love sickness duration.")
	elseif option == SaturationDecayOID
		SetInfoText("The rate at which the euphoria level decreases every game hour.")
	elseif option == OverloadChanceOID
		SetInfoText("The chance for an \"overload\" reaction to occur when euphoria reaches 100%.  This triggers 3 things:\nLoss of skill levels, according to the skill loss setting (can be zero). \nLoss of resistance to love sickness according to the resistance loss setting (can be zero). \nEuphoria reduction, according to the setting for reduction on overload (can be zero).")
	elseif option == ResistanceIncrementOID
		SetInfoText("How much resistance toward love sickness you lose when euphoria reaches 100% and \"overload\" occurs. \nBe careful.  Resistance loss is permanent.")
	elseif option == IncomingDamageOID
		SetInfoText("During love sickness, damage to the player is multiplied by this factor.")
	elseif option == OutgoingDamageOID
		SetInfoText("During love sickness, the damage the player does with weapons (not spells) is multiplied by this factor.")
	elseif option == MagicCostOID
		SetInfoText("During love sickness, the cost of player spells is multiplied by this factor.")
	elseif option == StaminaReductionOID
		SetInfoText("During love sickness, player stamina is reduced by this amount.")
	elseif option == ExpFactorOID
		SetInfoText("During love sickness, experience gain is multiplied by this factor. \nNOTE: This also affects skill books and training.")
	elseif option == IntimidationFactorOID
		SetInfoText("During love sickness, the chance of player intimidation attempts is multiplied by this factor.")
	elseif option == BarterFactorOID
		SetInfoText("During love sickness, buying prices are multiplied by this factor and selling prices are divided by it.")
	elseif option == AlchemyReductionOID
		SetInfoText("During love sickness, the power of created potions is reduced by this factor.")
	elseif option == ThiefReductionOID
		SetInfoText("During love sickness, sneak, lockpicking, and pickpocketing skills are reduced by this amount.")
	elseif option == WorkingClothesButton
		SetInfoText("When you're wearing this body clothing, the mod assumes that you're working as a prostitute. \nClick to select your current body clothing.")
	elseif option == SaturationResetOID
		SetInfoText("When euphoria reaches 100%, an \"overload\" reaction can occur.  If it does, euphoria is reduced by this amount. \nBe careful.  At a very low setting, a gang bang could cause overload for every round of sex.")
	elseif option == ShakeCameraOID
		SetInfoText("Briefly shake the camera with this strength when overload occurs.  0 disables camera shake. \nThe default strength of 0.1 is gentle.  (For reference, game default camera shake strength is 0.5.)")
	elseif option == SkillLossNumberOID
		SetInfoText("The number of skill ranks lost per overload.  A skill might be selected for loss more than once per skill loss event. \nLosing skills also reduces character level progress.")
	elseif option == SkillFloorOID
		SetInfoText("Skills at or below this level cannot be lost.")
	elseif option == DoFadeOIDM
		SetInfoText("The screen fades to pink when love sickness begins or its duration is extended.\n\"Only at onset\" means only when you get love sickness, not when its duration is extended.\nIf this and the hearts effect are both disabled, a notification message will display instead.")
	elseif option == DoHeartsOIDM
		SetInfoText("The player is enveloped by hearts for a few seconds when love sickness begins or its duration is extended.\n\"Only at onset\" means only when you get love sickness, not when its duration is extended.\nIf this and the fade to pink effect are both disabled, a notification message will display instead.")
	elseif option == StatLossOIDM
		SetInfoText("Select whether to lose health, magicka, or stamina (or whichever is highest) when you lose a level.  Carry weight will be reduced if stamina is lost.  Regardless of this setting, a stat will never be reduced below 100, so if necessary a different one will be chosen.")
	endif
EndEvent

; Functions ===============================================

int Function DisplayOnFor(bool flag)
	if flag
		return OPTION_FLAG_NONE
	endif
	return OPTION_FLAG_DISABLED
EndFunction

string Function RoundAsString(float number, int precision)
	if number == 0.0
		return "0"
	endif

	string result = number as int
	number -= number as int
	if precision > 0
		result += "."
	endif
	While precision > 0
		precision -= 1
		number *= 10
		result += number as int
		number -= number as int
	EndWhile
	return result
EndFunction

string Function GetSkillName(int index)
	ActorValueInfo avi = ActorValueInfo.GetActorValueInfobyID(6 + index)
	return avi.GetName()
EndFunction

Function InitLists()
	WhenToUpdateOptions = new string[2]
	WhenToUpdateOptions[0] = "On player orgasm"
	WhenToUpdateOptions[1] = "On sex end"
	
	AinList = new string[3]
	AinList[0] = "Always"
	AinList[1] = "Only at onset"
	AinList[2] = "Never"
	
	StatLossOptions = new string[4]
	StatLossOptions[0] = "Highest value"
	StatLossOptions[1] = "Health"
	StatLossOptions[2] = "Magicka"
	StatLossOptions[3] = "Stamina"
EndFunction	EndWhile
