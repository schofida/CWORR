Scriptname CWO_Xbox_Debug_Script extends ActiveMagicEffect

Quest Property CWOApolloFixMeQuest auto

Event OnEffectStart(actor AkTarget, actor AkCaster)
    CWOApolloFixMeScript CWOApolloFixMeS = CWOApolloFixMeQuest as CWOApolloFixMeScript
    Quest CW = CWOApolloFixMeS.CW
    CWScript CWs = CW as CWScript
    if CW.IsRunning()
        debug.Notification("Main CW Quest Is On Stage " + CW.Getstage() as String)
    endIf
    if game.Getplayer().IsInFaction(CWS.CWSonsFaction)
        debug.Notification("We are In The Sons Faction")
    elseIf game.Getplayer().IsInFaction(CWS.CWImperialFaction)
        debug.Notification("We are In the Imperial Faction")
    else
        debug.Notification("We are Not Yet Hostile")
    endIf
    if CWs.CWCampaign.IsRunning()
        debug.Notification("CWCampaign Quest Is On Stage " + CWs.CWCampaign.Getstage() as String + "; Phase " + CWs.CWCampaignS.CWCampaignPhase.GetValueInt())
    endIf

     if CWs.PlayerAllegiance == CWs.iImperials && CWs.CrimeFactionImperial.GetCrimeGold() > 0
        debug.Notification("CrimeFactionImperial Bounty Is Is " + CWs.CrimeFactionImperial.GetCrimeGold())
    elseif CWs.PlayerAllegiance == CWs.iSons && CWs.CrimeFactionSons.GetCrimeGold() > 0
        debug.Notification("CrimeFactionSons Bounty Is Is " + CWs.CrimeFactionSons.GetCrimeGold())
    endif

    if CWs.CWCampaignS.CWOMonitorQuest.IsRunning()
        debug.Notification("CWO Monitor State " + CWs.CWCampaignS.GetMonitorState())
    endif

    if CWs.CWCampaignS.CWOArmorDisguise.IsRunning()
        debug.Notification("CWOArmorDisguise Is On. Are you disguised? " + CWs.CWCampaignS.CWODisguiseGlobal.GetValueInt())
    endIf
    if CWs.CWCampaignS.CWOSendForPlayerQuest.IsRunning()
        debug.Notification("CWO Courier Quest Is On Stage " + CWs.CWCampaignS.CWOSendForPlayerQuest.Getstage() as String)
    endIf
    if CWs.CWCampaignS.CWMission01.IsRunning()
        debug.Notification("Skirmish at X Is On Stage " + CWs.CWCampaignS.CWMission01.Getstage() + " AP: " + ((CWs.CWSiegeS as Quest) as CWReinforcementControllerScript).PoolAttacker + " DP: " + ((CWs.CWSiegeS as Quest) as CWReinforcementControllerScript).PoolDefender)
    endIf
    if CWs.CWCampaignS.CWMission02.IsRunning()
        debug.Notification("Sabotage at X Is On Stage " + CWs.CWCampaignS.CWMission02.Getstage() as String)
    endIf
    if CWs.CWMission03.IsRunning()
        debug.Notification("A False Front Is On Stage " + CWs.CWMission03.Getstage() as String)
    endIf
    if CWs.CWMission04.IsRunning()
        debug.Notification("Rescue From X Is On Stage " + CWs.CWMission04.Getstage() as String)
    endIf
    if CWs.CWCampaignS.CWMission05.IsRunning()
        debug.Notification("X's Last Battle Is On Stage " + CWs.CWCampaignS.CWMission05.Getstage() as String)
    endIf
    if CWs.CWCampaignS.CWMission06.IsRunning()
        debug.Notification("Defector Collector Is On Stage " + CWs.CWCampaignS.CWMission06.Getstage() as String)
    endIf
    if CWs.CWMission07.IsRunning()
        debug.Notification("Compelling Tribute Is On Stage " + CWs.CWMission07.Getstage() as String)
    endIf
    if CWs.CWCampaignS.CWMission08Quest.IsRunning()
        debug.Notification("Can't Lead a Cow to Goldar Is On Stage " + CWs.CWCampaignS.CWMission08Quest.Getstage() as String)
    endIf
    if CWs.CWCampaignS.CWMission09.IsRunning()
        debug.Notification("X Marks the Docs Is On Stage " + CWs.CWCampaignS.CWMission09.Getstage() as String)
    endIf
    if CWs.CWSiegeS.IsRunning()
        debug.Notification("Major Siege Quest Is On Stage " + CWs.CWSiegeS.Getstage() + " AP: " + ((CWs.CWSiegeS as Quest) as CWReinforcementControllerScript).PoolAttacker + " DP: " + ((CWs.CWSiegeS as Quest) as CWReinforcementControllerScript).PoolDefender)
    endIf
    if CWs.CWFortsiegeFort.IsRunning()
        debug.Notification("Fort Siege Quest Is On Stage " + CWs.CWFortsiegeFort.Getstage() + " AP: " + (CWs.CWFortSiegeFort as CWReinforcementControllerScript).PoolAttacker + " DP: " + (CWs.CWFortSiegeFort as CWReinforcementControllerScript).PoolDefender)
    endIf
    if CWs.CWFortSiegeCapital.IsRunning()
        debug.Notification("Capital Siege Quest Is On Stage " + CWs.CWFortSiegeCapital.Getstage() + " AP: " + (CWs.CWFortSiegeCapital as CWReinforcementControllerScript).PoolAttacker + " DP: " + (CWs.CWFortSiegeCapital as CWReinforcementControllerScript).PoolDefender)
    endIf
    if cws.CWCampaignS.CWOStillABetterEndingMonitor.IsRunning()
        debug.Notification("Player Bleedout Monitor Is On")
    endif
    if CWs.CWCampaignS.PlayerAllegianceLastStand()
        debug.Notification("STILL A BETTER ENDING THAN MASS EFFECT 3 Is On")
    endIf
    if CWs.CWDefender.GetValueInt() == CWs.playerAllegiance
        debug.Notification("CWO Thinks you are on DEFENSE")
    else
        debug.Notification("CWO Thinks you are on OFFENSE/DEFAULT")
    endIf
    if CWS.CWcontestedHold.GetValueInt() == 1
        debug.Notification("CWO Thinks your current hold is HAAFINGAR")
    elseIf CWS.CWcontestedHold.GetValueInt() == 2
        debug.Notification("CWO Thinks your current hold is THE REACH")
    elseIf CWS.CWcontestedHold.GetValueInt() == 3
        debug.Notification("CWO Thinks your current hold is HJAALMARCH")
    elseIf CWS.CWcontestedHold.GetValueInt() == 4
        debug.Notification("CWO Thinks your current hold is Whiterun")
    elseIf CWS.CWcontestedHold.GetValueInt() == 5
        debug.Notification("CWO Thinks your current hold is Falkreath")
    elseIf CWS.CWcontestedHold.GetValueInt() == 6
        debug.Notification("CWO Thinks your current hold is THE PALE")
    elseIf CWS.CWcontestedHold.GetValueInt() == 7
        debug.Notification("CWO Thinks your current hold is Winterhold")
    elseIf CWS.CWcontestedHold.GetValueInt() == 8
        debug.Notification("CWO Thinks your current hold is EASTMARCH")
    elseIf CWS.CWcontestedHold.GetValueInt() == 9
        debug.Notification("CWO Thinks your current hold is THE RIFT")
    else
        debug.Notification("CWO Thinks your current hold is N/A")
    endIf
    debug.Notification("Haafingar is owned by the " + CWs.FactionName(CWs.GetHoldOwner(1)))
    debug.Notification("Hjaalmarch is owned by the " + CWs.FactionName(CWs.GetHoldOwner(3)))
    debug.Notification("The Reach is owned by the " + CWs.FactionName(CWs.GetHoldOwner(2)))
    debug.Notification("Falkreath is owned by the " + CWs.FactionName(CWs.GetHoldOwner(5)))
    debug.Notification("Whiterun is owned by the " + CWs.FactionName(CWs.GetHoldOwner(4)))
    debug.Notification("The Pale is owned by the " + CWs.FactionName(CWs.GetHoldOwner(6)))
    debug.Notification("The Rift is owned by the " + CWs.FactionName(CWs.GetHoldOwner(9)))
    debug.Notification("Winterhold is owned by the " + CWs.FactionName(CWs.GetHoldOwner(7)))
    debug.Notification("Eastmarch is owned by the " + CWs.FactionName(CWs.GetHoldOwner(8)))
EndEvent