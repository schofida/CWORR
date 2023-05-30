scriptName CWOSABETME3Monitor extends ReferenceAlias

;-- Properties --------------------------------------
musictype property MUSSpecialDeath auto
imagespacemodifier property pDoubleVision auto
globalvariable property CWPercentPoolRemainingAttacker auto
faction property CWOtemporaryAllies auto
idle property pIdleReset auto
idle property pGetUp auto
cwscript property CWS auto
sound property pQSTTG05ArrowKnockOut2D auto
globalvariable property CWPercentPoolRemainingDefender auto
quest property CWFinale auto
spell property CWOSABETME3Ability auto
quest property CWAttackCity auto
cwfinalescript property CWf auto
ObjectReference property pTG05ArrowHitRef auto
quest property WerewolfQuest auto
musictype property MUSCombatCivilWar auto
actor property PlayerRef auto
ObjectReference property pTG05TransitionAudio auto
ObjectReference property TG05UnconsciousAudioRef auto
imagespacemodifier property pStrikeandFall auto
idle property pKnockdown auto
Quest property VampireQuest auto
ObjectReference property WindhelmMarker auto
ObjectReference property SolitudeMarker auto

;-- Variables ---------------------------------------
Bool WeBeImperials
Float WhenDoIFall = 0.0800000
ObjectReference WhereweGoinTo
Bool WeBeSons
Bool ThisIsFinale
Bool DisableIt
Location WhereAreWe
Bool DidWeFall = false
Float TotalHealth
Float HealthPercentage

;-- Functions ---------------------------------------

; Skipped compiler generated GetState

; Skipped compiler generated GotoState

Event OnEnterBleedout()
	CWScript.Log("CWOSABETME3Monitor", " OnEnterBleedout()") 
	((GetOwningQuest() as CWOStillABetterEndingMonitorScript).triggerQuest as CWReinforcementControllerScript).StopSpawning()
	ThisIsFinale = false
	if !FigureItOut()
		PlayerRef.KillEssential()
		GetOwningQuest().Stop()
		return
	endif
	if WerewolfQuest.IsRunning()
		(WerewolfQuest as playerwerewolfchangescript).ShiftBack()
	elseif VampireQuest.IsRunning()
		(VampireQuest as DLC1PlayerVampireChangeScript).ShiftBack()
	endIf
	pStrikeandFall.Apply(1.00000)
	game.DisablePlayerControls(true, true, true, true, true, true, true, false, 0)
	PlayerRef.DamageAv("Health", 99999 as Float)
	PlayerRef.SetUnconscious(true)
	utility.wait(10 as Float)
	game.enablefasttravel(true)
	utility.wait(2 as Float)
	PlayerRef.moveto(WhereweGoinTo, 0.000000, 0.000000, 0.000000, true)
	Utility.Wait(2.0)
	game.EnablePlayercontrols(true, true, true, true, true, true, true, true, 0)
	game.DisablePlayerControls(true, true, false, false, false, true, true, false, 0)
	PlayerRef.SetUnconscious(false)
	if !ThisIsFinale
		Recover()
	else
		while PlayerRef.IsInInterior() == False
			utility.Wait(0.5)
		EndWhile
		PlayerRef.moveto(WhereweGoinTo, 0.000000, 0.000000, 0.000000, true)
		CWF.PlayerEnteredCastle()
	endif
endEvent

function Recover()
	PlayerRef.RestoreAv("Health", 9999 as Float)
	PlayerRef.PlayIdle(pIdleReset)
	utility.wait(5 as Float)
	game.EnablePlayercontrols(true, true, true, true, true, true, true, true, 0)
	utility.wait(1.50000)
	game.EnablePlayercontrols(true, true, true, true, true, true, true, true, 0)
	self.GetOwningQuest().Stop()
EndFunction

bool function FigureItOut()
	CWScript.Log("CWOSABETME3Monitor", " FigureItOut()") 
	int[] holdIDs = new int[9]
	holdIDs[0] = 1
	holdIDs[1] = 3
	holdIDs[2] = 2
	holdIDs[3] = 5
	holdIDs[4] = 4
	holdIDs[5] = 6
	holdIDs[6] = 9
	holdIDs[7] = 7
	holdIDs[8] = 8
	int currentHold = CWs.GetHoldID(((GetOwningQuest() as CWOStillABetterEndingMonitorScript).triggerQuest as CWSiegeScript).Hold.GetLocation())
	if currentHold == -1
		return false
	endif
	int currentHoldIndex = holdIDs.Find(currentHold)
	int[] orderedHoldIDs = new int[7]
	int orderedIndex = 0
	if currentHoldIndex == 0
		orderedHoldIDs[0] = holdIDs[1]
		orderedIndex = orderedIndex + 1
		currentHoldIndex = 1
	elseif currentHoldIndex == 8
		orderedHoldIDs[0] = holdIDs[7]
		orderedIndex = orderedIndex + 1
		currentHoldIndex = 8
	endif
	if CWS.PlayerAllegiance == CWS.iImperials
		int[] imperialHoldIDs = new int[9]
		
		if currentHold == 1 && CWs.CWCampaignS.PlayerAllegianceLastStand() && CWFinale.IsRunning() && CWFinale.GetStageDone(10)
			WhereweGoinTo = SolitudeMarker
			ThisIsFinale = true
			return true
		endif
		int i = currentHoldIndex - 1
		if i < 1
			i = holdIDs.Length - 1
		endif
		while i != currentHoldIndex
			orderedHoldIDs[orderedIndex] = holdIDs[i]
			i = i - 1
			orderedIndex = orderedIndex + 1
			if i < 1
				i = holdIDs.Length - 1
			endif
		endwhile
	elseIf CWS.PlayerAllegiance == CWS.iSons

		if currentHold == 8 && CWs.CWCampaignS.PlayerAllegianceLastStand() && CWFinale.IsRunning() && CWFinale.GetStageDone(10)
			WhereweGoinTo = WindhelmMarker
			ThisIsFinale = true
			return true
		endif

		int i = currentHoldIndex + 1
		if i > holdIDs.Length - 1
			i = 1
		endif
		while i != currentHoldIndex
			orderedHoldIDs[orderedIndex] = holdIDs[i]
			i = i + 1
			orderedIndex = orderedIndex + 1
			if i > holdIDs.Length - 1
				i = 1
			endif
		endwhile
	else
		return false
	endIf
	orderedIndex = 0
	while orderedIndex < orderedHoldIDs.Length && WhereweGoinTo == none
		if orderedHoldIDs[orderedIndex]
			ObjectReference enableMarker = (GetOwningQuest() as CWOStillABetterEndingMonitorScript).GetCampEnableMarkerByHoldID(orderedHoldIDs[orderedIndex])
			if enableMarker != none && enableMarker.IsEnabled()
				WhereweGoinTo = (GetOwningQuest() as CWOStillABetterEndingMonitorScript).GetCampMapMarkerByHoldID(orderedHoldIDs[orderedIndex])
			endif
		endif
		orderedIndex = orderedIndex + 1
	endwhile
	if WhereweGoinTo != none
		return true
	else
		return false
	endif
endFunction
