scriptName CWOSPringheelJakScript extends ObjectReference

;-- Properties --------------------------------------


;-- Variables ---------------------------------------
Float Jumpheight
;-- Functions ---------------------------------------

; Skipped compiler generated GotoState

function OnEquipped(Actor AkActor)

	if AkActor == game.GetPlayer()
		Jumpheight = game.GetGameSettingFloat("fJumpHeightMin")
		game.SetGameSettingfloat("fJumpHeightMin", Jumpheight + 150 as Float)
	endIf
endFunction

function OnUnEquipped(Actor AkActor)

	if AkActor == game.GetPlayer()
		game.SetGameSettingfloat("fJumpHeightMin", Jumpheight)
	endIf
endFunction

; Skipped compiler generated GetState
