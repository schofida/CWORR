scriptName CWOPlayerEnters extends ReferenceAlias

;-- Properties --------------------------------------
ReferenceAlias property MarkarthMarker auto
ReferenceAlias property WhiterunMarker auto
locationalias property CityAlias auto
cwscript property CWS auto
ReferenceAlias property CityCenterMarkerAlias auto
locationalias property CapitalHQ auto
ReferenceAlias property RiftenMarker auto
actor property PlayerRef auto
ReferenceAlias Property FieldCO Auto

;-- Variables ---------------------------------------
Objectreference CWOMarker
Bool IsInArea
Location CWOMarkerLocation

;-- Functions ---------------------------------------

function OnLocationChange(Location akOldLoc, Location akNewLoc)

	if akNewLoc == CityAlias.getLocation() && CWS.CWSiegeS.isRunning() && FieldCO.GetActorRef().IsDead()
		IsInArea = true
		self.RegisterForSingleUpdate(1.50000)
	else
		IsInArea = false
		self.UnRegisterForUpdate()
	endIf
endFunction

function OnUpdate()

	if IsInArea == true
		if PlayerRef.isinlocation(CityAlias.getLocation()) && \
			self.GetOwningQuest().GetStage() == 10 && \
			(PlayerRef.getworldspace() == RiftenMarker.getreference().getworldspace() || \
				PlayerRef.getworldspace() == MarkarthMarker.getreference().getworldspace() || \
				PlayerRef.getworldspace() == WhiterunMarker.getreference().getworldspace())
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
