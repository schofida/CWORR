scriptName CWOMCMScript extends MCM_ConfigBase

;-- Properties --------------------------------------
; Property names must stay identical to the classic SKI_ConfigBase variant so
; the quest's auto-filled properties work for either compiled .pex.
globalvariable property CWOCapitalReinforcements auto
cwscript property CWs auto
globalvariable property CWOSiegeReinforcements auto
globalvariable property CWOPCChance auto
quest property CW auto
faction property CWSonsFactionNPC auto
globalvariable property CWOImperialReinforcements auto
quest property CWOPatrolsQuest auto
globalvariable property CWOStillABetterEndingGlobal auto
quest property CWOArmorDisguise auto
quest property CWOSendForPlayer auto
globalvariable property CWOCourierSentGlobal auto
quest property CWSiege auto
quest property CWFortSiegeCapital auto
globalvariable property CWPercentPoolRemainingDefender auto
quest property CWFortsiegeFort auto
faction property CWImperialFactionNPC auto
globalvariable property CWOSonsReinforcements auto
globalvariable property CWPercentPoolRemainingAttacker auto
globalvariable property CWOFortReinforcements auto
globalvariable property CWODisguiseGlobal auto
globalvariable property CWOBAChance auto
globalvariable property CWODisguiseGameType auto
globalvariable property CWOVersion auto
globalvariable property CWOTroopPoolGameType auto
globalvariable property CWOSiChance auto
quest property CWAttackCity Auto
globalvariable property CWOGarrisonReinforcements Auto
GlobalVariable Property CWOPlayerAttackerScaleMult Auto
GlobalVariable Property CWOPlayerDefenderScaleMult Auto
GlobalVariable Property CWOEnemyAttackerScaleMult Auto
GlobalVariable Property CWOEnemyDefenderScaleMult Auto
GlobalVariable Property CWOCourierHoursMin Auto
GlobalVariable Property CWOCourierHoursMax Auto
GlobalVariable Property CWOCampaignPhaseMax Auto
Quest Property CWOSpanishInquisitionImperials Auto
Quest Property CWOSpanishInquisitionSons Auto
Quest Property CWOBAController Auto
Quest Property CWOBAQuest Auto
Quest Property CWOQuestMonitor Auto
GlobalVariable Property CWODisableCWMission01 Auto
GlobalVariable Property CWODisableCWMission02 Auto
GlobalVariable Property CWODisableCWMission05 Auto
GlobalVariable Property CWODisableCWMission06 Auto
GlobalVariable Property CWODisableCWMission08 Auto
GlobalVariable Property CWODisableCWMission09 Auto
GlobalVariable Property CWODisableFortSiegeFort Auto
GlobalVariable Property CWODisableWindhelmSiege Auto
GlobalVariable Property CWODisableSolitudeSiege Auto
GlobalVariable Property CWODisableFaint Auto
GlobalVariable Property CWODisableNotifications Auto
GlobalVariable Property CWOEnableAdditionalSoldiers Auto
GlobalVariable Property CWODisableFriendlyFire Auto
GlobalVariable Property CWODisableMinorCapitalStuff Auto
GlobalVariable Property CWODisableMinorSieges Auto
GlobalVariable Property CWODisableMarkarthSiege Auto
GlobalVariable Property CWODisableRiftenSiege Auto
LeveledItem Property LItemArmorCuirassLightSpecial Auto
LeveledItem Property LItemArmorCuirassHeavySpecial Auto
LeveledItem Property LItemArmorShieldLightSpecial Auto
LeveledItem Property LItemArmorShieldHeavySpecial Auto
LeveledItem Property LItemWeaponSwordSpecial Auto
LeveledItem Property CWRankRewardSons Auto
LeveledItem Property CWRankRewardImperial Auto
LeveledItem Property CWFinaleFactionLeaderSwordList Auto
Quest Property CWOApolloFixMe Auto
;-- MCM Helper (config.json) PropertyValueInt selects fill these ----------
Int Property iStartSiegeHold Auto
Int Property iWinHold Auto
Int Property iSwitchHold Auto
Int Property iWinWarFaction Auto
;-- Variables ---------------------------------------
Bool SetReinforcementsBusy = False
String[] holdsList
Int[] holdsID

;-- Events ------------------------------------------

Event OnConfigInit()
	EnsureHoldLists()
EndEvent

Event OnConfigOpen()
	SyncSettingsToGlobals()
	PopulateDebugPage()
EndEvent

Event OnConfigClose()
	SetReinforcementsBusy = False
EndEvent

