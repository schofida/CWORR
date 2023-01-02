Scriptname CWOMonitorScript extends ReferenceAlias Conditional

CWscript property cws auto
Quest property CWSiegeQuest auto
Quest property CWSiegeCapitalQuest auto
Quest property CWAttackCityQuest auto
perk property Perk5 auto
perk property Perk3 auto
perk property Perk1 auto
perk property Perk4 auto
perk property Perk2 auto
perk property Perk6 auto
GlobalVariable property CWOVersion auto
GlobalVariable property CWOCurrentHold auto

Event init()
	;used by CWHoldManagerScript attached to this quest
	registerforsingleupdate(30)	
EndEvent	

auto State WaitingToStartNewCampaign

	function OnPlayerLoadGame()
		DoPlayerLoadGameStuff()
	endfunction

	Event OnUpdate()
		CWScript.log("CWScript", "State WaitingToStartNewCampaign OnUpdate()")

		if !cws.WhiterunSiegeFinished
			CWScript.log("CWScript", "WaitingToStartNewCampaign, War has not started yet. Bailing out here.")
			registerforsingleupdate(30)
			return
		endif
	 
		if cws.debugForceOffscreenResult == 1 && !(CWSiegeQuest as CWSiegeScript).GetQuestStillRunning() && !(CWSiegeCapitalQuest as CWFortSiegeScript).GetMinorCityQuestStillRunning()
			GoToState("StartingNewCampaignOffscreenMode")
			CWScript.log("CWScript", "WaitingToStartNewCampaign, WarIsActive == 1 & CWCampaign.IsRunning() == False, going to state StartingNewCampaignOffscreenMode.")
			
				;### START NEW CAMPAIGN
				cws.StartNewCampaign()
			
		elseif cws.CWCampaignS.FactionOwnsAll(cws.PlayerAllegiance) && \
			cws.CWDebugForceAttacker.GetValueInt() == cws.PlayerAllegiance && \
			!(CWSiegeQuest as CWSiegeScript).GetQuestStillRunning() && \
			!(CWSiegeCapitalQuest as CWFortSiegeScript).GetMinorCityQuestStillRunning() && \
			CWS.CWCampaign.IsRunning() == False
				GoToState("WaitingToFinishWar")
				if cws.PlayerAllegiance == cws.iImperials
					cws.CWContestedHold.setValueInt(cws.iEastmarch)
				Else
					cws.CWContestedHold.SetValueInt(cws.iHaafingar)
				endif
				cws.CWAttacker.value = cws.PlayerAllegiance
				cws.CWDefender.value = cws.getOppositeFactionInt(cws.PlayerAllegiance)

				CWs.setAttackDelta()
				CWs.purchaseDelta = CWs.AttackDelta
				CWScript.log("CWScript", "WaitingToStartNewCampaign, Player is taking final. Do not start a campaign. Simply let vanilla flow take over")
		elseif cws.CWCampaignS.FactionOwnsAll(cws.getOppositeFactionInt(cws.PlayerAllegiance)) && \
			cws.CWDebugForceAttacker.GetValueInt() == cws.getOppositeFactionInt(cws.PlayerAllegiance) && \
			!(CWSiegeQuest as CWSiegeScript).GetQuestStillRunning() && \
			!(CWSiegeCapitalQuest as CWFortSiegeScript).GetMinorCityQuestStillRunning() && \
			CWS.CWCampaign.IsRunning() == False
				GoToState("StartingNewCampaign")
				int contestedHold = 0
				if cws.PlayerAllegiance == cws.iImperials

					contestedHold = cws.iHaafingar
				Else
					contestedHold = cws.iEastMarch
				endif
				cws.CWContestedHold.setValueInt(contestedHold)
				cws.CWAttacker.value = cws.getOppositeFactionInt(cws.PlayerAllegiance)
				cws.CWDefender.value = cws.PlayerAllegiance

				cws.cwcampaigns.SetLastStand(1)

				CWs.setAttackDelta()
				CWs.purchaseDelta = CWs.AttackDelta
				CWScript.log("CWScript", "WaitingToStartNewCampaign, Opponent is taking final hold. Player must defend to keep from losing the war. ")

				CWs.startCampaignQuest(ContestedHold)
			
		elseif !(CWSiegeQuest as CWSiegeScript).GetQuestStillRunning() && !(CWSiegeCapitalQuest as CWFortSiegeScript).GetMinorCityQuestStillRunning() && CWS.CWCampaign.IsRunning() == False
				GoToState("StartingNewCampaign")
				CWScript.log("CWScript", "WaitingToStartNewCampaign, WarIsActive == 1 & CWCampaign.IsRunning() == False, going to state StartingNewCampaign.")
				cws.cwcampaigns.SetLastStand(0)
				;### START NEW CAMPAIGN
				cws.StartNewCampaign()
			
		
		Else
			CWScript.log("CWScript", "WaitingToStartNewCampaign, WarIsActive == 0, keep waiting.")
		
		EndIf
		registerforsingleupdate(30)
	EndEvent


