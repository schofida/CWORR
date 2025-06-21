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
;BEGIN AUTOCAST TYPE CWOBAQuestScript
Quest __temp = self as Quest
CWOBAQuestScript kmyQuest = __temp as CWOBAQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.RevertFactions(Alias_StormcloakSpy01.GetActorRef())
kmyQuest.RevertFactions(Alias_ImperialSpy01.GetActorRef())
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
kmyQuest.InitFactionSwitch(Alias_StormcloakSpy01, kmyQuest.CWs.iSons)
kmyQuest.InitFactionSwitch(Alias_ImperialSpy01, kmyQuest.CWs.iImperials)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE CWOBAQuestScript
Quest __temp = self as Quest
CWOBAQuestScript kmyQuest = __temp as CWOBAQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.SwapFactions(Alias_StormcloakSpy01.GetActorRef())
kmyQuest.SwapFactions(Alias_ImperialSpy01.GetActorRef())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
