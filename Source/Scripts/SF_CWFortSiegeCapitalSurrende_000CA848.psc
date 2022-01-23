;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SF_CWFortSiegeCapitalSurrende_000CA848 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
CWScript.Log("CWFortSiege", "CWFortSiegeCapitalSurrenderScene Started.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
CWScript.Log("CWFortSiege", "CWFortSiegeCapitalSurrenderScene Ended.")
if (GetOwningQuest() as CWFortSiegeScript).WasThisAnAttack
    GetOwningQuest().setStage(9000) ;success
Else
    GetOwningQuest().setStage(9200) ;failure
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
