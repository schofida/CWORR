scriptName QF_CWOSpanishInquisition_0201563D extends Quest hidden

;-- Properties --------------------------------------
cwscript property CWS auto
locationalias property Alias_Hold auto
referencealias property Alias_Player auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GotoState

function Fragment_2()

	CWS.CWCampaignS.StartSpanishInquisition(Alias_Hold)	; Reddit BugFix #11
	utility.wait(5 as Float)
	if CWS.CWsiegeS.IsRunning()
		CWS.CWsiegeS.SetStage(1)
	elseIf CWS.CWFortSiegeCapital.IsRunning()
		CWS.CWFortSiegeCapital.SetStage(10)
	endIf
	self.stop()
endFunction

; Skipped compiler generated GetState