EndState

State StartingNewCampaign

	function OnPlayerLoadGame()
		DoPlayerLoadGameStuff()
	endfunction
	Event OnUpdate()
			if (cws.CWContestedHold.GetValueInt() == cws.iEastmarch || cws.CWContestedHold.GetValueInt() == cws.iHaafingar) && cws.CWAttacker.GetValueInt() == cws.PlayerAllegiance
				GoToState("WaitingToFinishWar")

				CWScript.log("CWScript", "StartingNewCampaign, Player attacking final hold. Don't start campaign. Attack enemy fort and then city like in vanilla.")
			elseif cws.CWCampaign.IsRunning() == True
				GoToState("WaitingForCampaignToFinish")

				CWScript.log("CWScript", "StartingNewCampaign, CWCampaign.isRunning == True, going to state WaitingForCampaignToFinish.")
			elseif !cws.isrunning()
				CWScript.log("CWScript", "StartingNewCampaign, That's all folks. Thanks for Playing!")
				unregisterforupdate()
				GetOwningQuest().stop()	
				return	
			Else
				CWScript.log("CWScript", "StartingNewCampaign, CWCampaign.isRunning == False, waiting for CWCampaign to start.")
				
			endif
			registerforsingleupdate(30)
	EndEvent

EndState

State WaitingToFinishWar

	function OnPlayerLoadGame()
		DoPlayerLoadGameStuff()
	endfunction
	Event OnUpdate()
		if cws.CWDebugForceAttacker.Value != cws.PlayerAllegiance
			GoToState("WaitingToStartNewCampaign")
			CWScript.log("CWScript", "WaitingToFinishWar, Player lost final fort or city siege. Now its opponent's turn.")
			registerforsingleupdate(30)
		elseif cws.cwobj.getstagedone(255)
			CWScript.log("CWScript", "WaitingToFinishWar, That's all folks. Thanks for Playing!")
			unregisterforupdate()
			GetOwningQuest().Stop()
		else
			CWScript.log("CWScript", "WaitingToFinishWar, ...still waiting")
			registerforsingleupdate(30)	
		endif
	EndEvent

EndState

State StartingNewCampaignOffscreenMode
	function OnPlayerLoadGame()
		DoPlayerLoadGameStuff()
	endfunction
	Event OnUpdate()
		CWScript.log("CWScript", "StartingNewCampaignOffscreenMode state OnUpdate() is doing nothing until StartNewCampaign() function call has called ResolveOffscreen() and that function call has finished.")

		registerforsingleupdate(30)
	EndEvent

EndState

State WaitingForCampaignToFinish

	function OnPlayerLoadGame()
		DoPlayerLoadGameStuff()
	endfunction
	Event OnUpdate()
		Actor player = Game.GetPlayer()
		if cws.CWCampaign.IsRunning() == False
			GoToState("WaitingToStartNewCampaign")

			CWScript.log("CWScript", "WaitingForCampaignToFinish, CWCampaign.IsRunning() == False, going to state WaitingToStartNewCampaign.")
			registerforsingleupdate(5)
		Elseif (CWs.CWAttacker.GetValueInt() == CWs.playerAllegiance && Cws.CwCampaignS.FieldHQ.GetLocation() != none && player.IsInLocation(Cws.CwCampaignS.FieldHQ.GetLocation()) && CWs.FieldCO.GetActorRef() != none && CWs.FieldCO.GetActorRef().IsInLocation(Cws.CwCampaignS.FieldHQ.GetLocation())) || CWs.CWDefender.GetValueInt() == CWs.playerAllegiance
			CWScript.log("CWScript", "WaitingForCampaignToFinish, CWCampaign.IsRunning() == True, Player is in Camp start quests if there are none running.")
			CWs.CWCampaignS.StartMissions()
			registerforsingleupdate(10)
		Else
			CWScript.log("CWScript", "WaitingForCampaignToFinish, CWCampaign.IsRunning() == True, waiting for CWCampaign quest to stop.")
			registerforsingleupdate(30)
		endif
	EndEvent
EndState

State WaitingForPlayerToBeOutOfMajorCity

	function OnPlayerLoadGame()
		DoPlayerLoadGameStuff()
	endfunction
	Event OnUpdate()
	
		if !CWs.CWSiegeS.PlayerInMajorCity(self.GetActorRef())
			GoToState("WaitingForSiegeToStop")
			CWSiegeQuest.Stop()
			CWAttackCityQuest.Stop()
		endif
		registerforsingleupdate(5)
	EndEvent
EndState

