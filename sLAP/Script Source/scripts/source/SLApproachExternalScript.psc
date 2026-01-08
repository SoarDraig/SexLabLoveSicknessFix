Scriptname SLApproachExternalScript extends Quest

SLAppPCSexQuestScript property SLApproachPC auto

SLApproachMainScript Property SLAMain Auto

Event Onint()
	SetFormIDSLS()
	SetFormIDDDI()
EndEvent

;####################################################
;###############Sexlab Survival######################
;####################################################

Actor Property PlayerRef Auto

GlobalVariable Property SLApproachAskNameTimes Auto
GlobalVariable Property SLApproachAskSexTimes Auto
GlobalVariable Property SLApproachGiftTimes Auto

GlobalVariable Property SLApproachSpankTimes Auto
GlobalVariable Property SLApproachBackHugTimes Auto
GlobalVariable Property SLApproachBackHugMolestTimes Auto
GlobalVariable Property SLApproachMolestTimes Auto
GlobalVariable Property SLApproachSweetKissTimes Auto
GlobalVariable Property SLApproachForcedKissTimes Auto
GlobalVariable Property SLApproachSexualInsultTimes Auto

GlobalVariable Property SLApproachRapedTimes Auto
GlobalVariable Property SLApproachNormalSexTimes Auto
GlobalVariable Property SLApproachProstitutionTimes Auto

GlobalVariable Property SLA_SLSurvivalLicenseClothes Auto
GlobalVariable Property SLA_SLSurvivalLicenseBikini Auto
GlobalVariable Property SLA_SLSurvivalLicenseWeapon Auto
GlobalVariable Property SLA_SLSurvivalLicenseArmor Auto
GlobalVariable Property SLA_SLSurvivalLicenseMagic Auto
GlobalVariable Property SLA_SLSurvivalLicenseNotice Auto

GlobalVariable Property sla_slsurvival Auto

Book Property _SLS_LicenceClothes Auto
Book Property _SLS_LicenceBikini Auto
Book Property _SLS_LicenceWeapon Auto
Book Property _SLS_LicenceArmor Auto
Book Property _SLS_LicenceMagic Auto
Book Property _SLS_EvictionNotice Auto

Faction Property SLTollCollectorFaction Auto
Faction Property SLKennelKeeperFaction Auto
Faction Property SLLicenseQuarterMasterFaction Auto

Formlist Property SLApproachSexlabSurvivalClothesList Auto
Formlist Property SLApproachSexlabSurvivalArmorList Auto
Formlist Property SLApproachSexlabSurvivalBikiniList Auto
Formlist Property SLApproachSexlabSurvivalMagicList Auto
Formlist Property SLApproachSexlabSurvivalWeaponList Auto
Formlist Property SLApproachSexlabSurvivalEvictionList Auto
Formlist Property SLApproachExcludeFaction Auto

Spell Property SLApproachNoApproachSpell Auto

Function SetFormIDSLS()
	_SLS_LicenceClothes = Game.GetFormFromFile(0x0492CB, "SL Survival.esp") as Book
	_SLS_LicenceBikini = Game.GetFormFromFile(0x0492C7, "SL Survival.esp") as Book
	_SLS_LicenceWeapon = Game.GetFormFromFile(0x043BAF, "SL Survival.esp") as Book
	_SLS_LicenceArmor = Game.GetFormFromFile(0x043BAE, "SL Survival.esp") as Book
	_SLS_LicenceMagic = Game.GetFormFromFile(0x041B54, "SL Survival.esp") as Book
	_SLS_EvictionNotice = Game.GetFormFromFile(0x00434B, "SL Survival.esp") as Book
	
	SLSFormDistribution()
EndFunction

Function SLSFormDistribution()
	SLApproachSexlabSurvivalClothesList.AddForm(_SLS_LicenceClothes)
	SLApproachSexlabSurvivalArmorList.AddForm(_SLS_LicenceArmor)
	SLApproachSexlabSurvivalBikiniList.AddForm(_SLS_LicenceBikini)
	SLApproachSexlabSurvivalMagicList.AddForm(_SLS_LicenceMagic)
	SLApproachSexlabSurvivalWeaponList.AddForm(_SLS_LicenceWeapon)
	SLApproachSexlabSurvivalEvictionList.AddForm(_SLS_EvictionNotice)
