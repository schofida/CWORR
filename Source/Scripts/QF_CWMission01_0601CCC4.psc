;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 0
Scriptname QF_CWMission01_0601CCC4 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Garrison
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Garrison Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ImperialSoldier4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ImperialSoldier4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ImperialSoldier1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ImperialSoldier1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWGarrisonEnableMarkerImperial
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CWGarrisonEnableMarkerImperial Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SonsSoldier2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SonsSoldier2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Ally3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Ally3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Ally1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Ally1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Hold
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Hold Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWGarrisonEnableMarkerSons
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CWGarrisonEnableMarkerSons Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SonsSoldier4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SonsSoldier4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ImperialSoldier3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ImperialSoldier3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Enemy4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Enemy4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ReservationMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ReservationMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Enemy2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Enemy2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SonsSoldier1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SonsSoldier1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SonsSoldier3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SonsSoldier3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Enemy3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Enemy3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CampaignStartMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CampaignStartMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FieldCO
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FieldCO Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Enemy1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Enemy1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ImperialSoldier2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ImperialSoldier2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Ally2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Ally2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MapMarkerGarrison
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MapMarkerGarrison Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MissionNumberRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MissionNumberRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Ally4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Ally4 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE cwmission01script
Quest __temp = self as Quest
cwmission01script kmyQuest = __temp as cwmission01script
;END AUTOCAST
;BEGIN CODE
CWScript.Log("CWMission01QuestFragment", self + "Stage 0" )
kmyquest.CWs.CWBattlePhase.SetValue(0)
((self as quest) as CWFortSiegeMissionScript).ResetCommonMissionProperties()

((self as quest) as CWFortSiegeMissionScript).FlagFieldCOWithPotentialMissionFactions(1)

kmyquest.CWStateAttackStarted.SetValue(0)
kmyquest.CWStateDefenderOutOfReinforcements.SetValue(0)

kmyquest.ToggleOnComplexWIInteractions(Alias_Garrison)

kmyQuest.CWs.CwCampaignS.StartDefense(Alias_Garrison.GetLocation())

kmyQuest.RegisterImperialAliases(Alias_ImperialSoldier1, Alias_ImperialSoldier2, Alias_ImperialSoldier3, Alias_ImperialSoldier4)
kmyQuest.RegisterSonsAliases(Alias_SonsSoldier1, Alias_SonsSoldier2, Alias_SonsSoldier3, Alias_SonsSoldier4)
kmyQuest.RegisterAllyAliases(Alias_Ally1, Alias_Ally2, Alias_Ally3, Alias_Ally4)
kmyQuest.RegisterEnemyAliases(Alias_Enemy1, Alias_Enemy2, Alias_Enemy3, Alias_Enemy4)

if kmyQuest.CWs.PlayerAllegiance == kmyQuest.CWs.iImperials
    kmyQuest.EnemySpawnMarker = Alias_CWGarrisonEnableMarkerSons.GetRef()

Else
    kmyQuest.EnemySpawnMarker = Alias_CWGarrisonEnableMarkerImperial.GetRef()
endif

Utility.Wait(1)

kmyQuest.SetUpAliases(Alias_Garrison.GetLocation())

while !kmyQuest.DoneSettingUpAliases
    Utility.Wait(1)
endwhile

kmyQuest.RegisterAliasesWithCWReinforcementScript(Alias_Garrison.GetLocation())

CWScript.Log("CWMission01QuestFragment", "Stage 0: Calling RegisterSpawnDefenderAliasesWithCWReinforcementScript()")
if kmyQuest.cws.CWAttacker.GetValueInt() == kmyQuest.cws.PlayerAllegiance && kmyQuest.cws.playerAllegiance == kmyQuest.cws.iImperials
    kmyquest.RegisterSpawnDefenderAliasesWithCWReinforcementScript(Alias_CWGarrisonEnableMarkerSons, Alias_CWGarrisonEnableMarkerSons, Alias_CWGarrisonEnableMarkerSons, Alias_CWGarrisonEnableMarkerSons, Alias_CWGarrisonEnableMarkerSons)
