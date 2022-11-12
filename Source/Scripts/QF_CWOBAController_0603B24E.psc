;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname QF_CWOBAController_0603B24E Extends Quest Hidden

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE CWOBAControllerQuestScript
Quest __temp = self as Quest
CWOBAControllerQuestScript kmyQuest = __temp as CWOBAControllerQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.CWOBAQuest.Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
