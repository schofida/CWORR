Scriptname qf_cwmission06_06055233 extends Quest Hidden 
;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 15

;BEGIN ALIAS PROPERTY DissaffectedSoldier03
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DissaffectedSoldier03 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWCampEnemy
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_CWCampEnemy Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier08
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier08 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier07
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier07 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DissaffectedSoldier01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DissaffectedSoldier01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier04
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier04 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FieldCO
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FieldCO Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Hold
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Hold Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MissionNumberRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MissionNumberRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DissaffectedSoldier02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DissaffectedSoldier02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier11
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier11 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CampaignStartMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CampaignStartMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier06
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier06 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier09
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier09 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWCampEnemyMapMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CWCampEnemyMapMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier03
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier03 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier12
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier12 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier10
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier10 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier05
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier05 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWCampEnemyLocationCenterMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CWCampEnemyLocationCenterMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN AUTOCAST TYPE cwmission06script
Quest __temp = self as Quest
cwmission06script kmyQuest = __temp as cwmission06script
;END AUTOCAST
;BEGIN CODE
if MissionFinished == true
    return
endif
MissionFinished = true

debug.traceConditional("CWMission06 stage 205 (Misson Failed)", kmyquest.CWs.debugon.value)

kmyQuest.FailAllObjectives()

kmyQuest.FlagFieldCOWithMissionResultFaction(6, MissionFailure = true)

kmyQuest.CleanUpLoyalistFactions(Alias_LoyalistSoldier01, Alias_LoyalistSoldier02, Alias_LoyalistSoldier03, Alias_LoyalistSoldier04, Alias_LoyalistSoldier05, Alias_LoyalistSoldier06, Alias_LoyalistSoldier07, Alias_LoyalistSoldier08, Alias_LoyalistSoldier09, Alias_LoyalistSoldier10, Alias_LoyalistSoldier11, Alias_LoyalistSoldier12)

kmyQuest.CWs.CWCampaignS.StartDisguiseQuest()

while Game.GetPlayer().IsInLocation(Alias_CWCampEnemy.GetLocation())
    utility.wait(5)
endwhile

stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN AUTOCAST TYPE cwmission06script
Quest __temp = self as Quest
cwmission06script kmyQuest = __temp as cwmission06script
;END AUTOCAST
;BEGIN CODE
ReferenceAlias EnemyFieldCO = kmyQuest.CWs.GetAliasCampFieldCOForHold(Alias_Hold.GetLocation(), kmyQuest.CWs.getOppositeFactionInt(kmyQuest.CWs.playerAllegiance))
if !EnemyFieldCO.GetActorRef().IsDead()
    EnemyFieldCO.TryToDisable()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE cwmission06script
Quest __temp = self as Quest
cwmission06script kmyQuest = __temp as cwmission06script
;END AUTOCAST
;BEGIN CODE
debug.traceConditional("CWMission06 stage 0", kmyquest.CWs.debugon.value)

MissionFinished = false

kmyQuest.ResetCommonMissionProperties()

kmyQuest.FlagFieldCOWithPotentialMissionFactions(6)


kmyquest.ToggleOnComplexWIInteractions(Alias_CWCampEnemy)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE cwmission06script
Quest __temp = self as Quest
cwmission06script kmyQuest = __temp as cwmission06script
;END AUTOCAST
;BEGIN CODE
debug.traceConditional("CWMission06 stage 10", kmyquest.CWs.debugon.value)

kmyQuest.FlagFieldCOWithActiveQuestFaction(6)

;schofida - Set quest as active on the map so player knows where to meet the troops
kmyQuest.setActive()

kmyQuest.EnableMapMarkerAlias(Alias_CWCampEnemyMapMarker)

if kmyquest.cws.playerAllegiance == kmyquest.cws.iImperials
    kmyquest.cws.cwcampaigns.CampEnableSons.TryToEnable()
    kmyQuest.CWCampEnemyEnable = kmyquest.cws.cwcampaigns.CampEnableSons.GetReference()
