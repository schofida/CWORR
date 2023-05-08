;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 7
Scriptname qf_cwotestsiegebattles_060366A5 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE CWOTestSiegeBattlesScript
Quest __temp = self as Quest
CWOTestSiegeBattlesScript kmyQuest = __temp as CWOTestSiegeBattlesScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier1Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier2Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier3Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier4Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier5Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier6Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier7Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier8Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier9Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier10Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier1Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier2Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier3Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier4Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier5Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier6Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier7Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier8Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier9Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier10Instance)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN AUTOCAST TYPE CWOTestSiegeBattlesScript
Quest __temp = self as Quest
CWOTestSiegeBattlesScript kmyQuest = __temp as CWOTestSiegeBattlesScript
;END AUTOCAST
;BEGIN CODE
if CWOBeast1Instance == none
    CWOBeast1Instance = kmyQuest.CWOSiegeImperialSoldier1.PlaceAtMe(kmyQuest.CWOImperialHound) As Actor
else
    CWOBeast1Instance.Reset(kmyQuest.CWOSiegeImperialSoldier1)
endif
if CWOBeast2Instance == none
    CWOBeast2Instance = kmyQuest.CWOSiegeSonsSoldier1.PlaceAtMe(kmyQuest.CWOWhiteWolf) As Actor
else
    CWOBeast2Instance.Reset(kmyQuest.CWOSiegeSonsSoldier1)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE CWOTestSiegeBattlesScript
Quest __temp = self as Quest
CWOTestSiegeBattlesScript kmyQuest = __temp as CWOTestSiegeBattlesScript
;END AUTOCAST
;BEGIN CODE
if CWOBeast1Instance == none
    CWOBeast1Instance = kmyQuest.CWOSiegeImperialSoldier1.PlaceAtMe(kmyQuest.CWOImperialHound) As Actor
else
    CWOBeast1Instance.Disable()
    CWOBeast1Instance.Resurrect()
    CWOBeast1Instance.MoveTo(kmyQuest.CWOSiegeImperialSoldier1)
    CWOBeast1Instance.Enable()
endif
if CWOBeast2Instance == none
    CWOBeast2Instance = kmyQuest.CWOSiegeSonsSoldier1.PlaceAtMe(kmyQuest.CWOWhiteWolf) As Actor
else
    CWOBeast2Instance.Disable()
    CWOBeast2Instance.Resurrect()
    CWOBeast2Instance.MoveTo(kmyQuest.CWOSiegeSonsSoldier1)
    CWOBeast2Instance.Enable()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE CWOTestSiegeBattlesScript
