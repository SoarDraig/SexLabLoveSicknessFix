;================================================================================
; lvskEffect.psc - Love Sickness 魔法效果脚本
;================================================================================
; 说明：
;   这个脚本处理恋爱病魔法效果的开始和结束
;   当玩家获得或失去恋爱病状态时，自动添加或移除相应的负面效果
;================================================================================
; 主要功能：
;   1. 效果开始时：添加所有负面效果 Perk
;   2. 效果结束时：移除所有负面效果 Perk
;   3. 更新存储在 StorageUtil 中的恋爱病状态标志
;================================================================================

Scriptname lvskEffect extends ActiveMagicEffect  

; ==================== 属性定义 ====================
Actor Property Player auto      ; 玩家角色引用
FormList Property Perks auto     ; 包含所有负面效果 Perk 的列表

;================================================================================
; OnEffectStart - 魔法效果开始事件
;================================================================================
; 说明：
;   当玩家获得恋爱病状态时触发
;   会将 FormList 中的所有 Perk 添加到玩家身上
;   这些 Perk 会产生各种负面效果（如伤害增加、经验减少等）
;
; 参数：
;   akTarget: 目标角色（玩家）
;   akCaster: 施法者（玩家）
;================================================================================
Event OnEffectStart(Actor akTarget, Actor akCaster)
	; 遍历 Perk 列表，将所有 Perk 添加到玩家身上
	int i = Perks.GetSize()
	While i > 0
		i -= 1
		Player.AddPerk(Perks.GetAt(i) as Perk)
	EndWhile
	
	; 设置 StorageUtil 标志，表示玩家当前处于恋爱病状态
	; 供其他脚本检查使用
	StorageUtil.SetIntValue(Player, "LVSK_IsLovesick", 1)
EndEvent

;================================================================================
; OnEffectFinish - 魔法效果结束事件
;================================================================================
; 说明：
;   当恋爱病状态结束时触发
;   移除所有之前添加的负面效果 Perk
;   清除 StorageUtil 中的恋爱病状态标志
;
; 参数：
;   akTarget: 目标角色（玩家）
;   akCaster: 施法者（玩家）
;================================================================================
Event OnEffectFinish(Actor akTarget, Actor akCaster)
	; 遍历 Perk 列表，从玩家身上移除所有 Perk
	int i = Perks.GetSize()
	While i > 0
		i -= 1
		Player.RemovePerk(Perks.GetAt(i) as Perk)
	EndWhile
	
	; 清除 StorageUtil 标志，表示玩家不再处于恋爱病状态
	StorageUtil.SetIntValue(Player, "LVSK_IsLovesick", 0)
EndEvent