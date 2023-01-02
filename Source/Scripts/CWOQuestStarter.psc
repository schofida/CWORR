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
ObjectReference property CW5SpawnAttackerRiften1 Auto
ObjectReference property CW5SpawnAttackerRiften2 Auto
ObjectReference property CW5SpawnAttackerRiften3 Auto
ObjectReference property CW5SpawnAttackerRiften4 Auto
ReferenceAlias Property PlayerAlias Auto

Event OnInit()
    utility.Wait(15)

	;schofida - if insalling on existing save. Evaluate CW FieldCO Alias Packages CW since quest
	;already started. Hopefully, this will pull the CWO packages since CWO is overwriting the CW quest
	CWS.Rikke.GetActorReference().EvaluatePackage()
	CWS.Galmar.GetActorReference().EvaluatePackage()
	CWS.Alias_FieldCOImperialHjaalmarchHQ.ForceRefTo(CWS.Alias_FieldCOImperialHjaalmarchHQ.GetActorReference())
	CWS.CWRank1RewardImperial = CWORank1RewardImperial
	CWS.CWRank2RewardImperial = CWORank2RewardImperial
	CWS.CWRank3RewardImperial = CWORank3RewardImperial
	CWS.CWRank4RewardImperial = CWORank4RewardImperial
	CWS.CWRank1RewardSons = CWORank1RewardSons
	CWS.CWRank2RewardSons = CWORank2RewardSons
	CWS.CWRank3RewardSons = CWORank3RewardSons
	CwS.CWRank4RewardSons = CWORank4RewardSons
	;schofida - reset spawners that were given a bad 'Location Ref Type' in vanilla.
	;will hopefully fix Riften battle if Riften exterior was already loaded into Palyer's game
	CW5SpawnAttackerRiften1.Reset()
	CW5SpawnAttackerRiften2.Reset()
	CW5SpawnAttackerRiften3.Reset()
	CW5SpawnAttackerRiften4.Reset()

	CWS.CWContestedHold.SetValueInt(4)
	cws.ContestedHold = 4
	CWS.CWAttacker.SetValueInt(2)
	CWs.CWDefender.SetValueInt(1)
	CWS.CWCampaignS.CWDebugSkipPurchase.SetValueInt(1)
	;That's it for now...
    Debug.Notification("CWO version " + CWOVersion.GetValueInt() + " initialized :)")
endevent

