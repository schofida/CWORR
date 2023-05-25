Scriptname CWFortSoldierWoundedScript extends Actor  

int Property PercentChanceToAppear = 75 Auto
{Default: 75; What percentage of the time should this actor be loaded?}

ObjectReference Property CampEnableMarker Auto
{MANDATORY!!! Pointer to the camp's enable marker}

Actor Property Legate Auto
{Added by USKP 1.3.3 - If the camp's Legate is dead, stop spawning wounded soldiers}

Quest Property CWMission06 Auto
{Added by CWO - Don't Load Wounded Soldiers if CWMission06 is running}

CWMission06Script CWMission06S

Event OnInit()
	CWMission06S = CWMission06 as CWMission06Script
EndEvent

Event OnCellLoad()

	disable()

	ObjectReference CWCampEnemyEnable
	if CWMission06.IsRunning()
		CWCampEnemyEnable = CWMission06S.CWCampEnemyEnable
	endif
	;CWO Check for nulls
	if( CampEnableMarker != none && CampEnableMarker.IsEnabled() && (CWCampEnemyEnable == none || CWCampEnemyEnable != CampEnableMarker) && Utility.RandomInt(1, 100) <= PercentChanceToAppear )
		if( !Legate.IsDead() )
			Enable()
			SetRestrained()
		EndIf
	EndIf

EndEvent

;Event OnLoad()
;	
;	BlockActivation(true)
;
;EndEvent

;Event OnActivate(ObjectReference akActionRef)
;
;	if akActionRef == Game.GetPlayer()
;		return
;
;	else
;		Activate(akActionRef, true)
;	
;	endif
;
;endEvent

;Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
;	kill(akAggressor as Actor)
;
;endEvent
