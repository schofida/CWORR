scriptName CWOBAQuestScript extends Quest Conditional

event OnInit()
    CWs = CW as CWScript
endevent

event OnUpdate()
    stop()
endevent

function SwapFactions(Actor Myself)
	if Myself == none
		return
    endif

	if !HasSwappedCWFactions
		HasSwappedCWFactions = true

		Myself.SetFactionRank(NewNPCFaction, 0)

		Myself.EvaluatePackage()
	endif
endfunction

function RevertFactions(Actor Myself)
	if Myself == none
		return
	endif

	if HasSwappedCWFactions
		HasSwappedCWFactions = false
		Myself.SetFactionRank(NewNPCFaction, -2)		
	endif

	if HasRemovedFactions
		HasRemovedFactions = false

		int i = OldFactions.Length
		While i
			i -= 1
			Myself.SetFactionRank(OldFactions[i], OldFactionRanks[i])
		EndWhile
		Myself.SetCrimeFaction(CrimeFaction)
	endif

	Myself.EvaluatePackage()
endfunction

function InitFactionSwitch(ReferenceAlias me, int allegiance)
    Actor myself = me.GetActorRef()
	if Myself == none
		return
	endif

	HasRemovedFactions = true

	NewNPCFaction = CWs.getFaction(allegiance, true)

	OldFactions = Myself.GetFactions(-128, 127)
	CrimeFaction = Myself.GetCrimeFaction()
	int i = OldFactions.Length
	OldFactionRanks = new int[128]
	While i
		i -= 1
		OldFactionRanks[i] = myself.getfactionrank(OldFactions[i])
		Myself.SetFactionRank(OldFactions[i],-2)
	EndWhile
	Myself.SetCrimeFaction(None)

	Myself.EvaluatePackage()

	(me as cwobascript2).RegisterForSingleUpdate(3.0)
endfunction

Faction CrimeFaction	; Reddit BugFix #9
Faction[] OldFactions
int[] OldFactionRanks
Faction NewNPCFaction

Bool HasRemovedFactions = false
Bool HasSwappedCWFactions = false

Quest Property CW  Auto  

CWScript Property CWS  Auto Hidden 

GlobalVariable Property QuestLength  Auto  

SPELL Property CWOBAInvisibility  Auto  

Bool Property TargetHit = false Auto hidden Conditional

Ammo Property CWOBASteelArrow Auto
Bool Property TargetFound = false  Auto hidden Conditional
