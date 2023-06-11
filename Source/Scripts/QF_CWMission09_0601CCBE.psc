;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 14
Scriptname QF_CWMission09_0601CCBE Extends Quest Hidden

;BEGIN ALIAS PROPERTY MissionNumberRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MissionNumberRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Hold
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Hold Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FieldCO
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FieldCO Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DocumentSpawn
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DocumentSpawn Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CampaignStartMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CampaignStartMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EnemyFieldHQ
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_EnemyFieldHQ Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Document
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Document Auto
;END ALIAS PROPERTY    

;BEGIN ALIAS PROPERTY DocumentSpawnFieldHQ
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DocumentSpawnFieldHQ Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DocumentSpawnCamp
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DocumentSpawnCamp Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EnemyCamp
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_EnemyCamp Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DocumentSpawnLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_DocumentSpawnLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EnemyCampMapMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_EnemyCampMapMarker Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
    ;BEGIN AUTOCAST TYPE cwmission09script
    Quest __temp = self as Quest
    cwmission09script kmyQuest = __temp as cwmission09script
    ;END AUTOCAST
    ;BEGIN CODE
    debug.traceConditional("CWMission09 stage 10", kmyquest.CWs.debugon.value)
    
    kmyQuest.FlagFieldCOWithActiveQuestFaction(9)
    
    Alias_Document.TryToEnable()

    Alias_Document.GetReference().SetFactionOwner(kmyQuest.CWs.GetCrimeFactionForHold(Alias_Hold.GetLocation()))

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
    
    debug.traceConditional("CWMission09 stage 255 (shut down phase)", kmyquest.CWs.debugon.value)
    kmyquest.ProcessFieldCOFactionsOnQuestShutDown()
    if Alias_Document.GetRef()
        Alias_Document.GetRef().DeleteWhenAble()
    endif
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
    debug.traceConditional("CWMission09 Stage 0: Quest Started", kmyquest.CWs.debugon.value)
    
    kmyquest.FlagFieldCOWithPotentialMissionFactions(9)
    
    kmyquest.ResetCommonMissionProperties()

    int SpawnAtCampChance = Utility.RandomInt()
    ObjectReference document
    ObjectReference documentSpawn
    if SpawnAtCampChance > 50 && kmyQuest.CWs.PlayerAllegiance == kmyQuest.CWs.iImperials
        kmyQuest.CWs.CWCampaignS.CampEnableSons.TryToEnable()
        Alias_EnemyCampMapMarker.GetReference().AddToMap(false)
    Elseif SpawnAtCampChance > 50
        kmyQuest.CWs.CWCampaignS.CampEnableImperial.TryToEnable()
        Alias_EnemyCampMapMarker.GetReference().AddToMap(false)
    endif

    if SpawnAtCampChance > 50
        documentSpawn = Alias_DocumentSpawnCamp.GetReference()
        Alias_DocumentSpawnLocation.ForceLocationTo(Alias_EnemyCamp.GetLocation())
    else
        documentSpawn = Alias_DocumentSpawnFieldHQ.GetReference()
        Alias_DocumentSpawnLocation.ForceLocationTo(Alias_EnemyFieldHQ.GetLocation())
    endif
    Alias_DocumentSpawn.ForceRefTo(documentSpawn)

    if kmyQuest.CWs.PlayerAllegiance == kmyQuest.CWs.iImperials
        document = documentSpawn.PlaceAtMe(kmyQuest.CWDocumentsSons, 1, true, true)
    else
        document = documentSpawn.PlaceAtMe(kmyQuest.CWDocumentsImperial, 1, true, true)
    endif
    Alias_Document.ForceRefTo(document)
    
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
    debug.traceConditional("CWMission09 stage 205 FAILURE!!!", kmyquest.CWs.debugon.value)

    kmyQuest.FailAllObjectives()
    
    kmyquest.FlagFieldCOWithMissionResultFaction(9, True)
    
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
debug.traceConditional("CWMission09 stage 40", kmyquest.CWs.debugon.value)

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
    debug.traceConditional("CWMission09 stage 100", kmyquest.CWs.debugon.value)
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
    
    debug.traceConditional("CWMission09 stage 200 SUCCESS!!!", kmyquest.CWs.debugon.value)

    kmyQuest.CompleteAllObjectives()
    
    kmyquest.FlagFieldCOWithMissionResultFaction(9)
    
    kmyquest.CWs.registerMissionSuccess(Alias_Hold.GetLocation())
    
    Alias_Player.GetActorRef().RemoveItem(Alias_Document.GetRef().GetBaseObject())
    Alias_FieldCO.GetActorRef().AddItem(Alias_Document.GetRef().GetBaseObject())

    kmyQuest.CWs.CWCampaignS.addAttackDeltaMissionBonus(1)
    
    kmyQuest.CWs.CWCampaignS.AdvanceCampaignPhase()
    
    stop()
    ;END CODE
EndFunction
;END FRAGMENT
        
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
