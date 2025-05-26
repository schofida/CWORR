Scriptname CWMission01PlayerScript extends ReferenceAlias  

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	CWScript.Log("CWMission01PlayerScript", self + "OnCombatStateChanged(" + akTarget + "," + aeCombatState + ")" )
	if (akTarget == Game.GetPlayer() && GetOwningQuest().GetStage() >= 11)
		if (aeCombatState == 1)
			RegisterForSingleUpdate(3.0)
		else
			UnRegisterForUpdate()
		endIf
	endIf
endEvent

Event OnUpdate()
	CWScript.Log("CWMission01PlayerScript", self + "OnUpdate()" )
	if !GetActorRef().IsInCombat()
		GetOwningQuest().SetStage(100)
	endif

EndEvent