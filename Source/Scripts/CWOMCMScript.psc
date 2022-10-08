scriptName CWOMCMScript extends SKI_ConfigBase

;-- Properties --------------------------------------
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

;-- Variables ---------------------------------------
Int _color = 16777215
Int _colorOID_C
Int _myKey = -1
Int _keymapOID_K
Int optionsStartSiege
Int optionsReinforcementsBaseCity
Int optionsPartyCrashersChance
Int optionsWinSiege
Int optionsReinforcementsBaseFort
Int optionsReinforcementsBaseCapital
Int optionsReinforcementsBaseGarrison
Int optionsCWOHelp
Int optionsCWOUninstall
Int optionsPlayerAttackerScaleMult
Int optionsPlayerDefenderScaleMult
Int optionsEnemyAttackerScaleMult
Int optionsEnemyDefenderScaleMult
Int optionsWinWar
Int optionsWinHold
Int optionsBAChance
int optionsDisguiseGameType
int optionsSIChance
int optionsCourierHoursMin
int optionsCourierHoursMax
int optionsCampaignPhaseMax

Float _sliderPercent = 100.000

Bool optionWinWarToggle = false
Bool optionsCWOHelpToggle = false
Bool optionsCWOUninstallToggle = false
bool SetReinforcementsBusy = False
bool optionsToggleCWWinBattle = false

String[] gameDisguiseList
String[] holdsList
;-- Functions ---------------------------------------

function SetReinforcements()
	if SetReinforcementsBusy
		return
	endif
	SetReinforcementsBusy = True
	Utility.Wait(5)
	if CWFortsiegeFort.IsRunning() && CWFortsiegeFort.GetStage() < 50
		CWs.CWCampaignS.SetReinforcementsFort(CWFortsiegeFort as CWsiegeScript)
	endif
	if CWFortSiegeCapital.IsRunning() && CWFortSiegeCapital.GetStage() < 50 && (CWFortSiegeCapital as cwfortsiegemissionscript).SpecialNonFortSiege == 0
		CWs.CWCampaignS.SetReinforcementsMinorCity(CWFortSiegeCapital as CWsiegeScript)
	endif
	if CWSiege.IsRunning() && CWSiege.GetStage() < 10
        CWs.CWCampaignS.SetReinforcementsMajorCity(CWSiege as CWSiegeScript)
	endif
	SetReinforcementsBusy = false
endfunction

