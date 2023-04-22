Scriptname CWAttackCityDragonReachDoor extends ReferenceAlias  

CWScript Property CWs Auto

Actor Property GalmarRef Auto
Actor Property RalofRef Auto
Actor Property RikkeRef Auto
Actor Property HadvarRef Auto

Faction Property CWImperialFaction Auto
Faction Property CWSonsFaction Auto

Event OnActivate(ObjectReference akActionRef)

	Actor PlayerRef = Game.GetPlayer()

	if akActionRef == PlayerRef
	
		;temporarily add them to the Imperial faction so the stop combat prevents people from following them into the castle
		;remove them in CWAttackCityConfrontationTriggerScript so the people inside the castle will agro on them
		;CWO but not if the player is an imperial trying to reclaim Whiterun
		if CWs.PlayerAllegiance == CWs.iImperials
			PlayerRef.AddToFaction(CWSonsFaction)
			RikkeRef.AddToFaction(CWSonsFaction)
			HadvarRef.AddToFaction(CWSonsFaction)
			PlayerRef.StopCombatAlarm()
			RikkeRef.StopCombatAlarm()
			HadvarRef.StopCombatAlarm()
		else
			PlayerRef.AddToFaction(CWImperialFaction)
			GalmarRef.AddToFaction(CWImperialFaction)
			RalofRef.AddToFaction(CWImperialFaction)
			PlayerRef.StopCombatAlarm()
			GalmarRef.StopCombatAlarm()
			RalofRef.StopCombatAlarm()
		endif

		
	EndIf

EndEvent
