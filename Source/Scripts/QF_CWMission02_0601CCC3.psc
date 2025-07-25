;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 27
Scriptname QF_CWMission02_0601CCC3 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Hold
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Hold Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWFortSiegeSons1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CWFortSiegeSons1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MapMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MapMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWFortSiegeSons3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CWFortSiegeSons3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Garrison1EnableSons
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Garrison1EnableSons Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWFortSiegeImperial2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CWFortSiegeImperial2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MissionNumberRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MissionNumberRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ResourceLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_ResourceLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FieldCO
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FieldCO Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Garrison1EnableImperial
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Garrison1EnableImperial Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWFortSiegeSons4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CWFortSiegeSons4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CampaignStartMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CampaignStartMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ResourceObject1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ResourceObject1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWFortSiegeImperial1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CWFortSiegeImperial1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWFortSiegeImperial3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CWFortSiegeImperial3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWFortSiegeImperial4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CWFortSiegeImperial4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWFortSiegeSons2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CWFortSiegeSons2 Auto
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
    CWScript.Log("CWCWMission02ScriptFragment", self + "Stage 255")
    
    kmyQuest.CWCampaignS.StartDisguiseQuest()

    ; ; debug.traceConditional("CWMission04 stage 255 (shut down phase)", kmyquest.CWs.debugon.value)
    kmyquest.ProcessFieldCOFactionsOnQuestShutDown()
    
    kmyQuest.CWS.StopCWCitizensFlee()
    kmyQuest.CWs.CWCampaignS.CWMission01Or02Done = 1

    kmyquest.CWS.SetOwner(Alias_ResourceLocation.GetLocation(), kmyQuest.CWs.playerAllegiance)

    Alias_CWFortSiegeSons1.TryToDisable()
    Alias_CWFortSiegeSons2.TryToDisable()
    Alias_CWFortSiegeSons3.TryToDisable()
    Alias_CWFortSiegeSons4.TryToDisable()
    Alias_CWFortSiegeImperial1.TryToDisable()
    Alias_CWFortSiegeImperial2.TryToDisable()
    Alias_CWFortSiegeImperial3.TryToDisable()
    Alias_CWFortSiegeImperial4.TryToDisable()
    
    if SmelterFix != None
        SmelterFix.ClearDestruction()
        SmelterFix.Disable()
        SmelterFix.Delete()
        SmelterFix = None
        OldSmelter.Enable()
        if NewSawMillLever != None
            NewSawMillLever.Disable()
            NewSawMillLever.Delete()
            NewSawMillLever = None
            OldSawMillLever.Enable()
        endif
    else
        ;delete created references
        (Alias_ResourceObject1.GetReference() as ResourceObjectScript).Repair()
    
        (Alias_ResourceObject1 as CWMission02ResourceObjectScript).Unregisterforupdate()
    endif
    
    kmyquest.ToggleOnComplexWIInteractions(Alias_ResourceLocation)

    Alias_CWFortSiegeSons1.GetRef().DeleteWhenAble()
    Alias_CWFortSiegeSons2.GetRef().DeleteWhenAble()
    Alias_CWFortSiegeSons3.GetRef().DeleteWhenAble()
    Alias_CWFortSiegeSons4.GetRef().DeleteWhenAble()
    Alias_CWFortSiegeImperial1.GetRef().DeleteWhenAble()
    Alias_CWFortSiegeImperial2.GetRef().DeleteWhenAble()
    Alias_CWFortSiegeImperial3.GetRef().DeleteWhenAble()
    Alias_CWFortSiegeImperial4.GetRef().DeleteWhenAble()
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
    
    CWScript.Log("CWCWMission02ScriptFragment", self + "Stage 200")
    
    ;Set in stage 120 but just in case..

    kmyQuest.CompleteAllObjectives()
    
    kmyquest.FlagFieldCOWithMissionResultFactionWithDelta(2, false, 1)

    (Alias_ResourceObject1 as CWMission02ResourceObjectScript).UnregisterForUpdate()
    
    kmyquest.CWs.CWCampaignS.registerMissionSuccess(Alias_Hold.GetLocation(), isFortBattle = false)	;if isFortBattle then we won't display the Objective for the hold again, because we've just won the campain
    
    while Game.GetPlayer().IsInLocation(Alias_ResourceLocation.GetLocation())
        CWScript.Log("CWCWMission02ScriptFragment", self + "SucceedQuest() Waiting for player to leave City before stopping quest")
       utility.wait(5)
    endwhile
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
    
    CWScript.Log("CWCWMission02ScriptFragment", self + "Stage 100")
    kmyquest.objectiveCompleted = 1
    
    SetStage(200)
    
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
    CWScript.Log("CWCWMission02ScriptFragment", self + "Stage 205")

    kmyQuest.FailAllObjectives()

    (Alias_ResourceObject1 as CWMission02ResourceObjectScript).UnregisterForUpdate()
    
    kmyquest.FlagFieldCOWithMissionResultFaction(2, MissionFailure = true)

    while Game.GetPlayer().IsInLocation(Alias_ResourceLocation.GetLocation())
        CWScript.Log("CWCWMission02ScriptFragment", self + "FailQuest() Waiting for player to leave City before stopping quest")
       utility.wait(5)
    endwhile
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
    
    CWScript.Log("CWCWMission02ScriptFragment", self + "Stage 0")
    
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
    CWScript.Log("CWCWMission02ScriptFragment", self + "Stage 10")
    
    kmyquest.FlagFieldCOWithActiveQuestFaction(2)

    kmyquest.CWs.StartCWCitizensFlee(Alias_ResourceLocation.GetLocation())
    kmyquest.CWs.RegisterEventHappening(Alias_ResourceLocation.GetLocation())

    kmyQuest.SetObjectiveDisplayed(10)

	;schofida - Set quest as active on the map so player knows where to meet the troops
	kmyQuest.setActive()

    if (Alias_ResourceObject1.GetReference().GetBaseObject() As Furniture == kmyQuest.CWs.CWCampaignS.ResourceObjectMine)
        OldSmelter = Alias_ResourceObject1.GetReference()
        OldSmelter.Disable()
        SmelterFix = OldSmelter.PlaceAtMe(kmyQuest.ResourceObjectMine)
        Alias_ResourceObject1.ForceRefTo(SmelterFix)
    elseif (Alias_ResourceObject1.GetReference().GetBaseObject() As Furniture == kmyQuest.CWs.CWCampaignS.ResourceObjectGrainMill)
        OldSmelter = Alias_ResourceObject1.GetReference()
        OldSmelter.Disable()
        SmelterFix = OldSmelter.PlaceAtMe(kmyQuest.ResourceObjectGrainMill)
        Alias_ResourceObject1.ForceRefTo(SmelterFix)
    elseif (Alias_ResourceObject1.GetReference().GetBaseObject() As Furniture == kmyQuest.CWs.CWCampaignS.ResourceObjectMill)
        OldSmelter = Alias_ResourceObject1.GetReference()
        OldSmelter.Disable()
        SmelterFix = OldSmelter.PlaceAtMe(kmyQuest.ResourceObjectSawMill)
        Alias_ResourceObject1.ForceRefTo(SmelterFix) 
        OldSawMillLever = kmyQuest.GetMillLever(Alias_ResourceLocation.GetLocation())
        OldSawMillLever.Disable()
        NewSawMillLever = OldSawMillLever.PlaceAtMe(kmyQuest.ResourceObjectSawMillLever)
    else
        Alias_ResourceObject1.TryToEnable()
    endif
    Alias_MapMarker.TryToEnable()
    
    
    (Alias_ResourceObject1.GetReference() as ResourceObjectScript).ChangeState(2)

    if kmyQuest.cws.playerAllegiance == kmyQuest.cws.iImperials
        Alias_CWFortSiegeSons1.TryToEnableNoWait()
        Alias_CWFortSiegeSons2.TryToEnableNoWait()
        Alias_CWFortSiegeSons3.TryToEnableNoWait()
        Alias_CWFortSiegeSons4.TryToEnableNoWait()
        Alias_CWFortSiegeSons1.TryToEvaluatePackage()
        Alias_CWFortSiegeSons2.TryToEvaluatePackage()
        Alias_CWFortSiegeSons3.TryToEvaluatePackage()
        Alias_CWFortSiegeSons4.TryToEvaluatePackage()
    else
        Alias_CWFortSiegeImperial1.TryToEnableNoWait()
        Alias_CWFortSiegeImperial2.TryToEnableNoWait()
        Alias_CWFortSiegeImperial3.TryToEnableNoWait()
        Alias_CWFortSiegeImperial4.TryToEnableNoWait()
        Alias_CWFortSiegeImperial1.TryToEvaluatePackage()
        Alias_CWFortSiegeImperial2.TryToEvaluatePackage()
        Alias_CWFortSiegeImperial3.TryToEvaluatePackage()
        Alias_CWFortSiegeImperial4.TryToEvaluatePackage()
    endif

    
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
    
    CWScript.Log("CWCWMission02ScriptFragment", self + "Stage 20")
    
    kmyQuest.CWCampaignS.StopDisguiseQuest()
;END CODE
EndFunction
;END FRAGMENT
    
        
    ;END FRAGMENT CODE - Do not edit anything between this and the begin comment
    
    ObjectReference SmelterFix
    ObjectReference OldSmelter
    ObjectReference NewSawMillLever
    ObjectReference OldSawMillLever