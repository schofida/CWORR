;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 14
Scriptname QF_CWMission09_0601CCBE Extends Quest Hidden

;BEGIN ALIAS PROPERTY Document
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Document Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Hold
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Hold Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWCaptialHQ
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_CWCapitalHQ Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MissionNumberRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MissionNumberRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DocumentSpawn
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DocumentSpawn Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CampaignStartMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CampaignStartMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FieldCO
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FieldCO Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE cwmission09script
Quest __temp = self as Quest
cwmission09script kmyQuest = __temp as cwmission09script
;END AUTOCAST
;BEGIN CODE
; ; debug.traceConditional("CWMission03 stage 10", kmyquest.CWs.debugon.value)

kmyQuest.FlagFieldCOWithPotentialMissionFactions(9, true)

ObjectReference doc
if kmyQuest.CWs.playerAllegiance == kmyQuest.CWs.iImperials
    doc = Alias_DocumentSpawn.GetRef().PlaceAtMe(kmyQuest.CWDocumentsSons)
Else
    doc = Alias_DocumentSpawn.GetRef().PlaceAtMe(kmyQuest.CWDocumentsImperial)
endif
doc.SetFactionOwner(kmyQuest.CWs.getPlayerAllegianceEnemyFaction())
Alias_Document.ForceRefTo(doc)

SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN AUTOCAST TYPE cwmission09script
Quest __temp = self as Quest
cwmission09script kmyQuest = __temp as cwmission09script
;END AUTOCAST
;BEGIN CODE
;shut down stage --  clean up created references, etc.
;NOTE: campaign should be advanced prior to this quest stage

; ; debug.traceConditional("CWMission03 stage 255 (shut down phase)", kmyquest.CWs.debugon.value)
kmyquest.ProcessFieldCOFactionsOnQuestShutDown()

; ; debug.traceConditional("CWMission03 stage 255: turning on complex WI interactions", kmyquest.CWs.debugon.value)
kmyquest.ToggleOnComplexWIInteractions(Alias_CWCapitalHQ)

;delete created references
;*** TO DO: When we have arrays, CreateMissionAliasedActor should put all created references to an array, then a new funciton should delete ALL of them
ObjectReference doc = Alias_Document.GetRef()
Alias_Document.Clear()
doc.Delete()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE cwmission09script
Quest __temp = self as Quest
cwmission09script kmyQuest = __temp as cwmission09script
;END AUTOCAST
;BEGIN CODE
; ; debug.traceConditional("CWMission03 Stage 0: Quest Started", kmyquest.CWs.debugon.value)
;debug.messageBox("CWMission03 Started")

kmyquest.FlagFieldCOWithPotentialMissionFactions(9) ;3 = Intercept Courier (this quest type)

kmyquest.ResetCommonMissionProperties()

; ; debug.traceConditional("CWMission03 stage 0: turning off complex WI interactions", kmyquest.CWs.debugon.value)
kmyquest.ToggleOffComplexWIInteractions(Alias_CWCapitalHQ)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN AUTOCAST TYPE cwmission09script
Quest __temp = self as Quest
cwmission09script kmyQuest = __temp as cwmission09script
;END AUTOCAST
;BEGIN CODE
;Fail quest
Alias_Player.GetActorRef().RemoveItem(Alias_Document.GetRef())
; ; debug.traceConditional("CWMission03 stage 205 FAILURE!!!", kmyquest.CWs.debugon.value)

kmyquest.FlagFieldCOWithMissionResultFaction(9, True)

kmyQuest.CWCampaignS.StopMonitors()

kmyQuest.CWs.CWCampaignS.AdvanceCampaignPhase()

stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN AUTOCAST TYPE cwmission09script
Quest __temp = self as Quest
cwmission09script kmyQuest = __temp as cwmission09script
;END AUTOCAST
;BEGIN CODE
; ; debug.traceConditional("CWMission03 stage 10", kmyquest.CWs.debugon.value)

kmyQuest.CWCampaignS.StartMonitors(kmyQuest)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE cwmission09script
Quest __temp = self as Quest
cwmission09script kmyQuest = __temp as cwmission09script
;END AUTOCAST
;BEGIN CODE
; ; debug.traceConditional("CWMission03 stage 100", kmyquest.CWs.debugon.value)
kmyquest.objectiveCompleted = 1

kmyQuest.SetObjectiveCompleted(10)
kmyQuest.SetObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN AUTOCAST TYPE cwmission09script
Quest __temp = self as Quest
cwmission09script kmyQuest = __temp as cwmission09script
;END AUTOCAST
;BEGIN CODE
;Successfully complete quest

; ; debug.traceConditional("CWMission03 stage 200 SUCCESS!!!", kmyquest.CWs.debugon.value)
Alias_Player.GetActorRef().RemoveItem(Alias_Document.GetRef())
Alias_FieldCO.GetActorRef().AddItem(Alias_Document.GetRef())

kmyquest.FlagFieldCOWithMissionResultFaction(9)

kmyquest.CWs.CWCampaignS.registerMissionSuccess(Alias_Hold.GetLocation())

kmyQuest.CWCampaignS.StopMonitors()

kmyQuest.CWs.CWCampaignS.AdvanceCampaignPhase()

stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
