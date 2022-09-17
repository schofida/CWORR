scriptName QF_CWOSendForPlayer_0200E50F extends Quest hidden

;-- Properties --------------------------------------
Quest property CourierQuest auto
referencealias property Alias_NoteFinalImperial auto
Quest property CourierQuestScript auto
referencealias property Alias_FieldCO auto
Quest property NewProperty auto
referencealias property Alias_NoteMinor auto
faction property CWODefensiveFaction auto
locationalias property Alias_CapitalHQ auto
referencealias property Alias_NoteFinalSons auto
referencealias property Alias_RiftenMarker auto
referencealias property Alias_WhiterunMarker auto
referencealias property Alias_Player auto
cwscript property CWS auto
wicourierscript property CourierS auto
locationalias property Alias_CityOrFortOrGarrison auto
referencealias property Alias_Note auto
referencealias property Alias_MarkarthMarker auto
referencealias property Alias_CityCenterMarker auto
Quest property CWOSiegeObj auto
GlobalVariable property CWOCourierSentGlobal auto
GlobalVariable property CWOCourierHoursMin auto
GlobalVariable property CWOCourierHoursMax auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function Fragment_1()
	; Quest stage 10 (after reading city note, but player is not yet in Riften/Markarth/Whiterun)
	self.SetObjectiveCompleted(10, true)
	self.setobjectivedisplayed(0, 1 as Bool, false)
	Alias_FieldCO.getactorreference().addtofaction(CWODefensiveFaction)
	CWOCourierSentGlobal.SetValueInt(0)
endFunction

; Skipped compiler generated GotoState

; Skipped compiler generated GetState

function Fragment_11()
	; Quest stage 40 (after reading minor hold note)
	CWOCourierSentGlobal.SetValueInt(0)
	self.SetObjectiveCompleted(10, true)
	if CWS.CWFortSiegeCapital.IsRunning()
		CWS.WarIsActive = 1	;schofida - This is in case player loses Whiterun at the start, if they win capital battle, they will not get next directive from General
		CWS.PlayerInvolved = 1	;schofida - This is in case player loses Whiterun at the start, if they win capital battle, they will not get next directive from General	
		CWS.CWFortSiegeCapital.SetStage(10)
	elseif CWS.CWFortSiegeFort.IsRunning()
		CWS.CWFortSiegeFort.SetStage(10)
	elseif CWS.CWCampaignS.CWMission01.IsRunning()
		CWS.CWCampaignS.CWMission01.SetStage(10)
	endif		
endFunction

function Fragment_7()
	; Quest stage 20 (I guess this is a failsafe if the defense siege starts, called from capital/minor capital siege scripts)
	Actor PlayerRef = Alias_Player.GetActorRef()
	PlayerRef.RemoveItem(Alias_Note.GetReference().GetBaseObject())
	PlayerRef.RemoveItem(Alias_NoteMinor.GetReference().GetBaseObject())
	PlayerRef.RemoveItem(Alias_NoteFinalImperial.GetReference().GetBaseObject())
	PlayerRef.RemoveItem(Alias_NoteFinalSons.GetReference().GetBaseObject())
endFunction

function Fragment_0()
	Quest __temp = self as Quest
	CWOSendForPlayerQuestScript kmyQuest = __temp as CWOSendForPlayerQuestScript
	; Quest stage 0 - Start quest
	self.setobjectivedisplayed(10, 1 as Bool, false)
	kmyQuest.RegisterForSingleUpdateGameTime(utility.randomfloat(CWOCourierHoursMin.GetValue(), CWOCourierHoursMax.GetValue()))
endFunction

function Fragment_3()
	if !CWS.CWCampaignS.PlayerAllegianceLastStand()
		If CWS.CWSiegeS.isrunning()
			CourierS.AddAliasToContainer(Alias_Note)
		Else
			CourierS.AddAliasToContainer(Alias_NoteMinor)
		endIf
	elseIf CWS.PlayerAllegiance == CWS.iImperials
		;Alias_FieldCO.ForceRefTo(CWS.Galmar.getreference())
		;CourierS.AddAliasToContainer(Alias_NoteFinalSons)
		Alias_FieldCO.ForceRefTo(CWS.Rikke.getreference())
		CourierS.AddAliasToContainer(Alias_NoteFinalImperial)
	else
		;Alias_FieldCO.ForceRefTo(CWS.Rikke.getreference())
		;CourierS.AddAliasToContainer(Alias_NoteFinalImperial)
		Alias_FieldCO.ForceRefTo(CWS.Galmar.getreference())
		CourierS.AddAliasToContainer(Alias_NoteFinalSons)
	endIf
	CWOCourierSentGlobal.SetValueInt(1)
endfunction

function Fragment_10()
	; Quest stage 30 - Defense of Major capital (after reading note and player is in one of these cities or talked to FieldCO)
	CWOCourierSentGlobal.SetValueInt(0)

	CWS.WarIsActive = 1	;schofida - This is in case player loses Whiterun at the start, if they win capital battle, they will not get next directive from General
	CWS.PlayerInvolved = 1	;schofida - This is in case player loses Whiterun at the start, if they win capital battle, they will not get next directive from General
	utility.wait(8 as Float)
	CWS.CWSiegeS.setstage(1)
	self.SetObjectiveCompleted(0, true)
	Alias_FieldCO.getactorreference().removefromfaction(CWODefensiveFaction)
endFunction
