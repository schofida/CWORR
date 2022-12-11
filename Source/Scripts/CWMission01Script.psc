Scriptname CWMission01Script extends CWSiegeScript conditional
{Extends CWMissionScript which extends Quest}

;NOTE: Some mission tracking properties are common to all CWMission quests. See CWMissionScript for details

int Property FriendlyShouldAttack Auto	Conditional	;0 = unset, 1 = pick package to travel to enemy soldier

bool DisabledFastTravel = false 

LocationAlias Property Garrison Auto	

GlobalVariable Property CWOGarrisonReinforcements Auto

ObjectReference Property EnemySpawnMarker Auto

;"Array" of aliases
;rather than declaring these again on all siege scripts, we will create a function that the quest fragment can pass in the Alias_XXX aliases and put them in the "array"

;Attacker/Defender aliases (the ones pointing at specific references in the world who have the link refs)
ReferenceAlias ImperialSoldier1
ReferenceAlias ImperialSoldier2
ReferenceAlias ImperialSoldier3
ReferenceAlias ImperialSoldier4

ReferenceAlias SonsSoldier1
ReferenceAlias SonsSoldier2
ReferenceAlias SonsSoldier3
ReferenceAlias SonsSoldier4

;Attacker/Defender Aliases (the ones with the packages and scripts to make the sieges work, the above aliases will be shoved into these depending on who is attacking/defending)
ReferenceAlias Ally1
ReferenceAlias Ally2
ReferenceAlias Ally3
ReferenceAlias Ally4

ReferenceAlias Enemy1
ReferenceAlias Enemy2
ReferenceAlias Enemy3
ReferenceAlias Enemy4

int AllyCounter = 0
int EnemyCounter = 0


;Register functions essentially shove the aliases from the quest into arrays to be used more conveniently by other function calls

;Register Imperial aliases
Function RegisterImperialAliases(ReferenceAlias RefAlias1, ReferenceAlias RefAlias2, ReferenceAlias RefAlias3, ReferenceAlias RefAlias4 )
 	CWScript.Log("CWSiegeScript", self + "calling RegisterGarrisonAliases()" +  RefAlias1 + "," + RefAlias2 + "," + RefAlias3 + "," + RefAlias4 )
	ImperialSoldier1 = RefAlias1
	ImperialSoldier2 = RefAlias2
	ImperialSoldier3 = RefAlias3
	ImperialSoldier4 = RefAlias4

EndFunction

Function RegisterSonsAliases(ReferenceAlias RefAlias1, ReferenceAlias RefAlias2, ReferenceAlias RefAlias3, ReferenceAlias RefAlias4 )
	CWScript.Log("CWSiegeScript", self + "calling RegisterGarrisonAliases()" +  RefAlias1 + "," + RefAlias2 + "," + RefAlias3 + "," + RefAlias4 )
   SonsSoldier1 = RefAlias1
   SonsSoldier2 = RefAlias2
   SonsSoldier3 = RefAlias3
   SonsSoldier4 = RefAlias4

EndFunction

Function RegisterAllyAliases(ReferenceAlias RefAlias1, ReferenceAlias RefAlias2, ReferenceAlias RefAlias3, ReferenceAlias RefAlias4 )
	CWScript.Log("CWSiegeScript", self + "calling RegisterAllyAliases()" +  RefAlias1 + "," + RefAlias2 + "," + RefAlias3 + "," + RefAlias4 )
   Ally1 = RefAlias1
   Ally2 = RefAlias2
   Ally3 = RefAlias3
   Ally4 = RefAlias4

EndFunction

Function RegisterEnemyAliases(ReferenceAlias RefAlias1, ReferenceAlias RefAlias2, ReferenceAlias RefAlias3, ReferenceAlias RefAlias4 )
	CWScript.Log("CWSiegeScript", self + "calling RegisterEnemyAliases()" +  RefAlias1 + "," + RefAlias2 + "," + RefAlias3 + "," + RefAlias4 )
   Enemy1 = RefAlias1
   Enemy2 = RefAlias2
   Enemy3 = RefAlias3
   Enemy4 = RefAlias4

