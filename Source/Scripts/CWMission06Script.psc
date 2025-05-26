Scriptname CWMission06Script extends CWMissionScript  Conditional
{Extends CWMissionScript which extends Quest}

Scene Property CWMission06ImperialScene  Auto  

Scene Property CWMission06SonsScene  Auto  

int Property KillLoyalists  Auto hidden Conditional
{1 = player suggested they kill the loyalists}

ReferenceAlias Property TurncoatLeader Auto

LocationAlias Property CWCampEnemy Auto

Actor Property PlayerRef Auto

Keyword Property LocTypeHabitation Auto

Faction Property CWPlayerAlly Auto

int property TurncoatAliveCount auto Conditional hidden ;set in stage 0

int Property LoyalistAliveCount auto Conditional hidden ;set in stage 0 by calling getLoyalistAliveCount() Function

ActorBase Property CWMission06LoyalistLeaderImperial auto
ActorBase Property CWMission06DissaffectSoldierImperial1 auto

ActorBase Property CWMission06LoyalistLeaderSons auto
ActorBase Property CWMission06DissaffectSoldierSons1 auto

Outfit Property CWMission06TurncoatGuardSonsOutfit auto
Outfit Property CWMission06TurncoatGuardImperialOutfit auto

Faction Property CWMission06LoyalistSoldierFaction Auto

ObjectReference Property CWCampEnemyEnable Auto

Event OnUpdate()

; ;	debug.trace("TurncoatLeader.GetReference():" + TurncoatLeader.GetReference())
; ;	debug.trace("TurncoatLeader.GetReference().GetParentCell():"+ TurncoatLeader.GetReference().GetParentCell())
; ;	debug.trace("TurncoatLeader.GetReference().GetParentCell().IsInterior():"+ TurncoatLeader.GetReference().GetParentCell().IsInterior())
	

	;if we are at the correct stage, the TurncoatLeader is outside, and the player is in the same location, then start the scene.
	if GetStage() >= 10 && GetStage() < 20
		if PlayerRef.GetDistance(TurncoatLeader.GetReference()) < 750
			if CWs.PlayerAllegiance == CWs.iImperials
				CWMission06ImperialScene.start()
			Else
				CWMission06SonsScene.start()
			endif
		else
			registerForSingleUpdate(2)
		endif
	else
		registerForSingleUpdate(2)
	EndIf

EndEvent

Function SetInitialLoyalistAliveCount( \
	ReferenceAlias LoyalistLeader, \
	ReferenceAlias Loyalist1, \
	ReferenceAlias Loyalist2, \
	ReferenceAlias Loyalist3, \
	ReferenceAlias Loyalist4, \
	ReferenceAlias Loyalist5, \
	ReferenceAlias Loyalist6, \
	ReferenceAlias Loyalist7, \
	ReferenceAlias Loyalist8, \
	ReferenceAlias Loyalist9, \
	ReferenceAlias Loyalist10, \
	ReferenceAlias Loyalist11, \
	ReferenceAlias Loyalist12 )
{Call once when quest starts to establish the LoyalistAliveCount property value}

;*** IF THE NUMBER OF LOYALIST ALIASES CHANGES, WE NEED TO CHANGE THIS FUNCTION ***

	LoyalistAliveCount = 0
	
	if Loyalist1.GetReference()
		LoyalistAliveCount += 1
	EndIf
	if Loyalist2.GetReference()
		LoyalistAliveCount += 1
	EndIf
	if Loyalist3.GetReference()
		LoyalistAliveCount += 1
	EndIf
	if Loyalist4.GetReference()
		LoyalistAliveCount += 1
	EndIf
	if Loyalist5.GetReference()
		LoyalistAliveCount += 1
	EndIf
	if Loyalist6.GetReference()
		LoyalistAliveCount += 1
	EndIf
	if Loyalist7.GetReference()
		LoyalistAliveCount += 1
	EndIf
	if Loyalist8.GetReference()
		LoyalistAliveCount += 1
	EndIf
	if Loyalist9.GetReference()
		LoyalistAliveCount += 1
	EndIf
	if Loyalist10.GetReference()
		LoyalistAliveCount += 1
	EndIf
	if Loyalist11.GetReference()
		LoyalistAliveCount += 1
	EndIf
	if Loyalist12.GetReference()
		LoyalistAliveCount += 1
	EndIf
	
	TurnCoatAliveCount = 3
	
EndFunction

Function DecrementLoyalistAliveCount()
	LoyalistAliveCount -= 1
	
	if loyalistAliveCount == 0
		setStage(100)
	EndIf
	
EndFunction

function DecrementTurncoatAliveCount()
	TurnCoatAliveCount -= 1
	
	if TurncoatAliveCount == 0
		setStage(205)
	EndIf
	
EndFunction

function processPreRevoltFactions(ReferenceAlias AliasToProcess)

	Actor ActorRef = AliasToProcess.GetActorReference()

	if ActorRef == none
		return
	endif
	
	ActorRef.RemoveFromFaction(CWs.CWImperialFactionNPC)
	ActorRef.RemoveFromFaction(CWs.CWSonsFactionNPC)
	ActorRef.RemoveFromFaction(CWs.CWImperialFaction)
	ActorRef.RemoveFromFaction(CWs.CWSonsFaction)
	ActorRef.RemoveFromFaction(CWs.IsGuardFaction)
	ActorRef.addToFaction(CWs.CWDisaffectedSoldierFaction)

	giveNewOutfit(AliasToProcess.GetActorRef(), true)

