scriptName CWOBAControllerScript extends ReferenceAlias

;-- Properties --------------------------------------
quest property WaitForHelgen auto
quest property AwesomeQuest auto
globalvariable property CWOBAUpper auto
globalvariable property CWOBALower auto
globalvariable property UpdateTime auto
keyword property CWCapital auto
keyword property LocTypeMilitaryCamp auto
GlobalVariable Property CWOBAChance Auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GotoState

Event OnCellAttach()
    Actor player = GetActorRef()
	if !AwesomeQuest.IsRunning()
		return
	endif
    if player.IsInInterior()
        GetOwningQuest().Stop()
    elseif !player.getCurrentLocation().HasKeyword(CWCapital) && !player.getCurrentLocation().HasKeyword(LocTypeMilitaryCamp)
        GetOwningQuest().Stop()
    endif
endevent

function OnUpdate()
    Actor player = GetActorRef()
	if AwesomeQuest.IsRunning()
		AwesomeQuest.Stop()
		utility.wait(5 as Float)
	endIf
	if WaitForHelgen.IsCompleted() && \
		!player.IsInInterior() && \
		CWOBAChance.GetValueInt() > 0 && \
		(player.getCurrentLocation().HasKeyword(CWCapital) || \
			player.getCurrentLocation().HasKeyword(LocTypeMilitaryCamp)) && \
		SKSE.GetVersionRelease() > 0
		AwesomeQuest.Start()
	endif
	self.registerforsingleupdate(utility.randomfloat(CWOBALower.GetValue(), CWOBAUpper.GetValue()))
endFunction

function OnInit()

	self.registerforsingleupdate(utility.randomfloat(CWOBALower.GetValue(), CWOBAUpper.GetValue()))
endFunction

; Skipped compiler generated GetState
