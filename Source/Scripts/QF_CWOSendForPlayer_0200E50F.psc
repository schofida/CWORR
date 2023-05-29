;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 15
Scriptname QF_CWOSendForPlayer_0200E50F Extends Quest Hidden

;BEGIN ALIAS PROPERTY CityOrFortOrGarrison
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_CityOrFortOrGarrison Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY NoteMinor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_NoteMinor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY NoteFinalImperial
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_NoteFinalImperial Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Letter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Letter Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY NoteSiege
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_NoteSiege Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY NoteFinalSons
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_NoteFinalSons Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FieldCO
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FieldCO Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN AUTOCAST TYPE CWOSendForPlayerQuestScript
Quest __temp = self as Quest
CWOSendForPlayerQuestScript kmyQuest = __temp as CWOSendForPlayerQuestScript
;END AUTOCAST
;BEGIN CODE
; Quest stage 10 (after reading city note, but player is not yet in Riften/Markarth/Whiterun)
	self.SetObjectiveCompleted(10, true)
	self.setobjectivedisplayed(0, true, false)
	Alias_FieldCO.getactorreference().addtofaction(kmyQuest.CWODefensiveFaction)
	kmyQuest.CWOCourierSentGlobal.SetValueInt(0)
	kmyQuest.UnregisterForUpdate()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN AUTOCAST TYPE CWOSendForPlayerQuestScript
Quest __temp = self as Quest
CWOSendForPlayerQuestScript kmyQuest = __temp as CWOSendForPlayerQuestScript
;END AUTOCAST
;BEGIN CODE
; Quest stage 40 (after reading minor hold note)
	kmyQuest.CWOCourierSentGlobal.SetValueInt(0)
	self.SetObjectiveCompleted(10, true)
	if kmyQuest.CWS.CWFortSiegeFort.IsRunning()
		kmyQuest.CWS.CWFortSiegeFort.SetStage(10)
	elseif kmyQuest.CWS.CWCampaignS.CWMission01.IsRunning()
		kmyQuest.CWS.CWCampaignS.CWMission01.SetStage(10)
	endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN AUTOCAST TYPE CWOSendForPlayerQuestScript
Quest __temp = self as Quest
CWOSendForPlayerQuestScript kmyQuest = __temp as CWOSendForPlayerQuestScript
;END AUTOCAST
;BEGIN CODE
; Quest stage 30 - Defense of Major capital (after reading note and player is in one of these cities or talked to FieldCO)
	kmyQuest.CWOCourierSentGlobal.SetValueInt(0)
	self.SetObjectiveCompleted(0, true)
	utility.wait(8 as Float)
	if kmyQuest.CWS.CWFortSiegeCapital.IsRunning()
		kmyQuest.CWS.CWFortSiegeCapital.SetStage(10)
	else
		kmyQuest.CWS.CWSiegeS.setstage(1)
	endif
	Alias_FieldCO.getactorreference().removefromfaction(kmyQuest.CWODefensiveFaction)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
; Quest stage 20
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN AUTOCAST TYPE CWOSendForPlayerQuestScript
Quest __temp = self as Quest
CWOSendForPlayerQuestScript kmyQuest = __temp as CWOSendForPlayerQuestScript
;END AUTOCAST
;BEGIN CODE
;CWO - This should happen during Spanish Inquisition
	if kmyQuest.CWs.CWAttacker.GetValueInt() ==kmyQuest.CWs.PlayerAllegiance
		return
	endif
	; Quest stage 0 - Start quest
	self.setobjectivedisplayed(10, 1 as Bool, false)
	kmyQuest.cws.setstage(4)
	kmyQuest.RegisterForSingleUpdateGameTime(utility.randomfloat(kmyQuest.CWOCourierHoursMin.GetValue(), kmyQuest.CWOCourierHoursMax.GetValue()))
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE CWOSendForPlayerQuestScript
Quest __temp = self as Quest
CWOSendForPlayerQuestScript kmyQuest = __temp as CWOSendForPlayerQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.UnregisterForUpdate()
	Alias_Letter.TryToEnable()
	kmyQuest.CourierS.AddAliasToContainer(Alias_Letter)
	kmyQuest.CWOCourierSentGlobal.SetValueInt(1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
