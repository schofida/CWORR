Scriptname CWPlayerScript extends ReferenceAlias  
{Script attached to Player Alias in certain CW missions}

LocationAlias Property ShutDownQuestWhenPlayerLeavesThisLocationAlias Auto
{If this is set, call stop if the player leaves this location after the StageAfterWhichShutDownQuestWhenPlayerLeaves}

Int Property StageAfterWhichShutDownQuestWhenPlayerLeaves Auto
{After this or later quest stage, shut down quest after player leaves ShutDownQuestWhenPlayerLeavesThisLocationAlias}

LocationAlias Property SetStageWhenPlayerLeavesThisOtherLocationAliasAlso Auto
{If this is set, set stage to StageToSetWhenPlayerLeaves if the player leaves this location}

LocationAlias Property SetStageWhenPlayerLeavesThisLocationAlias Auto
{If this is set, set stage to StageToSetWhenPlayerLeaves if the player leaves this location}

LocationAlias Property SetStageWhenPlayerArrivesAtThisOtherLocationAliasAlso Auto
{If this is set, set stage to StageToSetWhenPlayerArrives if the player arrives at this location}

LocationAlias Property SetStageWhenPlayerArrivesAtThisLocationAlias Auto
{If this is set, set stage to StageToSetWhenPlayerArrives if the player arrives at this location}

Int Property StageToSetWhenPlayerArrives Auto
{set this quest stage, when the player arrives at SetStageWhenPlayerArrivesAtThisLocationAlias}

Int Property StageToSetWhenPlayerLeaves Auto
{set this quest stage, when the player arrives at SetStageWhenPlayerLeavesThisLocationAlias}

Int Property StageAfterWhichSetStageWhenPlayerLeaves Auto
{After this or later quest stage, set quest stage to StageToSetWhenPlayerLeaves after player leaves SetStageWhenPlayerLeavesThisLocationAlias}

Int Property StageAfterWhichSetStageWhenPlayerArrives Auto
{After this or later quest stage, set quest stage to StageToSetWhenPlayerArrives after player arrives SetStageWhenPlayerArrivesAtThisLocationAlias or SetStageWhenPlayerArrivesAtThisOtherLocationAliasAlso}


Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	Quest OwningQuest = GetOwningQuest()
	Location LocToCheck
	Location LocToCheck2
	
	if OwningQuest.IsRunning() == False		;just in case it's hung up in the shut down phase
		Return
	EndIf
	
	if ShutDownQuestWhenPlayerLeavesThisLocationAlias && StageAfterWhichShutDownQuestWhenPlayerLeaves
	
		LocToCheck = ShutDownQuestWhenPlayerLeavesThisLocationAlias.GetLocation()

		if OwningQuest.GetStage() >= StageAfterWhichShutDownQuestWhenPlayerLeaves && Game.GetPlayer().IsInLocation(LocToCheck) == False
; 			CWScript.Log("CWPlayerScript", self + "OnLocationChange() calling Stop() on owning quest because player left the location (" + LocToCheck + ") after stage " + StageAfterWhichShutDownQuestWhenPlayerLeaves)

			OwningQuest.stop()
		
		EndIf
		
	EndIf

	if StageToSetWhenPlayerLeaves && SetStageWhenPlayerLeavesThisLocationAlias
	
		LocToCheck = SetStageWhenPlayerLeavesThisLocationAlias.GetLocation()
		;CWO Add additional location for when the player leaves (similiar to enters)
		LocToCheck2 = SetStageWhenPlayerLeavesThisOtherLocationAliasAlso.GetLocation()
	
		if OwningQuest.GetStageDone(StageToSetWhenPlayerLeaves) == False 
			;CWO - Add Stage condition
			if OwningQuest.GetStage() >= StageAfterWhichSetStageWhenPlayerLeaves && (!LocToCheck || Game.GetPlayer().IsInLocation(LocToCheck) == false) && (!LocToCheck2 || Game.GetPlayer().IsInLocation(LocToCheck2) == false)
; 				CWScript.Log("CWPlayerScript", self + "OnLocationChange() calling setStage(" + StageToSetWhenPlayerLeaves +  ") on owning quest because player left location " + LocToCheck)

				OwningQuest.setStage(StageToSetWhenPlayerLeaves)
			
			endif
		
		EndIf
	
	EndIf
	
	if StageToSetWhenPlayerArrives && ( SetStageWhenPlayerArrivesAtThisLocationAlias || SetStageWhenPlayerArrivesAtThisOtherLocationAliasAlso)
	
		LocToCheck = SetStageWhenPlayerArrivesAtThisLocationAlias.GetLocation()
		LocToCheck2 = SetStageWhenPlayerArrivesAtThisOtherLocationAliasAlso.GetLocation()
	
		if OwningQuest.GetStageDone(StageToSetWhenPlayerArrives) == False 
			;CWO - Add Stage condition
			if OwningQuest.GetStage() >= StageAfterWhichSetStageWhenPlayerArrives && ((LocToCheck && Game.GetPlayer().IsInLocation(LocToCheck)) || (LocToCheck2 && Game.GetPlayer().IsInLocation(LocToCheck2)))
; 				CWScript.Log("CWPlayerScript", self + "OnLocationChange() calling setStage(" + StageToSetWhenPlayerArrives +  ") on owning quest because player arrived at either location " + LocToCheck + " or the other optional location" + LocToCheck2)

				OwningQuest.setStage(StageToSetWhenPlayerArrives)
			
			endif
		
		EndIf
	
	
	EndIf
	

EndEvent