elseif kmyQuest.cws.CWAttacker.GetValueInt() == kmyQuest.cws.PlayerAllegiance && kmyQuest.cws.playerAllegiance == kmyQuest.cws.iSons
    kmyquest.RegisterSpawnDefenderAliasesWithCWReinforcementScript(Alias_CWGarrisonEnableMarkerImperial, Alias_CWGarrisonEnableMarkerImperial, Alias_CWGarrisonEnableMarkerImperial, Alias_CWGarrisonEnableMarkerImperial, Alias_CWGarrisonEnableMarkerImperial)
elseif kmyQuest.cws.CWAttacker.GetValueInt() != kmyQuest.cws.PlayerAllegiance && kmyQuest.cws.playerAllegiance == kmyQuest.cws.iImperials
    kmyquest.RegisterSpawnAttackerAliasesWithCWReinforcementScript(Alias_CWGarrisonEnableMarkerSons, Alias_CWGarrisonEnableMarkerSons, Alias_CWGarrisonEnableMarkerSons, Alias_CWGarrisonEnableMarkerSons, Alias_CWGarrisonEnableMarkerSons)
else
    kmyquest.RegisterSpawnAttackerAliasesWithCWReinforcementScript(Alias_CWGarrisonEnableMarkerImperial, Alias_CWGarrisonEnableMarkerImperial, Alias_CWGarrisonEnableMarkerImperial, Alias_CWGarrisonEnableMarkerImperial, Alias_CWGarrisonEnableMarkerImperial)
endif

;CWO Move P

Utility.Wait(1)

kmyQuest.SetEnemyPools()

((kmyquest as quest) as CWSiegePollPlayerLocation).RegisterBattleCenterMarkerAndLocation(Alias_ReservationMarker.GetReference(), Alias_Garrison.GetLocation())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE cwmission01script
Quest __temp = self as Quest
cwmission01script kmyQuest = __temp as cwmission01script
;END AUTOCAST
;BEGIN CODE
CWScript.Log("CWMission01QuestFragment", self + "Stage 10" )

((self as quest) as CWFortSiegeMissionScript).FlagFieldCOWithActiveQuestFaction(1)

kmyquest.CWs.CWBattlePhase.SetValue(1)
kmyquest.CWs.CWThreatCombatBarksS.RegisterBattlePhaseChanged()

kmyquest.CWs.StartCWCitizensFlee(Alias_Garrison.GetLocation())
kmyquest.CWs.RegisterEventHappening(Alias_Garrison.GetLocation())

Alias_CWGarrisonEnableMarkerImperial.TryToDisable()
Alias_CWGarrisonEnableMarkerSons.TryToDisable()

kmyQuest.EnableMapMarkerAlias(Alias_MapMarkerGarrison)

setObjectiveDisplayed(10)

;<TurnOnAliases>------------------
kmyQuest.TurnOnAllyAliases()

While kmyquest.DoneTurningOnAliases == false
;do nothing
	utility.wait(1)
 	CWScript.Log("CWMission01QuestFragment", self + "Waiting for DoneTurningOnAliases != false, happens in TurnOnAliases() in CWSiegeScript.psc")	;*** WRITE TO LOG
endWhile
;</TurnOnAliases>-----------------

;CWO Stop defense courier quest if running
if kmyQuest.CWs.CWCampaignS.CWOSendForPlayerQuest.Isrunning()
	kmyQuest.CWs.CWCampaignS.CWOSendForPlayerQuest.Stop()
endIf

;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE cwmission01script
Quest __temp = self as Quest
cwmission01script kmyQuest = __temp as cwmission01script
;END AUTOCAST
;BEGIN CODE
CWScript.Log("CWMission01QuestFragment", self + "Stage 11" )

kmyquest.CWs.CWBattlePhase.SetValue(2)
kmyquest.CWs.CWThreatCombatBarksS.RegisterBattlePhaseChanged()

setObjectiveCompleted(10)
setObjectiveDisplayed(20)

kmyquest.CWStateAttackStarted.SetValue(1)
kmyQuest.MUSCombatCivilWar.Add()

kmyQuest.CWs.CWCampaignS.StartMonitors(kmyQuest)
kmyQuest.CWs.CWCampaignS.StopDisguiseQuest()

;<TurnOnAliases>------------------
kmyQuest.TurnOnEnemyAliases()

