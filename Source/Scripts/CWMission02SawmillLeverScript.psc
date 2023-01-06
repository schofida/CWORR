Scriptname CWMission02SawmillLeverScript extends ReferenceAlias

ReferenceAlias Property ResourceObjectSawMill Auto

Event onActivate ( objectReference triggerRef )
    ; if activated by an actor, do nothing special. If activated by non-actor, assume trying to saw
    if triggerRef == Game.GetPlayer()
        ; show BUSY message
        (ResourceObjectSawMill.GetReference() As ResourceObjectSawMillScript).TryToSabotage(triggerRef)
    endif
EndEvent