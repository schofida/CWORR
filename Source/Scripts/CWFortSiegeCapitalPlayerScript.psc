Scriptname CWFortSiegeCapitalPlayerScript extends ReferenceAlias  

CWScript property CW auto ;pointer to cwscript on CW quest
LocationAlias property Fort auto ;from quest
ReferenceAlias property Player auto ;from quest
Quest Property CWSiege Auto



Event OnLocationChange(Location akOldLoc, Location akNewLoc)

	Location FortLoc = Fort.GetLocation()
	;CWO Exterior Final Siege has been restored and is losable. Cleanup Interior city siege once the siege starts and the player is not in the location anymore.
	If (FortLoc == CW.WindhelmLocation) && (CWSiege.GetStageDone(50) || CWSiege.GetStageDone(200)) && (Player.GetReference().IsInLocation(CW.WindhelmLocation) == false)
; 		;CWScript.Log(“CWFortSiegeCapitalPlayerScript”, “Fort alias is Windhelm, player is no longer in Windhelm, calling stop on quest”)
		;debug.MessageBox("Stopping CWFortSiegeCapital Quest")

; 		CWScript.Log("CWFortSiegeCapitalPlayerScript", "OnLocationChange() calling stop() on owning quest")
		GetOwningQuest().Stop()

	Elseif (FortLoc == CW.SolitudeLocation) && (CWSiege.GetStageDone(50) || CWSiege.GetStageDone(200)) && (Player.GetReference().IsInLocation(CW.SolitudeLocation) == false)
; 		;CWScript.Log(“CWFortSiegeCapitalPlayerScript”, “Fort alias is Solitude, player is no longer in Solitude, calling stop on quest”)

; 		CWScript.Log("CWFortSiegeCapitalPlayerScript", "OnLocationChange() calling stop() on owning quest")
		GetOwningQuest().Stop()

	Endif

EndEvent