Scriptname CWFinalePlayerScript extends ReferenceAlias  

;Bring dangling Civil War quests to a close as well.
Quest Property CW Auto ;USKP 1.3.2
Quest Property CWObj Auto ;USKP 1.3.2
Quest Property CWPostWhiterunObj Auto ;USSEP 4.2.1 Bug #27753

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	if GetOwningQuest().GetStageDone(400) || (GetOwningQuest().GetStageDone(340) && !Game.GetPlayer().IsInLocation((GetOwningQuest() as CWFinaleScript).AliasLocation.GetLocation()))
; 		CWScript.Log("CWFinalePlayerScript", "OnLocationChange() Stage 400 done, stopping quest")
		if !GetOwningQuest().GetStageDone(400)
			GetOwningQuest().SetStage(400)
		endif
		GetOwningQuest().stop()
		if !(GetOwningQuest() As CWFinaleScript).DefenseSuccessful
			if( CWPostWhiterunObj.GetStageDone(100) == 0 )
				CWPostWhiterunObj.SetObjectiveDisplayed(1, abDisplayed = false)
			endif
			CWPostWhiterunObj.Stop()
			CWObj.Stop()
			CW.Stop()
		endif
	Else
; 		CWScript.Log("CWFinalePlayerScript", "OnLocationChange() Stage 400 NOT done, NOT stopping quest")
	EndIf

EndEvent