Else
    kmyquest.cws.cwcampaigns.CampEnableImperial.TryToEnable()
    kmyQuest.CWCampEnemyEnable = kmyquest.cws.cwcampaigns.CampEnableImperial.GetReference()
endif

kmyquest.cws.CWDisaffectedSoldierFaction.setEnemy(kmyQuest.CWMission06LoyalistSoldierFaction, true, true)

kmyquest.CWs.RegisterEventHappening(Alias_CWCampEnemy.GetLocation())

SetObjectiveDisplayed(10)

Alias_LoyalistSoldier01.TryToReset()
Alias_LoyalistSoldier02.TryToReset()
Alias_LoyalistSoldier03.TryToReset()
Alias_LoyalistSoldier04.TryToReset()
Alias_LoyalistSoldier05.TryToReset()
Alias_LoyalistSoldier06.TryToReset()
Alias_LoyalistSoldier07.TryToReset()
Alias_LoyalistSoldier08.TryToReset()
Alias_LoyalistSoldier09.TryToReset()
Alias_LoyalistSoldier10.TryToReset()
Alias_LoyalistSoldier11.TryToReset()
Alias_LoyalistSoldier12.TryToReset()

Alias_DissaffectedSoldier01.TryToEnable()
Alias_DissaffectedSoldier02.TryToEnable()
Alias_DissaffectedSoldier03.TryToEnable()

Alias_DissaffectedSoldier01.TryToReset()
Alias_DissaffectedSoldier02.TryToReset()
Alias_DissaffectedSoldier03.TryToReset()

Alias_LoyalistSoldier01.TryToAddToFaction(kmyQuest.CWPlayerAlly)
Alias_LoyalistSoldier02.TryToAddToFaction(kmyQuest.CWPlayerAlly)
Alias_LoyalistSoldier03.TryToAddToFaction(kmyQuest.CWPlayerAlly)
Alias_LoyalistSoldier04.TryToAddToFaction(kmyQuest.CWPlayerAlly)
Alias_LoyalistSoldier05.TryToAddToFaction(kmyQuest.CWPlayerAlly)
Alias_LoyalistSoldier06.TryToAddToFaction(kmyQuest.CWPlayerAlly)
Alias_LoyalistSoldier07.TryToAddToFaction(kmyQuest.CWPlayerAlly)
Alias_LoyalistSoldier08.TryToAddToFaction(kmyQuest.CWPlayerAlly)
Alias_LoyalistSoldier09.TryToAddToFaction(kmyQuest.CWPlayerAlly)
Alias_LoyalistSoldier10.TryToAddToFaction(kmyQuest.CWPlayerAlly)
Alias_LoyalistSoldier11.TryToAddToFaction(kmyQuest.CWPlayerAlly)
Alias_LoyalistSoldier12.TryToAddToFaction(kmyQuest.CWPlayerAlly)

Alias_DissaffectedSoldier01.TryToAddToFaction(kmyQuest.CWPlayerAlly)
Alias_DissaffectedSoldier02.TryToAddToFaction(kmyQuest.CWPlayerAlly)
Alias_DissaffectedSoldier03.TryToAddToFaction(kmyQuest.CWPlayerAlly)

ReferenceAlias EnemyFieldCO = kmyQuest.CWs.GetAliasCampFieldCOForHold(Alias_Hold.GetLocation(), kmyQuest.CWs.getOppositeFactionInt(kmyQuest.CWs.playerAllegiance))
if !EnemyFieldCO.GetActorRef().IsDead()
    EnemyFieldCO.TryToDisable()
endif

kmyQuest.TurncoatLeader = Alias_DissaffectedSoldier01

Alias_DissaffectedSoldier01.GetActorRef().GetActorBase().SetVoiceType(kmyQuest.MaleSoldier)

kmyQuest.RegisterForSingleUpdate(2)
kmyQuest.processPreRevoltFactions(Alias_DissaffectedSoldier01)
kmyQuest.processPreRevoltFactions(Alias_DissaffectedSoldier02)
kmyQuest.processPreRevoltFactions(Alias_DissaffectedSoldier03)