Event OnSettingChange(string a_ID)
	ApplySettingToGlobal(a_ID)
	if a_ID == "fCapitalReinforcements:Main" || a_ID == "fFortReinforcements:Main" || a_ID == "fSiegeReinforcements:Main" || a_ID == "fAdditionalSoldiers:Main"
		SetReinforcements()
	elseif a_ID == "fPlayerAttackerScaleMult:Main" || a_ID == "fPlayerDefenderScaleMult:Main" || a_ID == "fEnemyAttackerScaleMult:Main" || a_ID == "fEnemyDefenderScaleMult:Main"
		SetReinforcements()
	elseif a_ID == "fGarrisonReinforcements:Main"
		if CWs.CWCampaignS.CWMission01.IsRunning() && CWs.CWCampaignS.CWMission01.GetStage() < 10
			(CWs.CWCampaignS.CWMission01 as CWMission01Script).SetEnemyPools()
		endif
	elseif a_ID == "iCampaignPhaseMax:Main"
		if CWs.CWCampaignS != none
			CWs.CWCampaignS.ResolutionPhase = CWOCampaignPhaseMax.GetValueInt()
		endif
	elseif a_ID == "iDisguiseType:Main"
		if CWOArmorDisguise.IsRunning()
			CWOArmorDisguise.Stop()
			CWOArmorDisguise.Start()
		endif
	elseif a_ID == "bDisableFortSiegeFort:Compatibility"
		if CWODisableFortSiegeFort.GetValueInt() == 1
			CWs.CWCampaignS.CWFortSiegeFortDone = 1
		else
			if CWS.CWAttacker.GetValueInt() == CWs.PlayerAllegiance && CWs.contestedHold == CWs.iFalkreath
				CWs.CWCampaignS.CWFortSiegeFortDone = 1
			else
				CWs.CWCampaignS.CWFortSiegeFortDone = 0
			endif
		endif
	endif
EndEvent

;-- Mod Setting <-> Global sync ---------------------------------------
; Writes every mod setting into its corresponding global so the game logic
; (which only reads globals) sees the values from settings.ini / the
; MCM\Settings save file. Called on every config open and on each change.

Function SyncSettingsToGlobals()
	ApplySettingToGlobal("bDisableNotifications:Main")
	ApplySettingToGlobal("bDisableBleedout:Main")
	ApplySettingToGlobal("bDisableFriendlyFire:Main")
	ApplySettingToGlobal("fCapitalReinforcements:Main")
	ApplySettingToGlobal("fFortReinforcements:Main")
	ApplySettingToGlobal("fSiegeReinforcements:Main")
	ApplySettingToGlobal("fGarrisonReinforcements:Main")
	ApplySettingToGlobal("fPlayerAttackerScaleMult:Main")
	ApplySettingToGlobal("fPlayerDefenderScaleMult:Main")
	ApplySettingToGlobal("fEnemyAttackerScaleMult:Main")
	ApplySettingToGlobal("fEnemyDefenderScaleMult:Main")
	ApplySettingToGlobal("fAdditionalSoldiers:Main")
	ApplySettingToGlobal("iCampaignPhaseMax:Main")
	ApplySettingToGlobal("iPartyCrashersChance:Main")
	ApplySettingToGlobal("iBenedictArnoldChance:Main")
	ApplySettingToGlobal("iSpanishInquisitionChance:Main")
	ApplySettingToGlobal("iCourierHoursMin:Main")
	ApplySettingToGlobal("iCourierHoursMax:Main")
	ApplySettingToGlobal("iDisguiseType:Main")
	ApplySettingToGlobal("bDisableCWMission01:Compatibility")
	ApplySettingToGlobal("bDisableCWMission02:Compatibility")
	ApplySettingToGlobal("bDisableCWMission05:Compatibility")
	ApplySettingToGlobal("bDisableCWMission06:Compatibility")
	ApplySettingToGlobal("bDisableCWMission08:Compatibility")
	ApplySettingToGlobal("bDisableCWMission09:Compatibility")
	ApplySettingToGlobal("bDisableFortSiegeFort:Compatibility")
	ApplySettingToGlobal("bDisableSolitudeSiege:Compatibility")
	ApplySettingToGlobal("bDisableWindhelmSiege:Compatibility")
	ApplySettingToGlobal("bDisableMinorCapitalStuff:Compatibility")
	ApplySettingToGlobal("bDisableMarkarthSiege:Compatibility")
	ApplySettingToGlobal("bDisableRiftenSiege:Compatibility")
	ApplySettingToGlobal("bDisableMinorSieges:Compatibility")
EndFunction

