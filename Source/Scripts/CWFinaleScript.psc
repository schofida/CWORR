Scriptname CWFinaleScript extends Quest Conditional

CWScript Property CWs  Auto  

CWFortSiegeScript Property CWFortSiegeS Auto

ReferenceAlias Property Leader Auto
ReferenceAlias Property Second Auto

ReferenceAlias Property EnemyLeader Auto
ReferenceAlias Property EnemySecond Auto

ReferenceAlias Property Door1 Auto
ReferenceAlias Property Door2 Auto
ReferenceAlias Property Door3 Auto
ReferenceAlias Property Door4 Auto
ReferenceAlias Property Door5 Auto
ReferenceAlias Property Door6 Auto
ReferenceAlias Property Door7 Auto
ReferenceAlias Property Door8 Auto
ReferenceAlias Property Door9 Auto
ReferenceAlias Property Door10 Auto

ReferenceAlias Property CrowdMarker1 Auto
ReferenceAlias Property CrowdMarker2 Auto
ReferenceAlias Property CrowdMarker3 Auto
ReferenceAlias Property CrowdMarker4 Auto
ReferenceAlias Property CrowdMarker5 Auto
ReferenceAlias Property CrowdMarker6 Auto
ReferenceAlias Property CrowdMarker7 Auto
ReferenceAlias Property CrowdMarker8 Auto
ReferenceAlias Property CrowdMarker9 Auto
ReferenceAlias Property CrowdMarker10 Auto
ReferenceAlias Property CrowdMarker11 Auto
ReferenceAlias Property CrowdMarker12 Auto
ReferenceAlias Property CrowdMarker13 Auto
ReferenceAlias Property CrowdMarker14 Auto
ReferenceAlias Property CrowdMarker15 Auto

ReferenceAlias Property CrowdMember1 Auto
ReferenceAlias Property CrowdMember2 Auto
ReferenceAlias Property CrowdMember3 Auto
ReferenceAlias Property CrowdMember4 Auto
ReferenceAlias Property CrowdMember5 Auto
ReferenceAlias Property CrowdMember6 Auto
ReferenceAlias Property CrowdMember7 Auto
ReferenceAlias Property CrowdMember8 Auto
ReferenceAlias Property CrowdMember9 Auto
ReferenceAlias Property CrowdMember10 Auto
ReferenceAlias Property CrowdMember11 Auto
ReferenceAlias Property CrowdMember12 Auto
ReferenceAlias Property CrowdMember13 Auto
ReferenceAlias Property CrowdMember14 Auto
ReferenceAlias Property CrowdMember15 Auto

LocationAlias Property AliasLocation Auto

Location Property SolitudeLocation Auto
Location Property WindhelmLocation Auto

Scene Property CWFinaleSolitudeSceneA Auto
Scene Property CWFinaleSolitudeSceneB Auto
Scene Property CWFinaleSolitudeSceneC Auto
Scene Property CWFinaleSolitudeSceneD Auto

Scene Property CWFinaleWindhelmSceneA Auto
Scene Property CWFinaleWindhelmSceneB Auto
Scene Property CWFinaleWindhelmSceneC Auto
Scene Property CWFinaleWindhelmSceneD Auto


ActorBase Property CWFinaleSoldierImperial Auto
ActorBase Property CWFinaleSoldierSons Auto

Faction Property CWImperialFactionNPC Auto
Faction Property CWSonsFactionNPC Auto

Faction Property CrimeFactionHaafingar Auto
Faction Property CrimeFactionEastmarch Auto

float Property PauseBeforeScene = 0.1 Auto

int Property ExecutePrompt Auto	Conditional hidden	;set stage 210, set in scene phase result script, used to conditionalize dialogue on Leader asking player to slay EnemyLeader

LeveledItem Property CWFinaleFactionLeaderSwordList Auto

Faction Property CWFinaleTemporaryAllies  Auto  

ReferenceAlias Property SABETME3Soldier  Auto  

Bool Property DefenseSuccessful = false Auto Hidden

