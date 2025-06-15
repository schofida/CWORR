Scriptname CWFinaleDoorScript extends ReferenceAlias  
{Script attached to Door aliases in CWFinale quest}

Event OnActivate(ObjectReference akActionRef)

	CWScript CWs = (GetOwningQuest() as CWFinaleScript).CWs
	ObjectReference PlayerRef = Game.GetPlayer()

	if GetOwningQuest().GetStageDone(100) == False
	

		float waitTime = 0.5
		float waitingFor
		
		if akActionRef == PlayerRef
; 			CWScript.Log("CWFinaleDoorScript", self + "Player activated door. Moving actors, setting up scene, and locking doors.")

			
			while PlayerRef.IsInInterior() == False
				utility.Wait(waitTime)
				waitingFor += waitTime
; 				CWScript.Log("CWFinaleDoorScript", self + "Waiting for player to be inside. Have been waiting for " + waitingFor)
			EndWhile
			
; 			CWScript.Log("CWFinaleDoorScript", self + "Player to be inside. Waited for " + waitingFor + " calling PlayerEnteredCastle()")
			(GetOwningQuest() as CWFinaleScript).PlayerEnteredCastle()
			
		EndIf
	elseif GetOwningQuest().GetStageDone(100) && CWs.CWCampaignS.PlayerAllegianceLastStand() && akActionRef == PlayerRef
		CWs.CWSiegeS.Stop()
		CWs.CWFortSiegeCapital.Stop()
	Else
	
; 		CWScript.Log("CWFinaleDoorScript", self + "Player activated door. But stage 100 is done, not doing anything.")
			
			
	EndIf
EndEvent

Event OnCellLoad()	

	if GetRef() == none
		return
	endif
	CWScript CWs = (GetOwningQuest() as CWFinaleScript).CWs
	;check to see if siege is running and running in the location where this ref is currently located
	location SiegeLoc = CWs.CWSiegeCity.GetLocation()


	
	
	if CWs.CWSiegeS.IsStopped() == False && (GetRef().IsInLocation(SiegeLoc) ) && CWs.CWCampaignS.PlayerAllegianceLastStand()
; 		CWScript.Log("CWLockDuringSiegeScript", self + "OnCellLoad() CWSiege is running and my location is the siege's location.")
	
		if CWs.CWSiegeS.GetStageDone(1)
; 			CWScript.Log("CWLockDuringSiegeScript", self + "OnCellLoad() Locking after setting lock level to LockLevelDuringSiege: " + LockLevelDuringSiege)
			GetRef().SetLockLevel(255)
			GetRef().Lock()
		Else
; 			CWScript.Log("CWLockDuringSiegeScript", self + "OnCellLoad() NOT locking because RequireSiegeQuestToBeAcceptedToLock and CWSiege stage 1 is NOT done: ")
			
		EndIf
	
	elseif CWs.CWSiegeS.IsStopped() ||  CWs.CWSiegeS.GetStageDone(255)	;siege isn't running, or is running somewhere other than my current location
; 		CWScript.Log("CWLockDuringSiegeScript", self + "OnCellLoad() Neither CWSiege nor CWFortSiegeCapital are running in my location, unlocking and setting lock level to LockLevelPostSiege: " + LockLevelPostSiege)
		
		GetRef().SetLockLevel(0)
		
			GetRef().Lock(False)

	endif

EndEvent