Function ApplySettingToGlobal(string a_ID)
	if a_ID == "bDisableNotifications:Main"
		CWODisableNotifications.SetValueInt(GetModSettingBool(a_ID) as int)
	elseif a_ID == "bDisableBleedout:Main"
		CWODisableFaint.SetValueInt(GetModSettingBool(a_ID) as int)
	elseif a_ID == "bDisableFriendlyFire:Main"
		CWODisableFriendlyFire.SetValueInt(GetModSettingBool(a_ID) as int)
	elseif a_ID == "fCapitalReinforcements:Main"
		CWOCapitalReinforcements.SetValue(GetModSettingFloat(a_ID))
	elseif a_ID == "fFortReinforcements:Main"
		CWOFortReinforcements.SetValue(GetModSettingFloat(a_ID))
	elseif a_ID == "fSiegeReinforcements:Main"
		CWOSiegeReinforcements.SetValue(GetModSettingFloat(a_ID))
	elseif a_ID == "fGarrisonReinforcements:Main"
		CWOGarrisonReinforcements.SetValue(GetModSettingFloat(a_ID))
	elseif a_ID == "fPlayerAttackerScaleMult:Main"
		CWOPlayerAttackerScaleMult.SetValue(GetModSettingFloat(a_ID))
	elseif a_ID == "fPlayerDefenderScaleMult:Main"
		CWOPlayerDefenderScaleMult.SetValue(GetModSettingFloat(a_ID))
	elseif a_ID == "fEnemyAttackerScaleMult:Main"
		CWOEnemyAttackerScaleMult.SetValue(GetModSettingFloat(a_ID))
	elseif a_ID == "fEnemyDefenderScaleMult:Main"
		CWOEnemyDefenderScaleMult.SetValue(GetModSettingFloat(a_ID))
	elseif a_ID == "fAdditionalSoldiers:Main"
		CWOEnableAdditionalSoldiers.SetValue(GetModSettingFloat(a_ID))
	elseif a_ID == "iCampaignPhaseMax:Main"
		int index = GetModSettingInt(a_ID)
		int phase = 3
		if index == 0
			phase = 1
		elseif index == 2
			phase = 5
		else
			phase = 3
		endif
		CWOCampaignPhaseMax.SetValueInt(phase)
	elseif a_ID == "iPartyCrashersChance:Main"
		CWOPCChance.SetValue(GetModSettingInt(a_ID) as float)
	elseif a_ID == "iBenedictArnoldChance:Main"
		CWOBAChance.SetValue(GetModSettingInt(a_ID) as float)
	elseif a_ID == "iSpanishInquisitionChance:Main"
		CWOSiChance.SetValue(GetModSettingInt(a_ID) as float)
	elseif a_ID == "iCourierHoursMin:Main"
		CWOCourierHoursMin.SetValue(GetModSettingInt(a_ID) as float)
	elseif a_ID == "iCourierHoursMax:Main"
		CWOCourierHoursMax.SetValue(GetModSettingInt(a_ID) as float)
	elseif a_ID == "iDisguiseType:Main"
		CWODisguiseGameType.SetValueInt(GetModSettingInt(a_ID))
	elseif a_ID == "bDisableCWMission01:Compatibility"
		CWODisableCWMission01.SetValueInt(GetModSettingBool(a_ID) as int)
	elseif a_ID == "bDisableCWMission02:Compatibility"
		CWODisableCWMission02.SetValueInt(GetModSettingBool(a_ID) as int)
	elseif a_ID == "bDisableCWMission05:Compatibility"
		CWODisableCWMission05.SetValueInt(GetModSettingBool(a_ID) as int)
	elseif a_ID == "bDisableCWMission06:Compatibility"
		CWODisableCWMission06.SetValueInt(GetModSettingBool(a_ID) as int)
	elseif a_ID == "bDisableCWMission08:Compatibility"
		CWODisableCWMission08.SetValueInt(GetModSettingBool(a_ID) as int)
	elseif a_ID == "bDisableCWMission09:Compatibility"
		CWODisableCWMission09.SetValueInt(GetModSettingBool(a_ID) as int)
	elseif a_ID == "bDisableFortSiegeFort:Compatibility"
		CWODisableFortSiegeFort.SetValueInt(GetModSettingBool(a_ID) as int)
	elseif a_ID == "bDisableSolitudeSiege:Compatibility"
		CWODisableSolitudeSiege.SetValueInt(GetModSettingBool(a_ID) as int)
	elseif a_ID == "bDisableWindhelmSiege:Compatibility"
		CWODisableWindhelmSiege.SetValueInt(GetModSettingBool(a_ID) as int)
	elseif a_ID == "bDisableMinorCapitalStuff:Compatibility"
		CWODisableMinorCapitalStuff.SetValueInt(GetModSettingBool(a_ID) as int)
	elseif a_ID == "bDisableMarkarthSiege:Compatibility"
		CWODisableMarkarthSiege.SetValueInt(GetModSettingBool(a_ID) as int)
	elseif a_ID == "bDisableRiftenSiege:Compatibility"
		CWODisableRiftenSiege.SetValueInt(GetModSettingBool(a_ID) as int)
	elseif a_ID == "bDisableMinorSieges:Compatibility"
		CWODisableMinorSieges.SetValueInt(GetModSettingBool(a_ID) as int)
	endif
EndFunction

