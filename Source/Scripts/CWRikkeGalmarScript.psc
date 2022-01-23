Scriptname CWRikkeGalmarScript extends ReferenceAlias  


Event OnCellDetach()
 	CWScript.Log("CWRikkeGalmarScript", self + "OnCellDetach() Calling MoveRikkeGalmarToCampIfNeeded() because GetStageDone(4) == true")
	;CWO Use new Campaign Function
	(GetOwningQuest() as CWScript).CWCampaignS.MoveRikkeGalmarToCampIfNeeded()
EndEvent

Event OnDetachedFromCell()
 	CWScript.Log("CWRikkeGalmarScript", self + "OnDetachedFromCell() Calling MoveRikkeGalmarToCampIfNeeded() because GetStageDone(4) == true")
	;CWO Use new Campaign Function
	(GetOwningQuest() as CWScript).CWCampaignS.MoveRikkeGalmarToCampIfNeeded()
EndEvent

Event OnPackageChange(Package akOldPackage)
	if GetOwningQuest().GetStageDone(4)
 		CWScript.Log("CWRikkeGalmarScript", self + "OnPackageChange() Calling MoveRikkeGalmarToCampIfNeeded() because GetStageDone(4) == true")
		;CWO Use new Campaign Function
		(GetOwningQuest() as CWScript).CWCampaignS.MoveRikkeGalmarToCampIfNeeded(CheckIfUnloaded = true)
	EndIf

EndEvent