kmyQuest.SetInitialLoyalistAliveCount(Alias_LoyalistSoldier01, Alias_LoyalistSoldier01, Alias_LoyalistSoldier02, Alias_LoyalistSoldier03, Alias_LoyalistSoldier04, Alias_LoyalistSoldier05, Alias_LoyalistSoldier06, Alias_LoyalistSoldier07, Alias_LoyalistSoldier08, Alias_LoyalistSoldier09, Alias_LoyalistSoldier10, Alias_LoyalistSoldier11, Alias_LoyalistSoldier12)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE cwmission06script
Quest __temp = self as Quest
cwmission06script kmyQuest = __temp as cwmission06script
;END AUTOCAST
;BEGIN CODE
debug.traceConditional("CWMission06 stage 100", kmyquest.CWs.debugon.value)
kmyQuest.objectiveCompleted = 1

;CWO Repacify soldiers so they don't start attacking the wounded
kmyquest.cws.CWDisaffectedSoldierFaction.setEnemy(kmyQuest.CWMission06LoyalistSoldierFaction, true, true)

Alias_DissaffectedSoldier01.TryToEvaluatePackage()
Alias_DissaffectedSoldier02.TryToEvaluatePackage()
Alias_DissaffectedSoldier03.TryToEvaluatePackage()

;Just In Case
Alias_LoyalistSoldier01.TryToKill()
Alias_LoyalistSoldier02.TryToKill()
Alias_LoyalistSoldier03.TryToKill()
Alias_LoyalistSoldier04.TryToKill()
Alias_LoyalistSoldier05.TryToKill()
Alias_LoyalistSoldier06.TryToKill()
Alias_LoyalistSoldier07.TryToKill()
Alias_LoyalistSoldier08.TryToKill()
Alias_LoyalistSoldier09.TryToKill()
Alias_LoyalistSoldier10.TryToKill()
Alias_LoyalistSoldier11.TryToKill()
Alias_LoyalistSoldier12.TryToKill()

SetObjectiveCompleted(20)

