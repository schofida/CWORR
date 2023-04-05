Scriptname CWFinaleDoorScript extends ReferenceAlias  
{Script attached to Door aliases in CWFinale quest}

Event OnActivate(ObjectReference akActionRef)

	CWScript CWs = (GetOwningQuest() as CWFinaleScript).CWs
	ObjectReference PlayerRef = Game.GetPlayer()
	if CWs.CWCampaignS.PlayerAllegianceLastStand()&& (akActionRef == PlayerRef)
		GetOwningQuest().Stop()
		CWs.CWSiegeS.Stop()
		CWs.CWFortSiegeCapital.Stop()
		CWs.CWCampaignS.SetMonitorMajorCitySiegeStopped()
		return
	endif

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
	Else
	
; 		CWScript.Log("CWFinaleDoorScript", self + "Player activated door. But stage 100 is done, not doing anything.")
			
			
	EndIf
EndEvent
