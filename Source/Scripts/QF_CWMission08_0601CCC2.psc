;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname QF_CWMission08_0601CCC2 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Hold
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Hold Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Cow
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Cow Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SonsSoldier01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SonsSoldier01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Goldar
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Goldar Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CampaignStartMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CampaignStartMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GiantCampCenterMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GiantCampCenterMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CowSpawnCampSons
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CowSpawnCampSons Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AttackPoint
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_AttackPoint Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CowHand
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CowHand Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SonsSoldier02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SonsSoldier02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SonsSoldier04
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SonsSoldier04 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SonsSoldier03
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SonsSoldier03 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FieldCO
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FieldCO Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AttackPointRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AttackPointRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MissionNumberRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MissionNumberRef Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE cwmission08script
Quest __temp = self as Quest
cwmission08script kmyQuest = __temp as cwmission08script
;END AUTOCAST
;BEGIN CODE
kmyquest.FlagFieldCOWithPotentialMissionFactions(8) ;3 = Intercept Courier (this quest type)

kmyquest.ResetCommonMissionProperties()

kmyquest.ToggleOffComplexWIInteractions(Alias_AttackPoint)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE cwmission08script
Quest __temp = self as Quest
cwmission08script kmyQuest = __temp as cwmission08script
;END AUTOCAST
;BEGIN CODE
Alias_SonsSoldier01.TryToEnable()
Alias_SonsSoldier02.TryToEnable()
Alias_SonsSoldier03.TryToEnable()
Alias_SonsSoldier04.TryToEnable()
Alias_Goldar.TryToEnable()
Alias_Cow.GetActorRef().GetActorBase().SetEssential(true)
;Let them fight for a bit
kmyQuest.SetStage(21)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN AUTOCAST TYPE cwmission08script
Quest __temp = self as Quest
cwmission08script kmyQuest = __temp as cwmission08script
;END AUTOCAST
;BEGIN CODE
;Fail quest
kmyQuest.FailAllObjectives()
; ; debug.traceConditional("CWMission03 stage 205 FAILURE!!!", kmyquest.CWs.debugon.value)

kmyquest.FlagFieldCOWithMissionResultFaction(8, MissionFailure = true)

;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN AUTOCAST TYPE cwmission08script
Quest __temp = self as Quest
cwmission08script kmyQuest = __temp as cwmission08script
;END AUTOCAST
;BEGIN CODE
;shut down stage --  clean up created references, etc.
;NOTE: campaign should be advanced prior to this quest stage

; ; debug.traceConditional("CWMission04 stage 255 (shut down phase)", kmyquest.CWs.debugon.value)
kmyquest.ProcessFieldCOFactionsOnQuestShutDown()

kmyQuest.CWs.CWCampaignS.CWMission08Done = true

UnregisterForUpdate()

;delete created references
Alias_SonsSoldier01.TryToDisableNoWait()
Alias_SonsSoldier01.TryToDisableNoWait()
Alias_SonsSoldier01.TryToDisableNoWait()
Alias_Goldar.TryToDisableNoWait()
Alias_Cow.TryToDisableNoWait()
Alias_CowHand.TryToDisableNoWait()

kmyquest.ToggleOnComplexWIInteractions(Alias_AttackPoint)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE cwmission08script
Quest __temp = self as Quest
cwmission08script kmyQuest = __temp as cwmission08script
;END AUTOCAST
;BEGIN CODE
Alias_Cow.TryToEnable()
Alias_Cow.TryToReset()
Alias_CowHand.TryToEnable()

kmyQuest.FlagFieldCOWithPotentialMissionFactions(8, true)

kmyQuest.SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE cwmission08script
Quest __temp = self as Quest
cwmission08script kmyQuest = __temp as cwmission08script
;END AUTOCAST
;BEGIN CODE
kmyQuest.SetObjectiveCompleted(10)
kmyQuest.SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE cwmission08script
Quest __temp = self as Quest
cwmission08script kmyQuest = __temp as cwmission08script
;END AUTOCAST
;BEGIN CODE
kmyQuest.CompleteAllObjectives()
; ; debug.traceConditional("CWMission03 stage 100", kmyquest.CWs.debugon.value)
kmyquest.objectiveCompleted = 1

setStage(200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE cwmission08script
Quest __temp = self as Quest
cwmission08script kmyQuest = __temp as cwmission08script
;END AUTOCAST
;BEGIN CODE
Utility.Wait(6.9)
kmyQuest.SetStage(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN AUTOCAST TYPE cwmission08script
Quest __temp = self as Quest
cwmission08script kmyQuest = __temp as cwmission08script
;END AUTOCAST
;BEGIN CODE
;Successfully complete quest

; ; debug.traceConditional("CWMission03 stage 200 SUCCESS!!!", kmyquest.CWs.debugon.value)

kmyquest.FlagFieldCOWithMissionResultFaction(8)

;kmyquest.CWs.CWMission03Done = 1 ;used to conditionalize story manager node

kmyquest.CWs.CWCampaignS.registerMissionSuccess(Alias_Hold.GetLocation())

kmyQuest.CWs.CWAlliesS.AddPotentialAlly(Alias_Goldar.GetRef(), true, true, true, true, true, true, true, true, true, false, true)

;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN AUTOCAST TYPE cwmission08script
Quest __temp = self as Quest
cwmission08script kmyQuest = __temp as cwmission08script
;END AUTOCAST
;BEGIN CODE
Alias_SonsSoldier01.TryToRemoveFromFaction(kmyQuest.CWMission08EnemyToGiant)
Alias_SonsSoldier02.TryToRemoveFromFaction(kmyQuest.CWMission08EnemyToGiant)
Alias_SonsSoldier03.TryToRemoveFromFaction(kmyQuest.CWMission08EnemyToGiant)
Alias_SonsSoldier04.TryToRemoveFromFaction(kmyQuest.CWMission08EnemyToGiant)
Alias_Goldar.TryToAddToFaction(kmyQuest.CWs.CWSonsFactionNPC)
Game.GetPlayer().AddToFaction(kmyQuest.CWMission08GiantPlayerAlliesFaction)
Alias_SonsSoldier01.TryToStopCombat()
Alias_SonsSoldier02.TryToStopCombat()
Alias_SonsSoldier03.TryToStopCombat()
Alias_SonsSoldier04.TryToStopCombat()
Alias_Goldar.TryToStopCombat()
Alias_SonsSoldier01.TryToEvaluatePackage()
Alias_SonsSoldier02.TryToEvaluatePackage()
Alias_SonsSoldier03.TryToEvaluatePackage()
Alias_SonsSoldier04.TryToEvaluatePackage()
kmyQuest.SetStage(100)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