Function PlayerEnteredCastle()
	setStage(100)
	
	Actor PlayerActor = Game.GetPlayer()

	CWScript.Log("CWFinaleScript", self + "PlayerEnteredCastle() Moving actors, setting up scene, and locking doors.")
	
	;schofida - call helper function instead
	LockDoors()

	bool sabetme3 = CWs.CWcampaignS.PlayerAllegianceLastStand()
	
	makeMeStopCombat(Leader)
	makeMeStopCombat(Second)
	makeMeStopCombat(EnemyLeader)
	makeMeStopCombat(EnemySecond)
	makeMeStopCombat(SABETME3Soldier)
	
	PlayerActor.StopCombat()
	PlayerActor.StopCombatAlarm()
	
	if sabetme3
		Leader.TryToMoveTo(EnemyLeader.GetRef())
		Second.TryToMoveTo(EnemySecond.GetRef())
	else
		Leader.TryToMoveTo(PlayerActor)
		Second.TryToMoveTo(PlayerActor)
	endif
	
	EnemyLeader.TryToRemoveFromFaction(CrimeFactionHaafingar)
	EnemyLeader.TryToRemoveFromFaction(CrimeFactionEastmarch)

	EnemySecond.TryToRemoveFromFaction(CrimeFactionHaafingar)
	EnemySecond.TryToRemoveFromFaction(CrimeFactionEastmarch)
	
	MakeCrowd()	;THIS MUST HAPPEN BEFORE YOU START THE SCENE as it reevals actors in running scenes, and can break the scene
	
	;wait before scene otherwise you miss the first bit of dialogue about locking the door
	Game.DisablePlayerControls(sabetme3)

	Utility.Wait(PauseBeforeScene)

	if sabetme3
		; Have the statue face the player
		ObjectReference SABETME3SoldierRef = SABETME3Soldier.GetRef()
		Actor PlayerRef = Game.GetPlayer()
		PlayerRef.MoveTo(SABETME3SoldierRef)
		float zOffset = SABETME3SoldierRef.GetHeadingAngle(PlayerRef)
		SABETME3SoldierRef.SetAngle(SABETME3SoldierRef.GetAngleX(), SABETME3SoldierRef.GetAngleY(), SABETME3SoldierRef.GetAngleZ() + zOffset)
		ObjectReference LeaderRef = Leader.GetRef()
		zOffset = PlayerRef.GetHeadingAngle(LeaderRef)
		PlayerRef.SetAngle(PlayerRef.GetAngleX(), PlayerRef.GetAngleY(), PlayerRef.GetAngleZ() + zOffset)
	endif
	
	startSceneA()
	;TURN OFF THE FORT SIEGE
	CWFortSiegeS.DisableAllAliases()

	;CWO Reset Troop crime in case of friendly fire
	CWs.CWCampaignS.cwResetCrime()
	
; 	CWScript.Log("CWFinaleScript", "PlayerEnteredCastle() calling stop() on CWFortSiege")
	((CWFortSiegeS AS Quest) As CWReinforcementControllerScript).StopSpawning()
	((CWs.CWFortSiegeCapital AS Quest) As CWReinforcementControllerScript).StopSpawning()
	CWs.CWCampaignS.SetMonitorMajorCitySiegeStopping()	;this doesn't finish shutting down until after the player leaves.
	
EndFunction

Function PlayerLastStandWasSuccessful()
	CWScript.Log("CWFinaleScript", self + "PlayerLastStandWasSuccessful() completing the quest and siege.")
	DefenseSuccessful = true
	setStage(100)

	;CWO Reset Troop crime in case of friendly fire
	CWs.CWCampaignS.cwResetCrime()

; 	CWScript.Log("CWFinaleScript", "PlayerEnteredCastle() calling stop() on CWFortSiege")
	((CWFortSiegeS AS Quest) As CWReinforcementControllerScript).StopSpawning()
	((CWs.CWFortSiegeCapital AS Quest) As CWReinforcementControllerScript).StopSpawning()
	CWs.CWCampaignS.SetMonitorMajorCitySiegeStopping()	;this doesn't finish shutting down until after the player leaves.
	
	SetStage(330)
endfunction

function EnemySecondDied()
; 	CWScript.Log("CWFinaleScript", self + "EnemySecondDied() waiting for leader to be in bleedout, then will stop combat and start scene.")
	
	int waitingFor

	;CWO Unregister for update. Scene gonna start
	UnregisterForUpdate()
	
	Actor EnemyLeaderActor = EnemyLeader.GetActorReference()
	
	while EnemyLeaderActor.isBleedingOut() == False
		Utility.wait(1)
		waitingFor += 1
