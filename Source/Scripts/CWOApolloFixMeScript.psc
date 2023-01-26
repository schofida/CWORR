Scriptname CWOApolloFixMeScript extends Quest

;## Quests ##
Quest Property CW  Auto  
Quest Property CWCampaign Auto  
Quest Property CWCampaignObj Auto  

;## Scripts ##
;These will be assigned in the OnInit() block
CWScript Property CWs Auto hidden
CWCampaignScript Property CWCampaignS Auto hidden

MusicType Property MUSCombatCivilWar Auto

Event OnInit()
	
	CWs = CW as CWScript
	CWCampaignS = CWCampaign as CWCampaignScript
	
 	CWScript.Log("CWMissionScript", self + ": OnInit()")
	
EndEvent