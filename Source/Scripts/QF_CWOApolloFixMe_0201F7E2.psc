;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname QF_CWOApolloFixMe_0201F7E2 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE CWOApolloFixMeScript
Quest __temp = self as Quest
CWOApolloFixMeScript kmyQuest = __temp as CWOApolloFixMeScript
;END AUTOCAST
;BEGIN CODE
;Stage 20
game.EnablePlayercontrols(true, true, true, true, true, true, true, true, 0)
CWScript CWs = kmyQuest.CWs
CWCampaignScript CWCampaignS = kmyQuest.CWs.CWCampaignS
if CWCampaignS.CWMission01.IsRunning()
	debug.notification("Trying to fix CWMission01")
	(CWCampaignS.CWMission01 as CWMission01Script).TryToFixQuest()
	Stop()
	Return
endif
if CWCampaignS.CWMission02.IsRunning()
	debug.notification("Trying to fix CWMission02")
	(CWCampaignS.CWMission02 as CWMission02Script).TryToFixQuest()
	Stop()
	Return
endif
if CWCampaignS.CWMission08Quest.IsRunning()
	(CWCampaignS.CWMission08Quest as CWMission08Script).TryToFixQuest()
	Stop()
	return
endif
debug.notification("Nothing to fix....")
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE CWOApolloFixMeScript
Quest __temp = self as Quest
CWOApolloFixMeScript kmyQuest = __temp as CWOApolloFixMeScript
;END AUTOCAST
;BEGIN CODE
;	kmyQuest.CWs.CWODefendingActive.SetValueInt(0)
;	utility.wait(5 as Float)
;	kmyQuest.CWs.GetRikkeOrGalmar(-1).enable(false)
;	
;	kmyQuest.CWOArmorDisguises.stop()
;	game.getplayer().removefromfaction(kmyQuest.CWSonsFactionNPC)
;	game.getplayer().removefromfaction(kmyQuest.CWImperialFactionNPC)
;	if kmyQuest.CWs.PlayerAllegiance == 1
;		game.getplayer().addtofaction(kmyQuest.CWImperialFactionNPC)
;	elseIf kmyQuest.CWs.PlayerAllegiance == 2
;		game.getplayer().addtofaction(kmyQuest.CWSonsFactionNPC)
;	endIf
;	kmyQuest.CWOArmorDisguises.Start()
;	kmyQuest.CW.setstage(4)
;	game.getplayer().moveto(Alias_PlayerMarker.GetReference(), 0.000000, 0.000000, 0.000000, true)
;	utility.wait(1 as Float)
;	self.setstage(20)