;-- Debug page ---------------------------------------
function PopulateDebugPage()
	SetModSettingString("sCWOVersion:Debug", "")
	SetModSettingString("sMainCWQuest:Debug", "")
	SetModSettingString("sPlayerFaction:Debug", "")
	SetModSettingString("sCampaignQuest:Debug", "")
	SetModSettingString("sCampaignPhase:Debug", "")
	SetModSettingString("sBountyImperial:Debug", "")
	SetModSettingString("sBountySons:Debug", "")
	SetModSettingString("sMonitor:Debug", "")
	SetModSettingString("sDisguise:Debug", "")
	SetModSettingString("sDisguised:Debug", "")
	SetModSettingString("sCourier:Debug", "")
	SetModSettingString("sCourierSent:Debug", "")
	SetModSettingString("sPatrols:Debug", "")
	SetModSettingString("sMission01:Debug", "")
	SetModSettingString("sMission02:Debug", "")
	SetModSettingString("sMission03:Debug", "")
	SetModSettingString("sMission04:Debug", "")
	SetModSettingString("sMission05:Debug", "")
	SetModSettingString("sMission06:Debug", "")
	SetModSettingString("sMission07:Debug", "")
	SetModSettingString("sMission08:Debug", "")
	SetModSettingString("sMission09:Debug", "")
	SetModSettingString("sSiege:Debug", "")
	SetModSettingString("sFortSiege:Debug", "")
	SetModSettingString("sCapitalSiege:Debug", "")
	SetModSettingString("sBleedoutMonitor:Debug", "")
	SetModSettingString("sME3:Debug", "")
	SetModSettingString("sDefender:Debug", "")
	SetModSettingString("sContestedHold:Debug", "")
	SetModSettingString("sCapitalQuest:Debug", "")
	SetModSettingString("sPoolAttackerCapital:Debug", "")
	SetModSettingString("sPoolDefenderCapital:Debug", "")
	SetModSettingString("sPoolAttackerFort:Debug", "")
	SetModSettingString("sPoolDefenderFort:Debug", "")
	SetModSettingString("sPoolAttackerMajor:Debug", "")
	SetModSettingString("sPoolDefenderMajor:Debug", "")
	SetModSettingString("sPoolGarrison:Debug", "")
	SetModSettingString("sPoolRemainingAttacker:Debug", "")
	SetModSettingString("sPoolRemainingDefender:Debug", "")
	SetModSettingString("sOwnerHaafingar:Debug", "")
	SetModSettingString("sOwnerHjaalmarch:Debug", "")
	SetModSettingString("sOwnerReach:Debug", "")
	SetModSettingString("sOwnerFalkreath:Debug", "")
	SetModSettingString("sOwnerWhiterun:Debug", "")
	SetModSettingString("sOwnerPale:Debug", "")
	SetModSettingString("sOwnerRift:Debug", "")
	SetModSettingString("sOwnerWinterhold:Debug", "")
	SetModSettingString("sOwnerEastmarch:Debug", "")

	SetModSettingString("sCWOVersion:Debug", GetCWOVersionReaderFriendly(CWOVersion.GetValue()))
	if CW.IsRunning()
		SetModSettingString("sMainCWQuest:Debug", "Is On Stage " + CW.GetStage() as String)
	endif
	if game.GetPlayer().IsInFaction(CWS.CWSonsFaction)
		SetModSettingString("sPlayerFaction:Debug", "In The Sons Faction")
	elseIf game.GetPlayer().IsInFaction(CWS.CWImperialFaction)
		SetModSettingString("sPlayerFaction:Debug", "In the Imperial Faction")
	else
		SetModSettingString("sPlayerFaction:Debug", "Not Yet Hostile")
	endIf
	if CWs.CWCampaign.IsRunning()
		SetModSettingString("sCampaignQuest:Debug", "Is On Stage " + CWs.CWCampaign.GetStage() as String)
		SetModSettingString("sCampaignPhase:Debug", CWs.CWCampaignS.CWCampaignPhase.GetValueInt() as string)
	endif
	if CWs.PlayerAllegiance == CWs.iImperials && CWs.CrimeFactionImperial.GetCrimeGold() > 0
		SetModSettingString("sBountyImperial:Debug", CWs.CrimeFactionImperial.GetCrimeGold() as string)
	elseif CWs.PlayerAllegiance == CWs.iSons && CWs.CrimeFactionSons.GetCrimeGold() > 0
		SetModSettingString("sBountySons:Debug", CWs.CrimeFactionSons.GetCrimeGold() as string)
	endif
	if CWOQuestMonitor.IsRunning()
		SetModSettingString("sMonitor:Debug", CWs.CWCampaignS.GetMonitorState())
	endif
	if CWOArmorDisguise.IsRunning()
		SetModSettingString("sDisguise:Debug", "Is On")
		if CWODisguiseGlobal.GetValueInt() > 0
			SetModSettingString("sDisguised:Debug", "YES")
		else
			SetModSettingString("sDisguised:Debug", "NO")
		endIf
	endIf
	if CWOSendForPlayer.IsRunning()
		SetModSettingString("sCourier:Debug", "Is On Stage " + CWOSendForPlayer.GetStage() as String)
		if CWOCourierSentGlobal.GetValue() > 0 as Float && CWOSendForPlayer.GetStage() < 10
			SetModSettingString("sCourierSent:Debug", "Has Been Sent")
		elseIf CWOSendForPlayer.GetStage() < 10
			SetModSettingString("sCourierSent:Debug", "Has NOT Been Sent")
		endIf
	endIf
	if CWOPatrolsQuest.IsRunning()
		SetModSettingString("sPatrols:Debug", "Is On")
	endif
	if CWs.CWCampaignS.CWMission01.IsRunning()
		SetModSettingString("sMission01:Debug", "Is On Stage " + CWs.CWCampaignS.CWMission01.GetStage() as String)
	endif
	if CWs.CWCampaignS.CWMission02.IsRunning()
		SetModSettingString("sMission02:Debug", "Is On Stage " + CWs.CWCampaignS.CWMission02.GetStage() as String)
	endif
	if CWs.CWMission03.IsRunning()
		SetModSettingString("sMission03:Debug", "Is On Stage " + CWs.CWMission03.GetStage() as String)
	endif
	if CWs.CWMission04.IsRunning()
		SetModSettingString("sMission04:Debug", "Is On Stage " + CWs.CWMission04.GetStage() as String)
	endif
	if CWs.CWCampaignS.CWMission05.IsRunning()
		SetModSettingString("sMission05:Debug", "Is On Stage " + CWs.CWCampaignS.CWMission05.GetStage() as String)
	endif
	if CWs.CWCampaignS.CWMission06.IsRunning()
		SetModSettingString("sMission06:Debug", "Is On Stage " + CWs.CWCampaignS.CWMission06.GetStage() as String)
	endif
	if CWs.CWMission07.IsRunning()
		SetModSettingString("sMission07:Debug", "Is On Stage " + CWs.CWMission07.GetStage() as String)
	endif
	if CWs.CWCampaignS.CWMission08Quest.IsRunning()
		SetModSettingString("sMission08:Debug", "Is On Stage " + CWs.CWCampaignS.CWMission08Quest.GetStage() as String)
	endif
	if CWs.CWCampaignS.CWMission09.IsRunning()
		SetModSettingString("sMission09:Debug", "Is On Stage " + CWs.CWCampaignS.CWMission09.GetStage() as String)
	endif
	if CWSiege.IsRunning()
		SetModSettingString("sSiege:Debug", "Is On Stage " + CWSiege.GetStage() as String)
	endif
	if CWFortsiegeFort.IsRunning()
		SetModSettingString("sFortSiege:Debug", "Is On Stage " + CWFortsiegeFort.GetStage() as String)
	endif
	if CWFortSiegeCapital.IsRunning()
		SetModSettingString("sCapitalSiege:Debug", "Is On Stage " + CWFortSiegeCapital.GetStage() as String)
	endif
	if cws.CWCampaignS.CWOStillABetterEndingMonitor.IsRunning()
		SetModSettingString("sBleedoutMonitor:Debug", "Is On")
	endif
	if CWOStillABetterEndingGlobal.GetValue() > 0 as Float
		SetModSettingString("sME3:Debug", "Is On")
	endif
	if CWs.CWDefender.GetValueInt() == CWs.playerAllegiance
		SetModSettingString("sDefender:Debug", "DEFENSE")
	else
		SetModSettingString("sDefender:Debug", "OFFENSE/DEFAULT")
	endif
	if CWS.CWcontestedHold.GetValueInt() == 1
		SetModSettingString("sContestedHold:Debug", "HAAFINGAR")
	elseIf CWS.CWcontestedHold.GetValueInt() == 2
		SetModSettingString("sContestedHold:Debug", "THE REACH")
	elseIf CWS.CWcontestedHold.GetValueInt() == 3
		SetModSettingString("sContestedHold:Debug", "HJAALMARCH")
	elseIf CWS.CWcontestedHold.GetValueInt() == 4
		SetModSettingString("sContestedHold:Debug", "WHITERUN")
	elseIf CWS.CWcontestedHold.GetValueInt() == 5
		SetModSettingString("sContestedHold:Debug", "FALKREATH")
	elseIf CWS.CWcontestedHold.GetValueInt() == 6
		SetModSettingString("sContestedHold:Debug", "THE PALE")
	elseIf CWS.CWcontestedHold.GetValueInt() == 7
		SetModSettingString("sContestedHold:Debug", "WINTERHOLD")
	elseIf CWS.CWcontestedHold.GetValueInt() == 8
		SetModSettingString("sContestedHold:Debug", "EASTMARCH")
	elseIf CWS.CWcontestedHold.GetValueInt() == 9
		SetModSettingString("sContestedHold:Debug", "THE RIFT")
	else
		SetModSettingString("sContestedHold:Debug", "N/A")
	endIf
	if CWFortSiegeCapital.IsRunning()
		SetModSettingString("sCapitalQuest:Debug", "Is On")
	endif
	if CWFortSiegeCapital.IsRunning() && !CWSiege.IsRunning()
		SetModSettingString("sPoolAttackerCapital:Debug", (CWFortSiegeCapital as CWReinforcementControllerScript).PoolAttacker as String)
		SetModSettingString("sPoolDefenderCapital:Debug", (CWFortSiegeCapital as CWReinforcementControllerScript).PoolDefender as String)
	endif
	if CWFortSiegeFort.IsRunning()
		SetModSettingString("sPoolAttackerFort:Debug", (CWFortSiegeFort as CWReinforcementControllerScript).PoolAttacker as String)
		SetModSettingString("sPoolDefenderFort:Debug", (CWFortSiegeFort as CWReinforcementControllerScript).PoolDefender as String)
	endif
	if CWSiege.IsRunning()
		SetModSettingString("sPoolAttackerMajor:Debug", (CWSiege as CWReinforcementControllerScript).PoolAttacker as String)
		SetModSettingString("sPoolDefenderMajor:Debug", (CWSiege as CWReinforcementControllerScript).PoolDefender as String)
	endif
	if CWs.CWCampaignS.CWMission01.IsRunning()
		SetModSettingString("sPoolGarrison:Debug", (CWSiege as CWReinforcementControllerScript).PoolDefender as String)
	endif
	if CWFortSiegeCapital.IsRunning() || CWFortSiegeFort.IsRunning() || CWSiege.IsRunning()
		SetModSettingString("sPoolRemainingAttacker:Debug", CWPercentPoolRemainingAttacker.GetValueInt() as string)
		SetModSettingString("sPoolRemainingDefender:Debug", CWPercentPoolRemainingDefender.GetValueInt() as string)
	endif
	SetModSettingString("sOwnerHaafingar:Debug", CWs.FactionName(CWs.GetHoldOwner(1)))
	SetModSettingString("sOwnerHjaalmarch:Debug", CWs.FactionName(CWs.GetHoldOwner(3)))
	SetModSettingString("sOwnerReach:Debug", CWs.FactionName(CWs.GetHoldOwner(2)))
	SetModSettingString("sOwnerFalkreath:Debug", CWs.FactionName(CWs.GetHoldOwner(5)))
	SetModSettingString("sOwnerWhiterun:Debug", CWs.FactionName(CWs.GetHoldOwner(4)))
	SetModSettingString("sOwnerPale:Debug", CWs.FactionName(CWs.GetHoldOwner(6)))
	SetModSettingString("sOwnerRift:Debug", CWs.FactionName(CWs.GetHoldOwner(9)))
	SetModSettingString("sOwnerWinterhold:Debug", CWs.FactionName(CWs.GetHoldOwner(7)))
	SetModSettingString("sOwnerEastmarch:Debug", CWs.FactionName(CWs.GetHoldOwner(8)))
