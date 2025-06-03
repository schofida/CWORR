scriptName QF_CWOSpanishInquisition_0201563D extends Quest hidden
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
	if CWS.CwCampaignS.CWODisableNotifications.GetValueInt() == 0
		CWOSpanishInquisition.Show()
	endif
	CWS.CWCampaignS.StartSpanishInquisition(Alias_Hold)	; Reddit BugFix #11
	self.stop()
;END CODE
EndFunction
;END FRAGMENT

CWScript Property CWs Auto 

Message Property CWOSpanishInquisition Auto

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
