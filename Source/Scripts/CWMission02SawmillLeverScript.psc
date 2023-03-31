Scriptname CWMission02SawmillLeverScript extends TrapLever

Quest Property CW Auto
CWScript Property CWs Auto Hidden

event OnInit()
    CWs = CW as CWScript
endevent

function onActivate ( objectReference triggerRef )
    ; if activated by an actor, do nothing special. If activated by non-actor, assume trying to saw
    if triggerRef == Game.GetPlayer()
        ; show BUSY message
        (CWs.CWCampaignS.CWMission02 as CWMission02Script).ResourceObject1.GetRef().DamageObject(9999)
        CWs.GetFaction(CWs.getOppositeFactionInt(CWs.PlayerAllegiance), false).SendAssaultAlarm()
    endif
endfunction