endfunction

;-- Shared helpers / action functions ---------------------------------------

function SetReinforcements()
	if SetReinforcementsBusy
		return
	endif
	SetReinforcementsBusy = True
	Utility.Wait(5)
	if CWFortsiegeFort.IsRunning() && CWFortsiegeFort.GetStage() < 50
		CWs.CWCampaignS.SetReinforcementsFort(CWFortsiegeFort)
	endif
	if CWFortSiegeCapital.IsRunning() && CWFortSiegeCapital.GetStage() < 50 && (CWFortSiegeCapital as cwfortsiegemissionscript).SpecialNonFortSiege == 0
		CWs.CWCampaignS.SetReinforcementsMinorCity(CWFortSiegeCapital)
	endif
	if CWSiege.IsRunning() && CWSiege.GetStage() < 10
		CWs.CWCampaignS.SetReinforcementsMajorCity(CWSiege as CWSiegeScript)
	endif
	SetReinforcementsBusy = false
endfunction

string function GetCWOVersionReaderFriendly(Float version)
	int majorVersion = Math.Floor(version / 10000.0)
	int minorVersion = Math.Floor((version - (majorVersion * 10000)) / 100.0)
	int bugFix = Math.Floor(version - (majorVersion * 10000) - (minorVersion * 100))
	return majorVersion + "." + minorVersion + "." + bugFix
