scriptName CWOBAScript2 extends ReferenceAlias

ReferenceAlias property SpyTarget auto
Spell property CWOBAEvaluatePackageSpell auto
Bool property HasFiredEvaluatePackageSpell auto hidden
;-- Variables ---------------------------------------

;-- Functions ---------------------------------------



; Skipped compiler generated GotoState

; Skipped compiler generated GetState
; Reddit BugFix #9

event OnLocationChange(Location akOldLoc, Location akNewLoc)
	self.TryToDisable()
	GetOwningQuest().Stop()
endEvent

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
	HasFiredEvaluatePackageSpell = false

endEvent
