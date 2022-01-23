scriptName CWODeleteOnQuestStage extends ReferenceAlias

;-- Properties --------------------------------------
Int property Whatstage auto
quest property WhatQuest auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function OnInit()

	self.registerforsingleupdate(5 as Float)
endFunction

; Skipped compiler generated GetState

; Skipped compiler generated GotoState

function OnUpdate()

	if WhatQuest.GetStage() > Whatstage
		self.getactorreference().Disable(false)
		self.getactorreference().Delete()
		self.GotoState("Dead")
	else
		self.registerforsingleupdate(5 as Float)
	endIf
endFunction

;-- State -------------------------------------------
state Dead
endState