; 		CWScript.Log("CWFinaleScript", self + "EnemySecondDied() waiting for leader to be in bleedout. Waiting for " + waitingFor)
	
	EndWhile


	setStage(200)

	Actor PlayerActor = Game.GetPlayer()
	
	EnemyLeader.TryToRemoveFromFaction(CrimeFactionHaafingar)
	EnemyLeader.TryToRemoveFromFaction(CrimeFactionEastmarch)
	
	EnemyLeaderActor.RemoveFromFaction(CWImperialFactionNPC)
	EnemyLeaderActor.RemoveFromFaction(CWSonsFactionNPC)
	
	makeMeStopCombat(Leader)
	makeMeStopCombat(Second)
	makeMeStopCombat(EnemyLeader)
	makeMeStopCombat(SABETME3Soldier)
	
	PlayerActor.StopCombat()
	PlayerActor.StopCombatAlarm()

	CWFinaleSolitudeSceneA.stop()

	if CWs.CwCampaignS.PlayerAllegianceLastStand() && CWs.playerAllegiance == CWs.iSons
		SetStage(310)
	else
		Utility.Wait(PauseBeforeScene)

		startSceneB()
	endif
	
EndFunction

function lockDoors()
	lockMe(Door1)
	lockMe(Door2)
	lockMe(Door3)
	lockMe(Door4)
	lockMe(Door5)
	lockMe(Door6)
	lockMe(Door7)
	lockMe(Door8)
	lockMe(Door9)
	lockMe(Door10)

EndFunction

function unlockDoors()
	UnlockMe(Door1)
	UnlockMe(Door2)
	UnlockMe(Door3)
	UnlockMe(Door4)
	UnlockMe(Door5)
	UnlockMe(Door6)
	UnlockMe(Door7)
	UnlockMe(Door8)
	UnlockMe(Door9)
	UnlockMe(Door10)

EndFunction

function lockMe(ReferenceAlias DoorToLock, int lockLevel = 255)
	ObjectReference DoorRef = DoorToLock.GetReference()

	;USKP 2.0.2 - These doors can be optional.
	if( DoorRef )
		DoorRef.SetLockLevel(lockLevel)
		DoorRef.Lock()
	EndIf

EndFunction

function UnlockMe(ReferenceAlias DoorToUnlock, int UnlockLevel = 255)
	ObjectReference DoorRef = DoorToUnlock.GetReference()

	;USKP 2.0.2 - These doors can be optional.
	if( DoorRef )
		DoorRef.lock(false)
	EndIf

EndFunction

function makeMeStopCombat(ReferenceAlias ActorAliasToChillOut)

	Actor ActorToChillOut = ActorAliasToChillOut.GetActorReference()
	if ActorToChillOut == None
		return
	endif
	ActorToChillOut.EvaluatePackage()	;should eval to a ignore combat package	
	ActorToChillOut.stopCombat()
	ActorToChillOut.StopCombatAlarm()

	

EndFunction

function makeMeStartCombat(Actor Actor1, Actor Actor2)

	Actor1.EvaluatePackage()	
	Actor2.EvaluatePackage()
	Actor1.StartCombat(Actor2)
	Actor2.StartCombat(Actor1)

EndFunction

function startSceneA()
	Location myLocation = AliasLocation.GetLocation()
	
	if myLocation == SolitudeLocation
		CWFinaleSolitudeSceneA.start()
		
	Else	;we'll assume it's windhelm
		CWFinaleWindhelmSceneA.start()
	
	EndIf

EndFunction

function startSceneB()
	Location myLocation = AliasLocation.GetLocation()
	
	if myLocation == SolitudeLocation
		CWFinaleSolitudeSceneB.start()
		
	Else	;we'll assume it's windhelm
		CWFinaleWindhelmSceneB.start()
	
	EndIf

EndFunction

function MakeCrowd()
; 	CWScript.Log("CWFinaleScript", self + "MakeCrowd() will create crowd aliases.")
	
	MakeCrowdMember(CrowdMarker1, CrowdMember1)
	MakeCrowdMember(CrowdMarker2, CrowdMember2)
	MakeCrowdMember(CrowdMarker3, CrowdMember3)
	MakeCrowdMember(CrowdMarker4, CrowdMember4)
	MakeCrowdMember(CrowdMarker5, CrowdMember5)
	MakeCrowdMember(CrowdMarker6, CrowdMember6)
	MakeCrowdMember(CrowdMarker7, CrowdMember7)
	MakeCrowdMember(CrowdMarker8, CrowdMember8)
	MakeCrowdMember(CrowdMarker9, CrowdMember9)
	MakeCrowdMember(CrowdMarker10, CrowdMember10)
	MakeCrowdMember(CrowdMarker11, CrowdMember11)
	MakeCrowdMember(CrowdMarker12, CrowdMember12)
	MakeCrowdMember(CrowdMarker13, CrowdMember13)
	MakeCrowdMember(CrowdMarker14, CrowdMember14)
	MakeCrowdMember(CrowdMarker15, CrowdMember15)
	
