Scriptname OCW03SiegeQuickStartScript extends Quest  

Quest Property CWSiegeQuickStart Auto

Keyword Property CWSiegeStart  Auto  

Function Do4110()
	; start battle of Whiterun as imperials attacking stormcloaks
	; CWSiegeQuickStart.setStage(4110)
	QuickStartSiege(4, 1, 1)
EndFunction

CWScript Property CWs Auto

Quest Property CWSiege Auto
; Quest Property CWFortSiegeCapital Auto

function QuickStartSiege(int Hold, int Attacker, int PlayerAllegiance)
	
	Location HoldLocation = CWs.getLocationForHold(Hold)
	ObjectReference FieldCO

;	CWs.debugOn.SetValue(CWDebugOn)
;	CWs.CWAlliesS.MakeHadvarAndRalofPotentialAllies()
;	CWs.setStage(PlayerAllegiance)

	if HoldLocation.GetKeywordData(CWs.CWOwner) == Attacker	
		int defender = CWs.GetOppositeFactionInt(Attacker)
		HoldLocation.SetKeywordData(CWs.CWOwner, defender)
		CWs.SetOwner(CWs.GetCapitalLocationForHold(HoldLocation), defender)
		CWs.SetOwner(CWs.GetCampLocationForHold(HoldLocation, attacker), attacker)	
		;CWO - Dialogue conditions depend on CWAttacker and CWDefender values. Set overrides here 
		CWs.CWAttacker.SetValueInt(attacker)	
		CWs.CWDefender.SetValueInt(defender)	
	EndIf	
	
	if Attacker == PlayerAllegiance
		FieldCO = CWs.GetReferenceCampFieldCOForHold(HoldLocation, PlayerAllegiance)
	Else
		FieldCO = CWs.GetReferenceHQFieldCOForHold(HoldLocation, PlayerAllegiance)
	EndIf

	Location Capital = CWs.GetCapitalLocationForHold(HoldLocation)

	if (!CWSiegeStart.SendStoryEventAndWait(Capital, FieldCO))
		; Debug.Trace("OCW03: error: CWSiegeStart.SendStoryEventAndWait returned False")
		return ; false
	endIf

	; That does not guarantee that the starting stage script fragment completed.
	int countdown = 60 
	while !CWSiege.IsRunning() && countdown > 0
		CWScript.Log("OCW03SiegeQuickStartScript",  "QuickStartSiege() Waiting for OCWSiegeDup.IsRunning() == true")	
		utility.Wait(0.5)
		countdown -= 1
	endWhile

	if !CWSiege.IsRunning()
		Debug.Trace("OCW03SiegeQuickStartScript: error: CWSiegeStart event did not start the CWSiege quest.")
		return ; false
	endIf

	; CWScript.Log("OCWSiegeQuickStartScript",  "QuickStartSiege() before OCWSiegeDUP.setStage(1)")

	; Wait to lessen a chance for a race condition glitch from interleaving stages 0 and 1 script fragments
	; TODO: ensure that no such glitch happens in CWSiege (as it does in vanilla CWFortSiegeCapital)
	Utility.Wait(1.5)

	bool is_defense = Attacker != PlayerAllegiance
	; SetFleeDistance(Hold, is_defense)

	; necessary corrections for the Whiterun imperials attack scenario
	QF_CWSiege_000954e1 qf = CWSiege AS QF_CWSiege_000954e1 
	qf.Alias_WhiterunAttackerGalmar.TryToDisable()
	qf.Alias_Attacker1General.ForceRefTo(qf.Alias_AttackerImperial1.GetReference())
	qf.Alias_Attacker1General.TryToEnable()

	CWSiegeScript cwss = CWSiege as CWSiegeScript	
	cwss.CWSiegeObjGeneral.ForceRefTo(qf.Alias_Attacker1General.GetReference())
	
	CWSiege.setStage(1)   ; show the quest objective
	CWs.CWSiegeObj.setActive()
	
EndFunction