;Stage 10
	CWScript.Log("CWScript", "GetCWOUnstuck()")
	game.EnablePlayercontrols(true, true, true, true, true, true, true, true, 0)

	CWScript CWs = kmyQuest.CWs
	CWCampaignScript CWCampaignS = kmyQuest.CWs.CWCampaignS

	kmyQuest.KickOffUpdateIfNeeded()
	
	if CWs.WarIsActive == 0 && (CWs.WhiteRunSiegeStarted || CWs.CW03.GetStageDone(50)) && !CWs.WhiterunSiegeFinished && !CWs.CWSiegeS.isRunning() ;I BELIEVE THIS SHOULD ONLY BE THE GENERIC FIELD CO IN WHITERUN CITY
		CWScript.Log("CWScript", self + "GetCWOUnstuck() IsPlayerInMyFaction == true && WarIsActive == false, CWs.CW03.GetStageDone(" + 50 + ") == true,  so starting the siege at Whiterun by calling CWScript SetFieldCOAlias() and CreateMissions()")
		debug.notification("Trying to start Whiterun Siege")
	    CWs.CreateMissions(CWs.WhiterunHoldLocation, CWs.GetReferenceHQFieldCOForHold(CWs.WhiterunHoldLocation, Cws.PlayerAllegiance), ForceFinalSiege = true)
		Stop()
		Return
    endif
	if CWs.WhiterunSiegeFinished && kmyQuest.CW.IsRunning() && CWCampaignS.GetMonitorState() == "DoNothing" ;I BELIEVE THIS SHOULD ONLY BE THE GENERIC FIELD CO IN WHITERUN CITY
		CWScript.Log("CWScript", self + "GetCWOUnstuck() CWs.WhiterunSiegeFinished && kmyQuest.CW.IsRunning() && CWCampaignS.GetMonitorState() == 'DoNothing'")
		debug.notification("CW03 Never started CWO Monitor. Let's get er goin..")
		CWs.CWCampaignS.SetMonitorWaitingToStartCampaign()
		Stop()
		Return
    endif
	if CWs.WarIsActive == 1 && CWs.CWCampaign.IsRunning() && CWs.CWCampaign.GetStage() == 0
		debug.notification("Conversation with General did not trigger Campaign to start. Setting CW Stage to 4")
		CWs.SetStage(4)
		Stop()
		Return
	endif
	if CWs.PlayerAllegiance == CWs.iImperials && CWs.WarIsActive == 1 && !CWs.CWCampaign.IsRunning() && CWs.FactionOwnsAll(cws.playerAllegiance)
		if !CWs.CWFortSiegeFort.IsRunning() && !CWS.EastmarchFortBattleComplete
			debug.notification("Trying to start Final Fort Siege")
			CWs.CreateMissions(CWs.EastmarchHoldLocation, CWs.Rikke.GetActorReference(), false)
			Stop()
			Return
		elseif !CWs.CWSiegeS.IsRunning() && CWS.EastmarchFortBattleComplete
			debug.notification("Trying to start Final Siege")
			CWs.CreateMissions(CWs.EastmarchHoldLocation, CWs.Rikke.GetActorReference(), true)
			Stop()
			Return
		endif
	elseif CWs.PlayerAllegiance == CWs.iSons && CWs.WarIsActive == 1 && !CWs.CWCampaign.IsRunning() && CWs.FactionOwnsAll(cws.playerAllegiance)
		if !CWs.CWFortSiegeFort.IsRunning() && !CWS.HaafingarFortBattleComplete
			debug.notification("Trying to start Final Siege")
			CWs.CreateMissions(CWs.HaafingarHoldLocation, CWs.Galmar.GetActorReference(), false)
			Stop()
			Return
		elseif !CWs.CWSiegeS.IsRunning() && CWS.HaafingarFortBattleComplete
			debug.notification("Trying to start Final Siege")
			CWs.CreateMissions(CWs.HaafingarHoldLocation, CWs.Galmar.GetActorReference(), true)
			Stop()
			Return
		endif
	endif
	if CWs.CWMission03.IsRunning()
		(CWs.CWMission03 as CWMission03Script).TryToFixQuest()
		Stop()
		return
	endif
	if CWs.CWMission04.IsRunning()
		(CWs.CWMission04 as CWMission04Script).TryToFixQuest()
		Stop()
		return
	endif
	if CWCampaignS.CWMission05.IsRunning()
		(CWCampaignS.CWMission05 as CWMission05Script).TryToFixQuest()
		Stop()
		return
	endif
	if CWCampaignS.CWMission06.IsRunning()
		(CWCampaignS.CWMission06 as CWMission06Script).TryToFixQuest()
		Stop()
		return
	endif
	if CWs.CWMission07.IsRunning()
		debug.notification("Trying to fix CWMission07")
		(CWs.CWMission07 as CWMission07Script).TryToFixQuest()
		Stop()
		Return
	endif
	if CWCampaignS.CWMission09.IsRunning()
		(CWCampaignS.CWMission09 as CWMission09Script).TryToFixQuest()
		Stop()
		return
	endif
	if CWS.CWFortSiegeFort.IsRunning()
		debug.notification("Trying to fix CWFortSiegeFort")		
		(CWS.CWFortSiegeFort as CWFortSiegeScript).TryToFixQuest()
		Stop()
		Return
	endif
	if cws.CWFortSiegeCapital.IsRunning()
		debug.notification("Trying to fix CWFortSiegeCapital")		
		(CWS.CWFortSiegeFort as CWFortSiegeScript).TryToFixQuest()
		Stop()
		Return
	endif
	if CWs.CWSiegeS.IsRunning()
		debug.notification("Trying to fix CWSiegeS")	
		(CWs.CWSiegeS).TryToFixQuest()
		Stop()
		Return
	endif
	debug.notification("Nothing to fix....")
	Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN AUTOCAST TYPE CWOApolloFixMeScript
Quest __temp = self as Quest
CWOApolloFixMeScript kmyQuest = __temp as CWOApolloFixMeScript
;END AUTOCAST
;BEGIN CODE
;Stage 40
debug.notification("Setting enemy faction reaction to neutral")
kmyQuest.CWs.CWCampaigns.StopDisguiseQuest(true)
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE CWOApolloFixMeScript
Quest __temp = self as Quest
CWOApolloFixMeScript kmyQuest = __temp as CWOApolloFixMeScript
;END AUTOCAST
;BEGIN CODE
;Stage 30
debug.notification("Stopping Music")
kmyQuest.CWs.CWSiegeS.MUSCombatCivilWar.remove()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN AUTOCAST TYPE CWOApolloFixMeScript
Quest __temp = self as Quest
CWOApolloFixMeScript kmyQuest = __temp as CWOApolloFixMeScript
;END AUTOCAST
;BEGIN CODE
;Stage 60
debug.notification("Clearing Civil War Faction Crime")
kmyQuest.CWs.CWCampaignS.cwResetCrime()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE CWOApolloFixMeScript
Quest __temp = self as Quest
CWOApolloFixMeScript kmyQuest = __temp as CWOApolloFixMeScript
;END AUTOCAST
;BEGIN CODE
;Stage 50
debug.notification("Fixing Whiterun Drawbridge")
kmyQuest.WhiterunDrawbridge.PlayGamebryoAnimation("Backward", TRUE)
kmyQuest.WhiterunDrawbridgeNavCollision.Disable()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_1()
;BEGIN AUTOCAST TYPE CWOApolloFixMeScript
Quest __temp = self as Quest
CWOApolloFixMeScript kmyQuest = __temp as CWOApolloFixMeScript
;END AUTOCAST
;BEGIN CODE
;Stage 0
;END CODE
EndFunction
;END FRAGMENT
	

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
