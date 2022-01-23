scriptName QF_CWMission05_0201CCC0 extends Quest hidden

;-- Properties --------------------------------------
referencealias property Alias_Player auto
referencealias property Alias_EnemyFieldCOSons auto
referencealias property Alias_EnemyFieldCOImperial auto
referencealias property Alias_EnemyFieldCO auto
locationalias property Alias_EnemyCampImperial auto
referencealias property Alias_FieldCO auto
locationalias property Alias_EnemyCampSons auto
locationalias property Alias_Hold auto
locationalias property Alias_EnemyCamp auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GetState

function Fragment_10()

	Quest __temp = self as Quest
	cwmission05script kmyQuest = __temp as cwmission05script
	kmyQuest.FailAllObjectives()
	kmyQuest.FlagFieldCOWithMissionResultFaction(5, true)
	kmyQuest.CWCampaignS.AdvanceCampaignPhase()
	self.stop()
endFunction

function Fragment_0()

	Quest __temp = self as Quest
	cwmission05script kmyQuest = __temp as cwmission05script
	kmyQuest.CompleteAllObjectives()
	kmyQuest.FlagFieldCOWithMissionResultFaction(5, false)
	kmyQuest.CWs.CWCampaignS.registerMissionSuccess(Alias_Hold.GetLocation(), false)
	kmyQuest.CWCampaignS.AdvanceCampaignPhase()
	self.stop()

endFunction

function Fragment_6()

	Quest __temp = self as Quest
	cwmission05script kmyQuest = __temp as cwmission05script
	kmyQuest.CWMission05COFlees.Start()
endFunction

function Fragment_5()
	Quest __temp = self as Quest
	cwmission05script kmyQuest = __temp as cwmission05script
endfunction

function Fragment_4()

	Quest __temp = self as Quest
	cwmission05script kmyQuest = __temp as cwmission05script
	kmyQuest.objectiveCompleted = 1
	kmyQuest.SetObjectiveCompleted(10, true)
	kmyQuest.SetObjectiveDisplayed(100, true)
endFunction

; Skipped compiler generated GotoState

function Fragment_8()

	Quest __temp = self as Quest
	cwmission05script kmyQuest = __temp as cwmission05script

	kmyQuest.FlagFieldCOWithPotentialMissionFactions(5, true)
	self.SetObjectiveDisplayed(10, 1 as Bool, false)
	;Reddit Bugfix #5
	Location currentHold = kmyQuest.CWs.GetMyCurrentHoldLocation(Alias_EnemyFieldCO.GetActorReference())
	int aliasAllegiance = kmyQuest.CWs.GetActorAllgeiance(Alias_EnemyFieldCO.GetActorReference())
	Actor FieldCOHQ = kmyQuest.CWs.GetAliasHQFieldCOForHold(currentHold, aliasAllegiance).GetActorReference()
	Actor FieldCOCamp = kmyQuest.CWs.GetAliasCampFieldCOForHold(currentHold, aliasAllegiance).GetActorReference()

	int hold = kmyQuest.CWs.CWContestedHold.GetValueInt()

	if kmyQuest.CWs.PlayerAllegiance == kmyQuest.CWs.iImperials
		if hold == 9
			kmyQuest.CWGarrisonEnableMarkerSonsCampRift.Enable(false)
		elseif hold == 7
			kmyQuest.CWGarrisonEnableMarkerSonsCampWinterhold.Enable(false)
		elseif hold == 6
			kmyQuest.CWGarrisonEnableMarkerSonsCampPale.Enable(false)
		elseif hold == 5
			kmyQuest.CWGarrisonEnableMarkerSonsCampFalkreath.Enable(false)
		elseif hold == 4
			kmyQuest.CWGarrisonEnableMarkerSonsCampWhiterun.Enable(false)
		elseif hold == 3
			kmyQuest.CWGarrisonEnableMarkerSonsCampHjaalmarch.Enable(false)
		elseif hold == 2
			kmyQuest.CWGarrisonEnableMarkerSonsCampReach.Enable(false)
		Endif
	Elseif  kmyQuest.CWs.PlayerAllegiance == kmyQuest.CWs.iSons
		if hold == 9
			kmyQuest.CWGarrisonEnableMarkerImperialCampRift.Enable(false)
		elseif hold == 7
			kmyQuest.CWGarrisonEnableMarkerImperialCampWinterhold.Enable(false)
		elseif hold == 6
			kmyQuest.CWGarrisonEnableMarkerImperialCampPale.Enable(false)
		elseif hold == 5
			kmyQuest.CWGarrisonEnableMarkerImperialCampFalkreath.Enable(false)
		elseif hold == 4
			kmyQuest.CWGarrisonEnableMarkerImperialCampWhiterun.Enable(false)
		elseif hold == 3
			kmyQuest.CWGarrisonEnableMarkerImperialCampHjaalmarch.Enable(false)
		elseif hold == 2
			kmyQuest.CWGarrisonEnableMarkerImperialCampReach.Enable(false)
		Endif
	endif

	FieldCOHQ.Enable(false)
	FieldCOCamp.Enable(false)

	Alias_EnemyFieldCO.GetActorReference().GetActorBase().SetEssential(false)
endFunction

function Fragment_1()
	Quest __temp = self as Quest
	cwmission05script kmyQuest = __temp as cwmission05script

	kmyQuest.ResetCommonMissionProperties()
	kmyQuest.FlagFieldCOWithPotentialMissionFactions(5, false)
endfunction

function fragment_2()
	Quest __temp = self as Quest
	cwmission05script kmyQuest = __temp as cwmission05script

	Location currentHold = kmyQuest.CWs.GetMyCurrentHoldLocation(Alias_EnemyFieldCO.GetActorReference())
	int aliasAllegiance = kmyQuest.CWs.GetActorAllgeiance(Alias_EnemyFieldCO.GetActorReference())
	Actor FieldCOHQ = kmyQuest.CWs.GetAliasHQFieldCOForHold(currentHold, aliasAllegiance).GetActorReference()
	Actor FieldCOCamp = kmyQuest.CWs.GetAliasCampFieldCOForHold(currentHold, aliasAllegiance).GetActorReference()
	FieldCOHQ.Disable(false)
	FieldCOCamp.Disable(false)

	kmyquest.ProcessFieldCOFactionsOnQuestShutDown()

endfunction
