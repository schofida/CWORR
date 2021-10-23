;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname USKP_QF_CWGovernmentHotfix_0203ECF2 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
if (WindhelmLocation.GetKeywordData(CWOwner) == CWImperial.GetValue())
  CWGovernmentStart.SendStoryEvent(WindhelmLocation)
elseif (SolitudeLocation.GetKeywordData(CWOwner) == CWSons.GetValue()) ;Because these should be mutually exclusive...
  CWGovernmentStart.SendStoryEvent(SolitudeLocation)
endif
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Location Property WindhelmLocation  Auto
Location Property SolitudeLocation  Auto
Keyword Property CWOwner  Auto
Keyword Property CWGovernmentStart Auto
GlobalVariable Property CWImperial  Auto
GlobalVariable Property CWSons  Auto
