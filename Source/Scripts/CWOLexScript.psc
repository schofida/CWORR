scriptName CWOLexScript extends ActiveMagicEffect

;-- Properties --------------------------------------
spell property DA09DawnbreakerBaneOfUndeadSpell auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GetState

function OnDying(Actor akKiller)

	DA09DawnbreakerBaneOfUndeadSpell.RemoteCast(akKiller as objectreference, akKiller, none)
endFunction

; Skipped compiler generated GotoState
