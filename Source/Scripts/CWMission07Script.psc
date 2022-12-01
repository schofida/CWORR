Scriptname CWMission07Script extends CWMissionScript  Conditional
{Extends CWMissionScript which extends Quest}

Faction Property CWMission07BlackMailedFaction auto

LocationAlias Property CaravanLocation Auto

LocationRefType Property CWMission07SoldierEnemy	Auto

Armor Property CWMission07EvidenceMarkarth Auto
Book Property CWMission07EvidenceRiften Auto

int property Persuaded auto hidden conditional

function checkForVictory()
	if CaravanLocation.GetLocation().GetRefTypeAliveCount(CWMission07SoldierEnemy) == 0 
 		CWScript.Log("CWMission07Script", "checkForVictory() found GetRefTypeAliveCount CWMission07SoldierEnemy == 0, so player succeeded")
	
		setStage(90)
	
	EndIf

EndFunction

function TryToFixQuest()
	debug.notification("Trying to fix CWMission07 quest")
	if GetStage() == 0
		SetStage(10)
	elseif GetStage() == 10
		SetStage(20)
	elseif GetStage() == 20
		if CWs.PlayerAllegiance == CWS.iImperials
			game.GetPlayer().AddItem(CWMission07EvidenceRiften)
		else
			game.GetPlayer().AddItem(CWMission07EvidenceMarkarth)
		endif
		SetStage(25)
	elseif GetStage() == 25
		SetStage(30)
	elseif GetStage() == 30
		if CWs.PlayerAllegiance == CWS.iImperials
			game.GetPlayer().RemoveItem(CWMission07EvidenceRiften)
		else
			game.GetPlayer().RemoveItem(CWMission07EvidenceMarkarth)
		endif
		SetStage(40)
	elseif GetStage() >= 40 && GetStage() < 65
		SetStage(65)
	elseif GetStage() == 65
		SetStage(90)
	elseif GetStage() == 90
		SetStage(100)
	elseif GetStage() == 100
		SetStage(200)
	elseif GetStage() == 200
		Stop()
	endif
	debug.notification("Done advancing CWMission07 quest")	
endfunction
