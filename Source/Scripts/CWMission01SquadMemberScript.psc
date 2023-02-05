Scriptname CWMission01SquadMemberScript extends ReferenceAlias  

Event OnLoad()
	CWScript.Log("CWMission01SquadMemberScript", self + "Onload()" )
	RegisterForUpdate(2)
EndEvent

Event OnUpdate()
	CWScript.Log("CWMission01SquadMemberScript", self + "OnUpdate()" )
	If GetOwningQuest().GetStage() < 11 ; can be set elsewhere like another soldier's script
		If GetReference().GetDistance(Game.GetPlayer()) < 300
			GetOwningQuest().setStage(11)
		EndIf
	
	Elseif GetOwningQuest().GetStage() < 51
		If GetReference().GetDistance((GetOwningQuest() as CWMission01Script).EnemySpawnMarker) < 300	
			GetOwningQuest().setStage(51)
			UnRegisterForUpdate() 
		endif
	Else
		UnRegisterForUpdate()
	EndIf

EndEvent