State WaitingForPlayerToBeOutOfMinorCity

	function OnPlayerLoadGame()
		DoPlayerLoadGameStuff()
	endfunction
	Event OnUpdate()
	
		if !(CWs.CWFortSiegeCapital As CWFortSiegeScript).PlayerInMinorCity(self.GetActorRef())
			GoToState("WaitingForSiegeToStop")
			CWSiegeCapitalQuest.Stop()
		endif
		registerforsingleupdate(5)
	EndEvent
EndState

State WaitingForSiegeToStop

	function OnPlayerLoadGame()
		DoPlayerLoadGameStuff()
	endfunction
	Event OnUpdate()
	
		if cws.CWCampaign.IsRunning() == False
			GoToState("WaitingToStartNewCampaign")

			CWScript.log("CWScript", "WaitingForCampaignToFinish, CWCampaign.IsRunning() == False, going to state WaitingToStartNewCampaign.")
			registerforsingleupdate(5)
		else
			registerforsingleupdate(5)
		endif
	EndEvent
EndState


State ResolvingCampaignOffscreen

	function OnPlayerLoadGame()
		DoPlayerLoadGameStuff()
	endfunction

	Event OnUpdate()
		CWScript.log("CWScript", "ResolvingCampaignOffscreen state OnUpdate() is doing nothing until ResolveOffscreen() function call has finished.")

		registerforsingleupdate(30)
	EndEvent

EndState

;-- State -------------------------------------------
state Rolling
	;schofida - hijacking this quest to add LoadGame specific stuff
	function OnPlayerLoadGame()
		DoPlayerLoadGameStuff()
	endfunction

	function onBeginState()
		;obselete
	endFunction

	function OnUpdate()
		;obselete
		registerforsingleupdate(30)
	endFunction
endState

;schofida - hijacking this quest to add LoadGame specific stuff
function OnPlayerLoadGame()
	DoPlayerLoadGameStuff()
endfunction

function DoPlayerLoadGameStuff()
	Utility.Wait(10)
	actor player = Game.GetPlayer()
	(CWS as CWScript).debugOn.setValue(1)
	if CWOVersion.GetValueInt() < 302
		player.RemoveFromFaction(CWs.CWSonsFactionNPC)
		player.RemoveFromFaction(CWs.CWImperialFactionNPC)
		if CWs.playerAllegiance == CWs.iImperials && CWs.WhiterunSiegeFinished
			player.AddToFaction(CWs.CWImperialFaction)
		endif
		CWOVersion.SetValueInt(302)
	endif
	if CWOVersion.GetValueInt() < 304
		if !CWs.WhiterunSiegeFinished
			CWOCurrentHold.SetValueInt(4)
		endif
		CWOVersion.SetValueInt(304)
	endif
	if CWOVersion.GetValueInt() < 405
		if CWs.CWCampaignS.CWOStillABetterEndingMonitor.IsRunning()
			CWs.CWCampaignS.CWOStillABetterEndingMonitor.Stop()
			utility.Wait(3.0)
			CWs.CWCampaignS.CWOStillABetterEndingMonitor.Start()
		endif
		CWOVersion.SetValueInt(405)
	endif
	if CWOVersion.GetValueInt() < 10000
		if !CWs.WhiterunSiegeFinished
			CWS.CWContestedHold.SetValueInt(4)
			cws.ContestedHold = 4
			CWS.CWAttacker.SetValueInt(2)
			CWs.CWDefender.SetValueInt(1)
		endif
		player.RemovePerk(perk1)
		player.RemovePerk(perk2)
		player.RemovePerk(perk3)
		player.RemovePerk(perk4)
		player.RemovePerk(perk5)
		player.RemovePerk(perk6)
		cws.cwcampaigns.CWMission01.Stop()
		cws.cwcampaigns.CWMission02.Stop()
		cws.cwcampaigns.CWMission06.Stop()
		cws.cwcampaigns.CWMission08Quest.Stop()
		cws.cwcampaigns.CWMission09.Stop()
		unregisterforupdate()
		CWOVersion.SetValueInt(10000)
		GoToState("WaitingToStartNewCampaign")
	endif
	if CWOVersion.GetValueInt() < 10003
		(GetOwningQuest() AS CWOQuestStarter).PlayerAlias.ForceRefTo(Player)
		CWOVersion.SetValueInt(10003)
	endif
	if CWOVersion.GetValueInt() < 10004
		cws.cwcampaigns.CWOMonitorQuest = GetOwningQuest()
		CWOVersion.SetValueInt(10004)
	endif
	if CWOVersion.GetValueInt() < 10005
		CWAttackCityQuest = Game.GetForm(0x0004F8BF) as Quest
		CWS.CWCampaignS.CWAttackCity = CWAttackCityQuest
		CWOVersion.SetValueInt(10005)
	endif
	registerforsingleupdate(30)
endfunction
