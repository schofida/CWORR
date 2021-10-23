Scriptname CWFinalePlayerScript extends ReferenceAlias  

;Added by USKP 1.3.2 to bring dangling Civil War quests to a close as well.
Quest Property CW Auto
Quest Property CWObj Auto

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	if GetOwningQuest().GetStageDone(400)
; 		CWScript.Log("CWFinalePlayerScript", "OnLocationChange() Stage 400 done, stopping quest")
		GetOwningQuest().stop()
		CWObj.Stop()
		CW.Stop()
	Else
; 		CWScript.Log("CWFinalePlayerScript", "OnLocationChange() Stage 400 NOT done, NOT stopping quest")
	EndIf

EndEvent