EndFunction


Function SLSurvivalLicenseCheck()
if SLAMain.enableSexlabSurvivalFlag
	SLSurvivalLicenseClothes()
	SLSurvivalLicenseBikini()
	SLSurvivalLicenseWeapon()
	SLSurvivalLicenseArmor()
	SLSurvivalLicenseMagic()
	SLSurvivalLicenseNotice()
endif
EndFunction

Bool Function SLSurvivalLicenseClothes()
if PlayerRef.getitemcount(_SLS_LicenceClothes) > 0
	SLA_SLSurvivalLicenseClothes.setvalue(1)
	return true
else
	SLA_SLSurvivalLicenseClothes.setvalue(0)
	return false
endif
Endfunction

Bool Function SLSurvivalLicenseBikini()
if PlayerRef.getitemcount(_SLS_LicenceBikini) > 0
	SLA_SLSurvivalLicenseBikini.setvalue(1)
	return true
else
	SLA_SLSurvivalLicenseBikini.setvalue(0)
	return false
endif
Endfunction

Bool Function SLSurvivalLicenseWeapon()
if PlayerRef.getitemcount(_SLS_LicenceWeapon) > 0
	SLA_SLSurvivalLicenseWeapon.setvalue(1)
	return true
else
	SLA_SLSurvivalLicenseWeapon.setvalue(0)
	return false
endif
Endfunction


Bool Function SLSurvivalLicenseArmor()
if PlayerRef.getitemcount(_SLS_LicenceArmor) > 0
	SLA_SLSurvivalLicenseArmor.setvalue(1)
	return true
else
	SLA_SLSurvivalLicenseArmor.setvalue(0)
	return false
endif
Endfunction

Bool Function SLSurvivalLicenseMagic()
if PlayerRef.getitemcount(_SLS_LicenceMagic) > 0
	SLA_SLSurvivalLicenseMagic.setvalue(1)
	return true
else
	SLA_SLSurvivalLicenseMagic.setvalue(0)
	return false
endif
Endfunction

Bool Function SLSurvivalLicenseNotice()
if PlayerRef.getitemcount(_SLS_EvictionNotice) > 0
	SLA_SLSurvivalLicenseNotice.setvalue(1)
	return true
else
	SLA_SLSurvivalLicenseNotice.setvalue(0)
	return false
endif
Endfunction

;#############################################################
;#################Devious Devices Integration#################
;#############################################################


Quest Property zadquest Auto

Keyword Property zad_Lockable Auto
Keyword Property zad_DeviousCollar Auto
Keyword Property zad_DeviousBelt Auto
Keyword Property zad_DeviousArmbinder Auto
Keyword Property zad_DeviousHarness Auto
Keyword Property zad_DeviousBra Auto
Keyword Property zad_DeviousSuit Auto
Keyword Property zad_DeviousYoke Auto
Keyword Property zad_DeviousGag Auto
Keyword Property zad_DeviousPlug Auto
Keyword Property zad_DeviousBlindfold Auto
Keyword Property zad_DeviousPiercingsVaginal Auto
Keyword Property zad_DeviousPlugVaginal Auto
Keyword Property zad_DeviousPlugAnal Auto
Keyword Property zad_DeviousBoots Auto
Keyword Property zad_DeviousHood Auto
Keyword Property zad_DeviousCorset Auto
Keyword Property zad_DeviousPiercingsNipple Auto

Formlist Property SLApproachDDIList Auto
Formlist Property SLApproachDDIBeltList Auto
Formlist Property SLApproachDDIBraList Auto
Formlist Property SLApproachDDICollarList Auto
Formlist Property SLApproachDDICorsetList Auto
Formlist Property SLApproachDDIGagList Auto
Formlist Property SLApproachDDIPiercingNList Auto
Formlist Property SLApproachDDIPiercingVList Auto
Formlist Property SLApproachDDIPlugAList Auto
Formlist Property SLApproachDDIPlugVList Auto
Formlist Property SLApproachDDIYokeList Auto

