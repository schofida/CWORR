Scriptname CWMission06TurncoatScript extends ReferenceAlias  
{Checks for death and calls function to decrement property on parent quest and set stage if property is zero.}

Event OnDeath(Actor akKiller)
	UnregisterForUpdate()
	(GetOwningQuest() as CWMission06Script).DecrementTurncoatAliveCount()

EndEvent

Event OnUpdate()
	If GetOwningQuest().GetStage() < 11 ; can be set elsewhere like another soldier's script
		If GetReference().GetDistance(Game.GetPlayer()) < 300
			GetOwningQuest().setStage(11)
			UnRegisterForUpdate() 
		EndIf
	
	Else
	
		UnRegisterForUpdate() 
		
	EndIf

EndEvent

Function PollForPlayer()
	RegisterForUpdate(2)
EndFunction
