Scriptname CWMission02SawmillLeverScript extends TrapLever

Quest Property CW  Auto 
CWScript Property CWs Auto hidden

Event OnInit()
	CWs = CW as CWScript
EndEvent

Event onActivate ( objectReference triggerRef )
    ; if activated by an actor, do nothing special. If activated by non-actor, assume trying to saw
    if triggerRef == Game.GetPlayer()
        ; show BUSY message
        ((CWs.CWCampaignS.CWMission02 as CWMission02Script).ResourceObject1.GetReference() As ResourceObjectSawMillScript).TryToSabotage(triggerRef)
    endif
EndEvent