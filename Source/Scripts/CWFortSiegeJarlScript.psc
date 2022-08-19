Scriptname CWFortSiegeJarlScript extends ReferenceAlias  

Event OnEnterBleedout()
	;USLEEP 3.0.13 Bug #23062
	CWFortSiegeScript CWFortSiegeCapitalS = GetOwningQuest() as CWFortSiegeScript
	Quest CWFortSiegeCapital = GetOwningQuest()

	if(CWFortSiegeCapitalS != None && CWFortSiegeCapital == CWFortSiegeCapitalS.Cws.CWFortSiegeCapital && CWFortSiegeCapital.IsRunning() && CWFortSiegeCapital.GetStageDone(920) )
		GetOwningQuest().setStage(1000)
	endif
EndEvent
