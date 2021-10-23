Scriptname CWMapFlagScript extends ObjectReference  

ObjectReference Property MapMarker Auto

EVENT OnActivate(ObjectReference akActionRef)
	if (Game.GetPlayer())
		MapMarker.AddToMap()
	endif
endEVENT

;Reset and detach events added by USKP 1.2.1 to deal with bloat caused by CWMapActivatorScript.psc
EVENT OnReset()
    DisableNoWait()
    Delete()
endEVENT

Event OnCellDetach()
    DisableNoWait()
    Delete()
EndEvent
