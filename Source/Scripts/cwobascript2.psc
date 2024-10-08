scriptName CWOBAScript2 extends ReferenceAlias

faction property CWSoldierNoGuardDialogueFaction auto
faction property GuardFaction auto
ReferenceAlias property SpyTarget auto
Spell property CWOBAEvaluatePackageSpell auto
Bool property HasFiredEvaluatePackageSpell auto hidden
;-- Variables ---------------------------------------

;-- Functions ---------------------------------------
Faction CrimeFaction	; Reddit BugFix #9
Faction[] OldFactions
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

event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
	bool abBashAttack, bool abHitBlocked)
	if !HasFiredEvaluatePackageSpell && akAggressor == Game.GetPlayer()	;and the player has hit 
		CWOBAEvaluatePackageSpell.Cast(self.GetActorRef())
		HasFiredEvaluatePackageSpell = true
	endif
EndEvent

event OnInit()
	Actor Myself = self.GetActorReference()
	if Myself == none
		return
	endif

	if !HasRemovedFactions
		HasRemovedFactions = true
		CWscript CWs = (GetOwningQuest() as CWOBAQuestScript).CWs

		int myAllegiance = CWs.GetActorAllgeiance(myself)
		NewNPCFaction = CWs.getFaction(CWs.getOppositeFactionInt(myAllegiance), true)

		OldFactions = Myself.GetFactions(-128, 127)
		CrimeFaction = Myself.GetCrimeFaction()
		Myself.RemoveFromAllFactions()
	endif

	Myself.EvaluatePackage()

	HasFiredEvaluatePackageSpell = false

	RegisterForSingleUpdate(3.0)

endEvent
