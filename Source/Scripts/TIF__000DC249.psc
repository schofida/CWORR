;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__000DC249 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
CWScript CWs = GetOwningQuest() as CWScript

if CWs.GetStageDone(50) == false
	CWs.setStage(50)
Endif
if CWs.CW03.IsRunning()
	CWs.CW03.SetStage(210)
endif
if CWs.CWCampaignS.CWOSendForPlayerQuest.IsRunning() && (GetOwningQuest() as CWScript).CWCampaignS.CWOSendForPlayerQuest.GetStage() == 10
	CWs.CWCampaignS.CWOSendForPlayerQuest.SetStage(30)
Else
	CWs.CWSiegeS.SetStage(1)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
