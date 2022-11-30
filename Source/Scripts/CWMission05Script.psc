scriptName cwmission05script extends CWMissionScript conditional
{Extends CWMissionScript which extends Quest}

;-- Properties --------------------------------------
scene property CWMission05COFlees auto

;-- Variables ---------------------------------------


function TryToFixQuest()
	debug.notification("Trying to fix CWMission05 quest")
	if GetStage() == 0
		SetStage(10)
	elseif GetStage() == 10
		SetStage(100)
	elseif GetStage() == 100
		SetStage(200)
	elseif GetStage() == 200
		Stop()
	endif
	debug.notification("Done advancing CWMission05 quest")	
endfunction