Quest __temp = self as Quest
CWOTestSiegeBattlesScript kmyQuest = __temp as CWOTestSiegeBattlesScript
;END AUTOCAST
;BEGIN CODE
Game.GetPlayer().MoveTo(kmyQuest.CWOSiegeImperialSoldier1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE CWOTestSiegeBattlesScript
Quest __temp = self as Quest
CWOTestSiegeBattlesScript kmyQuest = __temp as CWOTestSiegeBattlesScript
;END AUTOCAST
;BEGIN CODE
debug.Notification("CWO Test Siege Battles. Cleaning Up Old Soldiers")
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier1Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier2Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier3Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier4Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier5Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier6Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier7Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier8Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier9Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeImperialSoldier10Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier1Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier2Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier3Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier4Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier5Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier6Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier7Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier8Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier9Instance)
kmyQuest.CleanUpInstanceIfExists(CWOSiegeSonsSoldier10Instance)
debug.Notification("CWO Test Siege Battles. Creating new soldiers")
CWOSiegeImperialSoldier1Instance = kmyQuest.CWOSiegeImperialSoldier1.PlaceActorAtMe(kmyQuest.CWSiegeImperialSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeImperialSoldier2Instance = kmyQuest.CWOSiegeImperialSoldier2.PlaceActorAtMe(kmyQuest.CWSiegeImperialSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeImperialSoldier3Instance = kmyQuest.CWOSiegeImperialSoldier3.PlaceActorAtMe(kmyQuest.CWSiegeImperialSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeImperialSoldier4Instance = kmyQuest.CWOSiegeImperialSoldier4.PlaceActorAtMe(kmyQuest.CWSiegeImperialSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeImperialSoldier5Instance = kmyQuest.CWOSiegeImperialSoldier5.PlaceActorAtMe(kmyQuest.CWSiegeImperialSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeImperialSoldier6Instance = kmyQuest.CWOSiegeImperialSoldier6.PlaceActorAtMe(kmyQuest.CWSiegeImperialSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeImperialSoldier7Instance = kmyQuest.CWOSiegeImperialSoldier7.PlaceActorAtMe(kmyQuest.CWSiegeImperialSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeImperialSoldier8Instance = kmyQuest.CWOSiegeImperialSoldier8.PlaceActorAtMe(kmyQuest.CWSiegeImperialSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeImperialSoldier9Instance = kmyQuest.CWOSiegeImperialSoldier9.PlaceActorAtMe(kmyQuest.CWSiegeImperialSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeImperialSoldier10Instance = kmyQuest.CWOSiegeImperialSoldier10.PlaceActorAtMe(kmyQuest.CWSiegeImperialSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeSonsSoldier1Instance = kmyQuest.CWOSiegeSonsSoldier1.PlaceActorAtMe(kmyQuest.CWSiegeSonsSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeSonsSoldier2Instance = kmyQuest.CWOSiegeSonsSoldier2.PlaceActorAtMe(kmyQuest.CWSiegeSonsSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeSonsSoldier3Instance = kmyQuest.CWOSiegeSonsSoldier3.PlaceActorAtMe(kmyQuest.CWSiegeSonsSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeSonsSoldier4Instance = kmyQuest.CWOSiegeSonsSoldier4.PlaceActorAtMe(kmyQuest.CWSiegeSonsSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeSonsSoldier5Instance = kmyQuest.CWOSiegeSonsSoldier5.PlaceActorAtMe(kmyQuest.CWSiegeSonsSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeSonsSoldier6Instance = kmyQuest.CWOSiegeSonsSoldier6.PlaceActorAtMe(kmyQuest.CWSiegeSonsSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeSonsSoldier7Instance = kmyQuest.CWOSiegeSonsSoldier7.PlaceActorAtMe(kmyQuest.CWSiegeSonsSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeSonsSoldier8Instance = kmyQuest.CWOSiegeSonsSoldier8.PlaceActorAtMe(kmyQuest.CWSiegeSonsSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeSonsSoldier9Instance = kmyQuest.CWOSiegeSonsSoldier9.PlaceActorAtMe(kmyQuest.CWSiegeSonsSoldier, 4, kmyQuest.CWOTESTEZ)
CWOSiegeSonsSoldier10Instance = kmyQuest.CWOSiegeSonsSoldier10.PlaceActorAtMe(kmyQuest.CWSiegeSonsSoldier, 4, kmyQuest.CWOTESTEZ)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor CWOSiegeImperialSoldier1Instance
Actor CWOSiegeImperialSoldier2Instance
Actor CWOSiegeImperialSoldier3Instance
Actor CWOSiegeImperialSoldier4Instance
Actor CWOSiegeImperialSoldier5Instance
Actor CWOSiegeImperialSoldier6Instance
Actor CWOSiegeImperialSoldier7Instance
Actor CWOSiegeImperialSoldier8Instance
Actor CWOSiegeImperialSoldier9Instance
Actor CWOSiegeImperialSoldier10Instance
Actor CWOSiegeSonsSoldier1Instance
Actor CWOSiegeSonsSoldier2Instance
Actor CWOSiegeSonsSoldier3Instance
Actor CWOSiegeSonsSoldier4Instance
Actor CWOSiegeSonsSoldier5Instance
Actor CWOSiegeSonsSoldier6Instance
Actor CWOSiegeSonsSoldier7Instance
Actor CWOSiegeSonsSoldier8Instance
Actor CWOSiegeSonsSoldier9Instance
Actor CWOSiegeSonsSoldier10Instance

Actor CWOBeast1Instance
Actor CWOBeast2Instance
