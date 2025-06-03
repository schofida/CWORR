scriptName CWOArmorScript extends ReferenceAlias

;-- Properties --------------------------------------
keyword property ImperialKeyword auto
globalvariable property CWODisguiseGlobal auto
faction property PlayerFaction auto
formlist property ImperialArmor auto
keyword property SonsKeyword2 auto
formlist property SonsArmor auto
keyword property ImperialKeyword3 auto
keyword property ImperialKeyword2 auto
globalvariable property CWPlayerAllegiance auto
keyword property SonsKeyword auto
faction property CWSonsFactionNPC auto
CWScript property CWs auto
faction property CWImperialFactionNPC auto
Armor property WhatArmor auto

globalvariable property CWOStillABetterEndingGlobal auto
globalvariable property CWODisguiseGameType auto

Keyword property ArmorCuirass auto

Message property CWODisguiseEnemyCamp auto

;-- Variables ---------------------------------------
Bool IsNowImperial
Faction EnemyFaction
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
		PlayerFaction.SetEnemy(EnemyFaction, true, true)
		return
	endif
	if CWs.playerAllegiance == CWs.iSons
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
	elseIf CWs.playerAllegiance == CWs.iImperials
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
	if GetIsInPeaceTreaty()
		Return
	endif
	Armor thisIsArmor = akBaseObject as Armor
	if thisIsArmor != none && akBaseObject.HasKeyword(ArmorCuirass)
		WhatArmor = thisIsArmor
		EquipmentUpdate()
	endif
endEvent
; Reddit BugFix #8
event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	if GetIsInPeaceTreaty()
		Return
	endif
	Armor thisIsArmor = akBaseObject as Armor
	if thisIsArmor != none && akBaseObject.HasKeyword(ArmorCuirass)
		WhatArmor = none
		EquipmentUpdate()
	endif
endEvent
; Reddit BugFix #8
event OnLocationChange(Location akOldLoc, Location akNewLoc)
	if GetIsInPeaceTreaty()
		return
	endif
	CWCampaignScript CWCampaignS = CWs.CWCampaignS
	if CwCampaignS.IsRunning() && CwCampaignS.EnemyCamp.GetLocation() == akNewLoc && CwCampaignS.IsEnemyCampEnabled()
		if CwCampaignS.CWODisableNotifications.GetValueInt() == 0
			CWODisguiseEnemyCamp.Show()
		endif
		PlayerFaction.SetEnemy(ReturnEnemyFaction(), false, false)
		CWODisguiseGlobal.SetValueInt(0)
	else
		EquipmentUpdate()
	endif
	; self.RegisterforSingleUpdate(10 as Float) ; Reddit BugFix #8
endEvent

; Skipped compiler generated GetState

function OnInit()
	EnemyFaction = ReturnEnemyFaction()
	if GetIsInPeaceTreaty()
		Return
	endif
	EquipmentUpdate()
	; self.RegisterforSingleUpdate(10 as Float) ; Reddit BugFix #8
endFunction

faction function ReturnEnemyFaction()

	if CWs.playerAllegiance == CWs.iSons
		return CWImperialFactionNPC
	elseIf CWs.playerAllegiance == CWs.iImperials
		return CWSonsFactionNPC
	endIf
	return none
endFunction

bool function GetIsInPeaceTreaty()
	Bool PeaceTreaty = false
	if !CWs.IsRunning() || !CWs.WhiterunSiegeFinished || CWs.GetStage() == 255 || EnemyFaction == None
		PeaceTreaty = true
		GetOwningQuest().Stop()
	endIf
	if EnemyFaction != None && PeaceTreaty
		CWODisguiseGlobal.SetValueInt(1)
		PlayerFaction.SetEnemy(EnemyFaction, true, true)
	endif
	return PeaceTreaty

endfunction

; Skipped compiler generated GotoState
