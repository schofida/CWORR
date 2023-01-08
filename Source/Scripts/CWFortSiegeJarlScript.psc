Scriptname CWFortSiegeJarlScript extends ReferenceAlias  

Quest Property CWFortSiegeCapital Auto

Event OnEnterBleedout()

	if(CWFortSiegeCapital == GetOwningQuest() && CWFortSiegeCapital.IsRunning() && CWFortSiegeCapital.GetStageDone(920) )
		GetOwningQuest().setStage(1000)
	endif
EndEvent
