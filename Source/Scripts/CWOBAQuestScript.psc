scriptName CWOBAQuestScript extends Quest Conditional

event OnInit()
    CWs = CW as CWScript
endevent

event OnUpdate()
    stop()
endevent

Quest Property CW  Auto  

CWScript Property CWS  Auto Hidden 

GlobalVariable Property QuestLength  Auto  

SPELL Property CWOBAInvisibility  Auto  

Bool Property TargetHit = false Auto hidden Conditional

Ammo Property CWOBASteelArrow Auto
Bool Property TargetFound = false  Auto hidden Conditional