EndFunction

function processPostRevoltFactions(ReferenceAlias AliasToProcess)

	Actor ActorRef = AliasToProcess.GetActorReference()

	if actorref == none
		return
	endif
	
	if CWs.PlayerAllegiance == CWs.iImperials
		ActorRef.addToFaction(CWs.CWImperialFactionNPC)
		ActorRef.addToFaction(CWs.CWImperialFaction)
		ActorRef.addToFaction(CWs.CrimeFactionImperial)
		ActorRef.SetCrimeFaction(CWs.CrimeFactionImperial)
		
	Else
	
		ActorRef.addToFaction(CWs.CWSonsFactionNPC)
		ActorRef.addToFaction(CWs.CWSonsFaction)
		ActorRef.addToFaction(CWs.CrimeFactionSons)
		ActorRef.SetCrimeFaction(CWs.CrimeFactionSons)
	
	EndIf
	
	ActorRef.RemoveFromFaction(CWs.CWDisaffectedSoldierFaction)
	ActorRef.addToFaction(CWs.IsGuardFaction)

EndFunction

function giveNewOutfit(Actor ActorRef, bool GiveOpposite)

	if (CWs.PlayerAllegiance == CWs.iImperials && !GiveOpposite) || (CWs.PlayerAllegiance == CWs.iSons && GiveOpposite)
		ActorRef.setOutfit(CWMission06TurncoatGuardImperialOutfit)
			
	Else
		ActorRef.setOutfit(CWMission06TurncoatGuardSonsOutfit)
		
	EndIf

EndFunction

function CleanUpLoyalistFactions(ReferenceAlias Loyalist1, \
		ReferenceAlias Loyalist2, \
		ReferenceAlias Loyalist3, \
		ReferenceAlias Loyalist4, \
		ReferenceAlias Loyalist5, \
		ReferenceAlias Loyalist6, \
		ReferenceAlias Loyalist7, \
		ReferenceAlias Loyalist8, \
		ReferenceAlias Loyalist9, \
		ReferenceAlias Loyalist10, \
		ReferenceAlias Loyalist11, \
		ReferenceAlias Loyalist12 )
	Loyalist1.TryToRemoveFromFaction(CWPlayerAlly)
	Loyalist2.TryToRemoveFromFaction(CWPlayerAlly)
	Loyalist3.TryToRemoveFromFaction(CWPlayerAlly)
	Loyalist4.TryToRemoveFromFaction(CWPlayerAlly)
	Loyalist5.TryToRemoveFromFaction(CWPlayerAlly)
	Loyalist6.TryToRemoveFromFaction(CWPlayerAlly)
	Loyalist7.TryToRemoveFromFaction(CWPlayerAlly)
	Loyalist8.TryToRemoveFromFaction(CWPlayerAlly)
	Loyalist9.TryToRemoveFromFaction(CWPlayerAlly)
	Loyalist10.TryToRemoveFromFaction(CWPlayerAlly)
	Loyalist11.TryToRemoveFromFaction(CWPlayerAlly)
	Loyalist12.TryToRemoveFromFaction(CWPlayerAlly)

	Loyalist1.TryToEvaluatePackage()
	Loyalist2.TryToEvaluatePackage()
	Loyalist3.TryToEvaluatePackage()
	Loyalist4.TryToEvaluatePackage()
	Loyalist5.TryToEvaluatePackage()
	Loyalist6.TryToEvaluatePackage()
	Loyalist7.TryToEvaluatePackage()
	Loyalist8.TryToEvaluatePackage()
	Loyalist9.TryToEvaluatePackage()
	Loyalist10.TryToEvaluatePackage()
	Loyalist11.TryToEvaluatePackage()
	Loyalist12.TryToEvaluatePackage()
endfunction

function AddDisaffectedSoldierToPotentialAlly(ReferenceAlias refAlias)
	if refAlias.GetActorReference() != none && !refAlias.GetActorReference().IsDead()
		refAlias.GetActorRef().ResetHealthAndLimbs()
		giveNewOutfit(refAlias.GetActorRef(), false)
		cws.CWAlliesS.AddPotentialAlly(refAlias.GetActorRef(), \
			AllowedInHaafingar = False, \
			AllowedInReach = True, \
			AllowedInHjaalmarch = True, \
			AllowedInWhiterun = True, \
			AllowedInFalkreath = True, \
			AllowedInPale = True, \
			AllowedInWinterhold = True, \
			AllowedInEastmarch = False, \
			AllowedInRift = True, \
			ImperialsOnly = CWs.PlayerAllegiance == CWs.iImperials, \
			SonsOnly = CWs.PlayerAllegiance == CWs.iSons)
	endif
EndFunction

function TryToFixQuest()
	debug.notification("Trying to fix CWMission06 quest")
	if GetStage() == 0
		SetStage(10)
	elseif GetStage() == 10
		SetStage(20)
	elseif GetStage() == 20 && Game.GetPlayer().IsInLocation(CWs.CWCampaignS.EnemyCamp.GetLocation())
		SetStage(100)
	elseif GetStage() == 100
		SetStage(200)
	elseif GetStage() == 200
		Stop()
	endif
	debug.notification("Done advancing CWMission06 quest")	
endfunction