;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname USKP_QF_ChangeLocation08_02005E82 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE CWOApolloFixMeScript
Quest __temp = self as Quest
USKPChangeLocation08Script kmyQuest = __temp as USKPChangeLocation08Script
;END AUTOCAST
;BEGIN CODE
if (kmyQuest.WhiterunLocation.GetKeywordData(kmyQuest.CWOwner) as Int) == kmyQuest.CWSons.GetValueInt()
    DialogueWhiterunCaptainoftheGuard.SetStage(10)
elseif DialogueWhiterunCaptainoftheGuard.GetStage() == 10
    DialogueWhiterunCaptainoftheGuard.SetStage(20)
endif
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property DialogueWhiterunCaptainoftheGuard  Auto  