While kmyquest.DoneTurningOnAliases == false
;do nothing
	utility.wait(1)
 	CWScript.Log("CWMission01", self + "Waiting for DoneTurningOnAliases != false, happens in TurnOnAliases() in CWSiegeScript.psc")	;*** WRITE TO LOG
endWhile
;</TurnOnAliases>-----------------

kmyQuest.FriendlyShouldAttack = 1
Alias_Ally1.TryToEvaluatePackage()
Alias_Ally2.TryToEvaluatePackage()
Alias_Ally3.TryToEvaluatePackage()
Alias_Ally4.TryToEvaluatePackage()
Alias_Enemy1.TryToEvaluatePackage()
Alias_Enemy2.TryToEvaluatePackage()
Alias_Enemy3.TryToEvaluatePackage()
Alias_Enemy4.TryToEvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_3()
;BEGIN AUTOCAST TYPE cwmission01script
Quest __temp = self as Quest
cwmission01script kmyQuest = __temp as cwmission01script
;END AUTOCAST
;BEGIN CODE
CWScript.Log("CWMission01QuestFragment", self + "Stage 51" )

kmyquest.CWs.CWBattlePhase.SetValue(3)
kmyquest.CWs.CWThreatCombatBarksS.RegisterBattlePhaseChanged()

((kmyquest as quest) as CWSiegePollPlayerLocation).PlayerHasBeenToLocationOfBattle = true

kmyQuest.FriendlyShouldAttack = 0
Alias_Ally1.TryToEvaluatePackage()
Alias_Ally2.TryToEvaluatePackage()
Alias_Ally3.TryToEvaluatePackage()
Alias_Ally4.TryToEvaluatePackage()
Alias_Enemy1.TryToEvaluatePackage()
Alias_Enemy2.TryToEvaluatePackage()
Alias_Enemy3.TryToEvaluatePackage()
Alias_Enemy4.TryToEvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN AUTOCAST TYPE CWMission04Script
Quest __temp = self as Quest
CWMission01Script kmyQuest = __temp as CWMission01Script
;END AUTOCAST
;BEGIN CODE
((self as quest) as CWFortSiegeMissionScript).objectiveCompleted = 1

setObjectiveCompleted(20)

