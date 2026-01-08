Scriptname SLSW_scum extends ReferenceAlias  

Spell property SLSW_ISMRemovalSpell Auto
SLSW_mcmconfig property MCM auto
SLSW_upkeep property main auto
quest property scumquest auto
quest property InnDemands auto
WorldSpace Property Tamriel Auto
keyword Property LoctypeInn auto
GlobalVariable Property slsw_addictionIndicator auto
SPELL property slsw_bd_stage1 auto
SPELL property slsw_bd_stage2 auto
SPELL property slsw_bd_stage3 auto
SPELL property slsw_bd_stage4 auto
SPELL property slsw_bd_sideeffect auto
SPELL property slsw_ddsk_1 auto
SPELL property slsw_ddsk_2 auto
SPELL property slsw_ddsk_3 auto
SPELL property slsw_ddsk_4 auto
SPELL property slsw_ddsk_kj_1 auto
SPELL property slsw_ddsk_kj_2 auto
SPELL property slsw_ddsk_kj_3 auto
SPELL property slsw_ddsk_kj_4 auto
SPELL property slsw_ef_stage1 auto
SPELL property slsw_ef_stage2 auto
SPELL property slsw_ef_stage3 auto
SPELL property slsw_ef_stage4 auto
SPELL property slsw_leafskooma_1 auto
SPELL property slsw_leafskooma_2 auto
SPELL property slsw_leafskooma_3 auto
SPELL property slsw_leafskooma_4 auto
SPELL property slsw_leafskooma_kj_1 auto
SPELL property slsw_leafskooma_kj_2 auto
SPELL property slsw_leafskooma_kj_3 auto
SPELL property slsw_leafskooma_kj_4 auto
SPELL property slsw_mf_stage1 auto
SPELL property slsw_mf_stage2 auto
SPELL property slsw_mf_stage3 auto
SPELL property slsw_mf_stage4 auto
SPELL property slsw_mt_stage1 auto
SPELL property slsw_mt_stage2 auto
SPELL property slsw_mt_stage3 auto
SPELL property slsw_mt_stage4 auto
SPELL property slsw_op_stage1 auto
SPELL property slsw_op_stage2 auto
SPELL property slsw_op_stage3 auto
SPELL property slsw_op_stage4 auto
SPELL property slsw_skooma_1 auto
SPELL property slsw_skooma_2 auto
SPELL property slsw_skooma_3 auto
SPELL property slsw_skooma_4 auto
SPELL property slsw_skooma_kj_1 auto
SPELL property slsw_skooma_kj_2 auto
SPELL property slsw_skooma_kj_3 auto
SPELL property slsw_skooma_kj_4 auto
SPELL property slsw_tam_stage1 auto
SPELL property slsw_tam_stage2 auto
SPELL property slsw_tam_stage3 auto
SPELL property slsw_tam_stage4 auto
SPELL property slsw_tc_stage1 auto
SPELL property slsw_tc_stage2 auto
SPELL property slsw_tc_stage3 auto
SPELL property slsw_tc_stage4 auto
SPELL property slsw_td_stage1 auto
SPELL property slsw_td_stage2 auto
SPELL property slsw_td_stage3 auto
SPELL property slsw_td_stage4 auto
SPELL property slsw_tf_stage1 auto
SPELL property slsw_tf_stage2 auto
SPELL property slsw_tf_stage3 auto
SPELL property slsw_tf_stage4 auto
SPELL property slsw_tsb_stage1 auto
SPELL property slsw_tsb_stage2 auto
SPELL property slsw_tsb_stage3 auto
SPELL property slsw_tsb_stage4 auto

Actor PlayerRef

Event OnInit()
	PlayerRef = Game.GetPlayer()
EndEvent

Event OnPlayerLoadGame()
	If !PlayerRef
		PlayerRef = Game.GetPlayer()
	Endif
	main.OnGameLoad()
EndEvent

Event OnCellLoad()

If mcm.scum == true && (slsw_addictionIndicator.getvalue()) >= 4
	Utility.Wait(2)
	If PlayerRef.GetWorldSpace() != Tamriel
		If PlayerRef.GetCurrentLocation().Haskeyword(LoctypeInn) == True
			If InnDemands.isrunning() != true
				InnDemands.Start()
			endif
		elseIf PlayerRef.IsInInterior() != true
			if scumQuest.isrunning() != true
				scumQuest.start()
			endif
		endif
	endif
endif
EndEvent

Function SleepItOff()

