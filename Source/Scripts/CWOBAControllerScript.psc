scriptName CWOBAControllerScript extends ReferenceAlias

;-- Properties --------------------------------------
quest property CWFinale auto
quest property WaitForHelgen auto
quest property AwesomeQuest auto
globalvariable property CWOBAUpper auto
globalvariable property CWOBALower auto
globalvariable property UpdateTime auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GotoState

function OnUpdate()

	if CWFinale.IsCompleted() || CWFinale.GetStageDone(100) ;schofida - Don't run quest on victory scene :(
		self.GetOwningQuest().Stop()
		return 
	endIf
	if AwesomeQuest.IsRunning()
		AwesomeQuest.Stop()
		utility.wait(5 as Float)
	endIf
	AwesomeQuest.Start()
	self.registerforsingleupdate(utility.randomfloat(CWOBALower.GetValue(), CWOBAUpper.GetValue()))
endFunction

function OnInit()

	while !WaitForHelgen.IsCompleted()
		utility.wait(60 as Float)
	endWhile
	self.registerforsingleupdate(utility.randomfloat(CWOBALower.GetValue(), CWOBAUpper.GetValue()))
endFunction

; Skipped compiler generated GetState
