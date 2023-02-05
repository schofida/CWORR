Scriptname CWFinalePlayerScript extends ReferenceAlias  

;Bring dangling Civil War quests to a close as well.
Quest Property CW Auto ;USKP 1.3.2
Quest Property CWObj Auto ;USKP 1.3.2
Quest Property CWPostWhiterunObj Auto ;USSEP 4.2.1 Bug #27753

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	if GetOwningQuest().GetStageDone(400)
; 		CWScript.Log("CWFinalePlayerScript", "OnLocationChange() Stage 400 done, stopping quest")
		GetOwningQuest().stop()
		if( CWPostWhiterunObj.GetStageDone(100) == 0 )
			CWPostWhiterunObj.SetObjectiveDisplayed(1, abDisplayed = false)
		endif
		CWPostWhiterunObj.Stop()
		CWObj.Stop()
		(CW as CWScript).CWSiegeS.Stop()
		CW.Stop()
	Else
; 		CWScript.Log("CWFinalePlayerScript", "OnLocationChange() Stage 400 NOT done, NOT stopping quest")
	EndIf

EndEvent
