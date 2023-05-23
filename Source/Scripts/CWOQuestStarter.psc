scriptName CWOQuestStarter extends Quest

cwscript property CWS auto

GlobalVariable property CWOVersion auto

LeveledItem Property CWORank1RewardImperial Auto
LeveledItem Property CWORank2RewardImperial Auto
LeveledItem Property CWORank3RewardImperial Auto
LeveledItem Property CWORank4RewardImperial Auto
LeveledItem Property CWORank1RewardSons Auto
LeveledItem Property CWORank2RewardSons Auto
LeveledItem Property CWORank3RewardSons Auto
LeveledItem Property CWORank4RewardSons Auto
LeveledItem Property CWOFinaleFactionLeaderSwordListSons auto
LeveledItem Property CWOFinaleFactionLeaderSwordListImperial auto
ReferenceAlias Property PlayerAlias Auto
Actor Property CWFieldCOImperialHaafingar Auto
Actor Property CWFieldCOSonsEastmarch Auto
Actor Property CWFieldCOImperialHjaalmarchCapital Auto


Event OnInit()
    utility.Wait(15)

	;schofida - if insalling on existing save. Evaluate CW FieldCO Alias Packages CW since quest
	;already started. Hopefully, this will pull the CWO packages since CWO is overwriting the CW quest
	CWS.Rikke.GetActorReference().EvaluatePackage()
	CWS.Galmar.GetActorReference().EvaluatePackage()
	;CWO - this fix is set by USSEP but just in case USSEP is loaded mid-size, CW would already be started. So set manually
	CWS.Alias_FieldCOImperialHjaalmarchHQ.ForceRefTo(CWFieldCOImperialHjaalmarchCapital)
	;CWO - Set to new CWO rewards
	CWS.CWRank1RewardImperial = CWORank1RewardImperial
	CWS.CWRank2RewardImperial = CWORank2RewardImperial
	CWS.CWRank3RewardImperial = CWORank3RewardImperial
	CWS.CWRank4RewardImperial = CWORank4RewardImperial
	CWS.CWRank1RewardSons = CWORank1RewardSons
	CWS.CWRank2RewardSons = CWORank2RewardSons
	CWS.CWRank3RewardSons = CWORank3RewardSons
	CwS.CWRank4RewardSons = CWORank4RewardSons
	
	;CWO - No Tutorial Mission
	CWs.TutorialMissionComplete = 1
	;CWO - Allow non-adjacent holds when determining next Hold 
	;(fixes issue with Winterhold values not being set properly)
	CWs.debugAllowNonAdjacentHolds = 1

	if !CWs.WhiterunSiegeFinished
		;CWO - War has not started yet. Set initial variables. Stormcloaks attacking, 
		;imperials defending, Whiterun is first hold
		CWS.CWContestedHold.SetValueInt(4)
		cws.ContestedHold = 4
		CWS.CWAttacker.SetValueInt(2)
		CWs.CWDefender.SetValueInt(1)
	else
		;CWO - War started. Set player to attacker and put monitor into trying to start a new campaign.
		CWs.CWDebugForceAttacker.Value = cws.PlayerAllegiance
		CWs.CWCampaignS.SetMonitorWaitingToStartCampaign()
	endif
	;CWO - Purchasing in CWCampaign not happening
	CWS.CWCampaignS.CWDebugSkipPurchase.SetValueInt(1)
	;CWO - Promotions/Rewards happen very differently. Remove from all reward factions
	CWs.CWCampaignS.RemoveGeneralFromRewardFaction(CWs.UlfricRef)
	CWs.CWCampaignS.RemoveGeneralFromRewardFaction(CWs.GeneralTulliusRef)
	;That's it for now...
    Debug.Notification("CWO version " + CWOVersion.GetValueInt() + " initialized :)")
endevent