setStage(200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE cwmission06script
Quest __temp = self as Quest
cwmission06script kmyQuest = __temp as cwmission06script
;END AUTOCAST
;BEGIN CODE
debug.traceConditional("CWMission06 stage 20", kmyquest.CWs.debugon.value)
SetObjectiveCompleted(10)
SetObjectiveDisplayed(20)

kmyQuest.CWs.CWCampaignS.StopDisguiseQuest()

kmyquest.cws.CWDisaffectedSoldierFaction.setEnemy(kmyQuest.CWMission06LoyalistSoldierFaction, false, false)

kmyQuest.CleanUpLoyalistFactions(Alias_LoyalistSoldier01, Alias_LoyalistSoldier02, Alias_LoyalistSoldier03, Alias_LoyalistSoldier04, Alias_LoyalistSoldier05, Alias_LoyalistSoldier06, Alias_LoyalistSoldier07, Alias_LoyalistSoldier08, Alias_LoyalistSoldier09, Alias_LoyalistSoldier10, Alias_LoyalistSoldier11, Alias_LoyalistSoldier12)

kmyQuest.KillLoyalists = 1
Alias_DissaffectedSoldier01.TryToEvaluatePackage()
Alias_DissaffectedSoldier02.TryToEvaluatePackage()
Alias_DissaffectedSoldier03.TryToEvaluatePackage()

ReferenceAlias EnemyFieldCO = kmyQuest.CWs.GetAliasCampFieldCOForHold(Alias_Hold.GetLocation(), kmyQuest.CWs.getOppositeFactionInt(kmyQuest.CWs.playerAllegiance))
if !EnemyFieldCO.GetActorRef().IsDead()
    EnemyFieldCO.TryToDisable()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN AUTOCAST TYPE cwmission06script
Quest __temp = self as Quest
cwmission06script kmyQuest = __temp as cwmission06script
;END AUTOCAST
;BEGIN CODE
;shut down stage --  clean up created references, etc.
debug.traceConditional("CWMission06 stage 255 (shut down phase)", kmyquest.CWs.debugon.value)
kmyQuest.ProcessFieldCOFactionsOnQuestShutDown()

kmyQuest.CWs.CWCampaignS.CWMission06Done = 1
debug.traceConditional("CWMission06 stage 255: turning on complex WI interactions", kmyquest.CWs.debugon.value)
kmyquest.ToggleOffComplexWIInteractions(Alias_CWCampEnemy)
kmyquest.CWs.UnregisterEventHappening(Alias_CWCampEnemy.GetLocation())

;delete created references
;*** TO DO: When we have arrays, CreateMissionAliasedActor should put all created references to an array, then a new funciton should delete ALL of them
Alias_LoyalistSoldier01.TryToReset()
Alias_LoyalistSoldier02.TryToReset()
Alias_LoyalistSoldier03.TryToReset()
Alias_LoyalistSoldier04.TryToReset()
Alias_LoyalistSoldier05.TryToReset()
Alias_LoyalistSoldier06.TryToReset()
Alias_LoyalistSoldier07.TryToReset()
Alias_LoyalistSoldier08.TryToReset()
Alias_LoyalistSoldier09.TryToReset()

if kmyQuest.objectiveCompleted == 1
    kmyQuest.processPostRevoltFactions(Alias_DissaffectedSoldier01)
    kmyQuest.processPostRevoltFactions(Alias_DissaffectedSoldier02)
    kmyQuest.processPostRevoltFactions(Alias_DissaffectedSoldier03)
endif

Alias_DissaffectedSoldier01.TryToDisable()
Alias_DissaffectedSoldier02.TryToDisable()
Alias_DissaffectedSoldier03.TryToDisable()

ReferenceAlias EnemyFieldCO = kmyQuest.CWs.GetAliasCampFieldCOForHold(Alias_Hold.GetLocation(), kmyQuest.CWs.getOppositeFactionInt(kmyQuest.CWs.playerAllegiance))
if !EnemyFieldCO.GetActorRef().IsDead()
    EnemyFieldCO.TryToEnable()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN AUTOCAST TYPE cwmission06script
Quest __temp = self as Quest
cwmission06script kmyQuest = __temp as cwmission06script
;END AUTOCAST
;BEGIN CODE
if MissionFinished == true
    return
endif
MissionFinished = true

debug.traceConditional("CWMission06 stage 200 (Misson Success)", kmyquest.CWs.debugon.value)

kmyQuest.CompleteAllObjectives()

kmyQuest.FlagFieldCOWithMissionResultFactionWithDelta(6, false, 0)

kmyquest.CWs.CWCampaignS.registerMissionSuccess(Alias_Hold.GetLocation(), isFortBattle = False)	;if isFortBattle then we won't display the Objective for the hold again, because we've just won the campain

kmyQuest.CleanUpLoyalistFactions(Alias_LoyalistSoldier01, Alias_LoyalistSoldier02, Alias_LoyalistSoldier03, Alias_LoyalistSoldier04, Alias_LoyalistSoldier05, Alias_LoyalistSoldier06, Alias_LoyalistSoldier07, Alias_LoyalistSoldier08, Alias_LoyalistSoldier09, Alias_LoyalistSoldier10, Alias_LoyalistSoldier11, Alias_LoyalistSoldier12)

kmyQuest.CWs.CWCampaignS.StartDisguiseQuest()

kmyQuest.AddDisaffectedSoldierToPotentialAlly(Alias_DissaffectedSoldier01)
kmyQuest.AddDisaffectedSoldierToPotentialAlly(Alias_DissaffectedSoldier02)
kmyQuest.AddDisaffectedSoldierToPotentialAlly(Alias_DissaffectedSoldier03)

Actor PlayerRef = Alias_Player.GetActorRef()

while PlayerRef.IsInLocation(Alias_CWCampEnemy.GetLocation())
    utility.wait(5)
endwhile

stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
bool MissionFinished = false