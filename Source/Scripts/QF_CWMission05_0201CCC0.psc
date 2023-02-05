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
	debug.traceConditional("CWMission05 stage 205", kmyquest.CWs.debugon.value)
	kmyQuest.FailAllObjectives()
	kmyQuest.FlagFieldCOWithMissionResultFaction(5, true)
	kmyQuest.CWCampaignS.AdvanceCampaignPhase()
endFunction

function Fragment_0()

	Quest __temp = self as Quest
	cwmission05script kmyQuest = __temp as cwmission05script
	debug.traceConditional("CWMission05 stage 200", kmyquest.CWs.debugon.value)
	kmyQuest.CompleteAllObjectives()
	kmyQuest.FlagFieldCOWithMissionResultFaction(5, false)
	kmyQuest.CWS.CWCampaignS.addAttackDeltaMissionBonus(1)
	kmyQuest.CWs.CWCampaignS.registerMissionSuccess(Alias_Hold.GetLocation(), false)
	kmyQuest.CWCampaignS.AdvanceCampaignPhase()

endFunction

function Fragment_6()

	Quest __temp = self as Quest
	cwmission05script kmyQuest = __temp as cwmission05script
	debug.traceConditional("CWMission05 stage 30", kmyquest.CWs.debugon.value)
endFunction

function Fragment_5()
	Quest __temp = self as Quest
	cwmission05script kmyQuest = __temp as cwmission05script
	debug.traceConditional("CWMission05 stage 20", kmyquest.CWs.debugon.value)
	Location currentHold = kmyQuest.CWs.GetMyCurrentHoldLocation(Alias_EnemyFieldCO.GetActorReference())
	int aliasAllegiance = kmyQuest.CWs.GetActorAllgeiance(Alias_EnemyFieldCO.GetActorReference())
	Actor FieldCOCamp = kmyQuest.CWs.GetAliasCampFieldCOForHold(currentHold, aliasAllegiance).GetActorReference()
	if FieldCOCamp == Alias_EnemyFieldCO.GetActorRef()
		kmyQuest.CWs.CWCampaignS.StopDisguiseQuest()
	endif
endfunction

function Fragment_4()

	Quest __temp = self as Quest
	cwmission05script kmyQuest = __temp as cwmission05script
	debug.traceConditional("CWMission05 stage 100", kmyquest.CWs.debugon.value)
	kmyQuest.objectiveCompleted = 1
	;Just in case
	Alias_EnemyFieldCO.TryToKill()
	
	SetStage(200)
endFunction

; Skipped compiler generated GotoState

function Fragment_8()

	Quest __temp = self as Quest
	cwmission05script kmyQuest = __temp as cwmission05script
	debug.traceConditional("CWMission05 stage 10", kmyquest.CWs.debugon.value)
	kmyQuest.FlagFieldCOWithPotentialMissionFactions(5, true)
	self.SetObjectiveDisplayed(10, 1 as Bool, false)
	;Reddit Bugfix #5
	Location currentHold = kmyQuest.CWs.GetMyCurrentHoldLocation(Alias_EnemyFieldCO.GetActorReference())
	int aliasAllegiance = kmyQuest.CWs.GetActorAllgeiance(Alias_EnemyFieldCO.GetActorReference())
	Actor FieldCOHQ = kmyQuest.CWs.GetAliasHQFieldCOForHold(currentHold, aliasAllegiance).GetActorReference()
	Actor FieldCOCamp = kmyQuest.CWs.GetAliasCampFieldCOForHold(currentHold, aliasAllegiance).GetActorReference()

	Alias_EnemyFieldCO.TryToEnable()

	Alias_EnemyFieldCO.GetActorReference().GetActorBase().SetEssential(false)

	if FieldCOCamp == Alias_EnemyFieldCO.GetActorRef()
		kmyQuest.CWs.CWCampaignS.EnableCamp()
	endif
endFunction

function Fragment_1()
	Quest __temp = self as Quest
	cwmission05script kmyQuest = __temp as cwmission05script
	debug.traceConditional("CWMission05 stage 0", kmyquest.CWs.debugon.value)
	kmyQuest.ResetCommonMissionProperties()
	kmyQuest.FlagFieldCOWithPotentialMissionFactions(5, false)
endfunction

function fragment_2()
	Quest __temp = self as Quest
	cwmission05script kmyQuest = __temp as cwmission05script
	debug.traceConditional("CWMission05 stage 255", kmyquest.CWs.debugon.value)
	kmyQuest.CWs.CWCampaignS.StartDisguiseQuest()
	Location currentHold = kmyQuest.CWs.GetMyCurrentHoldLocation(Alias_EnemyFieldCO.GetActorReference())
	int aliasAllegiance = kmyQuest.CWs.GetActorAllgeiance(Alias_EnemyFieldCO.GetActorReference())
	Actor FieldCOHQ = kmyQuest.CWs.GetAliasHQFieldCOForHold(currentHold, aliasAllegiance).GetActorReference()
	Actor FieldCOCamp = kmyQuest.CWs.GetAliasCampFieldCOForHold(currentHold, aliasAllegiance).GetActorReference()
	FieldCOHQ.Disable(false)
	FieldCOCamp.Disable(false)

	kmyquest.ProcessFieldCOFactionsOnQuestShutDown()

endfunction