setStage(200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN AUTOCAST TYPE CWMission04Script
Quest __temp = self as Quest
CWMission01Script kmyQuest = __temp as CWMission01Script
;END AUTOCAST
;BEGIN CODE
;Successfully complete quest
CWScript.Log("CWMission01QuestFragment", self + "Stage 200" )

kmyQuest.MUSCombatCivilWar.Remove()

bool PlayerIsAttacking = kmyQuest.CWs.CWAttacker.GetValueInt() == kmyQuest.CWs.playerAllegiance

int WinningFaction = kmyQuest.CwS.playerAllegiance

if PlayerIsAttacking
    kmyQuest.AttackersHaveWon = true
    kmyquest.CWStateDefenderOutOfReinforcements.SetValue(1)
Else
    kmyQuest.DefendersHaveWon = true
    kmyquest.CWStateAttackerOutOfReinforcements.SetValue(1)
endif

((self as quest) as CWFortSiegeMissionScript).FlagFieldCOWithMissionResultFaction(1)
((self as quest) as CWFortSiegeMissionScript).FlagFieldCOWithPotentialMissionFactions(1, true)

kmyquest.CWs.CWCampaignS.registerMissionSuccess(Alias_Hold.GetLocation(), isFortBattle = False)	;if isFortBattle then we won't display the Objective for the hold again, because we've just won the campain

kmyQuest.CWs.CWCampaignS.StopMonitors()
kmyQuest.CWs.CWCampaignS.StartDisguiseQuest()

while Game.GetPlayer().IsInLocation(Alias_Garrison.GetLocation())
	CWScript.Log("CWSiegeScript", self + "FailDefenseQuest() Waiting for player to leave City before stoping Siege quest")
    utility.wait(5)
endwhile

if PlayerIsAttacking
    kmyquest.CWS.SetOwner(Alias_Garrison.GetLocation(), WinningFaction)
    if WinningFaction == kmyQuest.CWs.iImperials
        Alias_CWGarrisonEnableMarkerImperial.TryToEnableNoWait()
    Else
        Alias_CWGarrisonEnableMarkerSons.TryToEnableNoWait()
    endif
endif
kmyquest.CWs.CWCampaignS.AdvanceCampaignPhase()

stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN AUTOCAST TYPE CWMission04Script
Quest __temp = self as Quest
CWMission01Script kmyQuest = __temp as CWMission01Script
;END AUTOCAST
;BEGIN CODE
;Fail quest
CWScript.Log("CWMission01QuestFragment", self + "Stage 205" )
bool PlayerIsAttacking = kmyQuest.CWs.CWAttacker.GetValueInt() == kmyQuest.CWs.playerAllegiance
kmyQuest.MUSCombatCivilWar.Remove()

int WinningFaction = kmyQuest.CwS.getOppositeFactionInt(kmyQuest.CwS.playerAllegiance)

if PlayerIsAttacking
    kmyQuest.DefendersHaveWon = true
    kmyQuest.CWStateAttackerOutOfReinforcements.SetValue(1)
else
    kmyQuest.AttackersHaveWon = true
    kmyquest.CWStateDefenderOutOfReinforcements.SetValue(1)
endif

((self as quest) as CWFortSiegeMissionScript).FlagFieldCOWithMissionResultFaction(1, MissionFailure = true)
((self as quest) as CWFortSiegeMissionScript).FlagFieldCOWithPotentialMissionFactions(1, true)

kmyQuest.CWs.CWCampaignS.StopMonitors()

kmyQuest.CWs.CWCampaignS.StartDisguiseQuest()

while Game.GetPlayer().IsInLocation(Alias_Garrison.GetLocation())
 	CWScript.Log("CWSiegeScript", self + "FailDefenseQuest() Waiting for player to leave City before stoping Siege quest")
    utility.wait(5)
endwhile

if !PlayerIsAttacking
    kmyquest.CWS.SetOwner(Alias_Garrison.GetLocation(), WinningFaction)
    if WinningFaction == kmyQuest.CWs.iImperials
        Alias_CWGarrisonEnableMarkerImperial.TryToEnableNoWait()
    Else
        Alias_CWGarrisonEnableMarkerSons.TryToEnableNoWait()
    endif
endif

kmyQuest.CWs.CWCampaignS.AdvanceCampaignPhase()

stop()  ;if unsuccessful, stop quest... quest is also stopped in CWMission04PrisonerScript if successful and he unloads
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN AUTOCAST TYPE CWMission04Script
Quest __temp = self as Quest
CWMission01Script kmyQuest = __temp as CWMission01Script
;END AUTOCAST
;BEGIN CODE
;shut down stage --  clean up created references, etc.
;NOTE: campaign should be advanced prior to this quest stage
CWScript.Log("CWMission01QuestFragment", self + "Stage 255" )

kmyQuest.CWS.StopCWCitizensFlee()
kmyQuest.CWs.CWCampaignS.CWMission01Or02Done = true
; ; debug.traceConditional("CWMission04 stage 255 (shut down phase)", kmyquest.CWs.debugon.value)
((self as quest) as CWFortSiegeMissionScript).ProcessFieldCOFactionsOnQuestShutDown()

kmyquest.CWs.CWBattlePhase.SetValue(0)
kmyquest.CWs.CWThreatCombatBarksS.RegisterBattlePhaseChanged()

kmyquest.CWStateAttackStarted.SetValue(0)
kmyQuest.CWStateAttackerOutOfReinforcements.SetValue(0)
kmyquest.CWStateDefenderOutOfReinforcements.SetValue(0)

Alias_CWGarrisonEnableMarkerImperial.TryToDisable()
Alias_CWGarrisonEnableMarkerSons.TryToDisable()
; ; debug.traceConditional("CWMission04 stage 255: turning on complex WI interactions", kmyquest.CWs.debugon.value)
kmyquest.ToggleOffComplexWIInteractions(Alias_Garrison)
kmyquest.CWs.UnregisterEventHappening(Alias_Garrison.GetLocation())

;delete created references
;*** TO DO: When we have arrays, CreateMissionAliasedActor should put all created references to an array, then a new funciton should delete ALL of them
kmyQuest.DisableAllAliases()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