Key Property zad_ChastityKey Auto
Key Property zad_PiercingsRemovalTool Auto
Key Property zad_RestraintsKey Auto


Function SetFormIDDDI()
if DDIIntegrationCheck()
	zad_DeviousBelt = Game.GetFormFromFile(0x003330, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousPlug = Game.GetFormFromFile(0x003331, "Devious Devices - Assets.esm") as Keyword
	zad_Lockable = Game.GetFormFromFile(0x003894, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousCollar = Game.GetFormFromFile(0x003DF7, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousBra = Game.GetFormFromFile(0x003DFA, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousPiercingsNipple = Game.GetFormFromFile(0x00CA39, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousArmbinder = Game.GetFormFromFile(0x00CA3A, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousBlindfold = Game.GetFormFromFile(0x011B1A, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousHarness = Game.GetFormFromFile(0x017C43, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousPlugVaginal = Game.GetFormFromFile(0x01DD7C, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousPlugAnal = Game.GetFormFromFile(0x01DD7D, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousPiercingsVaginal = Game.GetFormFromFile(0x023E70, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousBoots = Game.GetFormFromFile(0x027F29, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousHood = Game.GetFormFromFile(0x02AFA2, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousSuit = Game.GetFormFromFile(0x02AFA3, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousYoke = Game.GetFormFromFile(0x02C531, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousGag = Game.GetFormFromFile(0x007EB8, "Devious Devices - Assets.esm") as Keyword
	zad_DeviousCorset = Game.GetFormFromFile(0x027F28, "Devious Devices - Assets.esm") as Keyword

	zad_ChastityKey = Game.GetFormFromFile(0x008A4F, "Devious Devices - Integration.esm") as Key
	zad_PiercingsRemovalTool = Game.GetFormFromFile(0x0409A4, "Devious Devices - Integration.esm") as Key
	zad_RestraintsKey = Game.GetFormFromFile(0x01775F, "Devious Devices - Integration.esm") as Key
			
	zadquest = Game.GetFormFromFile(0x00F624, "Devious Devices - Integration.esm") as Quest
endif
EndFunction

Bool Function DDIIntegrationCheck()
if Game.GetModByName("Devious Devices - Integration.esm") != 255
	return true
else
	return true
endif
EndFunction

Function SLARemoveDDIDevice(Actor akActor, Armor deviceInventory, Keyword devicekeyword)
if DDIIntegrationCheck()
	zadlibs libs = zadquest as zadlibs
	libs.RemoveDevice(akActor, deviceInventory, libs.GetRenderedDevice(deviceInventory), devicekeyword, true, false)
endif
EndFunction

Function SLARemoveYoke(Actor akActor)
	SLARemoveDDIDevice(akActor, self.GetWornYoke(akActor) as armor, zad_DeviousYoke)
EndFunction

Function SLAProvideDDIKey(Actor akActor)
if DDIIntegrationCheck()
	int RI = Utility.randomint(1,99)
	
	If (1 <= RI) && (34 > RI)
		akActor.additem(zad_ChastityKey, 1)
	elseIf (34 <= RI) && (67 > RI)
		akActor.additem(zad_PiercingsRemovalTool, 1)
	elseIf (67 <= RI) && (99 > RI)
		akActor.additem(zad_RestraintsKey, 1)
	else
	endif
endif
EndFunction


Form Function GetRenderedDeviceInstance(actor akActor, int Slot, Keyword kwd)
	form f1 = akActor.GetWornForm(Slot) 
	if f1 && f1.HasKeyword(kwd)
		return f1
	Endif
	return none
EndFunction

Function CheckDD(actor akActor)
if DDIIntegrationCheck()
		GetWornYoke(akActor)
		GetWornBelt(akActor)
		GetWornCorset(akActor)
		GetWornCollar(akActor)
		GetWornBra(akActor)
		GetWornGag(akActor)
		GetWornPlugV(akActor)
		GetWornPlugA(akActor)
		GetWornPiercingV(akActor)
		GetWornPiercingN(akActor)
endif
EndFunction


Form Function GetWornYoke(actor akActor)
	form armb = GetRenderedDeviceInstance(akActor, 0x00010000, zad_DeviousArmbinder)
	if !armb ; Check for yokes
		armb = GetRenderedDeviceInstance(akActor, 0x00010000, zad_DeviousYoke)
	EndIf
	
	if armb
		SLApproachDDIList.addform(armb)
		SLApproachDDIYokeList.addform(armb)
	endif
	
	return armb
EndFunction

Form Function GetWornBelt(actor akActor)
	form belt = GetRenderedDeviceInstance(akActor, 0x00080000, zad_DeviousBelt)
	if !belt ; Check for Harness
		belt = GetRenderedDeviceInstance(akActor, 0x00080000, zad_Lockable)
	EndIf
	
	if belt
		SLApproachDDIBeltList.addform(belt)
		;SLApproachDDIList.addform(belt)
	endif
	return belt
EndFunction

Form Function GetWornCorset(actor akActor)
	form belt = GetRenderedDeviceInstance(akActor, 0x10000000, zad_DeviousCorset)
	if !belt ; Check for Corset
		belt = GetRenderedDeviceInstance(akActor, 0x10000000, zad_Lockable)
	EndIf
	
	if belt
		SLApproachDDICorsetList.addform(belt)
		;SLApproachDDIList.addform(belt)
	endif
	return belt
EndFunction

Form Function GetWornCollar(actor akActor)
	form Collar = GetRenderedDeviceInstance(akActor, 0x00008000, zad_DeviousCollar)
	if !Collar
		Collar = GetRenderedDeviceInstance(akActor, 0x00008000, zad_Lockable)
	EndIf
	
	if Collar
		SLApproachDDIList.addform(Collar)
		SLApproachDDICollarList.addform(Collar)
	endif
	return Collar
EndFunction

Form Function GetWornBra(actor akActor)
	form Bra = GetRenderedDeviceInstance(akActor, 0x04000000, zad_DeviousBra)
	if !Bra
		Bra = GetRenderedDeviceInstance(akActor, 0x04000000, zad_Lockable)
	EndIf
	
	if Bra
		SLApproachDDIBraList.addform(Bra)
	endif
	return Bra
EndFunction

Form Function GetWornGag(actor akActor)
	form Gag = GetRenderedDeviceInstance(akActor, 0x00004000, zad_DeviousGag)
	if !Gag
		Gag = GetRenderedDeviceInstance(akActor, 0x00004000, zad_Lockable)
	EndIf
	
	if Gag
		SLApproachDDIGagList.addform(Gag)
	endif
	return Gag
EndFunction

Form Function GetWornPlugV(actor akActor)
	form plug = GetRenderedDeviceInstance(akActor, 0x08000000, zad_DeviousPlugVaginal)
	if !plug
		plug = GetRenderedDeviceInstance(akActor, 0x08000000, zad_Lockable)
	EndIf
	
	if plug
		SLApproachDDIPlugVList.addform(plug)
	endif
	return plug
EndFunction

Form Function GetWornPlugA(actor akActor)
	form plug = GetRenderedDeviceInstance(akActor, 0x00040000, zad_DeviousPlugAnal)
	if !plug
		plug = GetRenderedDeviceInstance(akActor, 0x00040000, zad_Lockable)
	EndIf
	
	if plug
		SLApproachDDIPlugAList.addform(plug)
	endif
	return plug
EndFunction

Form Function GetWornPiercingV(actor akActor)
	form plug = GetRenderedDeviceInstance(akActor, 0x00100000, zad_DeviousPiercingsVaginal)
	if !plug
		plug = GetRenderedDeviceInstance(akActor, 0x00100000, zad_Lockable)
	EndIf
	
	if plug
		SLApproachDDIPiercingVList.addform(plug)
	endif
	return plug
EndFunction

Form Function GetWornPiercingN(actor akActor)
	form plug = GetRenderedDeviceInstance(akActor, 0x00200000, zad_DeviousPiercingsNipple)
	if !plug
		plug = GetRenderedDeviceInstance(akActor, 0x00200000, zad_Lockable)
	EndIf
	
	if plug
		SLApproachDDIPiercingNList.addform(plug)
	endif
	return plug
EndFunction

;SLA_DDEquipType
Function DeviousEquip(actor akactor, int Type)

zadlibs libs = zadquest as zadlibs
;Armor Function GetDeviceByTags(Keyword kw, String tags, bool requireAll = true, String tagsToSuppress = "", bool fallBack = true)
;bool Function ManipulateGenericDevice(actor akActor, armor device, bool equipOrUnequip, bool skipEvents = false , bool skipMutex = false)

	If Type == 1
		Libs.ManipulateGenericDevice(PlayerRef, Libs.GetDeviceByTags(Libs.zad_DeviousGag, "gag", false, ""), TRUE, FALSE, TRUE)
		DDequipCount("Gag")
		akactor.AddItem(Libs.restraintsKey, 1)
	elseif type == 2
		Libs.ManipulateGenericDevice(PlayerRef, Libs.GetDeviceByTags(Libs.zad_DeviousPiercingsVaginal, "piercing,vaginal", false, ""), TRUE, FALSE, TRUE)
		DDequipCount("PiercingsVaginal")
		akactor.AddItem(Libs.piercingKey, 1)
	elseif type == 3
		Libs.ManipulateGenericDevice(PlayerRef, Libs.GetDeviceByTags(Libs.zad_DeviousPiercingsNipple, "piercing,nipple", false, ""), TRUE, FALSE, TRUE)
		DDequipCount("PiercingsNipple")
		akactor.AddItem(Libs.piercingKey, 1)
	elseif type == 4
		if !PlayerRef.WornHasKeyword(libs.zad_DeviousPlugVaginal)
			Libs.ManipulateGenericDevice(PlayerRef, Libs.GetDeviceByTags(Libs.zad_DeviousPlugVaginal, "plug,vaginal", false, "pear,locking"), TRUE, TRUE, TRUE)
			DDequipCount("PlugVaginal")
			akactor.AddItem(Libs.restraintsKey, 1)
		endif
	elseif type == 5
		if !PlayerRef.WornHasKeyword(libs.zad_DeviousPlugAnal)
			Libs.ManipulateGenericDevice(PlayerRef, Libs.GetDeviceByTags(Libs.zad_DeviousPlugAnal, "plug,anal", false, "pear,locking"), TRUE, TRUE, TRUE)
			DDequipCount("PlugAnal")
			akactor.AddItem(Libs.restraintsKey, 1)
		endif
	elseif type == 6
		Libs.ManipulateGenericDevice(PlayerRef, Libs.GetDeviceByTags(Libs.zad_DeviousBelt, "belt", false, "stripe,hex,hypnotic,jade,fire,fifa,crimson"), TRUE, FALSE, TRUE)
		DDequipCount("Chastity")
		akactor.AddItem(Libs.chastityKey, 1)
	Endif
	
EndFunction


Function DDequipCount(string Type)
if Type == "Gag"

elseif Type == "PiercingsVaginal"

elseif Type == "PiercingsNipple"

elseif Type == "PlugVaginal"

elseif Type == "PlugAnal"

elseif Type == "Chastity"

endif
EndFunction

Function ExportStatSettings()
	String File = "../BakaFactory/SLAPPStats.json"

	JsonUtil.SetIntValue(File, "ApproachHelloTimes", SLApproachAskNameTimes.GetValue() as Int)
	JsonUtil.SetIntValue(File, "ApproachforSexTimes", SLApproachAskSexTimes.GetValue() as Int)
	JsonUtil.SetIntValue(File, "ApproachReceivedGiftTimes", SLApproachGiftTimes.GetValue() as Int)
	JsonUtil.SetIntValue(File, "ApproachSpankedTimes", SLApproachSpankTimes.GetValue() as Int)
	JsonUtil.SetIntValue(File, "ApproachBackHuggedTimes", SLApproachBackHugTimes.GetValue() as Int)
	JsonUtil.SetIntValue(File, "ApproachBackHugMolestedTimes", SLApproachBackHugMolestTimes.GetValue() as Int)
	JsonUtil.SetIntValue(File, "ApproachMolestTimes", SLApproachMolestTimes.GetValue() as Int);Spank + BackHug + BackHugMolest + ForcedKiss
	JsonUtil.SetIntValue(File, "ApproachSweetKissTimes", SLApproachSweetKissTimes.GetValue() as Int);Spank + BackHug + BackHugMolest + ForcedKiss
	JsonUtil.SetIntValue(File, "ApproachForcedKissTimes", SLApproachForcedKissTimes.GetValue() as Int);Spank + BackHug + BackHugMolest + ForcedKiss
	JsonUtil.SetIntValue(File, "ApproachVerbalInsultTimes", SLApproachSexualInsultTimes.GetValue() as Int);VerbalSexualInsult
	JsonUtil.SetIntValue(File, "ApproachRapedTimes", SLApproachRapedTimes.GetValue() as Int);Being raped by SLApproach
	JsonUtil.SetIntValue(File, "ApproachNormalSexTimes", SLApproachNormalSexTimes.GetValue() as Int)
	JsonUtil.SetIntValue(File, "ApproachProstitutionTimes", SLApproachProstitutionTimes.GetValue() as Int)

	JsonUtil.Save(File, false)
EndFunction


Function ReadJsonExcludeFaction()
;	if !PlayerRef.hasspell(SLApproachNoApproachSpell)
;		PlayerRef.addspell(SLApproachNoApproachSpell)
;	endif

	;Debug.Trace("Sexlab Approach: ReadJsonExcludeFaction")
	;SLApproachExcludeFaction.revert()
	;Faction ExcludeFaction
	
	;String File = "../BakaFactory/SLAPPExcludeFaction.json"
	;Int i = 0
	;i = JsonUtil.FormListCount(File, "customfaction")
	;Debug.Trace("Sexlab Approach: CustomFaction Counts" + i)
	;While i > 0
		;i -= 1
		;ExcludeFaction = JsonUtil.FormListGet(File, "customfaction", i) as faction
		;if ExcludeFaction
			;SLApproachExcludeFaction.AddForm(ExcludeFaction))
		;endif
	;EndWhile

	if sla_slsurvival.getvalue() == 1 && !SLApproachExcludeFaction.hasform(SLTollCollectorFaction)
		SLTollCollectorFaction = Game.GetFormFromFile(0x0000A09C, "SL Survival.esp") as faction
		SLKennelKeeperFaction = Game.GetFormFromFile(0x0002BBF8, "SL Survival.esp") as faction
		SLLicenseQuarterMasterFaction = Game.GetFormFromFile(0x00045164, "SL Survival.esp") as faction
		
		SLApproachExcludeFaction.addform(SLTollCollectorFaction)
		SLApproachExcludeFaction.addform(SLKennelKeeperFaction)
		SLApproachExcludeFaction.addform(SLLicenseQuarterMasterFaction)
	elseif sla_slsurvival.getvalue() == 0 && SLApproachExcludeFaction.hasform(SLTollCollectorFaction)
		SLApproachExcludeFaction.RemoveAddedForm(SLTollCollectorFaction)
		SLApproachExcludeFaction.RemoveAddedForm(SLKennelKeeperFaction)
		SLApproachExcludeFaction.RemoveAddedForm(SLLicenseQuarterMasterFaction)
	endif
EndFunction


Function RegisterSLAPPEvent()
	RegisterForModEvent("SLAPP_Trigger", "SLAPPTriggerEvent")
	
;	int handle = ModEvent.Create("SLAPP_Trigger")
;	if (handle)
;		ModEvent.Pushform(handle, form)
;		ModEvent.Pushint(handle, i)
;		ModEvent.Send(handle)
;	endIf	

EndFunction

Event SLAPPTriggerEvent(form akform, int tid)
	SLApproachPC.StopScene()
	Utility.Wait(1.0)
	SLApproachPC.ChanceRollMisc(akform as actor, PlayerRef, SLAMain.baseChanceMultiplier, tid)
EndEvent