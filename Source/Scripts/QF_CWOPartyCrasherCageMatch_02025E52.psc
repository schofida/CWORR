scriptName QF_CWOPartyCrasherCageMatch_02025E52 extends Quest hidden

;-- Properties --------------------------------------
referencealias property Alias_CatapultDefender1 auto
referencealias property Alias_CWODragon1 auto
referencealias property Alias_CWODragon2 auto
locationalias property Alias_City auto

Faction Property DragonFaction auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GotoState

; Skipped compiler generated GetState

function Fragment_0()
	if utility.randomint(0, 100) < 50
		Alias_CWODragon1.TryToEnable()
		Alias_CWODragon1.GetActorReference().StartCombat(game.GetPlayer())
	else
		Alias_CWODragon1.TryToEnable()
		Alias_CWODragon2.TryToEnable()
		Alias_CWODragon1.TryToRemoveFromFaction(DragonFaction)
		Alias_CWODragon2.GetActorReference().StartCombat(Alias_CWODragon1.GetActorReference())
		Alias_CWODragon1.GetActorReference().StartCombat(Alias_CWODragon2.GetActorReference())
	endIf
endFunction

function Fragment_1()
	Alias_CWODragon1.TryToDisable()
	Alias_CWODragon2.TryToDisable()
endfunction