;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname QF__02015BA4 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Hold
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Hold Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Debug.Notification("Spanish Inquisition Triggered. Starting Defense Quest.")
	CWS.CWCampaignS.StartSpanishInquisition(Alias_Hold)	; Reddit BugFix #11
	self.stop()
;END CODE
EndFunction
;END FRAGMENT

CWScript Property CWs Auto 

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