endfunction

function EnsureHoldLists()
	if holdsID == none || holdsList == none
		holdsList = new String[7]
		holdsList[0] = "Markarth"
		holdsList[1] = "Morthal"
		holdsList[2] = "Whiterun"
		holdsList[3] = "Falkreath"
		holdsList[4] = "Dawnstar"
		holdsList[5] = "Winterhold"
		holdsList[6] = "Riften"

		holdsID = new Int[7]
		holdsID[0] = 2
		holdsID[1] = 3
		holdsID[2] = 4
		holdsID[3] = 5
		holdsID[4] = 6
		holdsID[5] = 7
		holdsID[6] = 9
	endif
endfunction

function OnPayCrimeFaction()
	CWOApolloFixMe.Reset()
	CWOApolloFixMe.SetStage(60)
endfunction

function OnStopMusic()
	CWOApolloFixMe.Reset()
	CWOApolloFixMe.SetStage(30)
endfunction

function OnFixFactionAggression()
	CWOApolloFixMe.Reset()
	CWOApolloFixMe.SetStage(40)
endfunction

function OnFixWhiterunBridge()
	CWOApolloFixMe.Reset()
	CWOApolloFixMe.SetStage(50)
endfunction

function OnHelp()
	CWOApolloFixMe.Reset()
	CWOApolloFixMe.SetStage(10)
endfunction

function OnHelp2()
	CWOApolloFixMe.Reset()
	CWOApolloFixMe.SetStage(20)
endfunction

function OnUninstall()
	UninstallCWO()
endfunction

function OnWinSiege()
	CompleteRunningCampaign()
endfunction

function OnStartSiege()
	EnsureHoldLists()
	int holdIndex = iStartSiegeHold
	if holdIndex < 0 || holdIndex >= holdsID.length
		Debug.Notification("No hold selected.")
		return
	endif
	int holdID = holdsID[holdIndex]
	if CWs.CWcontestedHold.GetValueInt() == holdID
		Debug.Notification("Cannot set to current contested hold.")
	elseif CWs.CWAttacker.GetValueInt() == CWs.PlayerAllegiance && (CWs.CWcontestedHold.GetValueInt() == 1 || CWs.CWcontestedHold.GetValueInt() == 8)
		Debug.Notification("You are on the final contested hold. Cannot set.")
		return
	elseif CWs.GetHoldOwner(holdID) == CWs.PlayerAllegiance
		Debug.Notification("Cannot set to a hold you already own.")
		return
	endif
	CWs.CWDebugForceHold.SetValueInt(holdID)
	Debug.Notification("Setting next campaign hold to " + holdsList[holdIndex])
endfunction

function OnWinHold()
	EnsureHoldLists()
	int holdIndex = iWinHold
	if holdIndex < 0 || holdIndex >= holdsID.length
		Debug.Notification("No hold selected.")
		return
	endif
	int holdID = holdsID[holdIndex]
	if CWS.CWcontestedHold.GetValueInt() == holdID
		CompleteRunningCampaign(true)
	else
		Debug.Notification("Winning hold of " + holdsList[holdIndex])
		CWS.WinHoldOffScreenIfNotDoingCapitalBattles(CWs.getLocationForHold(holdID), CWs.GetHoldOwner(holdID) != CWs.PlayerAllegiance, CWs.GetHoldOwner(holdID) == CWs.PlayerAllegiance)
	endif