function OnOptionSliderAccept(Int a_option, Float a_value)
{Called when the user accepts a new slider value}

	if a_option == optionsReinforcementsBaseCapital
		_sliderPercent = a_value
		self.SetSliderOptionValue(a_option, a_value, "{0}", false)
		CWOCapitalReinforcements.SetValue(a_value)
		SetReinforcements()
	elseif a_option == optionsReinforcementsBaseCapital
		_sliderPercent = a_value
		self.SetSliderOptionValue(a_option, a_value, "{0}", false)
		CWOCampaignPhaseMax.SetValue(a_value)
		SetReinforcements()
	elseIf a_option == optionsReinforcementsBaseFort
		_sliderPercent = a_value
		self.SetSliderOptionValue(a_option, a_value, "{0}", false)
		CWOFortReinforcements.SetValue(a_value)
		SetReinforcements()
	elseIf a_option == optionsReinforcementsBaseCity
		_sliderPercent = a_value
		self.SetSliderOptionValue(a_option, a_value, "{0}", false)
		CWOSiegeReinforcements.SetValue(a_value)
		SetReinforcements()
	elseIf a_option == optionsReinforcementsBaseGarrison
		_sliderPercent = a_value
		self.SetSliderOptionValue(a_option, a_value, "{0}", false)
		CWOGarrisonReinforcements.SetValue(a_value)
		if CWs.CWCampaignS.CWMission01.IsRunning() && CWs.CWCampaignS.CWMission01.GetStage() < 10
			(CWs.CWCampaignS.CWMission01 as CWMission01Script).SetEnemyPools()
		endif
	elseIf a_option == optionsPlayerAttackerScaleMult
		_sliderPercent = a_value
		self.SetSliderOptionValue(a_option, a_value, "{1}", false)
		CWOPlayerAttackerScaleMult.SetValue(a_value)
		SetReinforcements()
	elseIf a_option == optionsPlayerDefenderScaleMult
		_sliderPercent = a_value
		self.SetSliderOptionValue(a_option, a_value, "{1}", false)
		CWOPlayerDefenderScaleMult.SetValue(a_value)
		SetReinforcements()
	elseIf a_option == optionsEnemyAttackerScaleMult
		_sliderPercent = a_value
		self.SetSliderOptionValue(a_option, a_value, "{1}", false)
		CWOEnemyAttackerScaleMult.SetValue(a_value)
		SetReinforcements()
	elseIf a_option == optionsEnemyDefenderScaleMult
		_sliderPercent = a_value
		self.SetSliderOptionValue(a_option, a_value, "{1}", false)
		CWOEnemyDefenderScaleMult.SetValue(a_value)
		SetReinforcements()
	elseIf a_option == optionsPartyCrashersChance
		_sliderPercent = a_value
		self.SetSliderOptionValue(a_option, a_value, "{0}%", false)
		CWOPCChance.SetValue(a_value)
	elseIf a_option == optionsBAChance
		_sliderPercent = a_value
		self.SetSliderOptionValue(a_option, a_value, "{0}%", false)
		CWOBAChance.SetValue(a_value)
	elseIf a_option == optionsSIChance
		_sliderPercent = a_value
		self.SetSliderOptionValue(a_option, a_value, "{0}%", false)
		CWOSIChance.SetValue(a_value)
	elseIf a_option == optionsCourierHoursMin
		_sliderPercent = a_value
		self.SetSliderOptionValue(a_option, a_value, "{0}", false)
		CWOCourierHoursMin.SetValue(a_value)
	elseIf a_option == optionsCourierHoursMax
		_sliderPercent = a_value
		self.SetSliderOptionValue(a_option, a_value, "{0}", false)
		CWOCourierHoursMax.SetValue(a_value)
	endIf
endFunction



function OnOptionSelect(Int a_option)
{Called when the user selects a non-dialog option}

	if a_option == optionsWinWar
		optionWinWarToggle = !optionWinWarToggle
		self.SetToggleOptionValue(a_option, optionWinWarToggle, false)
		if CWs.PlayerAllegiance == 1
			CWs.CWCampaignS.CWOImperialsWin()
		else
			CWs.CWCampaignS.CWOStormcloaksWin()
		endIf
	elseIf a_option == optionsWinSiege
		optionsToggleCWWinBattle = !optionsToggleCWWinBattle
		self.SetToggleOptionValue(a_option, optionsToggleCWWinBattle, false)
		CWs.CWCampaignS.CompleteCWMissions()
		CWs.CWCampaignS.CompleteCWSieges()
	elseIf a_option == optionsCWOHelp
		optionsCWOHelpToggle = !optionsCWOHelpToggle
		self.SetToggleOptionValue(a_option, optionsCWOHelpToggle, false)
		CWs.CWCampaignS.GetCWOUnstuck()
	elseIf a_option == optionsCWOHelp
		optionsCWOUninstallToggle = true
		self.SetToggleOptionValue(a_option, true, false)
		UninstallCWO()
	endIf
endFunction