EndFunction

;Register Sons aliases
Function SetUpAllyEnemyAliasas()
	CWScript.Log("CWSiegeScript", self + "calling SetUpAllyEnemyAliasas()")
	if CWs.PlayerAllegiance == CWs.iImperials
		SetupAlias(ImperialSoldier1, Ally1)
		SetupAlias(ImperialSoldier2, Ally2)
		SetupAlias(ImperialSoldier3, Ally3)
		SetupAlias(ImperialSoldier4, Ally4)
		SetupAlias(SonsSoldier1, Enemy1)
		SetupAlias(SonsSoldier2, Enemy2)
		SetupAlias(SonsSoldier3, Enemy3)
		SetupAlias(SonsSoldier4, Enemy4)
	Else
		SetupAlias(SonsSoldier1, Ally1)
		SetupAlias(SonsSoldier2, Ally2)
		SetupAlias(SonsSoldier3, Ally3)
		SetupAlias(SonsSoldier4, Ally4)
		SetupAlias(ImperialSoldier1, Enemy1)
		SetupAlias(ImperialSoldier2, Enemy2)
		SetupAlias(ImperialSoldier3, Enemy3)
		SetupAlias(ImperialSoldier4, Enemy4)		
	endif
EndFunction

;Register Attacker Aliases
Function SetupAlias(ReferenceAlias Source, ReferenceAlias Destination )
 	CWScript.Log("CWSiegeScript", self + "calling SetupAlias()" + Source )
	Destination.ForceRefTo(Source.GetActorRef())
EndFunction

Function RegisterAliasesWithCWReinforcementScript(Location SiegeLocationAttackPoint)
	CWScript.Log("CWSiegeScript", self + "calling RegisterAliasesWithCWReinforcementScript()")

	CWReinforcementControllerScript CWReinforcementControllerS = (self as quest ) as CWReinforcementControllerScript

	CWReinforcementControllerS.RegisterAttackPoint(SiegeLocationAttackPoint)
	
	CWReinforcementControllerS.RegisterAlias(Enemy1)
	CWReinforcementControllerS.RegisterAlias(Enemy2)
	CWReinforcementControllerS.RegisterAlias(Enemy3)
	CWReinforcementControllerS.RegisterAlias(Enemy4)

EndFunction


function DisableAllAliases()
 	CWScript.Log("CWSiegeScript", self + "calling DisableAllAliases()")
	DisableImperialSonsAliases()

EndFunction

Function SetUpAliases(Location garrisonLocation)
	DoneSettingUpAliases = false

 	CWScript.Log("CWSiegeScript", self + "calling SetUpAliases()")
		
	DisableImperialSonsAliases()		;disables ALL the soldiers
	SetUpAllyEnemyAliasas()		;shoves soldiers into Attacker/Defender aliases depending on the player's faction and which faction is attacking
	
	LogAttackDefenderAliases()			;for debugging
	
	DoneSettingUpAliases = true	
	
EndFunction

function TurnOnAllyAliases()
	DoneTurningOnAliases = false

 	CWScript.Log("CWSiegeScript", self + "calling TurnOnAliases()")
	
	EnableAllyAliases()		;Enables the Attacker/Defender aliases
	ResetAllyAliases()		;Resets the Attacker/Defender aliases
	
	DoneTurningOnAliases = true
	
EndFunction

function TurnOnEnemyAliases()
	DoneTurningOnAliases = false

 	CWScript.Log("CWSiegeScript", self + "calling TurnOnAliases()")
	
	EnableEnemyAliases()		;Enables the Attacker/Defender aliases
	ResetEnemyAliases()		;Resets the Attacker/Defender aliases
	
	DoneTurningOnAliases = true
	
