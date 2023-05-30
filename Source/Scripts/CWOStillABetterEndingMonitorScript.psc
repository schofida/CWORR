scriptName CWOStillABetterEndingMonitorScript extends Quest

Quest Property triggerQuest Auto Hidden

ObjectReference Property CWGarrisonEnableMarkerSonsCampHjaalmarch  Auto  

ObjectReference Property CWGarrisonEnableMarkerSonsCampFalkreath  Auto  

ObjectReference Property CWGarrisonEnableMarkerSonsCampReach  Auto  

ObjectReference Property CWGarrisonEnableMarkerSonsCampWhiterun  Auto  

ObjectReference Property CWGarrisonEnableMarkerSonsCampPale  Auto  

ObjectReference Property CWGarrisonEnableMarkerSonsCampRift  Auto  

ObjectReference Property CWGarrisonEnableMarkerSonsCampWinterhold  Auto  

ObjectReference Property CWGarrisonEnableMarkerImperialCampHjaalmarch  Auto  

ObjectReference Property CWGarrisonEnableMarkerImperialCampReach  Auto  

ObjectReference Property CWGarrisonEnableMarkerImperialCampFalkreath  Auto  

ObjectReference Property CWGarrisonEnableMarkerImperialCampWhiterun  Auto  

ObjectReference Property CWGarrisonEnableMarkerImperialCampPale  Auto  

ObjectReference Property CWGarrisonEnableMarkerImperialCampRift  Auto  

ObjectReference Property CWGarrisonEnableMarkerImperialCampWinterhold  Auto  

Quest Property CW Auto

CWScript CWs

Event OnInit()
    CWs = CW as CWScript
EndEvent

ObjectReference function GetCampEnableMarkerByHoldID(int holdID)
    if CWs.PlayerAllegiance == CWs.iImperials
        return GetImperialCampEnableMarkerByHoldID(holdID)
    else
        return GetSonsCampEnableMarkerByHoldID(holdID)
    endif
EndFunction

ObjectReference function GetImperialCampEnableMarkerByHoldID(int HoldToCheck)
    if HoldToCheck == CWs.iReach
		return CWGarrisonEnableMarkerImperialCampReach
	elseif HoldToCheck == CWs.iHjaalmarch
		return CWGarrisonEnableMarkerImperialCampHjaalmarch
	elseif HoldToCheck == CWs.iWhiterun
        return CWGarrisonEnableMarkerImperialCampWhiterun
	elseif HoldToCheck == CWs.iFalkreath
        return CWGarrisonEnableMarkerImperialCampFalkreath
	elseif HoldToCheck == CWs.iPale
        return CWGarrisonEnableMarkerImperialCampPale
	elseif HoldToCheck == CWs.iRift
		return CWGarrisonEnableMarkerImperialCampRift
	elseif HoldToCheck == CWs.iWinterhold
		return CWGarrisonEnableMarkerImperialCampWinterhold
	else
		CWScript.log("CWScript", "GetImperialCampEnableMarkerByHoldID(" + HoldToCheck + ") location unrecognized. Expected one of the nine holds, got something else.", 2)
		return none
	
	EndIf 
EndFunction

ObjectReference function GetSonsCampEnableMarkerByHoldID(int HoldToCheck)
    if HoldToCheck == CWs.iReach
		return CWGarrisonEnableMarkerSonsCampReach
	elseif HoldToCheck == CWs.iHjaalmarch
		return CWGarrisonEnableMarkerSonsCampHjaalmarch
	elseif HoldToCheck == CWs.iWhiterun
        return CWGarrisonEnableMarkerSonsCampWhiterun
	elseif HoldToCheck == CWs.iFalkreath
        return CWGarrisonEnableMarkerSonsCampFalkreath
	elseif HoldToCheck == CWs.iPale
        return CWGarrisonEnableMarkerSonsCampPale
	elseif HoldToCheck == CWs.iRift
		return CWGarrisonEnableMarkerSonsCampRift
	elseif HoldToCheck == CWs.iWinterhold
		return CWGarrisonEnableMarkerSonsCampWinterhold
	else
		CWScript.log("CWScript", "GetSonsCampEnableMarkerByHoldID(" + HoldToCheck + ") location unrecognized. Expected one of the nine holds, got something else.", 2)
		return none
	
	EndIf 
EndFunction

ObjectReference function GetCampMapMarkerByHoldID(int holdID)
    if CWs.PlayerAllegiance == CWs.iImperials
        return GetImperialCampMapMarkerByHoldID(holdID)
    else
        return GetSonsCampMapMarkerByHoldID(holdID)
    endif
EndFunction

ObjectReference function GetImperialCampMapMarkerByHoldID(int HoldToCheck)
    if HoldToCheck == CWs.iReach
		return CWs.MilitaryCampReachImperialMapMarker
	elseif HoldToCheck == CWs.iHjaalmarch
		return CWs.MilitaryCampHjaalmarchImperialMapMarker
	elseif HoldToCheck == CWs.iWhiterun
        return CWs.MilitaryCampWhiterunImperialMapMarker
	elseif HoldToCheck == CWs.iFalkreath
        return CWs.MilitaryCampFalkreathImperialMapMarker
	elseif HoldToCheck == CWs.iPale
        return CWs.MilitaryCampPaleImperialMapMarker
	elseif HoldToCheck == CWs.iRift
		return CWs.MilitaryCampRiftImperialMapMarker
	elseif HoldToCheck == CWs.iWinterhold
		return CWs.MilitaryCampWinterholdImperialMapMarker
	else
		CWScript.log("CWScript", "GetImperialCampMapMarkerByHoldID(" + HoldToCheck + ") location unrecognized. Expected one of the nine holds, got something else.", 2)
		return none
	
	EndIf 
EndFunction

ObjectReference function GetSonsCampMapMarkerByHoldID(int HoldToCheck)
    if HoldToCheck == CWs.iReach
		return CWs.MilitaryCampReachSonsMapMarker
	elseif HoldToCheck == CWs.iHjaalmarch
		return CWs.MilitaryCampHjaalmarchSonsMapMarker
	elseif HoldToCheck == CWs.iWhiterun
        return CWs.MilitaryCampWhiterunSonsMapMarker
	elseif HoldToCheck == CWs.iFalkreath
        return CWs.MilitaryCampFalkreathSonsMapMarker
	elseif HoldToCheck == CWs.iPale
        return CWs.MilitaryCampPaleSonsMapMarker
	elseif HoldToCheck == CWs.iRift
		return CWs.MilitaryCampRiftSonsMapMarker
	elseif HoldToCheck == CWs.iWinterhold
		return CWs.MilitaryCampWinterholdSonsMapMarker
	else
		CWScript.log("CWScript", "GetSonsCampMapMarkerByHoldID(" + HoldToCheck + ") location unrecognized. Expected one of the nine holds, got something else.", 2)
		return none
	
	EndIf 
EndFunction