EndFunction

function RemoveCrowd()

; 	CWScript.Log("CWFinaleScript", self + "MakeCrowd() will delete crowd aliases.")
	if CrowdMember1.GetReference() != none
		CrowdMember1.GetReference().Delete()
	endif	
	if CrowdMember2.GetReference() != none
		CrowdMember2.GetReference().Delete()
	endif	
	if CrowdMember3.GetReference() != none
		CrowdMember3.GetReference().Delete()
	endif	
	if CrowdMember4.GetReference() != none
		CrowdMember4.GetReference().Delete()
	endif	
	if CrowdMember5.GetReference() != none
		CrowdMember5.GetReference().Delete()
	endif	
	if CrowdMember6.GetReference() != none
		CrowdMember6.GetReference().Delete()
	endif	
	if CrowdMember7.GetReference() != none
		CrowdMember7.GetReference().Delete()
	endif	
	if CrowdMember8.GetReference() != none
		CrowdMember8.GetReference().Delete()
	endif	
	if CrowdMember9.GetReference() != none
		CrowdMember9.GetReference().Delete()
	endif	
	if CrowdMember10.GetReference() != none
		CrowdMember10.GetReference().Delete()
	endif	
	if CrowdMember11.GetReference() != none
		CrowdMember11.GetReference().Delete()
	endif	
	if CrowdMember12.GetReference() != none
		CrowdMember12.GetReference().Delete()
	endif	
	if CrowdMember13.GetReference() != none
		CrowdMember13.GetReference().Delete()
	endif	
	if CrowdMember14.GetReference() != none
		CrowdMember14.GetReference().Delete()
	endif	
	if CrowdMember15.GetReference() != none
		CrowdMember15.GetReference().Delete()
	endif	
	if SABETME3Soldier.GetReference() != none
		SABETME3Soldier.GetReference().Delete()	
	endif
EndFunction

Function MakeCrowdMember(ReferenceAlias MarkerAlias, ReferenceAlias MemberAlias)
	ObjectReference MarkerRef = MarkerAlias.GetReference()
	
	if MarkerRef
		bool sabetme3 = CWs.CWCampaignS.PlayerAllegianceLastStand()
		if (CWs.PlayerAllegiance == CWs.iImperials && !sabetme3) || (CWs.PlayerAllegiance == CWs.iSons && sabetme3)
			MemberAlias.ForceRefTo(MarkerRef.PlaceActorAtMe(CWFinaleSoldierImperial))
		
		Elseif (CWs.PlayerAllegiance == CWs.iSons && !sabetme3) || (CWs.PlayerAllegiance == CWs.iImperials && sabetme3)
			MemberAlias.ForceRefTo(MarkerRef.PlaceActorAtMe(CWFinaleSoldierSons))
			
		Else
; 			CWScript.Log("CWFinaleScript", self + "MakeCrowdMember() found unexpect PlayerAllegiance, expected 1 or 2. Got " + CWs.PlayerAllegiance)
		EndIf
		
	EndIf

EndFunction

Event OnUpdate()
	;CWO Adding onUpdate routine to kick NPCs in case they stop combat
	Leader.TryToEvaluatePackage()
	Second.TryToEvaluatePackage()
	EnemyLeader.TryToEvaluatePackage()
	EnemySecond.TryToEvaluatePackage()
	if CWs.CWCampaignS.CWs.CWCampaignS.PlayerAllegianceLastStand()
		SABETME3Soldier.TryToEvaluatePackage()
	endif
EndEvent

Function TryToFixQuest()
	debug.notification("Trying to fix CWFinale quest")
	if GetStageDone(100) == false
		PlayerEnteredCastle()
		return
	endif
	if GetStage() < 150
		CWFinaleSolitudeSceneA.Stop()
		CWFinaleWindhelmSceneA.Stop()
		SetStage(150)
		return
	endif
	if GetStage() < 200
		EnemySecondDied()
		return
	endif
	if GetStage() < 310
		CWFinaleSolitudeSceneB.Stop()
		CWFinaleWindhelmSceneB.Stop()
		SetStage(310)
		return
	endif
	if GetStage() < 320
		SetStage(320)
		return
	endif
	if GetStage() < 330
		SetStage(330)
		return
	endif
	if GetStage() < 340
		CWFinaleSolitudeSceneC.Stop()
		CWFinaleWindhelmSceneC.Stop()
		SetStage(340)
		return
	endif
endfunction