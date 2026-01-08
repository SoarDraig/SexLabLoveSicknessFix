Scriptname slsw_HerbTeaEffect extends activemagiceffect  

GlobalVariable Property SLSW_DrugPool_pd  Auto
GlobalVariable Property SLSW_DrugPool_md  Auto
GlobalVariable Property SLSW_DrugPool_mkd  Auto
SLSW_upkeep Property upkeep Auto
SPELL Property SLSW_pd_stage1 auto
SPELL Property SLSW_pd_stage2 auto
SPELL Property SLSW_pd_stage3 auto
SPELL Property SLSW_pd_stage4 auto
SPELL Property SLSW_pd_stage5 auto
SPELL Property SLSW_md_stage1 auto
SPELL Property SLSW_md_stage2 auto
SPELL Property SLSW_md_stage3 auto
SPELL Property SLSW_md_stage4 auto
SPELL Property SLSW_md_stage5 auto
SPELL Property SLSW_mkd_stage1 auto
SPELL Property SLSW_mkd_stage2 auto
SPELL Property SLSW_mkd_stage3 auto
SPELL Property SLSW_mkd_stage4 auto
SPELL Property SLSW_mkd_stage5 auto

Spell Property SLSW_HerbTeaSpell Auto

Float fEffectStartTime
Float fEffectDuration
Float fPD_Reduction
Float fMD_Reduction
Float fMKD_Reduction

Event OnEffectStart(Actor akTarget, Actor akCaster)
	fEffectStartTime = Utility.GetCurrentGameTime()
	fPD_Reduction = Utility.RandomFloat(6.0, 10.0)
	fMD_Reduction = Utility.RandomFloat(6.0, 10.0)
	fMKD_Reduction = Utility.RandomFloat(6.0, 10.0)

	fEffectDuration = fPD_Reduction
	If fEffectDuration < fMD_Reduction
		fEffectDuration = fMD_Reduction
	ElseIf fEffectDuration < fMKD_Reduction
		fEffectDuration = fMKD_Reduction
	EndIf
	RegisterForSingleUpdateGameTime(0.5)
EndEvent

Event OnUpdateGameTime()
	Float fHoursElapsed = ( Utility.GetCurrentGameTime() - fEffectStartTime ) * 24
	Float fPropCompleted = fHoursElapsed / fEffectDuration
	If fPropCompleted > 1.0
		fPropCompleted = 1.0
	EndIf
	If fPropCompleted < 1.0
		ReduceAddiction(fPD_Reduction * fPropCompleted, fMD_Reduction * fPropCompleted, fMKD_Reduction * fPropCompleted)
		fEffectDuration = fEffectDuration - fHoursElapsed
		fPD_Reduction = fPD_Reduction - (fPD_Reduction * fPropCompleted)
		fMD_Reduction = fMD_Reduction - (fMD_Reduction * fPropCompleted)
		fMKD_Reduction = fMKD_Reduction - (fMKD_Reduction * fPropCompleted)
		RegisterForSingleUpdateGameTime(0.5)
	Else
		ReduceAddiction(fPD_Reduction, fMD_Reduction, fMKD_Reduction)
		Self.Dispel()
	EndIf
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.RemoveSpell(SLSW_HerbTeaSpell)
EndEvent

Function ReduceAddiction(Float afPD_Reduction, Float afMD_Reduction, Float afMKD_Reduction)
	float CurrentValue_pd = SLSW_DrugPool_pd.getValue()

	CurrentValue_pd -= afPD_Reduction

	If CurrentValue_pd <= 0
		SLSW_DrugPool_pd.setValue(0)
	else
		SLSW_DrugPool_pd.setValue(CurrentValue_pd)
	endif

	float CurrentValue_md = SLSW_DrugPool_md.getValue()

	CurrentValue_md -= afMD_Reduction

	If CurrentValue_md <= 0
		SLSW_DrugPool_md.setValue(0)
	else
		SLSW_DrugPool_md.setValue(CurrentValue_md)
	endif


	float CurrentValue_mkd = SLSW_DrugPool_mkd.getValue()

	CurrentValue_mkd -= afMKD_Reduction

	If CurrentValue_mkd <= 0
		SLSW_DrugPool_mkd.setValue(0)
	else
		SLSW_DrugPool_mkd.setValue(CurrentValue_mkd)
	endif

	upkeep.getclean(SLSW_DrugPool_pd.getValue(), slsw_pd_stage1, slsw_pd_stage2, slsw_pd_stage3, slsw_pd_stage4, slsw_pd_stage5)
	upkeep.getclean(SLSW_DrugPool_md.getValue(), slsw_md_stage1, slsw_md_stage2, slsw_md_stage3, slsw_md_stage4, slsw_md_stage5)
	upkeep.getclean(SLSW_DrugPool_mkd.getValue(), slsw_mkd_stage1, slsw_mkd_stage2, slsw_mkd_stage3, slsw_mkd_stage4, slsw_mkd_stage5)

	upkeep.UpdateIndicator()

EndFunction