endfunction

function OnSwitchHold()
	EnsureHoldLists()
	int holdIndex = iSwitchHold
	if holdIndex < 0 || holdIndex >= holdsID.length
		Debug.Notification("No hold selected.")
		return
	endif
	int holdID = holdsID[holdIndex]
	if CWs.CWAttacker.GetValueInt() == CWs.PlayerAllegiance && (CWs.CWcontestedHold.GetValueInt() == 1 || CWs.CWcontestedHold.GetValueInt() == 8)
		Debug.Notification("You are on the final contested hold. Switch owners.")
		return
	endif
	if CWS.CWcontestedHold.GetValueInt() == holdID
		CompleteRunningCampaign(true)
	else
		Debug.Notification("Switching owner of " + holdsList[holdIndex])
		CWS.SetHoldOwnerByInt(holdID, CWs.getOppositeFactionInt(CWs.GetHoldOwner(holdID)))
	endif
endfunction

function OnWinWar()
	int factionIndex = iWinWarFaction
	if factionIndex == CWs.iImperials
		debug.notification("Winning the war for the imperials")
		if !CWs.CW01A.isrunning()
			CWs.CW01A.SetStage(1)
		endif
		CWs.CW01A.SetStage(200)

		if !(CWs.CW01A as CW01Script).CW02A.isrunning()
			(CWs.CW01A as CW01Script).CW02A.SetStage(10)
		endif
		(CWs.CW01A as CW01Script).CW02A.SetStage(200)

		if !CWs.CW03.isrunning()
			CWs.CW03.SetStage(10)
		endif
		CWs.CW03.SetStage(255)

		CompleteRunningCampaign()
		CWs.CWCampaignS.CWOImperialsWin()
	elseif factionIndex == CWs.iSons
		debug.notification("Winning the war for the stormcloaks")
		if !CWs.CW01B.isrunning()
			CWs.CW01B.SetStage(1)
		endif
		CWs.CW01B.SetStage(200)

		if !(CWs.CW01B as CW01BScript).CW02B.isrunning()
			(CWs.CW01B as CW01BScript).CW02B.SetStage(10)
		endif
		(CWs.CW01B as CW01BScript).CW02B.SetStage(200)

		if !CWs.CW03.isrunning()
			CWs.CW03.SetStage(10)
		endif
		CWs.CW03.SetStage(255)

		CompleteRunningCampaign()
		CWs.CWCampaignS.CWOStormcloaksWin()
	endif
endfunction

