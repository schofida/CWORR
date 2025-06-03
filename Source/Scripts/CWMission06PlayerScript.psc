Scriptname CWMission06PlayerScript extends CWPlayerScript  
{Checks for death and calls function to decrement property on parent quest and set stage if property is zero.}

Event OnPlayerLoadGame()
	if GetOwningQuest().GetStage() >= 10 && GetOwningQuest().GetStage() < 20
        CWMission06Script cwmission06 = (GetOwningQuest() as CWMission06Script)
        ActorBase TurnCoatLeaderBase = cwmission06.TurncoatLeader.GetActorRef().GetActorBase()
		TurnCoatLeaderBase.SetVoiceType(cwmission06.MaleSoldier)
	endif
endEvent
