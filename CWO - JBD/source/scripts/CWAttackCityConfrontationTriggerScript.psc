Scriptname CWAttackCityConfrontationTriggerScript extends ReferenceAlias  
{Script on ConfrontationTriggerbox alias in CWAttackCity quest - starts the confrontation scene with the Jarl, housecarl, and bodyguards}

CWScript Property CWs Auto

int Property StageToCallToStartConfrontationScene Auto


Actor Property GalmarRef Auto
Actor Property RalofRef Auto
Actor Property RikkeRef Auto
Actor Property HadvarRef Auto

Faction Property CWImperialFaction Auto
Faction Property CWSonsFaction Auto

Event OnTriggerEnter(ObjectReference akActionRef)

; 	debug.trace("CWAttackCityConfrontationTriggerScript OnTriggerEnter()")

	actor actorRef = akActionRef as Actor
	actor PlayerRef = Game.GetPlayer()
	
	if GetOwningQuest().GetStageDone(StageToCallToStartConfrontationScene) == False && akActionRef == PlayerRef
		GetOwningQuest().setStage(StageToCallToStartConfrontationScene)
	endif
	
	if CWs.playerAllegiance == CWs.iImperials
		;***ASSUMES THIS IS WHITERUN BECAUSE THATS THE ONLY PLACE FOR SIEGES NOW***
		;See - CWAttackCityDragonReachDoor for why we are doing this
		PlayerRef.RemoveFromFaction(CWSonsFaction)
		RikkeRef.RemoveFromFaction(CWSonsFaction)
		HadvarRef.RemoveFromFaction(CWSonsFaction)
	else
		;***ASSUMES THIS IS WHITERUN BECAUSE THATS THE ONLY PLACE FOR SIEGES NOW***
		;See - CWAttackCityDragonReachDoor for why we are doing this
		PlayerRef.RemoveFromFaction(CWImperialFaction)
		GalmarRef.RemoveFromFaction(CWImperialFaction)
		RalofRef.RemoveFromFaction(CWImperialFaction)
	endIf	
	
EndEvent

