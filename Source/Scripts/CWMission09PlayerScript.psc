ScriptName CWMission09PlayerScript Extends CWPlayerScript

event OnInit()
    AddInventoryEventFilter((GetOwningQuest() As CWMission09Script).CWDocumentsImperial)
    AddInventoryEventFilter((GetOwningQuest() As CWMission09Script).CWDocumentsSons)
endEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
    Utility.Wait(2.0)
    if GetOwningQuest().GetStage() < 200
        GetOwningQuest().SetStage(205)
    endif
endEvent