scriptName CWOBAScript2 extends ReferenceAlias

;-- Properties --------------------------------------
faction property FactionToAdd auto
faction property NPCFactionToAdd auto
faction property CWSoldierNoGuardDialogueFaction auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------
Faction[] ActorFactions	; Reddit BugFix #9
Bool IsSwapped = false

; Skipped compiler generated GotoState

; Skipped compiler generated GetState
; Reddit BugFix #9



event OnDeath(Actor akKiller)
	RevertFactions()
endEvent

function RemoveFromAllFactions(actor actorRef)
	Faction[] currentFactions = actorRef.GetFactions(-128, 127)
	int i = currentFactions.length
	While i
		i -= 1
		actorRef.RemoveFromFaction(currentFactions[i])
	endwhile
endfunction

function RevertFactions()
	actor Myself = self.GetActorReference()
	if Myself == none || IsSwapped == false
		return
	endif
	IsSwapped = false
	RemoveFromAllFactions(Myself)
	int i = ActorFactions.length
	While i
		i -= 1
		Myself.AddToFaction(ActorFactions[i])
	endwhile
	Myself.EvaluatePackage()
endfunction

event OnInit()

	Actor Myself = self.GetActorReference()
	if Myself == none
		return
	endif
	ActorFactions = Myself.GetFactions(-128, 127)	; Reddit BugFix #9
	RemoveFromAllFactions(Myself)
	Myself.AddToFaction(FactionToAdd)
	Myself.AddToFaction(NPCFactionToAdd)
	Myself.AddToFaction(CWSoldierNoGuardDialogueFaction)
	IsSwapped = true
	Myself.EquipItem(CWOBAArrow, false, true)
	Myself.EvaluatePackage()
endEvent

event OnPackageChange(Package akOldPackage)
	self.GetActorReference().EquipItem(Invisibility2, false, true)
endevent

Potion Property Invisibility2  Auto
Ammo Property CWOBAArrow Auto
