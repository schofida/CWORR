;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SF_CWSiegeWhiterunDefendedSce_000CD1A0 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
;debug.messagebox(self + "End")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
CWOForceWhiterunDefenseSceneEnd.SetValueInt(0)
Utility.Wait(20.0)
CWOForceWhiterunDefenseSceneEnd.SetValueInt(1)
;END CODE
EndFunction
;END FRAGMENT

GlobalVariable Property CWOForceWhiterunDefenseSceneEnd Auto

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
