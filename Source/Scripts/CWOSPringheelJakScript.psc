scriptName CWOSPringheelJakScript extends ObjectReference

;-- Properties --------------------------------------

;-- Variables ---------------------------------------
Float Jumpheight
;-- Functions ---------------------------------------

; Skipped compiler generated GotoState

function OnEquipped(Actor AkActor)

	if AkActor == game.GetPlayer() && SKSE.GetVersionRelease() > 0
		Jumpheight = game.GetGameSettingFloat("fJumpHeightMin")
		game.SetGameSettingfloat("fJumpHeightMin", Jumpheight + 150 as Float)
	endIf
endFunction

function OnUnEquipped(Actor AkActor)

	if AkActor == game.GetPlayer() && SKSE.GetVersionRelease() > 0
		game.SetGameSettingfloat("fJumpHeightMin", Jumpheight)
	endIf
endFunction

; Skipped compiler generated GetState
