Scriptname qf_cwmission06_06055233 extends Quest Hidden 
;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 14

;BEGIN ALIAS PROPERTY MapMarkerCampEnemy
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MapMarkerCampEnemy Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWCampEnemyMapMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CWCampEnemyMapMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Hold
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Hold Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier09
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier09 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FieldCO
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FieldCO Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GarrisonEnableMarkerEnemy
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GarrisonEnableMarkerEnemy Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier07
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier07 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DissaffectedSoldier03
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DissaffectedSoldier03 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWCampEnemy
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_CWCampEnemy Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GarrisonEnableMarkerSons
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GarrisonEnableMarkerSons Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWCampSons
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_CWCampSons Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CampaignStartMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CampaignStartMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GarrisonEnableMarkerImperial
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GarrisonEnableMarkerImperial Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier04
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier04 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DissaffectedSoldier02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DissaffectedSoldier02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier03
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier03 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier05
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier05 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWCampImperial
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_CWCampImperial Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DissaffectedSoldier01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DissaffectedSoldier01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MissionNumberRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MissionNumberRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier06
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier06 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LoyalistSoldier08
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LoyalistSoldier08 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN AUTOCAST TYPE cwmission06script
Quest __temp = self as Quest
cwmission06script kmyQuest = __temp as cwmission06script
;END AUTOCAST
;BEGIN CODE

((self as quest) as CWFortSiegeMissionScript).FlagFieldCOWithMissionResultFaction(6, MissionFailure = true)

kmyQuest.CWs.CWCampaignS.StartDisguiseQuest()

while Game.GetPlayer().IsInLocation(Alias_CWCampEnemy.GetLocation())
 	CWScript.Log("CWSiegeScript", self + "FailDefenseQuest() Waiting for player to leave City before stoping Siege quest")
    utility.wait(5)
endwhile

kmyQuest.CWs.CWCampaignS.AdvanceCampaignPhase()

stop()  ;if unsuccessful, stop quest... quest is also stopped in CWMission04PrisonerScript if successful and he unloads

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
kmyQuest.FlagFieldCOWithPotentialMissionFactions(6, true)

if kmyquest.cws.playerAllegiance == kmyquest.cws.iImperials
    kmyquest.cws.cwcampaigns.CampEnableSons.TryToEnable()
Else
    kmyquest.cws.cwcampaigns.CampEnableImperial.TryToEnable()
endif

kmyquest.CWs.RegisterEventHappening(Alias_CWCampEnemy.GetLocation())

Alias_LoyalistSoldier01.TryToEnable()
Alias_LoyalistSoldier02.TryToEnable()
Alias_LoyalistSoldier03.TryToEnable()
Alias_LoyalistSoldier04.TryToEnable()
Alias_LoyalistSoldier05.TryToEnable()
Alias_LoyalistSoldier06.TryToEnable()
Alias_LoyalistSoldier07.TryToEnable()
Alias_LoyalistSoldier08.TryToEnable()
Alias_LoyalistSoldier09.TryToEnable()

Alias_LoyalistSoldier01.TryToReset()
Alias_LoyalistSoldier02.TryToReset()
Alias_LoyalistSoldier03.TryToReset()
Alias_LoyalistSoldier04.TryToReset()
Alias_LoyalistSoldier05.TryToReset()
Alias_LoyalistSoldier06.TryToReset()
Alias_LoyalistSoldier07.TryToReset()
Alias_LoyalistSoldier08.TryToReset()
Alias_LoyalistSoldier09.TryToReset()

Alias_DissaffectedSoldier01.TryToEnable()
Alias_DissaffectedSoldier02.TryToEnable()
Alias_DissaffectedSoldier03.TryToEnable()

Alias_DissaffectedSoldier01.TryToReset()
Alias_DissaffectedSoldier02.TryToReset()
Alias_DissaffectedSoldier03.TryToReset()

kmyQuest.CWs.GetAliasCampFieldCOForHold(Alias_Hold.GetLocation(), kmyQuest.CWs.getOppositeFactionInt(kmyQuest.CWs.playerAllegiance)).TryToDisable()

kmyQuest.TurncoatLeader = Alias_DissaffectedSoldier01
(kmyQuest.TurncoatLeader as CWMission06TurncoatScript).PollForPlayer()
kmyQuest.processPreRevoltFactions(Alias_DissaffectedSoldier01)
kmyQuest.processPreRevoltFactions(Alias_DissaffectedSoldier02)
kmyQuest.processPreRevoltFactions(Alias_DissaffectedSoldier03)

kmyQuest.SetInitialLoyalistAliveCount(Alias_LoyalistSoldier01, Alias_LoyalistSoldier02, Alias_LoyalistSoldier03, Alias_LoyalistSoldier04, Alias_LoyalistSoldier05, Alias_LoyalistSoldier06, Alias_LoyalistSoldier07, Alias_LoyalistSoldier08, Alias_LoyalistSoldier09, None, None, None, None)

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
kmyQuest.FlagFieldCOWithMissionResultFaction(6)

