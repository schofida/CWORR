Scriptname DWRCGScript extends Quest  Conditional

Outfit Property pStormcloakOutfit Auto
Outfit Property pSteelArmorOutfit Auto
ReferenceAlias Property pCaius Auto
ReferenceAlias Property pSinmir Auto
Faction Property pCaptainGuardFaction Auto
ReferenceAlias Property GuardCaptain Auto ;USKP 2.0.4
ReferenceAlias Property GuardCaptainBackup Auto ;USKP 2.0.4
Quest Property TG03 Auto ;USKP 2.0.8
Quest Property TG03SP Auto ;USP 2.0.8
ReferenceAlias Property TG03Captain Auto ;USKP 2.0.8

;This function will set the Captains of the Guard
;Commander Caius moves to the Bannered Mare and Sinmir moves to Dragonsreach
Function StormcloakGo()

	pCaius.GetActorRef().SetOutfit(pSteelArmorOutfit,false)
	pCaius.GetActorRef().RemoveFromFaction(pCaptainGuardFaction)

	pSinmir.GetActorRef().SetOutfit(pStormcloakOutfit,false)
	pSinmir.GetActorRef().AddToFaction(pCaptainGuardFaction)

	WRCGTitleAlias.ForceRefTo(pSinmir.GetActorReference())
	
	;USKP 2.0.5 - Make sure he gets put into the Guard Captain alias on DialogueWhiterun, then clear the backup.
	GuardCaptain.ForceRefTo(pSinmir.GetActorReference())
	GuardCaptainBackup.Clear()

	;USKP 2.0.8 Bug #18073 - If TG03 is running, the captain's alias needs to get swapped there too.
	if( TG03.IsRunning() )
		TG03Captain.ForceRefTo(pSinmir.GetActorReference())
	EndIf

	;USKP 2.0.8 Bug #18073 - Same thing if TG03SP is running.
	if( TG03SP.IsRunning() )
		TG03Captain.ForceRefTo(pSinmir.GetActorReference())
	EndIf

endFunction

Function ImperialGo()

	pSinmir.GetActorRef().SetOutfit(pBandedIronArmorOutfit,false)
	pSinmir.GetActorRef().RemoveFromFaction(pCaptainGuardFaction)

	pCaius.GetActorRef().SetOutfit(pImperialOutfit,false)
	pCaius.GetActorRef().AddToFaction(pCaptainGuardFaction)

	;USKP 2.0.5 - Make sure he gets put into the Guard Captain alias on DialogueWhiterun, then clear the backup.
	GuardCaptain.ForceRefTo(pCaius.GetActorReference())
	GuardCaptainBackup.Clear()

	;USKP 2.0.8 Bug #18073 - If TG03 is running, the captain's alias needs to get swapped there too.
	if( TG03.IsRunning() )
		TG03Captain.ForceRefTo(pCaius.GetActorReference())
	EndIf

	;USKP 2.0.8 Bug #18073 - Same thing if TG03SP is running.
	if( TG03SP.IsRunning() )
		TG03Captain.ForceRefTo(pCaius.GetActorReference())
	EndIf

endFunction

Outfit Property pBandedIronArmorOutfit  Auto  

Outfit Property pImperialOutfit  Auto  

ReferenceAlias Property WRCGTitleAlias  Auto  
