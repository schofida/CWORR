;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname QF_CWMission05_0201CCC0 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Hold
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Hold Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CampaignStartMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CampaignStartMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EnemyCamp
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_EnemyCamp Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MissionNumberRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MissionNumberRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EnemyFieldHQ
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_EnemyFieldHQ Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FieldCO
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FieldCO Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EnemyFieldCOCamp
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_EnemyFieldCOCamp Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EnemyFieldCO
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_EnemyFieldCO Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EnemyCampSonsEnable
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_EnemyCampSonsEnable Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EnemyCampImperialEnable
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_EnemyCampImperialEnable Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EnemyCampEnable
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_EnemyCampEnable Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EnemyFieldCOHQ
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_EnemyFieldCOHQ Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EnemyCampMapMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_EnemyCampMapMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EnemyFieldCOLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_EnemyFieldCOLocation Auto
;END ALIAS PROPERTY
	
;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE cwmission05script
Quest __temp = self as Quest
cwmission05script kmyQuest = __temp as cwmission05script
;END AUTOCAST
;BEGIN CODE
debug.traceConditional("CWMission05 stage 100", kmyquest.CWs.debugon.value)
	kmyQuest.objectiveCompleted = 1
	;Just in case
	kmyQuest.CWs.GetAliasHQFieldCOForHold(Alias_Hold.GetLocation(), kmyQuest.CWs.getOppositeFactionInt(kmyQuest.CWs.PlayerAllegiance)).TryToKill()
	kmyQuest.CWs.GetAliasCampFieldCOForHold(Alias_Hold.GetLocation(), kmyQuest.CWs.getOppositeFactionInt(kmyQuest.CWs.PlayerAllegiance)).TryToKill()
	
	SetStage(200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE cwmission05script
Quest __temp = self as Quest
cwmission05script kmyQuest = __temp as cwmission05script
;END AUTOCAST
;BEGIN CODE
debug.traceConditional("CWMission05 stage 20", kmyquest.CWs.debugon.value)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE cwmission05script
Quest __temp = self as Quest
cwmission05script kmyQuest = __temp as cwmission05script
;END AUTOCAST
;BEGIN CODE
debug.traceConditional("CWMission05 stage 255", kmyquest.CWs.debugon.value)
	kmyQuest.CWs.CWCampaignS.StartDisguiseQuest()


	kmyquest.ProcessFieldCOFactionsOnQuestShutDown()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN AUTOCAST TYPE cwmission05script
Quest __temp = self as Quest
cwmission05script kmyQuest = __temp as cwmission05script
;END AUTOCAST
;BEGIN CODE
debug.traceConditional("CWMission05 stage 205", kmyquest.CWs.debugon.value)
	kmyQuest.FailAllObjectives()
	kmyQuest.FlagFieldCOWithMissionResultFaction(5, true)

	Actor PlayerRef = Alias_Player.GetActorRef()

	while PlayerRef.IsInLocation(Alias_EnemyCamp.GetLocation()) || PlayerRef.IsInLocation(Alias_EnemyFieldHQ.GetLocation())
		utility.wait(5)
	endwhile
	Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE cwmission05script
Quest __temp = self as Quest
cwmission05script kmyQuest = __temp as cwmission05script
;END AUTOCAST
;BEGIN CODE
debug.traceConditional("CWMission05 stage 0", kmyquest.CWs.debugon.value)
	kmyQuest.ResetCommonMissionProperties()
	kmyQuest.FlagFieldCOWithPotentialMissionFactions(5)

	if Alias_EnemyFieldCOCamp.GetReference() != none
		Alias_EnemyFieldCOLocation.ForceLocationTo(Alias_EnemyCamp.GetLocation())
	else
		Alias_EnemyFieldCOLocation.ForceLocationTo(Alias_EnemyFieldHQ.GetLocation())
	endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE cwmission05script
Quest __temp = self as Quest
cwmission05script kmyQuest = __temp as cwmission05script
;END AUTOCAST
;BEGIN CODE
debug.traceConditional("CWMission05 stage 200", kmyquest.CWs.debugon.value)
	kmyQuest.CompleteAllObjectives()
	kmyQuest.FlagFieldCOWithMissionResultFaction(5, false)
	kmyQuest.CWs.CWCampaignS.registerMissionSuccess(Alias_Hold.GetLocation(), false)

	Actor PlayerRef = Alias_Player.GetActorRef()

	while PlayerRef.IsInLocation(Alias_EnemyCamp.GetLocation()) || PlayerRef.IsInLocation(Alias_EnemyFieldHQ.GetLocation())
		utility.wait(5)
	endwhile

	Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN AUTOCAST TYPE cwmission05script
Quest __temp = self as Quest
cwmission05script kmyQuest = __temp as cwmission05script
;END AUTOCAST
;BEGIN CODE
debug.traceConditional("CWMission05 stage 10", kmyquest.CWs.debugon.value)
	kmyQuest.FlagFieldCOWithActiveQuestFaction(5)
	self.SetObjectiveDisplayed(10, 1 as Bool, false)
	;Reddit Bugfix #5

	;schofida - Set quest as active on the map so player knows where to meet the troops
	kmyQuest.setActive()

	Alias_EnemyFieldCO.TryToEnable()
	if Alias_EnemyFieldCOCamp.GetReference() != none
		Alias_EnemyCampEnable.TryToEnable()
		Alias_EnemyCampMapMarker.GetReference().AddToMap(False)
	endif

	Alias_EnemyFieldCO.GetActorReference().GetActorBase().SetEssential(false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE cwmission05script
Quest __temp = self as Quest
cwmission05script kmyQuest = __temp as cwmission05script
;END AUTOCAST
;BEGIN CODE
debug.traceConditional("CWMission05 stage 30", kmyquest.CWs.debugon.value)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

