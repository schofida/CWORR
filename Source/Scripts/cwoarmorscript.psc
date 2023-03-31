scriptName CWOArmorScript extends ReferenceAlias

;-- Properties --------------------------------------
keyword property ImperialKeyword auto
globalvariable property CWODisguiseGlobal auto
faction property PlayerFaction auto
formlist property ImperialArmor auto
keyword property SonsKeyword2 auto
quest property MQ302 auto
formlist property SonsArmor auto
keyword property ImperialKeyword3 auto
keyword property ImperialKeyword2 auto
globalvariable property CWPlayerAllegiance auto
keyword property SonsKeyword auto
faction property CWSonsFactionNPC auto
quest property CWFinale auto
Bool property PeaceTreaty auto
faction property CWImperialFactionNPC auto
Armor property WhatArmor auto

globalvariable property CWOStillABetterEndingGlobal auto
globalvariable property CWODisguiseGameType auto

Keyword property ArmorCuirass auto

;-- Variables ---------------------------------------
Bool IsNowImperial
Actor PlayerRef
Bool WeTookItOff
Bool isWorn
Bool wasSons
Bool IsNowSons
Bool wasImperial

;-- Functions ---------------------------------------
; Reddit BugFix #8
function EquipmentUpdate()
	if CWODisguiseGameType.GetValueInt() == 2
		CWODisguiseGlobal.SetValueInt(1)
		PlayerFaction.SetEnemy(ReturnEnemyFaction(), true, true)
		return
	endif
	if (CWFinale as cwfinalescript).CWs.playerAllegiance == (CWFinale as cwfinalescript).CWs.iSons && PeaceTreaty == false
		if CWODisguiseGameType.GetValueInt() == 1
			if WhatArmor != none && (WhatArmor.HasKeyword(SonsKeyword) || WhatArmor.HasKeyword(SonsKeyword2))
				CWODisguiseGlobal.SetValueInt(0)
				PlayerFaction.SetEnemy(CWImperialFactionNPC, false, false)
			else
				CWODisguiseGlobal.SetValueInt(1)
				PlayerFaction.SetEnemy(CWImperialFactionNPC, true, true)
			endIf
		else
			if WhatArmor != none && (WhatArmor.HasKeyword(ImperialKeyword) || WhatArmor.HasKeyword(ImperialKeyword2) || WhatArmor.HasKeyword(ImperialKeyword3))
				CWODisguiseGlobal.SetValueInt(1)
				PlayerFaction.SetEnemy(CWImperialFactionNPC, true, true)
			else
				CWODisguiseGlobal.SetValueInt(0)
				PlayerFaction.SetEnemy(CWImperialFactionNPC, false, false)
			endIf
		endif
	elseIf (CWFinale as cwfinalescript).CWs.playerAllegiance == (CWFinale as cwfinalescript).CWs.iImperials && PeaceTreaty == false
		if CWODisguiseGameType.GetValueInt() == 1
			if WhatArmor != none && (WhatArmor.HasKeyword(ImperialKeyword) || WhatArmor.HasKeyword(ImperialKeyword2) || WhatArmor.HasKeyword(ImperialKeyword3))
				CWODisguiseGlobal.SetValueInt(0)
				PlayerFaction.SetEnemy(CWSonsFactionNPC, false, false)
			else
				CWODisguiseGlobal.SetValueInt(1)
				PlayerFaction.SetEnemy(CWSonsFactionNPC, true, true)
			endIf
		else
			if WhatArmor != none && (WhatArmor.HasKeyword(SonsKeyword) || WhatArmor.HasKeyword(SonsKeyword2))
				PlayerFaction.SetEnemy(CWSonsFactionNPC, true, true)
				CWODisguiseGlobal.SetValueInt(1)
			else
				PlayerFaction.SetEnemy(CWSonsFactionNPC, false, false)
				CWODisguiseGlobal.SetValueInt(0)
			endIf
		endif
	endIf
endFunction
; Reddit BugFix #8
event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	Armor thisIsArmor = akBaseObject as Armor
	if thisIsArmor != none && akBaseObject.HasKeyword(ArmorCuirass)
		WhatArmor = thisIsArmor
		EquipmentUpdate()
	endif
endEvent
; Reddit BugFix #8
event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	Armor thisIsArmor = akBaseObject as Armor
	if thisIsArmor != none && akBaseObject.HasKeyword(ArmorCuirass)
		WhatArmor = none
		EquipmentUpdate()
	endif
endEvent
; Reddit BugFix #8
event OnLocationChange(Location akOldLoc, Location akNewLoc)
	CWCampaignScript CWCampaignS = (CWFinale as cwfinalescript).CWs.CWCampaignS
	if CwCampaignS.EnemyCamp.GetLocation() == akNewLoc && CwCampaignS.IsEnemyCampEnabled()
		if CwCampaignS.CWODisableNotifications.GetValueInt() == 0
			debug.notification("Your disguise does not work at the enemy camp.")
		endif
		PlayerFaction.SetEnemy(ReturnEnemyFaction(), false, false)
		CWODisguiseGlobal.SetValueInt(0)
	else
		EquipmentUpdate()
	endif
	if MQ302.IsRunning()
		if MQ302.GetStage() > 30
			PeaceTreaty = true
			PlayerFaction.SetEnemy(ReturnEnemyFaction(), true, true)
		else
			PeaceTreaty = false
		endIf
	else
		PeaceTreaty = false
	endIf
	; self.RegisterforSingleUpdate(10 as Float) ; Reddit BugFix #8
endEvent

; Skipped compiler generated GetState

function OnInit()

	PlayerRef = game.GetPlayer()
	PeaceTreaty = false
	EquipmentUpdate()
	; self.RegisterforSingleUpdate(10 as Float) ; Reddit BugFix #8
endFunction

faction function ReturnEnemyFaction()

	if (CWFinale as cwfinalescript).CWs.playerAllegiance == (CWFinale as cwfinalescript).CWs.iSons
		return CWImperialFactionNPC
	elseIf (CWFinale as cwfinalescript).CWs.playerAllegiance == (CWFinale as cwfinalescript).CWs.iImperials
		return CWSonsFactionNPC
	endIf
endFunction

; Skipped compiler generated GotoState