function OnOptionSliderOpen(Int a_option)
{Called when the user selects a slider option}

	If a_option == optionsReinforcementsBaseCapital
		self.SetSliderDialogStartValue(CWOCapitalReinforcements.GetValueInt() as Float)
		self.SetSliderDialogDefaultValue(20 as Float)
		self.SetSliderDialogRange(0 as Float, 500 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf a_option == optionsReinforcementsBaseFort
		self.SetSliderDialogStartValue(CWOFortReinforcements.GetValueInt() as Float)
		self.SetSliderDialogDefaultValue(15 as Float)
		self.SetSliderDialogRange(0 as Float, 300 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf a_option == optionsReinforcementsBaseCity
		self.SetSliderDialogStartValue(CWOSiegeReinforcements.GetValueInt() as Float)
		self.SetSliderDialogDefaultValue(25 as Float)
		self.SetSliderDialogRange(0 as Float, 300 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf a_option == optionsReinforcementsBaseGarrison
		self.SetSliderDialogStartValue(CWOGarrisonReinforcements.GetValueInt() as Float)
		self.SetSliderDialogDefaultValue(10 as Float)
		self.SetSliderDialogRange(0 as Float, 20 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf a_option == optionsCampaignPhaseMax
		self.SetSliderDialogStartValue(CWOCampaignPhaseMax.GetValueInt() as Float)
		self.SetSliderDialogDefaultValue(3 as Float)
		self.SetSliderDialogRange(1 as Float, 5 as Float)
		self.SetSliderDialogInterval(2 as Float)
	elseIf a_option == optionsPlayerAttackerScaleMult
		self.SetSliderDialogStartValue(CWOPlayerAttackerScaleMult.GetValue() as Float)
		self.SetSliderDialogDefaultValue(0.8 as Float)
		self.SetSliderDialogRange(0.2 as Float, 2.0 as Float)
		self.SetSliderDialogInterval(0.1 as Float)
	elseIf a_option == optionsPlayerDefenderScaleMult
		self.SetSliderDialogStartValue(CWOPlayerDefenderScaleMult.GetValue() as Float)
		self.SetSliderDialogDefaultValue(0.9 as Float)
		self.SetSliderDialogRange(0.2 as Float, 2.0 as Float)
		self.SetSliderDialogInterval(0.1 as Float)
	elseIf a_option == optionsEnemyAttackerScaleMult
		self.SetSliderDialogStartValue(CWOEnemyAttackerScaleMult.GetValue() as Float)
		self.SetSliderDialogDefaultValue(1.1 as Float)
		self.SetSliderDialogRange(0.2 as Float, 2.0 as Float)
		self.SetSliderDialogInterval(0.1 as Float)
	elseIf a_option == optionsEnemyDefenderScaleMult
		self.SetSliderDialogStartValue(CWOEnemyDefenderScaleMult.GetValue() as Float)
		self.SetSliderDialogDefaultValue(1.2 as Float)
		self.SetSliderDialogRange(0.2 as Float, 2.0 as Float)
		self.SetSliderDialogInterval(0.1 as Float)
	elseIf a_option == optionsPartyCrashersChance
		self.SetSliderDialogStartValue(CWOPCChance.GetValueInt() as Float)
		self.SetSliderDialogDefaultValue(CWOPCChance.GetValueInt() as Float)
		self.SetSliderDialogRange(0 as Float, 100 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf a_option == optionsBAChance
		self.SetSliderDialogStartValue(CWOBAChance.GetValueInt() as Float)
		self.SetSliderDialogDefaultValue(4 as Float)
		self.SetSliderDialogRange(0 as Float, 100 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf a_option == optionsSIChance
		self.SetSliderDialogStartValue(CWOSiChance.GetValueInt() as Float)
		self.SetSliderDialogDefaultValue(2 as Float)
		self.SetSliderDialogRange(0 as Float, 100 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf a_option == optionsCourierHoursMin
		self.SetSliderDialogStartValue(CWOCourierHoursMin.GetValueInt() as Float)
		self.SetSliderDialogDefaultValue(24 as Float)
		self.SetSliderDialogRange(1 as Float, 123 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf a_option == optionsCourierHoursMax
		self.SetSliderDialogStartValue(CWOCourierHoursMax.GetValueInt() as Float)
		self.SetSliderDialogDefaultValue(124 as Float)
		self.SetSliderDialogRange(2 as Float, 124 as Float)
		self.SetSliderDialogInterval(1 as Float)
	endIf
endFunction

function OnOptionColorOpen(Int a_option)
{Called when a color option has been selected}

	if a_option == _colorOID_C
		self.SetColorDialogStartColor(_color)
		self.SetColorDialogDefaultColor(16777215)
	endIf
endFunction

event OnConfigClose()
	optionWinWarToggle = false
	optionsCWOHelpToggle = false
	SetReinforcementsBusy = False
	optionsToggleCWWinBattle = false
	optionsCWOHelpToggle = false
endevent

function OnPageReset(String a_page)
{Called when a new page is selected, including the initial empty page}
	optionsCWOUninstallToggle = !CWOQuestMonitor.IsRunning()
	if a_page == "CWO Debug"
		SetCursorFillMode(self.LEFT_TO_RIGHT)
		if CW.IsRunning()
			self.AddtextOption("Main CW Quest", "Is On Stage " + CW.Getstage() as String, 0)
		endIf
		if game.Getplayer().IsInFaction(CWS.CWSonsFaction)
			self.AddtextOption("We are", "In The Sons Faction", 0)
		elseIf game.Getplayer().IsInFaction(CWS.CWImperialFaction)
			self.AddtextOption("We are", "In the Imperial Faction", 0)
		else
			self.AddtextOption("We are", "Not Yet Hostile", 0)
		endIf
		if CWs.CWCampaign.IsRunning()
			self.AddtextOption("CWCampaign Quest", "Is On Stage " + CWs.CWCampaign.Getstage() as String, 0)
			AddtextOption("CWCampaignPhase Is", CWs.CWCampaignS.CWCampaignPhase.GetValueInt(), 0)
		endIf
		if CWOArmorDisguise.IsRunning()
			self.AddtextOption("CWOArmorDisguise", "Is On", 0)
			if CWODisguiseGlobal.GetValueInt() > 0
				self.AddtextOption("Are we disguised?", "YES", 0)
			else
				self.AddtextOption("Are we disguised?", "NO", 0)
			endIf
		endIf
		if CWOSendForPlayer.IsRunning()
			self.AddtextOption("CWO Courier Quest", "Is On Stage " + CWOSendForPlayer.Getstage() as String, 0)
			if CWOCourierSentGlobal.GetValue() > 0 as Float && CWOSendForPlayer.Getstage() < 10
				self.AddtextOption("CWO Courier", "Has Been Sent", 0)
			elseIf CWOSendForPlayer.Getstage() < 10
				self.AddtextOption("CWO Courier", "Has NOT Been Sent", 0)
			endIf
		endIf
		if CWOPatrolsQuest.IsRunning()
			self.AddtextOption("CWOPatrolsQuest", "Is On", 0)
		endIf
		if CWs.CWCampaignS.CWMission01.IsRunning()
			self.AddtextOption("Skirmish at X", "Is On Stage " + CWs.CWCampaignS.CWMission01.Getstage() as String, 0)
		endIf
		if CWs.CWCampaignS.CWMission02.IsRunning()
			self.AddtextOption("Sabotage at X", "Is On Stage " + CWs.CWCampaignS.CWMission02.Getstage() as String, 0)
		endIf
		if CWs.CWMission03.IsRunning()
			self.AddtextOption("A False Front", "Is On Stage " + CWs.CWMission03.Getstage() as String, 0)
		endIf
		if CWs.CWMission04.IsRunning()
			self.AddtextOption("Rescue From X", "Is On Stage " + CWs.CWMission04.Getstage() as String, 0)
		endIf
		if CWs.CWCampaignS.CWMission05.IsRunning()
			self.AddtextOption("X's Last Battle", "Is On Stage " + CWs.CWCampaignS.CWMission05.Getstage() as String, 0)
		endIf
		if CWs.CWCampaignS.CWMission06.IsRunning()
			self.AddtextOption("Defector Collector", "Is On Stage " + CWs.CWCampaignS.CWMission06.Getstage() as String, 0)
		endIf
		if CWs.CWMission07.IsRunning()
			self.AddtextOption("Compelling Tribute", "Is On Stage " + CWs.CWMission07.Getstage() as String, 0)
		endIf
		if CWs.CWCampaignS.CWMission08Quest.IsRunning()
			self.AddtextOption("Can't Lead a Cow to Goldar", "Is On Stage " + CWs.CWCampaignS.CWMission08Quest.Getstage() as String, 0)
		endIf
		if CWs.CWCampaignS.CWMission09.IsRunning()
			self.AddtextOption("X Marks the Docs", "Is On Stage " + CWs.CWCampaignS.CWMission09.Getstage() as String, 0)
		endIf
		if CWSiege.IsRunning()
			self.AddtextOption("Major Siege Quest", "Is On Stage " + CWSiege.Getstage() as String, 0)
		endIf
		if CWFortsiegeFort.IsRunning()
			self.AddtextOption("Fort Siege Quest", "Is On Stage " + CWFortsiegeFort.Getstage() as String, 0)
		endIf
		if CWFortSiegeCapital.IsRunning()
			self.AddtextOption("Capital Siege Quest", "Is On Stage " + CWFortSiegeCapital.Getstage() as String, 0)
		endIf
		if cws.CWCampaignS.CWOStillABetterEndingMonitor.IsRunning()
			AddtextOption("Player Bleedout Monitor", "Is On", 0)
		endif
		if CWOStillABetterEndingGlobal.GetValue() > 0 as Float
			self.AddtextOption("STILL A BETTER ENDING THAN MASS EFFECT 3", "Is On", 0)
		endIf
		if CWs.CWDefender.GetValueInt() == CWs.playerAllegiance
			self.AddtextOption("CWO Thinks you are on", "DEFENSE", 0)
		else
			self.AddtextOption("CWO Thinks you are on", "OFFENSE/DEFAULT", 0)
		endIf
		if CWS.CWcontestedHold.GetValueInt() == 1
			self.AddtextOption("CWO Thinks your current hold is", "HAAFINGAR", 0)
		elseIf CWS.CWcontestedHold.GetValueInt() == 2
			self.AddtextOption("CWO Thinks your current hold is", "THE REACH", 0)
		elseIf CWS.CWcontestedHold.GetValueInt() == 3
			self.AddtextOption("CWO Thinks your current hold is", "HJAALMARCH", 0)
		elseIf CWS.CWcontestedHold.GetValueInt() == 4
			self.AddtextOption("CWO Thinks your current hold is", "Whiterun", 0)
		elseIf CWS.CWcontestedHold.GetValueInt() == 5
			self.AddtextOption("CWO Thinks your current hold is", "Falkreath", 0)
		elseIf CWS.CWcontestedHold.GetValueInt() == 6
			self.AddtextOption("CWO Thinks your current hold is", "THE PALE", 0)
		elseIf CWS.CWcontestedHold.GetValueInt() == 7
			self.AddtextOption("CWO Thinks your current hold is", "Winterhold", 0)
		elseIf CWS.CWcontestedHold.GetValueInt() == 8
			self.AddtextOption("CWO Thinks your current hold is", "EASTMARCH", 0)
		elseIf CWS.CWcontestedHold.GetValueInt() == 9
			self.AddtextOption("CWO Thinks your current hold is", "THE RIFT", 0)
		else
			self.AddtextOption("CWO Thinks your current hold is", "N/A", 0)
		endIf
		if CWFortSiegeCapital.IsRunning()
			self.AddtextOption("CWO thinks a capital quest", "Is On", 0)
		endIf
		if CWFortSiegeCapital.IsRunning()
			self.AddtextOption("Siege Attacker Pool is:", (CWFortSiegeCapital as CWReinforcementControllerScript).PoolAttacker as String, 0)
			self.AddtextOption("Siege Defender Pool is:", (CWFortSiegeCapital as CWReinforcementControllerScript).PoolDefender as String, 0)
		endIf
		if CWFortSiegeFort.IsRunning()
			self.AddtextOption("Siege Attacker Pool is:", (CWFortSiegeFort as CWReinforcementControllerScript).PoolAttacker as String, 0)
			self.AddtextOption("Siege Defender Pool is:", (CWFortSiegeFort as CWReinforcementControllerScript).PoolDefender as String, 0)
		endIf
		if CWSiege.IsRunning()
			self.AddtextOption("Siege Attacker Pool is:", (CWSiege as CWReinforcementControllerScript).PoolAttacker as String, 0)
			self.AddtextOption("Siege Defender Pool is:", (CWSiege as CWReinforcementControllerScript).PoolDefender as String, 0)
		endIf
		if CWFortSiegeCapital.IsRunning() || CWFortSiegeFort.IsRunning() || CWSiege.IsRunning()
			self.AddtextOption("CWPercentPoolRemainingAttacker is at", CWPercentPoolRemainingAttacker.GetValueInt() as String, 0)
			self.AddtextOption("CWPercentPoolRemainingDefender is at", CWPercentPoolRemainingDefender.GetValueInt() as String, 0)
		endif
		self.AddtextOption("Haafingar is owned by the", CWs.FactionName(CWs.GetHoldOwner(1)), 0)
		self.AddtextOption("Hjaalmarch is owned by the", CWs.FactionName(CWs.GetHoldOwner(3)), 0)
		self.AddtextOption("The Reach is owned by the", CWs.FactionName(CWs.GetHoldOwner(2)), 0)
		self.AddtextOption("Falkreath is owned by the", CWs.FactionName(CWs.GetHoldOwner(5)), 0)
		self.AddtextOption("Whiterun is owned by the", CWs.FactionName(CWs.GetHoldOwner(4)), 0)
		self.AddtextOption("The Pale is owned by the", CWs.FactionName(CWs.GetHoldOwner(6)), 0)
		self.AddtextOption("The Rift is owned by the", CWs.FactionName(CWs.GetHoldOwner(9)), 0)
		self.AddtextOption("Winterhold is owned by the", CWs.FactionName(CWs.GetHoldOwner(7)), 0)
		self.AddtextOption("Eastmarch is owned by the", CWs.FactionName(CWs.GetHoldOwner(8)), 0)
	elseIf a_page == "CWO Options"
		self.SetCursorFillMode(self.LEFT_TO_RIGHT)
		optionsReinforcementsBaseCapital = self.AddSlideroption("Capital Reinforcements Base", CWOCapitalReinforcements.GetValueInt() as Float, "{0}", 0)
		optionsReinforcementsBaseFort = self.AddSlideroption("Fort Reinforcements Base", CWOFortReinforcements.GetValueInt() as Float, "{0}", 0)
		optionsReinforcementsBaseCity = self.AddSlideroption("Siege Reinforcements Base", CWOSiegeReinforcements.GetValueInt() as Float, "{0}", 0)
		optionsReinforcementsBaseGarrison = self.AddSlideroption("Garrison Reinforcements Base", CWOSiegeReinforcements.GetValueInt() as Float, "{0}", 0)
		optionsPlayerAttackerScaleMult = self.AddSlideroption("Player Attacking Scale Mult", CWOPlayerAttackerScaleMult.GetValue() as Float, "{1}", 0)
		optionsPlayerDefenderScaleMult = self.AddSlideroption("Player Defending Scale Mult", CWOPlayerDefenderScaleMult.GetValue() as Float, "{1}", 0)
		optionsEnemyAttackerScaleMult = self.AddSlideroption("Enemy Attacking Scale Mult", CWOEnemyAttackerScaleMult.GetValue() as Float, "{1}", 0)
		optionsEnemyDefenderScaleMult = self.AddSlideroption("Enemy Defending Scale Mult", CWOEnemyDefenderScaleMult.GetValue() as Float, "{1}", 0)
		optionsCampaignPhaseMax = self.AddSlideroption("Campaign Phase Max", CWOCampaignPhaseMax.GetValue() as Float, "{0}", 0)
		optionsPartyCrashersChance = self.AddSlideroption("PARTY CRASHERS chance", CWOPCChance.GetValueInt() as Float, "{0}%", 0)
		optionsBAChance = self.AddSlideroption("Benedict Arnold Spies Chance", CWOBAChance.GetValueInt() as Float, "{0}%", 0)
		optionsSiChance = self.AddSlideroption("Spanish Inquisition Chance", CWOSiChance.GetValueInt() as Float, "{0}%", 0)
		optionsCourierHoursMin = self.AddSlideroption("Courier Hours Min", CWOCourierHoursMin.GetValueInt() as Float, "{0}", 0)
		optionsCourierHoursMax = self.AddSlideroption("Courier Hours Max", CWOCourierHoursMax.GetValueInt() as Float, "{0}", 0)
		optionsDisguiseGameType = self.AddMenuOption("Disguise Mechanic:", " ", 0)
		optionsStartSiege = self.AddMenuOption("Force start siege here:", " ", 0)
		optionsWinSiege = self.AddToggleOption("Win running siege:", optionsToggleCWWinBattle, 0)
		optionsWinHold = self.AddMenuOption("Win hold here:", " ", 0)
		optionsWinWar = self.AddToggleOption("Win the war", optionWinWarToggle, 0)
		optionsCWOHelp = self.AddToggleOption("Help get quests unstuck", optionsCWOHelpToggle, 0)
		optionsCWOUninstall = self.AddToggleOption("Uninstall CWO", optionsCWOUninstallToggle, 0)

		self.AddEmptyOption()
	endIf
endFunction

Int function GetVersion()

	return CWOVersion.GetValueInt()
endFunction

function OnConfigInit()

	Pages = new String[2]
	Pages[0] = "CWO Debug"
	Pages[1] = "CWO Options"
	holdsList = new String[9]
	holdsList[0] = "Solitude"
	holdsList[1] = "Markarth"
	holdsList[2] = "Morthal"
	holdsList[3] = "Whiterun"
	holdsList[4] = "Falkreath"
	holdsList[5] = "Dawnstar"
	holdsList[6] = "Winterhold"
	holdsList[7] = "Windhelm"
	holdsList[8] = "Riften"

	gameDisguiseList = new String[3]
	gameDisguiseList[0] = "Default"
	gameDisguiseList[1] = "Realistic"
	gameDisguiseList[2] = "Disabled"

endFunction

function OnOptionColorAccept(Int a_option, Int a_color)
{Called when a new color has been accepted}

	if a_option == _colorOID_C
		_color = a_color
		self.SetColorOptionValue(a_option, a_color, false)
	endIf
endFunction

; Skipped compiler generated GotoState

function OnOptionMenuOpen(Int a_option)
{Called when the user selects a menu option}

	if a_option == optionsStartSiege
		self.SetMenuDialogStartIndex(0)
		self.SetMenuDialogDefaultIndex(0)
		self.SetMenuDialogOptions(holdsList)
	elseif a_option == optionsWinHold
		self.SetMenuDialogStartIndex(0)
		self.SetMenuDialogDefaultIndex(0)
		self.SetMenuDialogOptions(holdsList)
	elseIf a_option == optionsDisguiseGameType
		self.SetMenuDialogStartIndex(CWODisguiseGameType.GetValueInt())
		self.SetMenuDialogDefaultIndex(CWODisguiseGameType.GetValueInt())
		self.SetMenuDialogOptions(gameDisguiseList)
	endIf
endFunction

function OnOptionMenuAccept(Int a_option, Int a_index)
{Called when the user accepts a new menu entry}

	if a_option == optionsStartSiege
		if !CWs.CWCampaign.IsRunning()
			CWs.CWDebugForceHold.SetValueInt(a_index + 1)
			CWs.StartNewCampaign()
		else

		endif
	elseIf a_option == optionsWinHold
		CWs.WinHoldOffScreenIfNotDoingCapitalBattles(CWs.GetLocationForHold(a_index + 1), true, false)
	elseif a_option == optionsDisguiseGameType
		CWODisguiseGameType.SetValueInt(a_index)
		if CWOArmorDisguise.IsRunning()
			CWOArmorDisguise.Stop()
			CWOArmorDisguise.Start()
		endif
	endIf
endFunction

function OnVersionUpdate(Int a_version)
{Called when a version update of this script has been detected}
	OnConfigInit()
endFunction

function OnOptionHighlight(Int a_option)
{Called when the user highlights an option}

	if a_option == optionsReinforcementsBaseCapital
		self.SetInfoText("Base Reinforcements for Minor Capital sieges")
	elseIf a_option == optionsReinforcementsBaseFort
		self.SetInfoText("Base reinforcements for Fort sieges")
	elseIf a_option == optionsReinforcementsBaseCity
		self.SetInfoText("Base reinforcements for Major sieges")
	elseIf a_option == optionsReinforcementsBaseGarrison
		self.SetInfoText("TODO")
	elseIf a_option == optionsPlayerAttackerScaleMult
		self.SetInfoText("TODO")
	elseIf a_option == optionsPlayerDefenderScaleMult
		self.SetInfoText("TODO")
	elseIf a_option == optionsEnemyAttackerScaleMult
		self.SetInfoText("TODO")
	elseIf a_option == optionsEnemyDefenderScaleMult
		self.SetInfoText("TODO")
	elseIf a_option == optionsCampaignPhaseMax
		self.SetInfoText("TODO")
	elseIf a_option == optionsPartyCrashersChance
		self.SetInfoText("Chance for dragon attacks during major capital sieges.")
	elseIf a_option == optionsWinWar
		self.SetInfoText("Automatically wins the war for your side")
	elseif a_option == optionsBAChance
		self.SetInfoText("Set the chance that a random guard or inconsequential NPC will become a spy for the other side. Set to 0 to disable.")
	elseif a_option == optionsDisguiseGameType
		self.SetInfoText("Changes the CWO Disguise mechanic. Default = Guards of contested holds will attack unless player dons a cuirass of the player's opposing faction. Realistic = Guards in contested holds will attack player only if player dons a cuirass of the player's faction.")
	elseif a_option == optionsSIChance
		self.SetInfoText("Sets the Spanish Inquisition chance. CWO will periodically poll and may start a defense quest if you are in a city your side controls.")
	elseif a_option == optionsStartSiege
		self.SetInfoText("Starts a campagin at a hold of your choice. Use this if you are not getting a quest from the general. Please close MCM after selecting.")
	elseif a_option == optionsWinSiege
		self.SetInfoText("Wins a fort or major/minor capital siege already in progress. Use this if the siege did not finish for some reason. Please do not use this at the battle of Solitude or Windhelm. Please close MCM after selecting.")
	elseif a_option == optionsWinHold
		self.SetInfoText("EXPERIMENTAL: Wins a hold of your choice. Use this if the commander is not giving you the quest for the next hold. The dialogue conditions are pretty strict and sometimes (mod conflict maybe?) you are not gaining the hold in the proper order. Check the holds on the debug page to see the orders of hold conquests. Imperials go down; Stormcloaks go up. Please close MCM after selecting.")
	elseif a_option == optionsCWOHelp
		self.SetInfoText("TODO")
	elseif a_option == optionsCWOUninstall
		self.SetInfoText("TODO")
	endIf
endFunction

function UninstallCWO()
	CWOQuestMonitor.Stop()
	CWOBAController.Stop()
	CWOBAQuest.Stop()
	CWs.CWCampaignS.CompleteCWMissions()
	Utility.Wait(10)
	CWs.CWCampaignS.CompleteCWSieges()
	Utility.Wait(10)
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
		if CWs.GetOwner(CWs.ReachHoldLocation)
			CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.FalkreathHoldLocation, CWs.GetOwner(cws.FalkreathHoldLocation) != cws.playerAllegiance, CWs.GetOwner(cws.FalkreathHoldLocation) == cws.playerAllegiance)
			CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.ReachHoldLocation, false, true)
			Cws.CWMission04Done = 1
			CWs.CWMission03Done = 1
		endif
		if CWs.GetOwner(CWs.Hjaalmarchholdlocation)
			CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.FalkreathHoldLocation, CWs.GetOwner(cws.FalkreathHoldLocation) != cws.playerAllegiance, CWs.GetOwner(cws.FalkreathHoldLocation) == cws.playerAllegiance)
			CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.ReachHoldLocation, CWs.GetOwner(cws.ReachHoldLocation) != cws.playerAllegiance, CWs.GetOwner(cws.ReachHoldLocation) == cws.playerAllegiance)
			CWs.WinHoldOffScreenIfNotDoingCapitalBattles(cws.Hjaalmarchholdlocation, false, true)
			CWs.CWMission04Done = 1
			Cws.CWMission07Done = 1
			CWs.CWMission03Done = 1
		endif
	endif	
endfunction

; Skipped compiler generated GetState
