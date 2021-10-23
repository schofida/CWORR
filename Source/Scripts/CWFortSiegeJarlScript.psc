Scriptname CWFortSiegeJarlScript extends ReferenceAlias  

Quest Property CWFortSiegeCapital Auto

Event OnEnterBleedout()
	;USLEEP 3.0.13 Bug #23062
	if( CWFortSiegeCapital && !CWFortSiegeCapital.IsRunning() )
		GetOwningQuest().setStage(950)
	endif
EndEvent
