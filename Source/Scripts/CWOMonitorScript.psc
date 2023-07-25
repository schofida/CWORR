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
Quest Property DialogueWhiterunCaptainOfTheGuard auto

ObjectReference Property WhiterunDrawbridge Auto
ObjectReference Property WhiterunDrawbridgeNavCollision Auto

Event init()
	;used by CWHoldManagerScript attached to this quest
	registerforsingleupdate(30)	
EndEvent	

Auto State DoNothing
	function OnPlayerLoadGame()
		DoPlayerLoadGameStuff()
	endfunction

	Event OnUpdate()
		
	endEvent
endState

State WaitingToStartNewCampaign

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
	 
		if cws.debugForceOffscreenResult == 1
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
					cws.ContestedHold = cws.iEastMarch
				Else
					cws.CWContestedHold.SetValueInt(cws.iHaafingar)
					cws.ContestedHold = cws.iHaafingar
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
				cws.ContestedHold = contestedHold
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
		elseif CWS.CWCampaign.IsRunning()
			GoToState("StartingNewCampaign")
			CWScript.log("CWScript", "WaitingToStartNewCampaign, Campaign is already running. Moving forward to StartingNewCampaign")
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
			bool InCampLocation  = false
			bool FieldCOInCampLocation  = false
			Location CurrentHold
			Actor FieldCO = CWs.GetRikkeOrGalmar(CWs.PlayerAllegiance)
			bool SiegeIsRunning = StringUtil.GetLength(CWs.CWCampaignS.isCWSiegesRunning()) > 0
			if !SiegeIsRunning && CWs.PlayerAllegiance == CWs.iImperials
				InCampLocation = GetActorRef().IsInLocation(CWs.MilitaryCampEastmarchImperialLocation)
				FieldCOInCampLocation = FieldCO.IsInLocation(CWs.MilitaryCampEastmarchImperialLocation)
				CurrentHold = CwS.EastmarchHoldLocation
			elseif !SiegeIsRunning
				InCampLocation = GetActorRef().IsInLocation(CWs.MilitaryCampHaafingarSonsLocation)
				FieldCOInCampLocation = FieldCO.IsInLocation(CWs.MilitaryCampHaafingarSonsLocation)
				CurrentHold = CWs.HaafingarHoldLocation
			endif
			if !SiegeIsRunning && InCampLocation && !FieldCOInCampLocation
				CWScript.log("CWScript", "WaitingToFinishWar, CO is not in Camp for some reason. Get em over there.")
				CWs.MoveRikkeGalmarToCampIfNeeded()
				registerforsingleupdate(5)
			elseif !SiegeIsRunning && InCampLocation && !FieldCOInCampLocation
				CWScript.log("CWScript", "WaitingToFinishWar, CO is in Camp but mission had not started. Starting mission.")
				CWs.CreateMissions(CurrentHold, FieldCo)
				registerforsingleupdate(30)
			else
				CWScript.log("CWScript", "WaitingToFinishWar, ...still waiting")
				registerforsingleupdate(30)	
			endif
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
		Actor player = GetActorRef()
		if cws.CWCampaign.IsRunning() == False
			GoToState("WaitingToStartNewCampaign")

			CWScript.log("CWScript", "WaitingForCampaignToFinish, CWCampaign.IsRunning() == False, going to state WaitingToStartNewCampaign.")
			registerforsingleupdate(5)
		Elseif (CWs.CWAttacker.GetValueInt() == CWs.playerAllegiance && Cws.CwCampaignS.FieldHQ.GetLocation() != none && player.IsInLocation(Cws.CwCampaignS.FieldHQ.GetLocation()) && CWs.FieldCO.GetActorRef() != none && CWs.FieldCO.GetActorRef().IsInLocation(Cws.CwCampaignS.FieldHQ.GetLocation())) || CWs.CWDefender.GetValueInt() == CWs.playerAllegiance
			CWScript.log("CWScript", "WaitingForCampaignToFinish, CWCampaign.IsRunning() == True, Player is in Camp start quests if there are none running.")
			CWs.CWCampaignS.StartMissions()
			registerforsingleupdate(10)
		Elseif CWs.CWAttacker.GetValueInt() == CWs.playerAllegiance && Cws.CwCampaignS.FieldHQ.GetLocation() != none && player.IsInLocation(Cws.CwCampaignS.FieldHQ.GetLocation()) && CWs.FieldCO.GetActorRef() != none && !CWs.FieldCO.GetActorRef().IsInLocation(Cws.CwCampaignS.FieldHQ.GetLocation())
			CWScript.log("CWScript", "WaitingForCampaignToFinish, CO is not in Camp for some reason. Get em over there.")
			CWs.CWCampaignS.MoveRikkeGalmarToCampIfNeeded()
			registerforsingleupdate(5)
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
		CWScript.log("CWScript", "WaitingForPlayerToBeOutOfMajorCity, OnUpdate()")
		if !CWs.CWSiegeS.PlayerInMajorCity(self.GetActorRef()) || !CWSiegeQuest.IsRunning()
			CWScript.log("CWScript", "WaitingForPlayerToBeOutOfMajorCity, going to state WaitingForSiegeToStop.")
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

			CWScript.log("CWScript", "WaitingForSiegeToStop, going to state WaitingToStartNewCampaign.")
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
	(CWS as CWScript).debugOn.setValue(0)
	CWs.TutorialMissionComplete = 1
	CWs.debugAllowNonAdjacentHolds = 1
	int currentVersion = CWOVersion.GetValueInt()
	if currentVersion < 302
		player.RemoveFromFaction(CWs.CWSonsFactionNPC)
		player.RemoveFromFaction(CWs.CWImperialFactionNPC)
		if CWs.playerAllegiance == CWs.iImperials && CWs.WhiterunSiegeFinished
			player.AddToFaction(CWs.CWImperialFaction)
		endif
		CWOVersion.SetValueInt(302)
	endif
	if currentVersion < 304
		if !CWs.WhiterunSiegeFinished
			CWOCurrentHold.SetValueInt(4)
		endif
		CWOVersion.SetValueInt(304)
	endif
	if currentVersion < 405
		if CWs.CWCampaignS.CWOStillABetterEndingMonitor.IsRunning()
			CWs.CWCampaignS.CWOStillABetterEndingMonitor.Stop()
			utility.Wait(3.0)
			CWs.CWCampaignS.CWOStillABetterEndingMonitor.Start()
		endif
		CWOVersion.SetValueInt(405)
	endif
	if currentVersion < 10000
		if !CWs.WhiterunSiegeFinished
			CWS.CWContestedHold.SetValueInt(4)
			cws.ContestedHold = 4
			CWS.CWAttacker.SetValueInt(2)
			CWs.CWDefender.SetValueInt(1)
			GoToState("DoNothing")
		else
			GoToState("WaitingToStartNewCampaign")
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
	endif
	if currentVersion < 10003
		(GetOwningQuest() AS CWOQuestStarter).PlayerAlias.ForceRefTo(Player)
		CWOVersion.SetValueInt(10003)
	endif
	if currentVersion < 10004
		cws.cwcampaigns.CWOMonitorQuest = GetOwningQuest()
		CWOVersion.SetValueInt(10004)
	endif
	if currentVersion < 10005
		CWAttackCityQuest = Game.GetForm(0x0004F8BF) as Quest
		CWS.CWCampaignS.CWAttackCity = CWAttackCityQuest
		CWOVersion.SetValueInt(10005)
	endif
	if currentVersion < 10006
		CWs.debugAllowNonAdjacentHolds = 1
		if CWs.CWCampaign.IsRunning()
			CWs.CWCampaignS.RemoveGeneralFromRewardFaction(CWs.UlfricRef)
			CWs.CWCampaignS.RemoveGeneralFromRewardFaction(CWs.GeneralTulliusRef)
		endif
		CWOVersion.SetValueInt(10006)
	endif
	if currentVersion < 10007
		CWOVersion.SetValueInt(10007)
	endif
	if currentVersion < 10008
		if Game.GetPlayer().IsInFaction((CWs.CWFinale as CWFinaleScript).CWFinaleTemporaryAllies)
			Game.GetPlayer().RemoveFromFaction((CWs.CWFinale as CWFinaleScript).CWFinaleTemporaryAllies)
		endif
		CWOVersion.SetValueInt(10008)
	endif
	if currentVersion < 10009
		if !DialogueWhiterunCaptainOfTheGuard.IsRunning()
			DialogueWhiterunCaptainOfTheGuard.Start()
		endif
		CWOVersion.SetValueInt(10009)
	endif
	if currentVersion < 10014
		if CWs.CWCampaignS.PlayerAllegianceLastStand() && CWs.CwSiegeS.GetStage() == 0
			if CWs.PlayerAllegiance == CWs.iImperials
				(CWs.CWSiegeS as CWSiegeScript).SetDefenderImperialV14((GetOwningQuest() as CWOQuestStarter).CWFieldCOImperialHaafingar)
			else
				(CWs.CWSiegeS as CWSiegeScript).SetDefenderSonsV14((GetOwningQuest() as CWOQuestStarter).CWFieldCOSonsEastmarch)
			endif	
		endif
		CWOVersion.SetValueInt(10014)
	endif
	if currentVersion < 10015
		CWs.CWCampaignS.SetCWCampaignFieldCOAliases()
		CWOVersion.SetValueInt(10015)	
		if CWs.CWCampaignS.CWOSendForPlayerQuest.IsRunning()
			(CWs.CWCampaignS.CWOSendForPlayerQuest AS CWOSendForPlayerQuestScript).CWs = CWs
		endif
	endif
	if currentVersion < 10016
		CWOVersion.SetValueInt(10016)	
	endif
	if currentVersion < 10017
		(cws.CwCampaignS.CWOSendForPlayerQuest as CWOSendForPlayerQuestScript).CWOCourierHoursMin.SetValueInt(1)
		(cws.CwCampaignS.CWOSendForPlayerQuest as CWOSendForPlayerQuestScript).CWOCourierHoursMax.SetValueInt(8)
		CWOVersion.SetValueInt(10017)	
	endif
	if currentVersion < 10018
		CWOVersion.SetValueInt(10018)
	endif
	if currentVersion < 10019
		CWOVersion.SetValueInt(10019)
		if SKSE.GetVersionRelease() > 0
		else
			Game.GetPlayer().AddSpell((GetOwningQuest() AS CWOQuestStarter).CWO_XBOX_BridgeFix_Spell)
			Game.GetPlayer().AddSpell((GetOwningQuest() AS CWOQuestStarter).CWO_XBOX_Debug_Spell)
			Game.GetPlayer().AddSpell((GetOwningQuest() AS CWOQuestStarter).CWO_XBOX_MusicFix_Spell)
			Game.GetPlayer().AddSpell((GetOwningQuest() AS CWOQuestStarter).CWO_XBOX_QuestFix_Spell)
			Game.GetPlayer().AddSpell((GetOwningQuest() AS CWOQuestStarter).CWO_XBOX_NPCFix_Spell)
		endif	
	endif
	if currentVersion < 10020
		CWOVersion.SetValueInt(10020)
		if !cws.WhiterunSiegeFinished
			cws.contestedHold = 0
		endif
	endif
	registerforsingleupdate(30)
endfunction
