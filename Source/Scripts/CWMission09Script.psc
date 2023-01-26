Scriptname CWMission09Script extends CWMissionScript conditional
{Extends CWMissionScript which extends Quest}

MiscObject Property CWDocumentsImperial  Auto
MiscObject Property CWDocumentsSons  Auto
ReferenceAlias Property DocumentSpawn Auto

function TryToFixQuest()
	debug.notification("Trying to fix CWMission09 quest")
	if GetStage() == 0
		SetStage(10)
	elseif GetStage() == 10
		if CWs.PlayerAllegiance == CWs.iImperials
			Game.GetPlayer().AddItem(CWDocumentsSons)
		elseif CWs.PlayerAllegiance == Cws.iSons
			Game.GetPlayer().AddItem(CWDocumentsImperial)
		endif
		SetStage(100)
	elseif GetStage() == 100
		SetStage(200)
	elseif GetStage() == 200
		Stop()
	endif
	debug.notification("Done advancing CWMission09 quest")	
endfunction
