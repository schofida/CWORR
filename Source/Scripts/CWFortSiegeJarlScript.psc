Scriptname CWFortSiegeJarlScript extends ReferenceAlias  

Quest Property CWFortSiegeCapital Auto

Event OnEnterBleedout()
	;USLEEP 3.0.13 Bug #23062
	if( CWFortSiegeCapital && CWFortSiegeCapital.IsRunning() && CWFortSiegeCapital.GetStageDone(920) )
		GetOwningQuest().setStage(1000)
	endif
EndEvent
