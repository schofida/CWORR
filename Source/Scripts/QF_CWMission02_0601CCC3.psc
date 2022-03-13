;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 27
Scriptname QF_CWMission02_0601CCC3 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Hold
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Hold Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MapMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MapMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MissionNumberRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MissionNumberRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FieldCO
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FieldCO Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ResourceLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_ResourceLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CampaignStartMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CampaignStartMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ResourceObject1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ResourceObject1 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN AUTOCAST TYPE CWMission02Script
Quest __temp = self as Quest
CWMission02Script kmyQuest = __temp as CWMission02Script
;END AUTOCAST
;BEGIN CODE
;shut down stage --  clean up created references, etc.
;NOTE: campaign should be advanced prior to this quest stage

; ; debug.traceConditional("CWMission04 stage 255 (shut down phase)", kmyquest.CWs.debugon.value)
kmyquest.ProcessFieldCOFactionsOnQuestShutDown()

kmyQuest.CWs.CWCampaignS.CWMission01Or02Done = true

UnregisterForUpdate()

;delete created references
(Alias_ResourceObject1.GetReference() as ResourceObjectScript).Repair()

(Alias_ResourceObject1 as CWMission02ResourceObjectScript).Unregisterforupdate()

kmyquest.ToggleOnComplexWIInteractions(Alias_ResourceLocation)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN AUTOCAST TYPE CWMission02Script
Quest __temp = self as Quest
CWMission02Script kmyQuest = __temp as CWMission02Script
;END AUTOCAST
;BEGIN CODE
;Successfully complete quest

; ; debug.traceConditional("CWMission04 stage 200 SUCCESS!!!", kmyquest.CWs.debugon.value)
kmyquest.objectiveCompleted = 1

kmyQuest.CWCampaignS.StopMonitors()

kmyquest.FlagFieldCOWithMissionResultFaction(2)

kmyquest.CWs.CWCampaignS.registerMissionSuccess(Alias_ResourceLocation.GetLocation(), isFortBattle = false)	;if isFortBattle then we won't display the Objective for the hold again, because we've just won the campain

kmyquest.CWs.WinHoldOffScreenIfNotDoingCapitalBattles(Alias_ResourceLocation.GetLocation())

kmyQuest.FlagFieldCOWithPotentialMissionFactions(2, True)

kmyQuest.CWCampaignS.AdvanceCampaignPhase()

stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN AUTOCAST TYPE CWMission02Script
Quest __temp = self as Quest
CWMission02Script kmyQuest = __temp as CWMission02Script
;END AUTOCAST
;BEGIN CODE


setObjectiveCompleted(10)
setObjectiveDisplayed(100)

;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN AUTOCAST TYPE CWMission02Script
Quest __temp = self as Quest
CWMission02Script kmyQuest = __temp as CWMission02Script
;END AUTOCAST
;BEGIN CODE
;Fail quest

; ; debug.traceConditional("CWMission04 stage 205 FAILURE!!!", kmyquest.CWs.debugon.value)
kmyQuest.CWCampaignS.StopMonitors()

kmyquest.FlagFieldCOWithMissionResultFaction(2, MissionFailure = true)

kmyQuest.CWCampaignS.AdvanceCampaignPhase()

stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE CWMission02Script
Quest __temp = self as Quest
CWMission02Script kmyQuest = __temp as CWMission02Script
;END AUTOCAST
;BEGIN CODE
;Fail quest

; ; debug.traceConditional("CWMission04 stage 205 FAILURE!!!", kmyquest.CWs.debugon.value)

kmyquest.FlagFieldCOWithPotentialMissionFactions(2)

kmyquest.ResetCommonMissionProperties()

kmyquest.ToggleOffComplexWIInteractions(Alias_ResourceLocation)

;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE CWMission02Script
Quest __temp = self as Quest
CWMission02Script kmyQuest = __temp as CWMission02Script
;END AUTOCAST
;BEGIN CODE
;Fail quest

; ; debug.traceConditional("CWMission04 stage 205 FAILURE!!!", kmyquest.CWs.debugon.value)

kmyquest.FlagFieldCOWithActiveQuestFaction(2)

kmyQuest.SetObjectiveDisplayed(10)

(Alias_ResourceObject1.GetReference() as ResourceObjectScript).ChangeState(2)

(Alias_ResourceObject1 as CWMission02ResourceObjectScript).RegisterForUpdate(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE CWMission02Script
Quest __temp = self as Quest
CWMission02Script kmyQuest = __temp as CWMission02Script
;END AUTOCAST
;BEGIN CODE
;Fail quest

; ; debug.traceConditional("CWMission04 stage 205 FAILURE!!!", kmyquest.CWs.debugon.value)

kmyQuest.CWCampaignS.StartMonitors(kmyQuest)


;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

