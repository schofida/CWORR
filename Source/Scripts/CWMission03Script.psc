Scriptname CWMission03Script extends CWMissionScript  Conditional
{Extends CWMissionScript which extends Quest}

int Property Bribed Auto	Conditional	;see dialogue with Innkeeper

;Registered in stage 10
Event OnGainLOS(Actor akViewer, ObjectReference akTarget)
	setStage(20)

EndEvent

function TryToFixQuest()
	debug.notification("Trying to fix CWMission03 quest")
	if GetStage() == 0
		SetStage(10)
	elseif (GetStage() >= 10 && GetStage() < 20)
		SetStage(20)
	elseif (GetStage() == 20 && GetStage() < 30)
		SetStage(30)
	elseif (GetStage() == 30)
		SetStage(31)
        Utility.Wait(3)
        SetStage(39)
        Utility.Wait(3)
        SetStage(40)
	elseif (GetStage() == 31)
        SetStage(39)
        Utility.Wait(3)
        SetStage(40)
	elseif (GetStage() == 39)
        SetStage(40)
	elseif (GetStage() == 40)
		SetStage(50)
	elseif (GetStage() == 50)
		SetStage(51)
	elseif (GetStage() == 51)
		SetStage(100)
	elseif (GetStage() == 100)
		SetStage(200)
	elseif GetStage() == 200
		Stop()
	endif
	debug.notification("Done advancing CWMission03 quest")	
endfunction