function UninstallCWO()
	CWOQuestMonitor.Stop()
	CWOBAController.Stop()
	CWOBAQuest.Stop()
	CWs.CWCampaignS.CompleteCWMissions()
	CWs.CWCampaignS.StartResolutionMission()
	Utility.Wait(10)
	CWs.CWCampaignS.CompleteCWSieges()
	Utility.Wait(10)
	CWS.CWRank1RewardImperial = CWRankRewardImperial
	CWS.CWRank2RewardImperial = LItemWeaponSwordSpecial 
	CWS.CWRank3RewardImperial = LItemArmorShieldHeavySpecial
	CWS.CWRank4RewardImperial = LItemArmorCuirassHeavySpecial
	CWS.CWRank1RewardSons = CWRankRewardSons
	CWS.CWRank2RewardSons = LItemWeaponSwordSpecial 
	CWS.CWRank3RewardSons = LItemArmorShieldLightSpecial
	CwS.CWRank4RewardSons = LItemArmorCuirassLightSpecial
	(CWS.CWFinale As CWFinaleScript).CWFinaleFactionLeaderSwordList = CWFinaleFactionLeaderSwordList
	if CWS.PlayerAllegiance == cws.iImperials
		Cws.WinHoldOffScreenIfNotDoingCapitalBattles(cws.haafingarholdlocation, CWs.GetOwner(cws.haafingarholdlocation) != cws.playerAllegiance, CWs.GetOwner(cws.haafingarholdlocation) == cws.playerAllegiance)
		Cws.WinHoldOffScreenIfNotDoingCapitalBattles(cws.Hjaalmarchholdlocation, CWs.GetOwner(cws.Hjaalmarchholdlocation) != cws.playerAllegiance, CWs.GetOwner(cws.Hjaalmarchholdlocation) == cws.playerAllegiance)
		CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.ReachHoldLocation, CWs.GetOwner(cws.ReachHoldLocation) != cws.playerAllegiance, CWs.GetOwner(cws.ReachHoldLocation) == cws.playerAllegiance)
		CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.FalkreathHoldLocation, CWs.GetOwner(cws.FalkreathHoldLocation) != cws.playerAllegiance, CWs.GetOwner(cws.FalkreathHoldLocation) == cws.playerAllegiance)
		CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.WhiterunHoldLocation, CWs.GetOwner(cws.WhiterunHoldLocation) != cws.playerAllegiance, CWs.GetOwner(cws.WhiterunHoldLocation) == cws.playerAllegiance)
		if CWs.GetOwner(CWs.PaleHoldLocation) == cws.iImperials
			CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.PaleHoldLocation, false, true)
			Cws.CWMission07Done = 1
		endif
		if CWs.GetOwner(CWs.RiftHoldLocation) == cws.iImperials
			CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.PaleHoldLocation, CWs.GetOwner(cws.PaleHoldLocation) != cws.playerAllegiance, CWs.GetOwner(cws.PaleHoldLocation) == cws.playerAllegiance)
			CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.RiftHoldLocation, false, true)
			CWs.CWMission03Done = 1
			Cws.CWMission07Done = 1
		endif
		if CWs.GetOwner(CWs.WinterholdHoldLocation) == cws.iImperials
			CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.PaleHoldLocation, CWs.GetOwner(cws.PaleHoldLocation) != cws.playerAllegiance, CWs.GetOwner(cws.PaleHoldLocation) == cws.playerAllegiance)
			CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.RiftHoldLocation, CWs.GetOwner(cws.RiftHoldLocation) != cws.playerAllegiance, CWs.GetOwner(cws.RiftHoldLocation) == cws.playerAllegiance)
			CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.WinterholdHoldLocation, false, true)
			CWs.CWMission04Done = 1
			CWs.CWMission03Done = 1
			Cws.CWMission07Done = 1
		endif
	elseif cws.playerAllegiance == cws.iSons
		Cws.WinHoldOffScreenIfNotDoingCapitalBattles(cws.eastmarchholdlocation, CWs.GetOwner(cws.eastmarchholdlocation) != cws.playerAllegiance, CWs.GetOwner(cws.eastmarchholdlocation) == cws.playerAllegiance)
		Cws.WinHoldOffScreenIfNotDoingCapitalBattles(cws.WinterholdHoldLocation, CWs.GetOwner(cws.WinterholdHoldLocation) != cws.playerAllegiance, CWs.GetOwner(cws.WinterholdHoldLocation) == cws.playerAllegiance)
		CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.RiftHoldLocation, CWs.GetOwner(cws.RiftHoldLocation) != cws.playerAllegiance, CWs.GetOwner(cws.RiftHoldLocation) == cws.playerAllegiance)
		CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.PaleHoldLocation, CWs.GetOwner(cws.PaleHoldLocation) != cws.playerAllegiance, CWs.GetOwner(cws.PaleHoldLocation) == cws.playerAllegiance)
		if CWs.GetOwner(CWs.WhiterunHoldLocation) == cws.iSons
			CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.WhiterunHoldLocation, false, true)
		endif
		if CWs.GetOwner(CWs.FalkreathHoldLocation) == cws.iSons
			CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.FalkreathHoldLocation, false, true)
			Cws.CWMission04Done = 1
		endif
		if CWs.GetOwner(CWs.ReachHoldLocation) == cws.iSons
			CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.FalkreathHoldLocation, CWs.GetOwner(cws.FalkreathHoldLocation) != cws.playerAllegiance, CWs.GetOwner(cws.FalkreathHoldLocation) == cws.playerAllegiance)
			CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.ReachHoldLocation, false, true)
			Cws.CWMission04Done = 1
			CWs.CWMission03Done = 1
		endif
		if CWs.GetOwner(CWs.Hjaalmarchholdlocation) == cws.iSons
			CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.FalkreathHoldLocation, CWs.GetOwner(cws.FalkreathHoldLocation) != cws.playerAllegiance, CWs.GetOwner(cws.FalkreathHoldLocation) == cws.playerAllegiance)
			CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.ReachHoldLocation, CWs.GetOwner(cws.ReachHoldLocation) != cws.playerAllegiance, CWs.GetOwner(cws.ReachHoldLocation) == cws.playerAllegiance)
			CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.Hjaalmarchholdlocation, false, true)
			CWs.CWMission04Done = 1
			Cws.CWMission07Done = 1
			CWs.CWMission03Done = 1
		endif
	endif	
	Debug.notification("CWO Uninstalled.")
	self.Stop()
endfunction

function CompleteRunningCampaign(bool failQuests = false)
	if !CWs.WhiterunSiegeFinished
		debug.notification("No campaigns running")
		return	
	endif
	debug.notification("Completing Missions if there any running")
	CWs.CWCampaignS.CompleteCWMissions(failQuests)
	debug.notification("Starting Hold Siege")
	CWs.CWCampaignS.StartResolutionMission()
	int wait = 0
	while !CWs.CWSiegeS.IsRunning() && !CWs.CWFortSiegeCapital.IsRunning() && wait < 30
		Utility.Wait(1.0)
		wait = wait + 1
	endWhile
	if wait >= 30
		debug.notification("Waited 30 seconds to start the hold siege put it never started. Please notify author.")
		CWs.CWCampaignS.AddGeneralToRewardFaction()
		Location contestedHoldLocation = cws.GetLocationForHold(cws.CWContestedHold.GetValueInt())
		CWs.CWDebugForceAttacker.SetValueInt(CWs.PlayerAllegiance)
		if CWs.CWCampaign.IsRunning()
			CWs.SetStage(255)
		endif
		CWs.WinHoldOffScreenIfNotDoingCapitalBattles(contestedHoldLocation, CWs.GetOwner(contestedHoldLocation) != cws.playerAllegiance, CWs.GetOwner(contestedHoldLocation) == cws.playerAllegiance)
		CWs.CWCampaignS.CWOMonitorQuest.GoToState("WaitingToStartNewCampaign")
	else
		debug.notification("Completing Hold Siege")
		if failQuests
			CWs.CWCampaignS.FailCWSieges()
		else
			CWs.CWCampaignS.CompleteCWSieges()
		endif
		debug.notification("Hold Siege Completed")
	endif
endfunction