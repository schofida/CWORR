scriptName CWOLetterScript extends ReferenceAlias

;-- Properties --------------------------------------
quest property CWFortSiegeCapital auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GotoState

; Skipped compiler generated GetState

function OnRead()

	;CWFortSiegeCapital.SetStage(10)
	GetOwningQuest().SetObjectiveCompleted(10, true)
	self.getOwningQuest().SetStage(40)
endFunction
