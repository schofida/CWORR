Scriptname CWMission02Script extends CWMissionScript  Conditional
{Extends CWMissionScript which extends Quest.}
Activator Property ResourceObjectMine Auto
Activator Property ResourceObjectSawMill Auto
Activator Property ResourceObjectSawMillLever Auto
Activator Property ResourceObjectGrainMill Auto

ReferenceAlias Property ResourceObject1 Auto

Location[] Property MillLocations Auto
ObjectReference[] Property MillLevers Auto

ObjectReference function GetMillLever(Location GarrisonToCheck)
	int i = MillLocations.Length

	while i
		i = i - 1
		if MillLocations[i] == GarrisonToCheck
			return MillLevers[i]
		endif
	endWhile
	return none
EndFunction

function TryToFixQuest()
	debug.notification("Trying to fix CWMission02 quest")
	if GetStage() == 0
		SetStage(10)
	elseif GetStage() == 10
		SetStage(15)
	elseif GetStage() == 15
		SetStage(20)
	elseif GetStage() == 20
		SetStage(100)
	elseif GetStage() == 100
		SetStage(200)
	elseif GetStage() == 200
		Stop()
	endif
	debug.notification("Done advancing CWMission02 quest")	
endfunction