EndFunction

Function LogAttackDefenderAliases()
	logAlias(Ally1)
	logAlias(Ally2)
	logAlias(Ally3)
	logAlias(Ally4)
	
	logAlias(Enemy1)
	logAlias(Enemy2)
	logAlias(Enemy3)
	logAlias(Enemy4)
	
EndFunction

function logAlias(ReferenceAlias AliasToPrintToLog)
 	CWScript.Log("CWSiegeScript", self + "logAlias()" + AliasToPrintToLog + " is REFERENCE " + AliasToPrintToLog.GetReference())
EndFunction


Function DisableImperialSonsAliases()
 	CWScript.Log("CWSiegeScript", self + "calling DisableImperialSonsAliases()")
	tryToDisableAlias(ImperialSoldier1)
	tryToDisableAlias(ImperialSoldier2)
	tryToDisableAlias(ImperialSoldier3)
	tryToDisableAlias(ImperialSoldier4)

	tryToDisableAlias(SonsSoldier1)
	tryToDisableAlias(SonsSoldier2)
	tryToDisableAlias(SonsSoldier3)
	tryToDisableAlias(SonsSoldier4)

EndFunction


function EnableAllyAliases()
 	CWScript.Log("CWSiegeScript", self + "calling EnableAllyAliases()")

	TryToEnableAlias(Ally1)
	TryToEnableAlias(Ally2)
	TryToEnableAlias(Ally3)
	TryToEnableAlias(Ally4)
	
EndFunction

function EnableEnemyAliases()
	CWScript.Log("CWSiegeScript", self + "calling EnableEnemyAliases()")

	TryToEnableAlias(Enemy1)
	TryToEnableAlias(Enemy2)
	TryToEnableAlias(Enemy3)
	TryToEnableAlias(Enemy4)

endfunction

Function ResetAllyAliases()
 	CWScript.Log("CWSiegeScript", self + "calling ResetAllyAliases()")

	TryToResetAlias(Ally1)
	TryToResetAlias(Ally2)
	TryToResetAlias(Ally3)
	TryToResetAlias(Ally4)

EndFunction

Function ResetEnemyAliases()
	CWScript.Log("CWSiegeScript", self + "calling ResetEnemyAliases()")

	TryToResetAlias(Enemy1)
	TryToResetAlias(Enemy2)
	TryToResetAlias(Enemy3)
	TryToResetAlias(Enemy4)

EndFunction

function SetEnemyPools()
	if CWs.CWAttacker.GetValueInt() == CWs.PlayerAllegiance
		SetPoolDefenderOnCWReinforcementScript(CWOGarrisonReinforcements.GetValueInt())
		SetPoolAttackerOnCWReinforcementScript(10, 1.0, 1.0, true)
	else
		SetPoolAttackerOnCWReinforcementScript(CWOGarrisonReinforcements.GetValueInt())
		SetPoolDefenderOnCWReinforcementScript(10, 1.0, 1.0, true)
	endif
endfunction

function TryToFixQuest()
	debug.notification("Trying to fix CWMission01 quest")
	if GetStage() == 0
		SetStage(10)
	elseif GetStage() == 10
		SetStage(11)
	elseif GetStage() == 11 || GetStage() == 51
		SetStage(100)
	elseif GetStage() == 100
		SetStage(200)
	elseif GetStage() == 200
		Stop()
	endif
	debug.notification("Done advancing CWMission01 quest")
endfunction

function EnableMapMarkerAlias(ReferenceAlias MapMarkerAlias)
	
	ObjectReference mapMarkerRef = MapMarkerAlias.GetReference()
	
	if mapMarkerRef
		mapMarkerRef.AddToMap(False)
	Else
 		CWScript.Log("CWMissionScript", self + "WARNING: EnableMapMarkerAlias([" + MapMarkerAlias + "]) is empty.", 2)
	
	EndIf

EndFunction