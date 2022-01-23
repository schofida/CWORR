;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname USKP_QF_HeimskrJail_0300B4AA Extends Quest Hidden

;BEGIN ALIAS PROPERTY CWHeimskrNewHome
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CWHeimskrNewHome Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Heimskr
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Heimskr Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HeimskrJailedSpot
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HeimskrJailedSpot Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Actor Heimskr = Alias_Heimskr.GetActorReference()
(Alias_Heimskr.GetReference() as pHeimskrScript).pHeimskrPreach = 0
WhiterunHeimskrPreachScene.Stop()
Heimskr.SetOutfit(PrisonerOutfit)
;Heimskr.SetRelationshipRank(Game.GetPlayer(), -2)
Heimskr.MoveTo(Alias_HeimskrJailedSpot.GetReference())
Alias_CWHeimskrNewHome.GetReference().Disable()
Heimskr.EvaluatePackage()
Setstage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_2()
;BEGIN CODE
Actor Heimskr = Alias_Heimskr.GetActorReference()
(Alias_Heimskr.GetReference() as pHeimskrScript).pHeimskrPreach = 1
WhiterunHeimskrPreachScene.Start()
Heimskr.SetOutfit(MonkOutfit)
;Heimskr.SetRelationshipRank(Game.GetPlayer(), -2)
Alias_CWHeimskrNewHome.GetReference().Enable()
Heimskr.MoveTo(Alias_CWHeimskrNewHome.GetReference())
Heimskr.EvaluatePackage()
Setstage(10)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Outfit Property PrisonerOutfit  Auto  

Outfit Property MonkOutfit	Auto

Scene Property WhiterunHeimskrPreachScene  Auto  
