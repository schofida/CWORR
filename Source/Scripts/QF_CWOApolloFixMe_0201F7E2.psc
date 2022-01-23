scriptName QF_CWOApolloFixMe_0201F7E2 extends Quest hidden

;-- Properties --------------------------------------
referencealias property Alias_TravelMarker auto
referencealias property Alias_Player auto
referencealias property Alias_PlayerMarker auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function Fragment_3()

	Quest __temp = self as Quest
	cwmission10script kmyQuest = __temp as cwmission10script
	self.SetObjectiveDisplayed(20, 1 as Bool, false)
	game.EnablePlayercontrols(true, true, true, true, true, true, true, true, 0)
	Alias_PlayerMarker.GetReference().disable(false)
	Alias_PlayerMarker.GetReference().delete()
	self.stop()
endFunction

; Skipped compiler generated GotoState

; Skipped compiler generated GetState

function Fragment_2()

	Quest __temp = self as Quest
	cwmission10script kmyQuest = __temp as cwmission10script
;	self.SetObjectiveDisplayed(10, 1 as Bool, false)
;	utility.wait(1 as Float)
;	kmyQuest.CWsiege.setstage(50)
;	kmyQuest.CWAttackCity.setstage(50)
;	kmyQuest.CWFortsiegeFort.setstage(1000)
;	kmyQuest.CWFortSiegeCapital.setstage(1000)
;	kmyQuest.CWmission03.setstage(100)
;	kmyQuest.CWmission04.setstage(100)
;	kmyQuest.CWmission07.setstage(100)
;	utility.wait(10 as Float)
;	if kmyQuest.CWs.PlayerAllegiance == kmyQuest.CWs.iImperials
;		if kmyQuest.CWs.GetHoldowner(3) == kmyQuest.CWs.ISons
;			kmyQuest.CWOCurrentHold.SetValueInt(3)
;		elseIf kmyQuest.CWs.GetHoldowner(2) == kmyQuest.CWs.ISons
;			kmyQuest.CWOCurrentHold.SetValueInt(2)
;		elseIf kmyQuest.CWs.GetHoldowner(5) == kmyQuest.CWs.ISons
;			kmyQuest.CWOCurrentHold.SetValueInt(5)
;		elseIf kmyQuest.CWs.GetHoldowner(4) == kmyQuest.CWs.ISons
;			kmyQuest.CWOCurrentHold.SetValueInt(4)
;		elseIf kmyQuest.CWs.GetHoldowner(6) == kmyQuest.CWs.ISons
;			kmyQuest.CWOCurrentHold.SetValueInt(6)
;		elseIf kmyQuest.CWs.GetHoldowner(9) == kmyQuest.CWs.ISons
;			kmyQuest.CWOCurrentHold.SetValueInt(9)
;		elseIf kmyQuest.CWs.GetHoldowner(7) == kmyQuest.CWs.ISons
;			kmyQuest.CWOCurrentHold.SetValueInt(7)
;		endIf
;	elseIf kmyQuest.CWs.PlayerAllegiance == kmyQuest.CWs.ISons
;		if kmyQuest.CWs.GetHoldowner(7) == kmyQuest.CWs.iImperials
;			kmyQuest.CWOCurrentHold.SetValueInt(7)
;		elseIf kmyQuest.CWs.GetHoldowner(9) == kmyQuest.CWs.iImperials
;			kmyQuest.CWOCurrentHold.SetValueInt(9)
;		elseIf kmyQuest.CWs.GetHoldowner(6) == kmyQuest.CWs.iImperials
;			kmyQuest.CWOCurrentHold.SetValueInt(6)
;		elseIf kmyQuest.CWs.GetHoldowner(4) == kmyQuest.CWs.iImperials
;			kmyQuest.CWOCurrentHold.SetValueInt(4)
;		elseIf kmyQuest.CWs.GetHoldowner(5) == kmyQuest.CWs.iImperials
;			kmyQuest.CWOCurrentHold.SetValueInt(5)
;		elseIf kmyQuest.CWs.GetHoldowner(2) == kmyQuest.CWs.iImperials
;			kmyQuest.CWOCurrentHold.SetValueInt(2)
;		elseIf kmyQuest.CWs.GetHoldowner(3) == kmyQuest.CWs.iImperials
;			kmyQuest.CWOCurrentHold.SetValueInt(3)
;		endIf
;	endIf
;	kmyQuest.CWs.CWODefendingActive.SetValueInt(0)
;	utility.wait(5 as Float)
;	kmyQuest.CWs.GetRikkeOrGalmar(-1).enable(false)
;	kmyQuest.MUSCombatCivilWar.remove()
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
endFunction

function Fragment_0()

	Quest __temp = self as Quest
	cwmission10script kmyQuest = __temp as cwmission10script
;	self.SetObjectiveDisplayed(0, 1 as Bool, false)
;	game.disableplayercontrols(true, true, false, false, false, true, true, false, 0)
;	utility.wait(2 as Float)
;	game.getplayer().moveto(Alias_TravelMarker.GetReference(), 0.000000, 0.000000, 0.000000, true)
;	utility.wait(1 as Float)
;	self.setstage(10)
endFunction
