;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname EGO_QF_CWOBAQuest_0203B24F Extends Quest Hidden

;BEGIN ALIAS PROPERTY ImperialTargetPlayer
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ImperialTargetPlayer Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY StormcloakSpy01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_StormcloakSpy01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ImperialSpy01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ImperialSpy01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ImperialTarget
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ImperialTarget Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SpyTarget
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SpyTarget Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SonsTargetPlayer
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SonsTargetPlayer Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SonsTarget
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SonsTarget Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
(Alias_StormcloakSpy01 as cwobascript2).RevertFactions()
(Alias_ImperialSpy01 as cwobascript2).RevertFactions()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE CWOBAQuestScript
Quest __temp = self as Quest
CWOBAQuestScript kmyQuest = __temp as CWOBAQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.registerforsingleupdate(kmyQuest.QuestLength.GetValue())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
(Alias_StormcloakSpy01 as cwobascript2).SwapFactions()
(Alias_ImperialSpy01 as cwobascript2).SwapFactions()
;Source NOT loaded
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
(Alias_StormcloakSpy01 as cwobascript2).UndoNPCFaction()
(Alias_ImperialSpy01 as cwobascript2).UndoNPCFaction()
;Source NOT loaded
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
