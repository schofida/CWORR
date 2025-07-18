Scriptname CWLockDuringSiegeScript extends ObjectReference  
{For doors that normally don't have locks but should be locked during sieges (like Taverns and Inns)}

Quest property CW Auto
{Pointer to CWScript attached to CW quest}

int Property LockLevelDuringSiege = 75 Auto
{Default: 75}

int Property LockLevelPostSiege Auto
{Default: 0}

bool Property AlwaysUnlockIfNoSiege = true Auto
{Default: true}

bool Property RequireSiegeQuestToBeAcceptedToLock = true Auto
{Default: true; Requires the player to be actively on the siege quest, not just that it's running... defined by stage 1 having been done.}

bool property TreatCWSiegeStage255AsStopped = true auto
{Default: true; Treats CWSiege stage 255 the same as if the quest isn't running for purposes of unlocking doors}

CWScript Property CWs Auto hidden

Event OnCellLoad()	

	;check to see if siege is running and running in the location where this ref is currently located
	location SiegeLoc = CWs.CWSiegeCity.GetLocation()
	Location SiegeLocMinor = CWs.CWFortSiegeCapitalFort.GetLocation()
	
	
	if CWs.CWSiegeS.IsStopped() == False && (IsInLocation(SiegeLoc) ) && !CWs.CWCampaignS.PlayerAllegianceLastStand()
; 		CWScript.Log("CWLockDuringSiegeScript", self + "OnCellLoad() CWSiege is running and my location is the siege's location.")
	
		if RequireSiegeQuestToBeAcceptedToLock && CWs.CWSiegeS.GetStageDone(1)
; 			CWScript.Log("CWLockDuringSiegeScript", self + "OnCellLoad() Locking after setting lock level to LockLevelDuringSiege: " + LockLevelDuringSiege)
			SetLockLevel(LockLevelDuringSiege)
			Lock()
		Else
; 			CWScript.Log("CWLockDuringSiegeScript", self + "OnCellLoad() NOT locking because RequireSiegeQuestToBeAcceptedToLock and CWSiege stage 1 is NOT done: ")
			
		EndIf
		
		

		
	
	elseif CWs.CWFortSiegeCapital.IsStopped() == false && (IsInLocation(SiegeLocMinor) ) && !CWs.CWCampaignS.PlayerAllegianceLastStand()
; 		CWScript.Log("CWLockDuringSiegeScript", self + "OnCellLoad() CWFortSiegeCapital is running and my location is the siege's location.")
			
		if RequireSiegeQuestToBeAcceptedToLock && CWs.CWFortSiegeCapital.GetStageDone(10)
; 			CWScript.Log("CWLockDuringSiegeScript", self + "OnCellLoad() Locking after setting lock level to LockLevelDuringSiege: " + LockLevelDuringSiege)
			SetLockLevel(LockLevelDuringSiege)
			Lock()
		Else
; 			CWScript.Log("CWLockDuringSiegeScript", self + "OnCellLoad() NOT locking because RequireSiegeQuestToBeAcceptedToLock and CWSiege stage 1 is NOT done: ")
			
		EndIf
	
	elseif CWs.CWSiegeS.IsStopped()|| ( TreatCWSiegeStage255AsStopped && CWs.CWSiegeS.GetStageDone(255) )	;siege isn't running, or is running somewhere other than my current location
; 		CWScript.Log("CWLockDuringSiegeScript", self + "OnCellLoad() Neither CWSiege nor CWFortSiegeCapital are running in my location, unlocking and setting lock level to LockLevelPostSiege: " + LockLevelPostSiege)
		
		SetLockLevel(LockLevelPostSiege)
		
		if AlwaysUnlockIfNoSiege
			Lock(False)
		EndIf

	endif

EndEvent

Event OnInit()
	CWs = CW as CWScript
EndEvent