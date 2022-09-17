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

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	if !CWs.CWCampaignS.isCWMissionsOrSiegesRunning()
		GetOwningQuest().Stop()
	endIf
EndEvent

Event OnEnterBleedout()
	if WerewolfQuest.IsRunning()
		(WerewolfQuest as playerwerewolfchangescript).ShiftBack()
	endIf
	pStrikeandFall.Apply(1.00000)
	game.DisablePlayerControls(true, true, true, true, true, true, true, false, 0)
	PlayerRef.DamageAv("Health", 99999 as Float)
	PlayerRef.SetUnconscious(true)


	utility.wait(10 as Float)
	game.enablefasttravel(true)
	utility.wait(2 as Float)
	PlayerRef.moveto(WhereweGoinTo, 0.000000, 0.000000, 0.000000, true)
	utility.wait(2 as Float)
	if (GetOwningQuest() as CWOStillABetterEndingMonitorScript).triggerQuest == cws.CWSiegeS && CWS.CWSiegeS.IsRunning() && CWS.CWSiegeS.GetStage() < 50 && !CWS.CWCampaignS.PlayerAllegianceLastStand() ;schofida - siege and capital are both running in final siege. Have capital take care of it
		if CWPercentPoolRemainingAttacker.GetValueInt() > CWPercentPoolRemainingDefender.GetValueInt()
			CWS.CWSiegeS.Setstage(50)
			CWAttackCity.Setstage(50)
		else
			CWS.CWSiegeS.Setstage(200)
		endIf
	elseIf (GetOwningQuest() as CWOStillABetterEndingMonitorScript).triggerQuest == cws.CWFortSiegeCapital && CWS.CWFortSiegeCapital.IsRunning() && CWS.CWFortSiegeCapital.GetStage() < 950
		if CWPercentPoolRemainingAttacker.GetValueInt() > CWPercentPoolRemainingDefender.GetValueInt()
			CWS.CWFortSiegeCapital.Setstage(1000)
		else
			CWS.CWFortSiegeCapital.Setstage(2000)
		endIf
	elseIf (GetOwningQuest() as CWOStillABetterEndingMonitorScript).triggerQuest == cws.CWFortSiegeFort && CWS.CWFortSiegeFort.IsRunning() && CWS.CWFortSiegeFort.GetStage() < 950
		if CWPercentPoolRemainingAttacker.GetValueInt() > CWPercentPoolRemainingDefender.GetValueInt()
			CWS.CWFortSiegeFort.Setstage(1000)
		else
			CWS.CWFortSiegeFort.Setstage(2000)
		endIf
	endIf
	utility.wait(3 as Float)
	game.EnablePlayercontrols(true, true, true, true, true, true, true, true, 0)
	game.DisablePlayerControls(true, true, false, false, false, true, true, false, 0)
	PlayerRef.SetUnconscious(false)
	PlayerRef.RestoreAv("Health", 9999 as Float)
	PlayerRef.PlayIdle(pIdleReset)
	utility.wait(5 as Float)
	game.EnablePlayercontrols(true, true, true, true, true, true, true, true, 0)
	utility.wait(1.50000)
	game.EnablePlayercontrols(true, true, true, true, true, true, true, true, 0)
	self.GetOwningQuest().Stop()
endEvent

function OnInit()
	if !CWs.CWCampaignS.isCWMissionsOrSiegesRunning() || !FigureItOut()
		GetOwningQuest().Stop()
		return
	endIf
endFunction

bool function FigureItOut()
	if CWS.PlayerAllegiance == CWS.iImperials
		if PlayerRef.IsInLocation(CWS.EastmarchHoldLocation)
			WhereweGoinTo = CWs.MilitaryCampWinterholdImperialMapMarker
		elseIf PlayerRef.IsInLocation(CWS.HaafingarHoldLocation)
			WhereweGoinTo = CWs.MilitaryCampHjaalmarchImperialMapMarker ; schofida Edit
		elseIf PlayerRef.IsInLocation(CWS.HjaalmarchHoldLocation)
			WhereweGoinTo = CWS.MilitaryCampReachImperialMapMarker		; schofida Edit
		elseIf PlayerRef.IsInLocation(CWS.WhiterunHoldLocation)
			WhereweGoinTo = CWS.MilitaryCampPaleImperialMapMarker		; schofida Edit
		elseIf PlayerRef.IsInLocation(CWS.ReachHoldLocation)
			WhereweGoinTo = CWS.MilitaryCampFalkreathImperialMapMarker		; schofida Edit
		elseIf PlayerRef.IsInLocation(CWS.RiftHoldLocation)
			WhereweGoinTo = CWS.MilitaryCampWinterholdImperialMapMarker		; schofida Edit
		elseIf PlayerRef.IsInLocation(CWS.FalkreathHoldLocation)
			WhereweGoinTo = CWS.MilitaryCampWhiterunImperialMapMarker		; schofida Edit
		elseIf PlayerRef.IsInLocation(CWS.PaleHoldLocation)
			WhereweGoinTo = CWS.MilitaryCampRiftImperialMapMarker		; schofida Edit
		elseIf PlayerRef.IsInLocation(CWS.WinterholdHoldLocation)
			WhereweGoinTo = CWS.MilitaryCampEastmarchImperialMapMarker		; schofida Edit
		else
			return false
		endIf
	elseIf CWS.PlayerAllegiance == CWS.iSons
		if PlayerRef.IsInLocation(CWS.EastmarchHoldLocation)
			WhereweGoinTo = CWs.MilitaryCampWinterholdSonsMapMarker ; schofida - final scene no longer occurs for losing battle
		elseIf PlayerRef.IsInLocation(CWS.HaafingarHoldLocation)
			WhereweGoinTo = CWs.MilitaryCampHjaalmarchSonsMapMarker
		elseIf PlayerRef.IsInLocation(CWS.WinterholdHoldLocation)
			WhereweGoinTo = CWS.MilitaryCampRiftSonsMapMarker		; schofida Edit
		elseIf PlayerRef.IsInLocation(CWS.WhiterunHoldLocation)
			WhereweGoinTo = CWS.MilitaryCampFalkreathSonsMapMarker		; schofida Edit
		elseIf PlayerRef.IsInLocation(CWS.PaleHoldLocation)
			WhereweGoinTo = CWS.MilitaryCampWhiterunSonsMapMarker		; schofida Edit
		elseIf PlayerRef.IsInLocation(CWS.FalkreathHoldLocation)
			WhereweGoinTo = CWS.MilitaryCampReachSonsMapMarker		; schofida Edit
		elseIf PlayerRef.IsInLocation(CWS.RiftHoldLocation)
			WhereweGoinTo = CWS.MilitaryCampPaleSonsMapMarker		; schofida Edit
		elseIf PlayerRef.IsInLocation(CWS.ReachHoldLocation)
			WhereweGoinTo = CWS.MilitaryCampHjaalmarchSonsMapMarker		; Reddit BugFix #12
		elseIf PlayerRef.IsInLocation(CWS.HjaalmarchHoldLocation)
			WhereweGoinTo = CWS.MilitaryCampHaafingarSonsMapMarker		; Reddit BugFix #12
		else
			return false
		endIf
	else
		return false
	endIf
	return true
endFunction
