Scriptname CWOSendForPlayerQuestScript extends Quest

Faction Property CWODefensiveFaction  Auto  

Quest Property CW  Auto  

CWScript Property CWS  Auto Hidden 

GlobalVariable Property CWOCourierSentGlobal  Auto  

GlobalVariable Property CWOCourierHoursMin  Auto  

GlobalVariable Property CWOCourierHoursMax  Auto  

Quest Property Courier  Auto  

WICourierScript Property CourierS  Auto Hidden

LocationAlias Property CityAlias  Auto  

ReferenceAlias Property FieldCO  Auto  

Event OnInit()
    CWs = CW as CWScript
    CourierS = Courier as wicourierscript
EndEvent

Event OnUpdateGameTime()
    SetStage(5)
endevent
