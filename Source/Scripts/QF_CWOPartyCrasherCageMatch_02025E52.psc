;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_CWOPartyCrasherCageMatch_02025E52 Extends Quest Hidden

;BEGIN ALIAS PROPERTY CatapultDefender1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CatapultDefender1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWODragon1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CWODragon1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY City
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_City Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CWODragon2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CWODragon2 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
	Alias_CWODragon1.TryToDisable()
	Alias_CWODragon2.TryToDisable()
	Alias_CWODragon1.GetRef().DeleteWhenAble()
	Alias_CWODragon2.GetRef().DeleteWhenAble()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
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
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property DragonFaction Auto