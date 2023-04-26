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