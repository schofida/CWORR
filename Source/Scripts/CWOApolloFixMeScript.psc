Scriptname CWOApolloFixMeScript extends Quest

;## Quests ##
Quest Property CW  Auto  
Quest Property CWCampaign Auto  
Quest Property CWCampaignObj Auto  

;## Scripts ##
;These will be assigned in the OnInit() block
CWScript Property CWs Auto hidden
CWCampaignScript Property CWCampaignS Auto hidden

ObjectReference Property WhiterunDrawbridge Auto
ObjectReference Property WhiterunDrawbridgeNavCollision Auto

Event OnInit()
	
	CWs = CW as CWScript
	CWCampaignS = CWCampaign as CWCampaignScript
	
 	CWScript.Log("CWMissionScript", self + ": OnInit()")
	
EndEvent

function KickOffUpdateIfNeeded()
	Quest CWOMonitorQuest = CwCampaignS.CWOMonitorQuest
	if CWOMonitorQuest.IsRunning()
		CWOMonitorScript CWOMonitor = (CWOMonitorQuest.GetAlias(0) as CWOMonitorScript)
		if CWOMonitor != none && CWOMonitor.ftimeSinceLastRegisterForUpdate < Utility.GetCurrentRealTime() - 45.0
			CWOMonitor.RegisterForSingleUpdate(5)
			CWOMonitor.ftimeSinceLastRegisterForUpdate = Utility.GetCurrentRealTime()
		endif
	endif
EndFunction