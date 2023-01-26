;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname QF_CWOApolloFixMe_0201F7E2 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE CWOApolloFixMeScript
Quest __temp = self as Quest
CWOApolloFixMeScript kmyQuest = __temp as CWOApolloFixMeScript
;END AUTOCAST
;BEGIN CODE
game.EnablePlayercontrols(true, true, true, true, true, true, true, true, 0)
kmyQuest.MUSCombatCivilWar.remove()
CWScript CWs = kmyQuest.CWs
CWCampaignScript CWCampaignS = kmyQuest.CWs.CWCampaignS
if CWCampaignS.CWMission05.IsRunning()
	(CWCampaignS.CWMission05 as CWMission05Script).TryToFixQuest()
	return
endif
if CWCampaignS.CWMission06.IsRunning()
	(CWCampaignS.CWMission06 as CWMission06Script).TryToFixQuest()
	return
endif
if CWCampaignS.CWMission08Quest.IsRunning()
	(CWCampaignS.CWMission08Quest as CWMission08Script).TryToFixQuest()
	return
endif
if CWCampaignS.CWMission09.IsRunning()
	(CWCampaignS.CWMission09 as CWMission09Script).TryToFixQuest()
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
	CWScript.Log("CWScript", "GetCWOUnstuck()")
	game.EnablePlayercontrols(true, true, true, true, true, true, true, true, 0)
	kmyQuest.MUSCombatCivilWar.remove()
	CWScript CWs = kmyQuest.CWs
	CWCampaignScript CWCampaignS = kmyQuest.CWs.CWCampaignS
	if CWs.WarIsActive == 0 && CWs.WhiteRunSiegeStarted && CWs.CW03.GetStageDone(100) && !CWs.CWSiegeS.isRunning() ;I BELIEVE THIS SHOULD ONLY BE THE GENERIC FIELD CO IN WHITERUN CITY
		CWScript.Log("CWScript", self + "GetCWOUnstuck() IsPlayerInMyFaction == true && WarIsActive == false, CWs.CW03.GetStageDone(" + 100 + ") == true,  so starting the siege at Whiterun by calling CWScript SetFieldCOAlias() and CreateMissions()")
		debug.notification("Trying to start Whiterun Siege")
	    CWs.CreateMissions(CWs.WhiterunHoldLocation, CWs.GetReferenceHQFieldCOForHold(CWs.WhiterunHoldLocation, Cws.PlayerAllegiance), ForceFinalSiege = true)
		Stop()
    endif
	if CWs.WarIsActive == 1 && CWs.CWCampaign.IsRunning() && CWs.CWCampaign.GetStage() == 0
		debug.notification("Conversation with General did not trigger Campaign to start. Setting CW Stage to 4")
		CWs.SetStage(4)
		Stop()
	endif
	if CWs.PlayerAllegiance == CWs.iImperials && CWs.WarIsActive == 1 && !CWs.CWCampaign.IsRunning() && CWs.FactionOwnsAll(cws.playerAllegiance)
		if !CWs.CWFortSiegeFort.IsRunning() && !CWS.EastmarchFortBattleComplete
			debug.notification("Trying to start Final Fort Siege")
			CWs.CreateMissions(CWs.EastmarchHoldLocation, CWs.Rikke.GetActorReference(), false)
			Stop()
		elseif !CWs.CWSiegeS.IsRunning() && CWS.EastmarchFortBattleComplete
			debug.notification("Trying to start Final Siege")
			CWs.CreateMissions(CWs.EastmarchHoldLocation, CWs.Rikke.GetActorReference(), true)
			Stop()
		endif
	elseif CWs.PlayerAllegiance == CWs.iSons && CWs.WarIsActive == 1 && !CWs.CWCampaign.IsRunning() && CWs.FactionOwnsAll(cws.playerAllegiance)
		if !CWs.CWFortSiegeFort.IsRunning() && !CWS.HaafingarFortBattleComplete
			debug.notification("Trying to start Final Siege")
			CWs.CreateMissions(CWs.HaafingarHoldLocation, CWs.Galmar.GetActorReference(), false)
			Stop()
		elseif !CWs.CWSiegeS.IsRunning() && CWS.HaafingarFortBattleComplete
			debug.notification("Trying to start Final Siege")
			CWs.CreateMissions(CWs.HaafingarHoldLocation, CWs.Galmar.GetActorReference(), true)
			Stop()
		endif
	endif
	if CWCampaignS.CWMission01.IsRunning()
		debug.notification("Trying to fix CWMission01")
		(CWCampaignS.CWMission01 as CWMission01Script).TryToFixQuest()
		Stop()
	endif
	if CWCampaignS.CWMission02.IsRunning()
		debug.notification("Trying to fix CWMission02")
		(CWCampaignS.CWMission02 as CWMission02Script).TryToFixQuest()
		Stop()
	endif
	if CWs.CWMission07.IsRunning()
		debug.notification("Trying to fix CWMission07")
		(CWs.CWMission07 as CWMission07Script).TryToFixQuest()
		Stop()
	endif
	if CWS.CWFortSiegeFort.IsRunning() || cws.CWFortSiegeCapital.IsRunning()
		debug.notification("Trying to fix CWFortSiegeFort or CWFortSiegeCapital")		
		(CWS.CWFortSiegeFort as CWFortSiegeScript).TryToFixQuest()
		Stop()
	endif
	if CWs.CWSiegeS.IsRunning()
		debug.notification("Trying to fix CWSiegeS")	
		(CWs.CWSiegeS).TryToFixQuest()
		Stop()
	endif
	debug.notification("Nothing to fix....")
	Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
