scriptName QF__02015BA4 extends Quest hidden

;-- Properties --------------------------------------
locationalias property Alias_Hold auto
cwscript property CWS auto
referencealias property Alias_Player auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GetState

; Skipped compiler generated GotoState

function Fragment_2()

	CWS.CWCampaignS.StartSpanishInquisition(Alias_Hold)	; Reddit BugFix #11

	self.stop()
endFunction
