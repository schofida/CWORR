Scriptname CWAttackCityScript extends CWMissionScript  Conditional
{Extends CWMissionScript which extends Quest}

;REMINDER extends CWMissionScript so has properties like CWs

;ObjectReference Property CWTempWhiterunCastleDoor Auto

Scene Property CWAttackCityConfrontationScene Auto
Scene Property CWAttackCitySurrenderScene Auto
Scene Property CWAttackCityJarlBleedingOutScene Auto
Quest Property CWSiegeObj Auto
LocationAlias Property CWSiegeObjCapitalHQ  Auto

ReferenceAlias Property CWSiegeObjJarl Auto
{Alias Jarl in CWSiegeObj quest}

int property jarlWillSurrender Auto hidden Conditional
int property jarlHasSurrendered Auto hidden Conditional

LocationAlias Property City Auto

ActorBase Property CWSiegeWhiterunImperialSoldier  Auto  
ActorBase Property CWSiegeRiftenSonsSoldier   Auto  
ActorBase Property CWSiegeMarkarthImperialSoldier   Auto  

ActorBase Property CWSiegeSonsSoldier Auto
ActorBase Property CWSiegeImperialSoldier Auto

MusicType Property MUSCombatCivilWar  Auto  

Outfit Property ArmorBalgruufSteelPlateNoHelmetOutfit Auto
Outfit Property JarlClothesBalgruuf Auto

CWSiegeScript Property CWSiegeS Auto

Weather Property SkyrimOvercastWar  Auto  

Faction Property CWSoldierPlayerEnemy Auto



;THIS WAS A WHILE LOOP IN STAGE 9000 BUT BECAUSE THAT WAS ULTIMATE TRIGGERED BY A SCENE END SCRIPT, THE SCENE WOULD HANG INDEFINATELY
Event OnUpdate()  ;REGISTERED IN STAGE 9000
	;[DVs CW Fix] Bug 6.1: Added 30-minute timeout to prevent infinite loop if player never leaves city
	int timeoutCounter = 0
	int maxIterations = 360  ; 360 * 5s = 1800s = 30 minutes
	while Game.GetPlayer().IsInLocation(City.GetLocation()) && timeoutCounter < maxIterations
; 		CWScript.Log("AttackCity", "OnUpdate() initiated by stage 9000: Waiting for player to leave City before stoping CWSiege and CWAttackCity quest")
		utility.wait(5)
	endwhile

  if timeoutCounter >= maxIterations
		Debug.Trace("[DVs CW Fix] CWAttackCity OnUpdate: Timeout reached after 1800s, forcing quest stop even though player is still in city")
	endif

; 	CWScript.Log("AttackCity", "OnUpdate() initiated by stage 9000: stoping CWSiege and CWAttackCity quest")

	
	CWSiegeS.Stop()
	stop()
	
EndEvent

function TryToFixQuest()
	debug.notification("Trying to fix CWAttackCity quest")
	if GetStage() < 10
		SetStage(10)
		return
	endif
	if GetStage() < 50
		SetStage(200)
		return
	endif
	if GetStageDone(9000)
		CWSiegeS.Stop()
		Stop()
	endif
endfunction

function tryToDeleteWhenAbleAlias(ReferenceAlias AliasToDeleteWhenAble)
	ObjectReference RefToDeleteWhenAble = AliasToDeleteWhenAble.GetReference() 
		if RefToDeleteWhenAble
; 			CWScript.Log("CWFortSiegeScript", self + "tryToDeleteWhenAbleAlias() disabling " + RefToDeleteWhenAble + " in alias " + AliasToDeleteWhenAble)
			RefToDeleteWhenAble.DeleteWhenAble()
		Endif

EndFunction