kmyquest.CWs.CWCampaignS.registerMissionSuccess(Alias_Hold.GetLocation(), isFortBattle = False)	;if isFortBattle then we won't display the Objective for the hold again, because we've just won the campain

kmyQuest.CWs.CWCampaignS.StartDisguiseQuest()

kmyQuest.processPostRevoltFactions(Alias_DissaffectedSoldier01)
kmyQuest.processPostRevoltFactions(Alias_DissaffectedSoldier02)
kmyQuest.processPostRevoltFactions(Alias_DissaffectedSoldier03)

if Alias_DissaffectedSoldier01.GetActorReference() != none
    kmyQuest.giveNewOutfit(Alias_DissaffectedSoldier01.GetActorRef())
    kmyQuest.cws.CWAlliesS.AddPotentialAlly(Alias_DissaffectedSoldier01.GetActorRef())
endif

if Alias_DissaffectedSoldier02.GetActorReference() != none
    kmyQuest.giveNewOutfit(Alias_DissaffectedSoldier02.GetActorRef())
    kmyQuest.cws.CWAlliesS.AddPotentialAlly(Alias_DissaffectedSoldier01.GetActorRef())
endif

if Alias_DissaffectedSoldier03.GetActorReference() != none
    kmyQuest.giveNewOutfit(Alias_DissaffectedSoldier03.GetActorRef())
    kmyQuest.cws.CWAlliesS.AddPotentialAlly(Alias_DissaffectedSoldier01.GetActorRef())
endif

while Game.GetPlayer().IsInLocation(Alias_CWCampEnemy.GetLocation())
 	CWScript.Log("CWSiegeScript", self + "FailDefenseQuest() Waiting for player to leave City before stoping Siege quest")
    utility.wait(5)
endwhile

kmyquest.CWs.CWCampaignS.AdvanceCampaignPhase()

stop()
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
kmyQuest.ResetCommonMissionProperties()

kmyQuest.FlagFieldCOWithPotentialMissionFactions(6)

kmyquest.ToggleOnComplexWIInteractions(Alias_CWCampEnemy)
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
kmyQuest.objectiveCompleted = 1

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
setObjectiveCompleted(10)
setObjectiveDisplayed(20)

kmyQuest.CWs.CWCampaignS.StopDisguiseQuest()

kmyQuest.KillLoyalists = 1
Alias_LoyalistSoldier01.TryToEvaluatePackage()
Alias_LoyalistSoldier02.TryToEvaluatePackage()
Alias_LoyalistSoldier03.TryToEvaluatePackage()
Alias_LoyalistSoldier04.TryToEvaluatePackage()
Alias_LoyalistSoldier05.TryToEvaluatePackage()
Alias_LoyalistSoldier06.TryToEvaluatePackage()
Alias_LoyalistSoldier07.TryToEvaluatePackage()
Alias_LoyalistSoldier08.TryToEvaluatePackage()
Alias_LoyalistSoldier09.TryToEvaluatePackage()
Alias_DissaffectedSoldier01.TryToEvaluatePackage()
Alias_DissaffectedSoldier02.TryToEvaluatePackage()
Alias_DissaffectedSoldier03.TryToEvaluatePackage()
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
; ; debug.traceConditional("CWMission04 stage 255 (shut down phase)", kmyquest.CWs.debugon.value)
kmyQuest.ProcessFieldCOFactionsOnQuestShutDown()

kmyQuest.CWs.CWCampaignS.CWMission06Done = true
; ; debug.traceConditional("CWMission04 stage 255: turning on complex WI interactions", kmyquest.CWs.debugon.value)
kmyquest.ToggleOffComplexWIInteractions(Alias_CWCampEnemy)
kmyquest.CWs.UnregisterEventHappening(Alias_CWCampEnemy.GetLocation())

;delete created references
;*** TO DO: When we have arrays, CreateMissionAliasedActor should put all created references to an array, then a new funciton should delete ALL of them
kmyquest.CWs.RegisterEventHappening(Alias_CWCampEnemy.GetLocation())

Alias_LoyalistSoldier01.TryToDisable()
Alias_LoyalistSoldier02.TryToDisable()
Alias_LoyalistSoldier03.TryToDisable()
Alias_LoyalistSoldier04.TryToDisable()
Alias_LoyalistSoldier05.TryToDisable()
Alias_LoyalistSoldier06.TryToDisable()
Alias_LoyalistSoldier07.TryToDisable()
Alias_LoyalistSoldier08.TryToDisable()
Alias_LoyalistSoldier09.TryToDisable()

Alias_DissaffectedSoldier01.TryToDisable()
Alias_DissaffectedSoldier02.TryToDisable()
Alias_DissaffectedSoldier03.TryToDisable()

kmyQuest.CWs.GetAliasCampFieldCOForHold(Alias_Hold.GetLocation(), kmyQuest.CWs.getOppositeFactionInt(kmyQuest.CWs.playerAllegiance)).TryToEnable()

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
