scriptName CWODefendLetterSiege extends ReferenceAlias

;-- Properties --------------------------------------
quest property CWFortSiegeCapital auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GotoState

; Skipped compiler generated GetState

function OnRead()
	GetOwningQuest().SetObjectiveCompleted(10, true)
	self.getOwningQuest().setstage(10)
endFunction
