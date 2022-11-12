scriptName CWOBAScript2 extends ReferenceAlias

faction property CWSoldierNoGuardDialogueFaction auto
faction property GuardFaction auto
ReferenceAlias property SpyTarget auto
;-- Variables ---------------------------------------

;-- Functions ---------------------------------------
Faction CrimeFaction	; Reddit BugFix #9
Faction[] OldFactions
Faction NewFaction
Faction NewNPCFaction

Bool HasRemovedFactions = false
Bool HasSwappedCWFactions = false


; Skipped compiler generated GotoState

; Skipped compiler generated GetState
; Reddit BugFix #9

function RevertFactions()
	actor Myself = self.GetActorReference()
	if Myself == none
		return
	endif

	if HasSwappedCWFactions
		HasSwappedCWFactions = false
		Myself.RemoveFromFaction(NewFaction)
		Myself.RemoveFromFaction(NewNPCFaction)		
	endif

	if HasRemovedFactions
		HasRemovedFactions = false

		int i = OldFactions.Length
		While i
			i -= 1
			Myself.AddToFaction(OldFactions[i])
		EndWhile
		Myself.SetCrimeFaction(CrimeFaction)
	endif

	Myself.EvaluatePackage()
endfunction

function UndoNPCFaction()
	actor Myself = self.GetActorReference()
	if Myself == none
		return
	endif

	if HasSwappedCWFactions
		HasSwappedCWFactions = false
		Myself.RemoveFromFaction(NewFaction)
		Myself.RemoveFromFaction(NewNPCFaction)		
	endif
endfunction


function SwapFactions()
	Actor Myself = self.GetActorReference()
	if Myself == none
		return
	endif

	CWscript CWs = (GetOwningQuest() as CWOBAQuestScript).CWs

	if !HasSwappedCWFactions
		HasSwappedCWFactions = true

		Myself.AddToFaction(NewFaction)
		Myself.AddToFaction(NewNPCFaction)

		Myself.EvaluatePackage()
		Myself.StartCombat(SpyTarget.GetActorRef())
	endif
endfunction

event OnUpdate()
	Actor Myself = self.GetActorReference()
	if Myself.GetDistance(SpyTarget.GetActorReference()) <= 300 && Myself.HasLOS(SpyTarget.GetActorReference())
		(GetOwningQuest() as CWOBAQuestScript).TargetFound = true
		GetOwningQuest().SetStage(30)
		return
	endif
	RegisterForSingleUpdate(3.0)
endevent

event OnInit()
	Actor Myself = self.GetActorReference()
	if Myself == none
		return
	endif

	if !HasRemovedFactions
		HasRemovedFactions = true
		CWscript CWs = (GetOwningQuest() as CWOBAQuestScript).CWs

		int myAllegiance = CWs.GetActorAllgeiance(myself)
		NEwFaction = CWs.getFaction(CWs.getOppositeFactionInt(myAllegiance))
		NewNPCFaction = CWs.getFaction(CWs.getOppositeFactionInt(myAllegiance), true)

		OldFactions = Myself.GetFactions(-128, 127)
		CrimeFaction = Myself.GetCrimeFaction()
		Myself.RemoveFromAllFactions()
	endif

	Myself.EvaluatePackage()

	RegisterForSingleUpdate(3.0)

endEvent
