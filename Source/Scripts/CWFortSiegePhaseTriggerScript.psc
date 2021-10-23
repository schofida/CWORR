Scriptname CWFortSiegePhaseTriggerScript extends ReferenceAlias

;This script is on the TriggerPhaseXX aliases in CWFortSiegePhase. All they do is call a function on their parent script which holds more of the logic

bool Property RequireStage10 = false Auto
{Default false; Does stage 10 need to be set before the triggerboxes work? Needed for the final siege of Solitude, so it doesn't do anything if things are running but not active waiting for Dark Brotherhood blocker}

Event OnTriggerEnter(ObjectReference akActionRef)

	if akActionRef == Game.GetPlayer()

		if RequireStage10 && GetOwningQuest().GetStageDone(10) == False
; 			CWScript.Log("CWFortSiegeScript", self + "RequireStage10 is true, and stage 10 hasn't been set. NOT updating battle phase.")
			;do nothing
			
		Else
; 			CWScript.Log("CWFortSiegeScript", self + "OnTriggerEnter() Player entered, calling SetStageBasedOntrigger()")

			;USLEEP 3.0.8 Bug #14642: Added this check to prevent triggers from calling the quest script when the quest is about to stop (stage 500 is the
			;highest possible stage that can be set by any trigger, so there's no need for triggers anyway to call the quest script if currentStageID <= 500):
			if GetOwningQuest().GetCurrentStageID() <= 500
				(GetOwningQuest() as CWFortSiegeScript).SetStageBasedOnTrigger(GetReference())
			endif

		
		EndIf

	

	EndIf
EndEvent
