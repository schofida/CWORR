;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname SF_CWFortSiegeCapitalSurrende_000CA848 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
CWScript.Log("CWFortSiege", "CWFortSiegeCapitalSurrenderScene Started.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
CWScript.Log("CWFortSiege", "CWFortSiegeCapitalSurrenderScene Ended.")
GetOwningQuest().setStage(9000) ;success
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