(PlayerRef.RemoveSpell(slsw_bd_stage1))
(PlayerRef.RemoveSpell(slsw_bd_stage2))
(PlayerRef.RemoveSpell(slsw_bd_stage3))
(PlayerRef.RemoveSpell(slsw_bd_stage4))
(PlayerRef.RemoveSpell(slsw_bd_sideeffect))

(PlayerRef.RemoveSpell(slsw_ddsk_1))
(PlayerRef.RemoveSpell(slsw_ddsk_2))
(PlayerRef.RemoveSpell(slsw_ddsk_3))
(PlayerRef.RemoveSpell(slsw_ddsk_4))

(PlayerRef.RemoveSpell(slsw_ddsk_kj_1))
(PlayerRef.RemoveSpell(slsw_ddsk_kj_2))
(PlayerRef.RemoveSpell(slsw_ddsk_kj_3))
(PlayerRef.RemoveSpell(slsw_ddsk_kj_4))

(PlayerRef.RemoveSpell(slsw_ef_stage1))
(PlayerRef.RemoveSpell(slsw_ef_stage2))
(PlayerRef.RemoveSpell(slsw_ef_stage3))
(PlayerRef.RemoveSpell(slsw_ef_stage4))
 
(PlayerRef.RemoveSpell(slsw_leafskooma_1))
(PlayerRef.RemoveSpell(slsw_leafskooma_2))
(PlayerRef.RemoveSpell(slsw_leafskooma_3))
(PlayerRef.RemoveSpell(slsw_leafskooma_4))

(PlayerRef.RemoveSpell(slsw_leafskooma_kj_1))
(PlayerRef.RemoveSpell(slsw_leafskooma_kj_2))
(PlayerRef.RemoveSpell(slsw_leafskooma_kj_3))
(PlayerRef.RemoveSpell(slsw_leafskooma_kj_4))
 
(PlayerRef.RemoveSpell(slsw_mf_stage1))
(PlayerRef.RemoveSpell(slsw_mf_stage2))
(PlayerRef.RemoveSpell(slsw_mf_stage3))
(PlayerRef.RemoveSpell(slsw_mf_stage4))
 
(PlayerRef.RemoveSpell(slsw_mt_stage1))
(PlayerRef.RemoveSpell(slsw_mt_stage2))
(PlayerRef.RemoveSpell(slsw_mt_stage3))
(PlayerRef.RemoveSpell(slsw_mt_stage4))
 
(PlayerRef.RemoveSpell(slsw_op_stage1))
(PlayerRef.RemoveSpell(slsw_op_stage2))
(PlayerRef.RemoveSpell(slsw_op_stage3))
(PlayerRef.RemoveSpell(slsw_op_stage4))
 
(PlayerRef.RemoveSpell(slsw_skooma_1))
(PlayerRef.RemoveSpell(slsw_skooma_2))
(PlayerRef.RemoveSpell(slsw_skooma_3))
(PlayerRef.RemoveSpell(slsw_skooma_4))
 
(PlayerRef.RemoveSpell(slsw_skooma_kj_1))
(PlayerRef.RemoveSpell(slsw_skooma_kj_2))
(PlayerRef.RemoveSpell(slsw_skooma_kj_3))
(PlayerRef.RemoveSpell(slsw_skooma_kj_4))
 
(PlayerRef.RemoveSpell(slsw_tam_stage1))
(PlayerRef.RemoveSpell(slsw_tam_stage2))
(PlayerRef.RemoveSpell(slsw_tam_stage3))
(PlayerRef.RemoveSpell(slsw_tam_stage4))
 
(PlayerRef.RemoveSpell(slsw_tc_stage1))
(PlayerRef.RemoveSpell(slsw_tc_stage2))
(PlayerRef.RemoveSpell(slsw_tc_stage3))
(PlayerRef.RemoveSpell(slsw_tc_stage4))
 
(PlayerRef.RemoveSpell(slsw_td_stage1))
(PlayerRef.RemoveSpell(slsw_td_stage2))
(PlayerRef.RemoveSpell(slsw_td_stage3))
(PlayerRef.RemoveSpell(slsw_td_stage4))
 
(PlayerRef.RemoveSpell(slsw_tf_stage1))
(PlayerRef.RemoveSpell(slsw_tf_stage2))
(PlayerRef.RemoveSpell(slsw_tf_stage3))
(PlayerRef.RemoveSpell(slsw_tf_stage4))
 
(PlayerRef.RemoveSpell(slsw_tsb_stage1))
(PlayerRef.RemoveSpell(slsw_tsb_stage2))
(PlayerRef.RemoveSpell(slsw_tsb_stage3))
(PlayerRef.RemoveSpell(slsw_tsb_stage4))
return
EndFunction