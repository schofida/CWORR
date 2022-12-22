Scriptname CWMission02ResourceObjectScript extends ReferenceAlias  

CWMission02Script property CWMission02S auto Hidden

int Property myType auto Hidden
int Property primaryResourceType auto Hidden
int Property DiscoverDistance = 1000 auto Hidden

;#### Pointers to things in master file

Event OnInit()
	CWMission02S = GetOwningQuest() as CWMission02Script
	
; 	CWScript.Log("CWMission02ResourceObjectScript", self + " OnInit()", 0, true, True)
; 	CWScript.Log("CWMission02ResourceObjectScript", self + " REMINDER: Make sure that my properties get cleared out when the quest starts up again when that functionality is implemented in Papyrus.", 1, 0, true)
	

	
EndEvent

;TEMP HACK UNTIL ALL THE RESOURCE OBJECTS COME ONLINE
Event OnActivate(ObjectReference akActionRef)
	if akActionRef == Game.GetPlayer()
	
		int RType = (GetReference() as ResourceObjectScript).GetResourceType() 

		CWMission02Script CWMission02 = GetOwningQuest() as CWMission02Script
		
		if RType == 1 || RType == 3		;1 = Wheat Mill(Farm), 2 = Saw Mill, 3 = Smelter(Mine)
			
			;TEMP HACK TO MAKE IT SABOTAGED WHEN YOU ACTIVATE IT
			GetReference().DamageObject(9999)
			CWMission02.CWs.GetFaction(CWMission02.CWs.getOppositeFactionInt(CWMission02.CWs.PlayerAllegiance), false).SendAssaultAlarm()
		EndIf
	
	EndIf

EndEvent


Event OnUpdate()
	CWScript.Log("CWMission02ResourceObjectScript", self + " OnUpdate()")

	
	if GetOwningQuest().GetStageDone(20) == False && Game.GetPlayer().GetDistance(self.GetReference()) < DiscoverDistance	;if the player is close to me
; 			CWScript.Log("CWMission02ResourceObjectScript", self + " OnUpdate(): PlayerDistance to" + Self + " < DiscoverDistance, advancing quest")
		GetOwningQuest().SetStage(20)
	EndIf
	
; 		CWScript.Log("CWMission02ResourceObjectScript", self + " OnUpdate(): myType == primaryResourceType, checking IsSabotaged()")
		
		if GetOwningQuest().GetStagedone(100) == False && (GetReference() as ResourceObjectScript).IsSabotaged()
			GetOwningQuest().setStage(100)
		EndIf
	
EndEvent

Event OnHit(ObjectReference akAggressor, Form akWeapon, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	
	;if player hits me and i'm the primary object, consider me "discovered"
	
	if akAggressor == Game.GetPlayer()	;and the player has hit me
		CWMission02Script CWMission02 = GetOwningQuest() as CWMission02Script
		CWMission02.CWs.GetFaction(CWMission02.CWs.getOppositeFactionInt(CWMission02.CWs.PlayerAllegiance), false).SendAssaultAlarm()
	EndIf

EndEvent

Event OnDestructionStageChanged(int aiOldStage, int aiCurrentStage)
	if aiCurrentStage > aiOldStage && aiCurrentStage >= 3 && (GetReference() as ResourceObjectScript).sabotaged == false
		(GetReference() as ResourceObjectScript).sabotaged = true
	endif
endevent