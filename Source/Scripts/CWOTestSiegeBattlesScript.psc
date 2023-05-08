Scriptname CWOTestSiegeBattlesScript extends Quest

ObjectReference Property CWOSiegeImperialSoldier1 Auto
ObjectReference Property CWOSiegeImperialSoldier2 Auto
ObjectReference Property CWOSiegeImperialSoldier3 Auto
ObjectReference Property CWOSiegeImperialSoldier4 Auto
ObjectReference Property CWOSiegeImperialSoldier5 Auto
ObjectReference Property CWOSiegeImperialSoldier6 Auto
ObjectReference Property CWOSiegeImperialSoldier7 Auto
ObjectReference Property CWOSiegeImperialSoldier8 Auto
ObjectReference Property CWOSiegeImperialSoldier9 Auto
ObjectReference Property CWOSiegeImperialSoldier10 Auto
ObjectReference Property CWOSiegeSonsSoldier1 Auto
ObjectReference Property CWOSiegeSonsSoldier2 Auto
ObjectReference Property CWOSiegeSonsSoldier3 Auto
ObjectReference Property CWOSiegeSonsSoldier4 Auto
ObjectReference Property CWOSiegeSonsSoldier5 Auto
ObjectReference Property CWOSiegeSonsSoldier6 Auto
ObjectReference Property CWOSiegeSonsSoldier7 Auto
ObjectReference Property CWOSiegeSonsSoldier8 Auto
ObjectReference Property CWOSiegeSonsSoldier9 Auto
ObjectReference Property CWOSiegeSonsSoldier10 Auto

ActorBase Property CWSiegeImperialSoldier Auto
ActorBase Property CWSiegeSonsSoldier Auto
ActorBase Property CWOWhiteWolf  Auto  
ActorBase Property CWOImperialHound  Auto 

EncounterZone Property CWOTESTEZ Auto

Function CleanUpInstanceIfExists(Actor instance)
    if instance != none
        instance.Disable()
        instance.SetCriticalStage(instance.CritStage_DisintegrateEnd)
    endif
endFunction 
