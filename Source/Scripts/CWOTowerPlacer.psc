scriptName CWOTowerPlacer extends ActiveMagicEffect

;-- Properties --------------------------------------
explosion property Boom auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function OnEffectStart(actor akTarget, actor akCaster)

	akTarget.PlaceAtMe(Boom as form, 1, false, false)
endFunction

; Skipped compiler generated GotoState

; Skipped compiler generated GetState
