scriptName CWOPlayerEnters extends ReferenceAlias

;-- Variables ---------------------------------------
Objectreference CWOMarker
Bool IsInArea

;-- Functions ---------------------------------------

function OnLocationChange(Location akOldLoc, Location akNewLoc)

	LocationAlias CityAlias = (GetOwningQuest() as CWOSendForPlayerQuestScript).CityAlias
	ReferenceAlias FieldCO = (GetOwningQuest() as CWOSendForPlayerQuestScript).FieldCO
	CWScript CWs = (GetOwningQuest() as CWOSendForPlayerQuestScript).CWs

	if akNewLoc == CityAlias.getLocation() && (CWS.CWSiegeS.isRunning() || CWs.CWFortSiegeCapital.IsRunning()) && FieldCO.GetActorRef().IsDead()
		IsInArea = true
		self.RegisterForSingleUpdate(1.50000)
	else
		IsInArea = false
		self.UnRegisterForUpdate()
	endIf
endFunction

function OnUpdate()

	LocationAlias CityAlias = (GetOwningQuest() as CWOSendForPlayerQuestScript).CityAlias
	Actor PlayerRef = GetActorReference()

	if IsInArea == true
		if PlayerRef.isinlocation(CityAlias.getLocation()) && self.GetOwningQuest().GetStage() == 10
			GetOwningQuest().setstage(30)
			self.UnRegisterForUpdate()
		else
			self.RegisterForSingleUpdate(1.50000)
		endIf
	else
		self.UnRegisterForUpdate()
	endIf
endFunction

; Skipped compiler generated GetState

; Skipped compiler generated GotoState
