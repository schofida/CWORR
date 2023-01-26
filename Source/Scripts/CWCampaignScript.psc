Scriptname CWCampaignScript extends Quest  Conditional

;#POINTER TO GLOBAL SHOW DEBUG TRACES
GlobalVariable property debugOn auto conditional					;0 = unset, 1 = set - show warnings
{Pointer to Global CWDebugOn, used to toggle campaign start message}


int property initCampaign auto conditional hidden ;0 = unset, 1 = running through initialization quest stages, -1 = finished

int property costPatrol auto conditional hidden 
int property ownerPatrol1 auto conditional hidden 
int property ownerPatrol2 auto conditional hidden 
int property ownerPatrol3 auto conditional hidden 
int property ownerPatrol4 auto conditional hidden 
int property ownerPatrol5 auto conditional hidden 

;What type each each offered mission? Used to flavor initial dialog when Field Officer is offering player missions
int property Mission1Type auto conditional	 hidden 						
int property Mission2Type auto conditional hidden 
int property Mission3Type auto conditional hidden 
;0 = un/reset
;100 = Tutorial / Ambush
;1 = attack settlement
;2 = sabotage resource
;3 = intercept courier
;4 = rescue soldier from fort prison
;5 = assassinate enemy field co
;6 = turn coats
;7 = blackmail steward
;8 - recruit a giant
;9 = steal plans
;10 - recruit a warrior ally
;11 - recruit orc ally
;200 - Fort Siege

;N = TBD


;*** Below is for debugging what is changing the properties in script -- note, this will break conditions functions, but I'm leaving it here for future reference.
;int __Mission1Type
;int property Mission1Type 
;	int function get()
;		return __Mission1Type
;	endFunction
;	function set(int value)
; ;		debug.tracestack("CWCampaignScript Mission1Type being set to: " + value)
;		__Mission1Type = value
;	endFunction
;endProperty

;int __Mission2Type
;int property Mission2Type
;	int function get()
;		return __Mission2Type
;	endFunction
;	function set(int value)
; ;		debug.tracestack("CWCampaignScript Mission2Type being set to: " + value)
;		__Mission2Type = value
;	endFunction
;endProperty



int Property ResolutionMissionType Auto Conditional Hidden
;1 = Attack Minor Hold Capital
;2 = Defend Minor Hold Capital
;3 = Attack Major Hold Capital
;4 = Defend Major Hold Capital

int property acceptedHooks auto conditional hidden 					;0 = un/reset, 1 = player has heard the opening mission hooks (unlocks mission topics)
int property acceptedMission auto conditional hidden 				;0 = un/reset, 1 = player has accepted a mission (suppresses other mission topics)

int Property acceptedTutorialHooks	Auto Conditional Hidden			;0 = un/reset, 1 = player has heard the opening mission hooks (unlocks mission topics)


int property resolutionPhase auto conditional hidden 		; N = at what CWCampaignPhase are we considered to be in the "resolution" phase, meaning the final mission (which can also resolve offscreen if player is absent)
																	;Reminder: GLOBAL CWCampaignPhase is the current phase

int property resolveOffscreen auto conditional hidden 		;0 = un/reset, 1 = waiting for CW to resolve offscreen and set this quest's stage 255 to stop it

int Property currentAttackDelta auto Conditional Hidden

int attackDeltaMissionBonus 	; this variable holds bonus attack delta points earned by completing certain CWMission quests -- see Add/SetAttackDeltaMissionBonus()

;"timer" variables
float property acceptDays auto conditional	 hidden 			;(set in stage 1) How many days we allow the player to accept a mission before advancing the phase without him
float property nextPhaseDay auto conditional hidden 			;At start of each phase, GameDaysPassed + acceptDays, after which we advance the phase
float property missionDays auto conditional hidden 			;(set in stage 1) How many days we allow the player to complete an accepted mission before we consider it a failure
int property failedMission auto conditional hidden 			;0 = unset, -N = player got dialog about failing mission, N = player just failed a mission of the numeric Mission type and should get dialogue about it (see comment under property "Mission1Type" above
int property completedMission auto conditional hidden 		;0 = unset, -N player got dialog about completing mission, N = player just completed a mission of the numeric Mission type and should get dialgoue about it (see comment under property "Mission1Type" above




int Property MissionAcceptancePollWait auto Hidden 						;How long to wait between ticks to poll for MissionAcceptance (see PollForMissionAcceptance())

int Property AttackDeltaBonusForKillingCapitalGarrison auto hidden						;how many points to add to the AttackDelta if the player killed all the guards in the capital location
Float Property AttackDeltaGarrisonValueModifierForDestroyingResource auto Hidden		;A multiplier to a garrison's cost when turning that garrison into a CurrentAttackDelta points... when the player destroys a resource, the garrison should contribute less to the attack delta. This is the multiplier that reflects that. Set in OnInit()


;## Quests ##
Quest Property CW  Auto  
{Pointer to CW Quest}

Quest Property CWMission00 Auto

Quest Property CWSiege Auto
{Pointer to CWSiegeScript on CWSiege}

;## Aliases ##
;Pointers to CWCampaign Aliases:

ReferenceAlias Property CampaignStartMarker auto

ReferenceAlias property Rikke Auto
ReferenceAlias property Galmar Auto

ReferenceAlias property GenericFieldCOImperial Auto
ReferenceAlias property GenericFieldCOSons Auto

ReferenceAlias property FieldCO Auto			;Actual field officer for player's faction (Rikke, or Galmar)
ReferenceAlias property EnemyFieldCO Auto		;Actual field officer for player's enemy (Generic Field Commander Imperial / Sons)

LocationAlias Property Hold	 Auto


LocationAlias Property Garrison1 Auto
LocationAlias Property Garrison2 Auto
LocationAlias Property Garrison3 Auto
LocationAlias Property Garrison4 Auto

ReferenceAlias Property Garrison1ResourceObject Auto
ReferenceAlias Property Garrison2ResourceObject Auto
ReferenceAlias Property Garrison3ResourceObject Auto
ReferenceAlias Property Garrison4ResourceObject Auto

LocationAlias Property Fort Auto

LocationAlias Property GarrisonDefenderOnly1 Auto
LocationAlias Property GarrisonDefenderOnly2 Auto
LocationAlias Property GarrisonDefenderOnly3 Auto
LocationAlias Property GarrisonDefenderOnly4 Auto
LocationAlias Property GarrisonDefenderOnly5 Auto
LocationAlias Property GarrisonDefenderOnly6 Auto

ReferenceAlias Property GarrisonDefenderOnly1ResourceObject Auto
ReferenceAlias Property GarrisonDefenderOnly2ResourceObject Auto
ReferenceAlias Property GarrisonDefenderOnly3ResourceObject Auto
ReferenceAlias Property GarrisonDefenderOnly4ResourceObject Auto


LocationAlias Property Capital Auto
LocationAlias Property CapitalHQ Auto

LocationAlias Property CampImperial Auto
LocationAlias Property CampSons Auto

LocationAlias Property FieldHQ Auto
LocationAlias Property EnemyFieldHQ Auto

ReferenceAlias Property CampEnableImperial Auto
ReferenceAlias Property CampEnableSons Auto

ReferenceAlias Property CampImperialLocationCenterMarker Auto
ReferenceAlias Property CampSonsLocationCenterMarker Auto
ReferenceAlias Property CapitalHQMarker Auto


LocationAlias Property Patrols Auto

ReferenceAlias Property PatrolsDefaultEnableImperial Auto
ReferenceAlias Property PatrolsDefaultEnableSons Auto


ReferenceAlias Property PatrolsEnableImperial1 Auto
ReferenceAlias Property PatrolsEnableImperial2 Auto
ReferenceAlias Property PatrolsEnableImperial3 Auto
ReferenceAlias Property PatrolsEnableImperial4 Auto
ReferenceAlias Property PatrolsEnableImperial5 Auto


ReferenceAlias Property PatrolsEnableSons1 Auto
ReferenceAlias Property PatrolsEnableSons2 Auto
ReferenceAlias Property PatrolsEnableSons3 Auto
ReferenceAlias Property PatrolsEnableSons4 Auto
ReferenceAlias Property PatrolsEnableSons5 Auto

;# EXTERNAL aliases:
;CWCampaignObj Aliases:
ReferenceAlias Property CWCampaignObjFieldCO Auto
ReferenceAlias Property CWCampaignObjFactionLeader Auto
ReferenceAlias Property CWCampaignObjCampaignStartMarker Auto
LocationAlias Property CWCampaignObjCampaignHold Auto


;## Globals ##
GlobalVariable Property GameDaysPassed Auto
GlobalVariable Property CWCampaignPhase Auto
GlobalVariable Property ResourceDestroyedAtStage Auto
GlobalVariable Property CWDebugSkipPurchase Auto		;if == 1, skips purchaing garrisons

;## Keywords ##
Keyword Property CWOwner Auto
Keyword Property CWCost Auto
Keyword Property CWPurchasedByAttacker Auto

Keyword Property CWMissionStart Auto
Keyword Property CWResolution01Start  Auto		;attack settlement capital resolution mission
Keyword Property CWResolution02Start  Auto		;defend settlement capital resolution mission
Keyword Property CWMissionTutorialStart Auto
Keyword Property CWSiegeStart Auto		;used to start siege attack and defend quests for cities


Keyword Property LocTypeCity Auto
Keyword Property LocTypeHabitation Auto

;## Location Ref Types ##
LocationRefType Property CWSoldier Auto
LocationRefType Property CWPatrolDefault Auto
LocationRefType Property CWPatrol1 Auto
LocationRefType Property CWPatrol2 Auto
LocationRefType Property CWPatrol3 Auto
LocationRefType Property CWPatrol4 Auto
LocationRefType Property CWPatrol5 Auto



;## Object References ##
ObjectReference Property CWMission1Ref Auto	;Passed in to SendStoryEvent when generating mission quests as a way to identify which mission #
ObjectReference Property CWMission2Ref Auto	;Passed in to SendStoryEvent when generating mission quests as a way to identify which mission #
ObjectReference Property CWMission3Ref Auto	;Passed in to SendStoryEvent when generating mission quests as a way to identify which mission #

;## Activators ##

;*** !! *** !! *** !! these are now just forms, and will be set with Game.GetForm(HEX ID) function rather than being pointed at in the editor. As soon as we get Activator objects in Papyrus, this need to change to point directly at the activators
Form Property ResourceObjectFarm auto hidden	;*** !!! TEMPORARILY SET IN OnInit() event using GetForm().... REMOVE THAT FROM THE OnInit() event
Form Property ResourceObjectMill auto hidden	;*** !!! TEMPORARILY SET IN OnInit() event using GetForm().... REMOVE THAT FROM THE OnInit() event
Form Property ResourceObjectMine auto hidden	;*** !!! TEMPORARILY SET IN OnInit() event using GetForm().... REMOVE THAT FROM THE OnInit() event

;## Scripts ##
;These will be assigned in the OnInit() block
CWScript Property CWs Auto hidden

;## CWO! LET'S FUCKING GO!! ##
;CWO Quests
CWOStillABetterEndingMonitorScript Property CWOStillABetterEndingMonitor Auto
Quest Property CWOArmorDisguise Auto
Quest Property CWOSendForPlayerQuest Auto
Quest Property CWMission01 Auto
Quest Property CWMission02 Auto
Quest Property CWMission05 Auto
Quest Property CWMission06 Auto
Quest Property CWMission08Quest Auto
Quest Property CWMission09 Auto
Quest Property CWAttackCity Auto
Quest Property CWOMonitorQuest Auto
Quest Property CWOBAController Auto
Quest Property CWOPartyCrasherCageMatch Auto
;House Quest
Quest Property HousePurchase Auto
;CWO Global Variables
GlobalVariable Property CWOPCChance Auto
GlobalVariable Property CWODisguiseGlobal Auto
GlobalVariable Property CWOCapitalReinforcements Auto
GlobalVariable Property CWOFortReinforcements Auto
GlobalVariable Property CWOSiegeReinforcements Auto
GlobalVariable Property CWOGarrisonReinforcements Auto
GlobalVariable Property CWOStillABetterEndingGlobal Auto
GlobalVariable Property CWOWarBegun Auto
GlobalVariable Property CWODisableFortSiegeFort auto
GlobalVariable Property CWODisableSolitudeSiege auto
GlobalVariable Property CWODisableWindhelmSiege auto
GlobalVariable Property CWODisableFaint auto
GlobalVariable Property CWOPlayerAttackerScaleMult Auto
GlobalVariable Property CWOPlayerDefenderScaleMult Auto
GlobalVariable Property CWOEnemyAttackerScaleMult Auto
GlobalVariable Property CWOEnemyDefenderScaleMult Auto
GlobalVariable Property CWOCampaignPhaseMax Auto
;New Packages for CO's
Package Property CWGalmarAtCampWhiterun Auto
Package Property CWRikkeAtCampWhiterun Auto
;Story event keywords
KeyWord Property cwopartycrasher Auto
Keyword Property CWODefendingStart Auto
Keyword Property CWOMissionStart2 Auto
;Siege scene for Generals
Scene Property CWSiegeGeneralChargeScene Auto
;NPC Records Jarls that don't fight in minor sieges
ActorBase Property JarlIdgrodRavencrone Auto
ActorBase Property JarlSiddgeir Auto
;Grain mill for mission 2
Furniture Property ResourceObjectGrainMill auto
;Player enemy faction
Faction Property CWSoldierPlayerEnemyFaction Auto
;Follow faction
Faction Property CurrentFollowerFaction Auto
;Faction to indicate Defense
Faction Property CWODefensiveFaction Auto
;Outfit for Jarl Fight in Minor Cities
Outfit Property CWArmorBalgruufSteelPlateNoHelmetOutfit Auto
;Enemy Camp Helpful for CWMission06
LocationAlias Property EnemyCamp Auto
;Enable Garrison Markers
ReferenceAlias Property Garrison1EnableImperial Auto
ReferenceAlias Property Garrison2EnableImperial Auto
ReferenceAlias Property Garrison3EnableImperial Auto
ReferenceAlias Property Garrison4EnableImperial Auto
ReferenceAlias Property Garrison1EnableSons Auto
ReferenceAlias Property Garrison2EnableSons Auto
ReferenceAlias Property Garrison3EnableSons Auto
ReferenceAlias Property Garrison4EnableSons Auto
;There is a chance that Ulfric or Tullius will join the sieges. These references are the unused defensive references outside of Solitude and Windhelm
Actor Property CWBattleTullius Auto
Actor Property CWBattleUlfric Auto
;Lydia
Actor Property HousecarlWhiterunRef Auto
;Enable markers for the military camps. Used in CWMission05
objectreference property CWGarrisonEnableMarkerSonsCampRift auto
objectreference property CWGarrisonEnableMarkerSonsCampWinterhold auto
objectreference property CWGarrisonEnableMarkerSonsCampPale auto
objectreference property CWGarrisonEnableMarkerSonsCampFalkreath auto
objectreference property CWGarrisonEnableMarkerSonsCampWhiterun auto
objectreference property CWGarrisonEnableMarkerSonsCampHjaalmarch auto
objectreference property CWGarrisonEnableMarkerSonsCampReach auto
objectreference property CWGarrisonEnableMarkerImperialCampRift auto
objectreference property CWGarrisonEnableMarkerImperialCampWinterhold auto
objectreference property CWGarrisonEnableMarkerImperialCampPale auto
objectreference property CWGarrisonEnableMarkerImperialCampFalkreath auto
objectreference property CWGarrisonEnableMarkerImperialCampWhiterun auto
objectreference property CWGarrisonEnableMarkerImperialCampHjaalmarch auto
objectreference property CWGarrisonEnableMarkerImperialCampReach auto
;Object references for Sieges
ObjectReference Property CWSiegeBarricadeWindhelmA Auto
ObjectReference Property CWSiegeBarricadeWindhelmB Auto
ObjectReference Property CWSiegeBarricadeSolitudeA Auto
ObjectReference Property CWSiegeBarricadeSolitudeB Auto
ObjectReference Property WindhelmExteriorGate01 Auto
ObjectReference Property WindhelmExteriorGate02 Auto
ObjectReference Property SolitudeExteriorGate01 Auto
objectreference property DawnstarMapMarkerREF auto
objectreference property FalkreathMapMarker auto
objectreference property MorthalMapMarkerRef auto
objectreference property WinterholdMapMarker auto
;Helper conditional variables
Int Property CanDoCWMission03 Auto Hidden Conditional
Int Property CanDoCWMission04 Auto Hidden Conditional
Int Property CanDoCWMission07 Auto Hidden Conditional
Bool Property CWFortSiegeFortDone Auto Hidden Conditional
Bool Property CWMission01Or02Done Auto Hidden Conditional
Bool Property CWMission06Done Auto Hidden Conditional
Bool Property CWMission08Done Auto Hidden Conditional
Bool Property SpanishInquisitionCompleted Auto Hidden Conditional
;# SetOwner() Location Variables 	-- these should be arrays, consider converting when we get arrays implemented in the language											
;Variables for holding locations that are purchased so we can pass them all to CWScript SetOwner()
Location PurchasedLocationImperial1
Location PurchasedLocationImperial2
Location PurchasedLocationImperial3
Location PurchasedLocationImperial4
Location PurchasedLocationImperial5
Location PurchasedLocationImperial6
Location PurchasedLocationImperial7
Location PurchasedLocationImperial8
Location PurchasedLocationImperial9
Location PurchasedLocationImperial10
Location PurchasedLocationImperial11
Location PurchasedLocationImperial12
Location PurchasedLocationImperial13
Location PurchasedLocationImperial14
Location PurchasedLocationImperial15
Location PurchasedLocationImperial16
Location PurchasedLocationImperial17
Location PurchasedLocationImperial18
Location PurchasedLocationImperial19
Location PurchasedLocationImperial20


Location PurchasedLocationSons1
Location PurchasedLocationSons2
Location PurchasedLocationSons3
Location PurchasedLocationSons4
Location PurchasedLocationSons5
Location PurchasedLocationSons6
Location PurchasedLocationSons7
Location PurchasedLocationSons8
Location PurchasedLocationSons9
Location PurchasedLocationSons10
Location PurchasedLocationSons11
Location PurchasedLocationSons12
Location PurchasedLocationSons13
Location PurchasedLocationSons14
Location PurchasedLocationSons15
Location PurchasedLocationSons16
Location PurchasedLocationSons17
Location PurchasedLocationSons18
Location PurchasedLocationSons19
Location PurchasedLocationSons20

Location PurchasedLocationBothFactions1
Location PurchasedLocationBothFactions2
Location PurchasedLocationBothFactions3
Location PurchasedLocationBothFactions4
Location PurchasedLocationBothFactions5
Location PurchasedLocationBothFactions6
Location PurchasedLocationBothFactions7
Location PurchasedLocationBothFactions8

bool StartMissionsRunning = false

Event OnInit()
	CWs = CW as CWScript

	CWScript.Log("CWCampaignScript", " OnInit() setting default property values.", 0, True, True)
	
	;CWO - No Tutorial Mission
	CWs.TutorialMissionComplete = 1

	AcceptDays = 5
	MissionDays = 2
	;CWO - Set Resolution Phase to 3. Will eventually be to change but should always be an odd number
	ResolutionPhase = CWOCampaignPhaseMax.GetValueInt()
	
	MissionAcceptancePollWait = 5	;wait this many seconds inside the while loop in PollForMissionAcceptance() function
	
	AttackDeltaBonusForKillingCapitalGarrison = 2
	AttackDeltaGarrisonValueModifierForDestroyingResource = 0.50	;destroying the resource object at a garrison halves it value
	
	if CWS.CWAttacker.GetValueInt() == CWs.PlayerAllegiance && CWs.CWMission03Done == 0 && ((CWs.PlayerAllegiance == CWs.iImperials && CWs.contestedHold == CWs.iPale) || (CWs.PlayerAllegiance == CWs.iSons && CWs.contestedHold == CWs.iHjaalmarch))
		candocwmission03 = 1
	Else
		candocwmission03 = 0
	endif

	if CWS.CWAttacker.GetValueInt() == CWs.PlayerAllegiance && CWs.CWMission04Done == 0 && ((CWs.PlayerAllegiance == CWs.iImperials && CWs.contestedHold == CWs.iWinterhold) || (CWs.PlayerAllegiance == CWs.iSons && CWs.contestedHold == CWs.iFalkreath))
		candocwmission04 = 1
	Else
		candocwmission04 = 0
	endif

	if CWS.CWAttacker.GetValueInt() == CWs.PlayerAllegiance && CWs.CWMission07Done == 0 && ((CWs.PlayerAllegiance == CWs.iImperials && CWs.contestedHold == CWs.iRift) || (CWs.PlayerAllegiance == CWs.iSons && CWs.contestedHold == CWs.iReach))
		candocwmission07 = 1
	Else
		candocwmission07 = 0
	endif

	if (CWS.CWAttacker.GetValueInt() == CWs.PlayerAllegiance &&  CWs.contestedHold == CWs.iFalkreath) || CWODisableFortSiegeFort.GetValueInt() == 1
		CWFortSiegeFortDone = 1
	else
		CWFortSiegeFortDone = 0
	endif

	;*** !!! *** !!! TEMPORARY HACK UNTIL WE GET ACTIVATORS IN AS OBJECT TYPES -- these should be set in editor
	ResourceObjectFarm = Game.GetForm(0X0001DA07)	;**** !!!! **** !!!!! THIS IS TEMPORARY WORK AROUND UNTIL WE GET ACTIVATOR OBJECTS IN PAPYRUS -- when that happens this property will be set in the editor in the CWCampaign quest
	ResourceObjectMill = Game.GetForm(0X00071C47)	;**** !!!! **** !!!!! THIS IS TEMPORARY WORK AROUND UNTIL WE GET ACTIVATOR OBJECTS IN PAPYRUS -- when that happens this property will be set in the editor in the CWCampaign quest
	ResourceObjectMine = Game.GetForm(0X0009C6CE)	;**** !!!! **** !!!!! THIS IS TEMPORARY WORK AROUND UNTIL WE GET ACTIVATOR OBJECTS IN PAPYRUS -- when that happens this property will be set in the editor in the CWCampaign quest
	;*** !!! *** !!! 
		
 EndEvent


Function ResetCampaign()

 	CWScript.Log("CWCampaignScript", " ResetCampaign() resetting property values.")
	Mission1Type = 0
	Mission2Type = 0
	Mission3Type = 0

	acceptedHooks = 0
	acceptedMission = 0
	
	completedMission = 0	
	failedMission = 0		

	ownerPatrol1 = 0
	ownerPatrol2 = 0
	ownerPatrol3 = 0
	ownerPatrol4 = 0
	ownerPatrol5 = 0
	
	unsetPurchasedLocations()
	
	attackDeltaMissionBonus = 0
	
	nextPhaseDay = GameDaysPassed.value + acceptDays 	;init value (note this is immediately updated again in stage 150, that's fine.)

	CWCampaignPhase.value = 0							;reset global (note this is immediately incremented to 1 by stage 150)
	resolveOffscreen = 0						;reset variable
	
	;Re-intialize CWO stuff
	SpanishInquisitionCompleted = false
	CWMission01Or02Done = false
	CWMission06Done = false
	CWMission08Done = false
	CWFortSiegeFortDone = false

EndFunction

Function PurchaseGarrisons()
{Depending on the CW.PurchaseDelta assign various garrisons and patrols to the attacker and defender.}

	;If PurchaseDelta is > 0 it means the attackers have the advantage and can purchase additional garrisons and patrols, if the PurchaseDelta < 0 it means the defenders have the advantage and have all the garrisons and can purchase additional patrols

 	CWScript.Log("CWCampaignScript", " PurchaseGarrisons() begining to purchase garrisons. Starting PurchaseDelta = " + CWs.PurchaseDelta)

	if CWDebugSkipPurchase.value == 1
; 		CWScript.Log("CWCampaignScript", ": CWDebugSkipPurchase == 1, we are skipping call to PurchaseGarrison()", 1)
		return
	EndIf
	
	unsetPurchasedLocations() ;### used with CallSetOwnerForPurchasedLocations() -- this would be easier if we had arrays
	
	
	;## 4-16-2010 -- jduvall
	;NOTE: Purchasing used to happen before resetting the defender only, camps, and patrols... I don't think there was any particular reason to do this, and since things go a little faster if the defender only stuff goes first because it includes the capital which takes the longest to process, I am now putting it first through the SetOwner() switchboard, it'll process its stuff while other garrisons are also being processed	
	;Hopefully this doesn't break anythingm if it does just but the "reset" stuff back below the "Purchased" stuff
	;## -----------------------------
	
	;"Purchased" THINGS THAT DON'T GET PURCHASED WITH ATTACK DELTA -- everything gets put in PurchasedLocationXXXn variables simulating an array -- see CallSetOwnerForPurchasedLocations()
	;Reset the defender only garrisons
	ResetDefenderOnlyGarrisons()
	
	;Reset the camps
	ResetCamps()
	
	;reset the shared Patrols location
	ResetPatrols()
	
	
	;PURCHASE GARRISONS AND PATROLS -- everything gets put in PurchasedLocationXXXn variables simulating an array -- see CallSetOwnerForPurchasedLocations()
	;Attempt to purchase garrisons
	PurchaseGarrisonLocationAlias(Garrison1)
	PurchaseGarrisonLocationAlias(Garrison2)
	PurchaseGarrisonLocationAlias(Garrison3)
	PurchaseGarrisonLocationAlias(Garrison4)
	
	PurchaseGarrisonLocationAlias(Fort)
	
	;Purchase additional patrols if there is any AttackDelta left:   see EnablePatrols() call below
	;CWO - Always award patrols to the defenders
	ownerPatrol1 = CWs.Defender;PurchasePatrolAndReturnNewOwner(1)
	ownerPatrol2 = CWs.Defender;PurchasePatrolAndReturnNewOwner(2)
	ownerPatrol3 = CWs.Defender;PurchasePatrolAndReturnNewOwner(3)
	ownerPatrol4 = CWs.Defender;PurchasePatrolAndReturnNewOwner(4)
	ownerPatrol5 = CWs.Defender;PurchasePatrolAndReturnNewOwner(5)
	
	;ENABLE THE PURCHASED PATROLS -- not these don't get passed into to SetOwner() via a PurchasedLocationXXXn variable, because these patrols are just turned on/off by toggling xmarkers, see the EnablePatrols() function below.
	;Enable patrols that have been purchased by enabling the proper enable markers
	EnablePatrols()

	CallSetOwnerForPurchasedLocations() ;### Calls CWs.SetOwner() for each of the purchased locations -- this would be easier if we had arrays
	
	
EndFunction


Function PurchaseGarrisonLocationAlias(LocationAlias GarrisonAlias)
{Calls PurchaseGarrisonLocation() with the location of the supplied alias, if the alias isn't empty}
	Location Loc = GarrisonAlias.Getlocation()
	
	If Loc != None
		PurchaseGarrisonLocation(Loc)
	EndIf

EndFunction

Function PurchaseGarrisonLocation(Location GarrisonLocation)
{If attacker has enough attack points (ie a large enough positive value in CW.PurchaseDelta) award the garrison ownership to attacker and subtract Purchase Delta, otherwise award to the defender.}
	int cost = GarrisonLocation.GetKeywordData(CWCost) as int
	int newOwner		;1 = Imperials, 2 = Sons -- will correspond to Attacker and Defender property on CWScript attached to CW quest

	;CWO - Always award garrisons to the defenders
	;If CWs.PurchaseDelta >= Cost	;award to attacker
	;	newOwner = CWs.Attacker
	;	CWs.PurchaseDelta = (CWs.PurchaseDelta - cost)
	;	GarrisonLocation.SetKeywordData(CWPurchasedByAttacker, 1)
; 		CWScript.Log("CWCampaignScript", " PurchaseGarrison() purchasing " + GarrisonLocation + " for attacker(" + CWs.FactionName(newOwner) + ") and flagged for reset")
		
	;Else	;award to defender
		newOwner = CWs.Defender
; 		CWScript.Log("CWCampaignScript", " PurchaseGarrison() purchasing " + GarrisonLocation + " for defender(" + CWs.FactionName(newOwner) + ") and flagged for reset")
		GarrisonLocation.SetKeywordData(CWPurchasedByAttacker, 0)
		;There is no cost for the defender to purchase a garrison... he owns it by default
		
	;EndIf

	SetPurchasedLocation(GarrisonLocation, NewOwner)
	
EndFunction

Function unsetPurchasedLocations()
	PurchasedLocationImperial1 = None
	PurchasedLocationImperial2 = None
	PurchasedLocationImperial3 = None
	PurchasedLocationImperial4 = None
	PurchasedLocationImperial5 = None
	PurchasedLocationImperial6 = None
	PurchasedLocationImperial7 = None
	PurchasedLocationImperial8 = None
	PurchasedLocationImperial9 = None
	PurchasedLocationImperial10 = None
	PurchasedLocationImperial11 = None
	PurchasedLocationImperial12 = None
	PurchasedLocationImperial13 = None
	PurchasedLocationImperial14 = None
	PurchasedLocationImperial15 = None
	PurchasedLocationImperial16 = None
	PurchasedLocationImperial17 = None
	PurchasedLocationImperial18 = None
	PurchasedLocationImperial19 = None
	PurchasedLocationImperial20 = None

	PurchasedLocationSons1 = None
	PurchasedLocationSons2 = None
	PurchasedLocationSons3 = None
	PurchasedLocationSons4 = None
	PurchasedLocationSons5 = None
	PurchasedLocationSons6 = None
	PurchasedLocationSons7 = None
	PurchasedLocationSons8 = None
	PurchasedLocationSons9 = None
	PurchasedLocationSons10 = None
	PurchasedLocationSons11 = None
	PurchasedLocationSons12 = None
	PurchasedLocationSons13 = None
	PurchasedLocationSons14 = None
	PurchasedLocationSons15 = None
	PurchasedLocationSons16 = None
	PurchasedLocationSons17 = None
	PurchasedLocationSons18 = None
	PurchasedLocationSons19 = None
	PurchasedLocationSons20 = None
	
	PurchasedLocationBothFactions1 = None
	PurchasedLocationBothFactions2 = None
	PurchasedLocationBothFactions3 = None
	PurchasedLocationBothFactions4 = None
	PurchasedLocationBothFactions5 = None
	PurchasedLocationBothFactions6 = None
	PurchasedLocationBothFactions7 = None
	PurchasedLocationBothFactions8 = None
EndFunction

Function SetPurchasedLocation(Location LocationThatWasPurchased, int OwningFaction)
; 	CWScript.Log("CWCampaignScript", " SetPurchasedLocation() LocationThatWasPurchased: " + LocationThatWasPurchased + ", OwningFaction:(" + OwningFaction + ")")

	if owningFaction == CWs.iImperials
		if 	!PurchasedLocationImperial1
			PurchasedLocationImperial1 = LocationThatWasPurchased
			
		elseif !PurchasedLocationImperial2
			PurchasedLocationImperial2 = LocationThatWasPurchased
			
		elseif !PurchasedLocationImperial3
			PurchasedLocationImperial3 = LocationThatWasPurchased
		
		elseif	!PurchasedLocationImperial4
			PurchasedLocationImperial4 = LocationThatWasPurchased
		
		ElseIf	!PurchasedLocationImperial5
			PurchasedLocationImperial5 = LocationThatWasPurchased
		
		ElseIf	!PurchasedLocationImperial6
			PurchasedLocationImperial6 = LocationThatWasPurchased
		
		ElseIf	!PurchasedLocationImperial7
			PurchasedLocationImperial7 = LocationThatWasPurchased
		
		ElseIf	!PurchasedLocationImperial8
			PurchasedLocationImperial8 = LocationThatWasPurchased
			
		ElseIf	!PurchasedLocationImperial9
			PurchasedLocationImperial9 = LocationThatWasPurchased

		ElseIf	!PurchasedLocationImperial10
			PurchasedLocationImperial10 = LocationThatWasPurchased
			
		Elseif !PurchasedLocationImperial11
			PurchasedLocationImperial11 = LocationThatWasPurchased
			
		elseif !PurchasedLocationImperial12
			PurchasedLocationImperial12 = LocationThatWasPurchased
			
		elseif !PurchasedLocationImperial13
			PurchasedLocationImperial13 = LocationThatWasPurchased
		
		elseif	!PurchasedLocationImperial14
			PurchasedLocationImperial14 = LocationThatWasPurchased
		
		ElseIf	!PurchasedLocationImperial15
			PurchasedLocationImperial15 = LocationThatWasPurchased
		
		ElseIf	!PurchasedLocationImperial16
			PurchasedLocationImperial16 = LocationThatWasPurchased
		
		ElseIf	!PurchasedLocationImperial17
			PurchasedLocationImperial17 = LocationThatWasPurchased
		
		ElseIf	!PurchasedLocationImperial18
			PurchasedLocationImperial18 = LocationThatWasPurchased
			
		ElseIf	!PurchasedLocationImperial19
			PurchasedLocationImperial19 = LocationThatWasPurchased

		ElseIf	!PurchasedLocationImperial20
			PurchasedLocationImperial20 = LocationThatWasPurchased
			
		Else
; 			CWScript.Log("CWCampaignScript", " ERROR!!! SetPurchasedLocation() ran out of PurchaseLocationXXXn variables. LocationThatWasPurchased: " + LocationThatWasPurchased + ", OwningFaction: " + OwningFaction, 2  )
		
		EndIf
	
	elseif owningFaction == CWs.iSons
	
		if !PurchasedLocationSons1
			PurchasedLocationSons1 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationSons2
			PurchasedLocationSons2 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationSons3
			PurchasedLocationSons3 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationSons4
			PurchasedLocationSons4 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationSons5
			PurchasedLocationSons5 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationSons6
			PurchasedLocationSons6 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationSons7
			PurchasedLocationSons7 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationSons8
			PurchasedLocationSons8 = LocationThatWasPurchased

		ElseIf !PurchasedLocationSons9
			PurchasedLocationSons9 = LocationThatWasPurchased

		ElseIf !PurchasedLocationSons10
			PurchasedLocationSons10 = LocationThatWasPurchased

		Elseif !PurchasedLocationSons11
			PurchasedLocationSons11 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationSons12
			PurchasedLocationSons12 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationSons13
			PurchasedLocationSons13 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationSons14
			PurchasedLocationSons14 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationSons15
			PurchasedLocationSons15 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationSons16
			PurchasedLocationSons16 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationSons17
			PurchasedLocationSons17 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationSons18
			PurchasedLocationSons18 = LocationThatWasPurchased

		ElseIf !PurchasedLocationSons19
			PurchasedLocationSons19 = LocationThatWasPurchased

		ElseIf !PurchasedLocationSons20
			PurchasedLocationSons20 = LocationThatWasPurchased
			
		Else
; 			CWScript.Log("CWCampaignScript", " ERROR!!! SetPurchasedLocation() ran out of PurchaseLocationXXXn variables. LocationThatWasPurchased: " + LocationThatWasPurchased + ", OwningFaction: " + OwningFaction, 2  )
		
		EndIf
		
	ElseIf owningFaction == CWs.iBothFactions
		
		if !PurchasedLocationBothFactions1
			PurchasedLocationBothFactions1 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationBothFactions2
			PurchasedLocationBothFactions2 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationBothFactions3
			PurchasedLocationBothFactions3 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationBothFactions4
			PurchasedLocationBothFactions4 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationBothFactions5
			PurchasedLocationBothFactions5 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationBothFactions6
			PurchasedLocationBothFactions6 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationBothFactions7
			PurchasedLocationBothFactions7 = LocationThatWasPurchased
		
		ElseIf !PurchasedLocationBothFactions8
			PurchasedLocationBothFactions8 = LocationThatWasPurchased

		Else
; 			CWScript.Log("CWCampaignScript", " ERROR!!! SetPurchasedLocation() ran out of PurchaseLocationXXXn variables. LocationThatWasPurchased: " + LocationThatWasPurchased + ", OwningFaction: " + OwningFaction, 2  )
		
		EndIf
		
		
	Else
; 		CWScript.Log("CWCampaignScript", " ERROR!!! SetPurchasedLocation() Recieved an unexpected value for OwningFaction. Expected 1, 2 or 3, got:" + OwningFaction, 2  )

	EndIf
	

EndFunction

Function CallSetOwnerForPurchasedLocations()
	
	;SetOwner() takes a max of 8 locations, so we call it until we are done with all the locations in our "arrays"
		
	;setOwner for Imperial garrisons
	if PurchasedLocationImperial1
		CWs.setOwner(PurchasedLocationImperial1, CWs.iImperials, PurchasedLocationImperial2, PurchasedLocationImperial3, PurchasedLocationImperial4, PurchasedLocationImperial5, PurchasedLocationImperial6, PurchasedLocationImperial7, PurchasedLocationImperial8)
	EndIf
	
	if PurchasedLocationImperial9
		CWs.setOwner(PurchasedLocationImperial9, CWs.iImperials, PurchasedLocationImperial10, PurchasedLocationImperial11, PurchasedLocationImperial12, PurchasedLocationImperial13, PurchasedLocationImperial14, PurchasedLocationImperial15, PurchasedLocationImperial16)
	EndIf
	
	if PurchasedLocationImperial17
		CWs.setOwner(PurchasedLocationImperial17, CWs.iImperials, PurchasedLocationImperial18, PurchasedLocationImperial19, PurchasedLocationImperial20)
	EndIf
	
	;setOwner for Sons garrisons
	if PurchasedLocationSons1
		CWs.setOwner(PurchasedLocationSons1, CWs.iSons, PurchasedLocationSons2, PurchasedLocationSons3, PurchasedLocationSons4, PurchasedLocationSons5, PurchasedLocationSons6, PurchasedLocationSons7, PurchasedLocationSons8)
	EndIf
	
	if PurchasedLocationSons9
		CWs.setOwner(PurchasedLocationSons9, CWs.iSons, PurchasedLocationSons10, PurchasedLocationSons11, PurchasedLocationSons12, PurchasedLocationSons13, PurchasedLocationSons14, PurchasedLocationSons15, PurchasedLocationSons16)
	EndIf
	
	if PurchasedLocationSons17
		CWs.setOwner(PurchasedLocationSons17, CWs.iSons, PurchasedLocationSons18, PurchasedLocationSons19, PurchasedLocationSons20)
	EndIf
	
	;setOwner for garrisons owned by both (the one patrol location)
	if PurchasedLocationBothFactions1
		CWs.setOwner(PurchasedLocationBothFactions1, CWs.iBothFactions, PurchasedLocationBothFactions2, PurchasedLocationBothFactions3, PurchasedLocationBothFactions4, PurchasedLocationBothFactions5, PurchasedLocationBothFactions6, PurchasedLocationBothFactions7, PurchasedLocationBothFactions8)
	EndIf
	
EndFunction


Function ResetDefenderOnlyGarrisons()
; 	CWScript.Log("CWCampaignScript", " ResetDefenderOnlyGarrisons() 'purchasing' aliases Captial & GarrisonDefenderOnly1-6 (if not empty)")

	ResetDefenderOnlyGarrison(1)
	ResetDefenderOnlyGarrison(2)
	ResetDefenderOnlyGarrison(3)
	ResetDefenderOnlyGarrison(4)
	ResetDefenderOnlyGarrison(5)
	ResetDefenderOnlyGarrison(6)
	
; 	CWScript.Log("CWCampaignScript", " ResetDefenderOnlyGarrisons() calling SetPurchasedLocation() for Capital" + Capital.GetLocation() + " to be owned by defender(" + CWs.FactionName(CWs.Defender) + ").")
	SetPurchasedLocation(Capital.GetLocation(), CWs.Defender)
	
	
EndFunction

Function ResetDefenderOnlyGarrison(Int GarrisonToReset)
{Calls ReturnLocationForDefenderOnlyGarrison and (if not None) sets the CWOwner keyword data on the location to be -Defender.}

	Location Garrison = ReturnLocationForDefenderOnlyGarrison(GarrisonToReset)
	
	if Garrison != None
; 		CWScript.Log("CWCampaignScript", " ResetDefenderOnlyGarrisons() calling SetPurchasedLocation() for GarrisonDefenderOnly" + GarrisonToReset + " to be owned by defender(" + CWs.FactionName(CWs.Defender) + ").")

		SetPurchasedLocation(Garrison, CWs.Defender)
			
	Else
		;Do nothing
	EndIf

EndFunction

location Function ReturnLocationForDefenderOnlyGarrison(int GarrisonToGet)
{Refturns the Location of the GarrisonDefenderOnlyX location alias corresponding to the supplied Int}

	if GarrisonToGet == 1
		return GarrisonDefenderOnly1.Getlocation()
	
	elseif GarrisonToGet == 2
		return GarrisonDefenderOnly2.Getlocation()
	
	elseif GarrisonToGet == 3
		return GarrisonDefenderOnly3.Getlocation()
		
	elseif GarrisonToGet == 4
		return GarrisonDefenderOnly4.Getlocation()
		
	elseif GarrisonToGet == 5
		return GarrisonDefenderOnly5.Getlocation()
		
	elseif GarrisonToGet == 6
		return GarrisonDefenderOnly6.Getlocation()
	else
	
	EndIf

EndFunction


Function ResetCamps()
{Sets keyword data CWOwner on CampImperial and CampSons location aliases to cause them to reset}
	if CWs.iImperials == CWs.Attacker
; 		CWScript.Log("CWCampaignScript", " ResetCamps() calling SetPurchasedLocation() for CampImperial locaion alias.")

		SetPurchasedLocation(CampImperial.GetLocation(), CWs.iImperials)	
		
; 		CWScript.Log("CWCampaignScript", " ResetCamps() disabling CampEnableSons.")
		CampEnableSons.GetReference().disable()

		
	Else	;Sons are attacking
; 		CWScript.Log("CWCampaignScript", " ResetCamps() calling SetPurchasedLocation() CampSons locaion alias.")

		SetPurchasedLocation(CampSons.GetLocation(), CWs.iSons)			
		
; 		CWScript.Log("CWCampaignScript", " ResetCamps() disabling CampEnableImperial.")
		CampEnableImperial.GetReference().disable()
	
	endif
	
	
EndFunction

int Function PurchasePatrolAndReturnNewOwner(int WhichPatrolToPurchase)
{Returns an int corresponding to faction that should own. If there is enough remaining positive or negative points in PurchaseDelta, purchase a patrol for the attacker (if positive) or defender (if negative)}
	int cost = CWs.iCostPatrol
	int newOwner		;1 = Imperials, 2 = Sons -- will correspond to Attacker and Defender property on CWScript attached to CW quest
	
	If CWs.PurchaseDelta >= Cost	;award to attacker, decrease the PurchaseDelta toward 0
		newOwner = CWs.Attacker
		CWs.PurchaseDelta = (CWs.PurchaseDelta - cost)
; 		CWScript.Log("CWCampaignScript", " PurchasePatrolAndReturnNewOwner() purchasing Patrol" + WhichPatrolToPurchase + " for Attacker (" + CWs.FactionName(NewOwner) + ") New PurchaseDelta =" + CWs.PurchaseDelta)
	
	Elseif -(CWs.PurchaseDelta) <= -(Cost)	;award to defender, increase the PurchaseDelta toward 0
		newOwner = CWs.Defender
		CWs.PurchaseDelta = (CWs.PurchaseDelta + cost)
; 		CWScript.Log("CWCampaignScript", " PurchasePatrolAndReturnNewOwner() purchasing Patrol" + WhichPatrolToPurchase + " for Defender (" + CWs.FactionName(NewOwner) + ")  New PurchaseDelta =" + CWs.PurchaseDelta)
		
	Else	;award to no one
		newOwner = 0
; 		CWScript.Log("CWCampaignScript", " PurchasePatrolAndReturnNewOwner() not purchasing Patrol" + WhichPatrolToPurchase + " for anyone. Not enough PurchaseDelta: " + CWs.PurchaseDelta)

	EndIf

	return newOwner

EndFunction

Function ResetPatrols()
; 	CWScript.Log("CWCampaignScript", " ResetPatrols() calling SetPurchasedLocation(" + Patrols.GetLocation() + ") with owner = 3 (both factions own patrols location).")

	SetPurchasedLocation(Patrols.GetLocation(), CWs.iBothFactions)	;this causes the garrison to reset/change hands, lives in CWScript
	
EndFunction

Function EnablePatrols()

	EnableDefaultPatrols()

	EnablePatrol(1)
	EnablePatrol(2)
	EnablePatrol(3)
	EnablePatrol(4)
	EnablePatrol(5)
	
EndFunction

Function EnableDefaultPatrols()
	PatrolsDefaultEnableImperial.GetReference().Enable()
	PatrolsDefaultEnableSons.GetReference().Enable()

; 	CWScript.Log("CWCampaignScript", " EnableDefaultPatrols() enabling ReferenceAliases PatrolsDefaultEnableImperial and PatrolsDefaultEnableSons.")
	
EndFunction

Function EnablePatrol(int WhichPatrolToEnable)
{Calls GetEnableMarkerForPatrol() for patrol supplied as an Int, and then enables it.}
	ObjectReference EnableMarker
	
	EnableMarker = GetEnableMarkerForPatrol(WhichPatrolToEnable)
	
	If EnableMarker != None
		EnableMarker.Enable()
; 		CWScript.Log("CWCampaignScript", " EnablePatrol() enabling " + EnableMarker)
	Else
; 		CWScript.Log("CWCampaignScript", " EnablePatrol() not enabling the patrol #" + WhichPatrolToEnable + " for either faction. Which should mean that neither own it.")
	EndIf

EndFunction

ObjectReference Function GetEnableMarkerForPatrol(int WhichPatrol)
{Returns the ObjectReference for patrol supplied as an Int}
	if WhichPatrol == 1
		if OwnerPatrol1 == CWs.iImperials
			return PatrolsEnableImperial1.GetReference()
		elseif OwnerPatrol1 == CWs.iSons
			return PatrolsEnableSons1.GetReference()
		else
			return None
		endif
		
	elseif WhichPatrol == 2
		if OwnerPatrol2 == CWs.iImperials
			return PatrolsEnableImperial2.GetReference()
		elseif OwnerPatrol2 == CWs.iSons
			return PatrolsEnableSons2.GetReference()
		else
			return None
		endif
	
	elseif WhichPatrol == 3
		if OwnerPatrol3 == CWs.iImperials
			return PatrolsEnableImperial3.GetReference()
		elseif OwnerPatrol3 == CWs.iSons
			return PatrolsEnableSons3.GetReference()
		else
			return None
		endif
	
	elseif WhichPatrol == 4
		if OwnerPatrol4 == CWs.iImperials
			return PatrolsEnableImperial4.GetReference()
		elseif OwnerPatrol4 == CWs.iSons
			return PatrolsEnableSons4.GetReference()
		else
			return None
		endif
	
	elseif WhichPatrol == 5
		if OwnerPatrol5 == CWs.iImperials
			return PatrolsEnableImperial5.GetReference()
		elseif OwnerPatrol5 == CWs.iSons
			return PatrolsEnableSons5.GetReference()
		else
			return None
		endif
	Else
; 		CWScript.Log("CWCampaignScript", " GetEnableMarkerForPatrol() expected an Int 1-5, instead got " + WhichPatrol)
		return None
	EndIf

EndFunction



Function SetCWCampaignFieldCOAliases()
	{Forces named field COs into FieldCO and generic enemy field COs into EnemyFieldCO, enables the EnemyFieldCO and disables the other non-used generic field CO}
	
		if CWs.playerAllegiance == CWs.iImperials
	
			if CWs.playerInvolved == 0
	; 			CWScript.Log("CWCampaignScript", " SetCWCampaignFieldCOAliases() Player Allegience == 1 and PlayerInvolved == 0, so we are Forcing GenericFieldCOImperial into FieldCo, GenericFieldCOSons into EnemyFieldCO, and enabling them both.")
				
				FieldCO.ForceRefTo(GenericFieldCOImperial.GetReference())
				EnemyFieldCO.ForceRefTo(GenericFieldCOSons.GetReference())
	
				GenericFieldCOImperial.GetReference().Enable()
				EnemyFieldCO.GetReference().Enable()
	
			Elseif CWs.playerInvolved == 1
		
	; 			CWScript.Log("CWCampaignScript", " SetCWCampaignFieldCOAliases() is Forcing Rikke into FieldCo, GenericFieldCOSons into EnemyFieldCO, enabling EnemyFieldCO, and disabling GenericFieldCOImperial.")
	
				FieldCO.ForceRefTo(Rikke.GetReference())
				EnemyFieldCO.ForceRefTo(GenericFieldCOSons.GetReference())
	
				EnemyFieldCO.GetReference().Enable()
				GenericFieldCOImperial.GetReference().Disable()
				
			Else
	; 			CWScript.Log("CWCampaignScript", "WARNING: SetCWCampaignFieldCOAliases() expected 0 or 1 for CWScript PlayerInvolved, instead found:" + CWs.playerInvolved, 2)
	
				
			EndIf
	
		Elseif CWs.playerAllegiance == CWs.iSons
			
			if CWs.playerInvolved == 0
	; 			CWScript.Log("CWCampaignScript", " SetCWCampaignFieldCOAliases() playerAllegiance == 2 and PlayerInvolved == 0, so we are Forcing GenericFieldCOSons into FieldCo, GenericFieldCOImperial into EnemyFieldCO, and enabling them both.")
				
				FieldCO.ForceRefTo(GenericFieldCOSons.GetReference())
				EnemyFieldCO.ForceRefTo(GenericFieldCOImperial.GetReference())
	
				GenericFieldCOImperial.GetReference().Enable()
				EnemyFieldCO.GetReference().Enable()
	
			Elseif CWs.playerInvolved == 1
	
	; 			CWScript.Log("CWCampaignScript", " SetCWCampaignFieldCOAliases() is Forcing Galmar into FieldCo, GenericFieldCOImperial into EnemyFieldCO, enabling EnemyFieldCO, and disabling GenericFieldCOSons.")
	
				FieldCO.ForceRefTo(Galmar.GetReference())
				EnemyFieldCO.ForceRefTo(GenericFieldCOImperial.GetReference())
	
				EnemyFieldCO.GetReference().Enable()
				GenericFieldCOSons.GetReference().Disable()
	
			Else
	; 			CWScript.Log("CWCampaignScript", "WARNING: SetCWCampaignFieldCOAliases() expected 0 or 1 for CWScript PlayerInvolved, instead found:" + CWs.playerInvolved, 2)
				
			EndIf
				
		Else
	; 		CWScript.Log("CWCampaignScript", "WARNING: SetCWCampaignFieldCOAliases expected playerAllegience to be 1 or 2, got " + CWs.playerAllegiance, 2)
	
		EndIf
		
	EndFunction

Function AdvanceCampaignPhase(int OptionalPhaseToSetTo = -1)
{Called when needing to advance the campaign to the next phase, and start new missions}
	
;CWO - I dont think that we need this anymore, CW does not advance to next phase after certain days pass anymore
	;* The reason for this weird if / while loop below...
	;Phases advance 'automatically': mission accept timers and mission fail timers expire setting mission quest stages that call AdvanceCampaignPhase() and then shut down.
	;However, this function is also called in dialogue with the FactionLeader the first time the player is joining a campaign to reset the campaign to the first phase (via passing a "1" in for the optional param)
	;It's possible that while in dialogue, the campaign phase could advance automatically and the resolution happens off screen, in the middle of the FactionLeader telling us to go meet the field officer - that'd be really weird.
	;We don't want him to say go join this campaign, and then immediately it fails.
	;So this while loop prevents the campaign from advancing at least until after the player leaves the town with the FactionLeader in it, since the player realizes this is a dynamic system, he'll hopefully forgive that weirdness if the campaign ends soon after leaving.
	;If the campaign is starting fresh (ie the CWCampaignPhase is 0) we don't care if the player is standing right in front of the FactionLeader, otherwise we'd never get start the campaign if the player hangs out in the same town with FactionLeader
	
	;* See rationale for this above
;	if CWCampaignPhase.value != 0 && OptionalPhaseToSetTo == -1	;ie the default call, not when it's called in dialogue with the faction leader the first time the player is joining a campaign in the civil war
;		while CWs.AliasFactionLeader.GetReference().getCurrentLocation().IsSameLocation(Game.GetPlayer().getCurrentLocation(), LocTypeHabitation)
; 			CWScript.Log("CWCampaignScript", " AdvanceCampaignPhase() WAITING -PLAYER NEARBY: in a while loop wait until after player and Faction leader aren't in the same LocTypeHabitation location.", 1)
;*** !!! *** IF WE EVER GET A WAIT MENU, THEN WE NEED TO NOT CARE IF THE PLAYER IS IN THE SAME LOCATION IF HE IS ALSO WAITING			
;			utility.wait(10)
;		
;		EndWhile
;	EndIf
	
 	CWScript.Log("CWCampaignScript", " AdvanceCampaignPhase() running.")
	
	if OptionalPhaseToSetTo > 0
		CWCampaignPhase.value = OptionalPhaseToSetTo
 		CWScript.Log("CWCampaignScript", " AdvanceCampaignPhase() forced CWCampaignPhase global to " + CWCampaignPhase.value )
	Else
		;Increment the phase
		CWCampaignPhase.value += 1
 		CWScript.Log("CWCampaignScript", " AdvanceCampaignPhase() incremented CWCampaignPhase global to " + CWCampaignPhase.value )
	EndIf
	
	if CWs.debugStartingCampaignPhase != 0 && CWCampaignPhase.value < CWs.debugStartingCampaignPhase
		CWCampaignPhase.value = CWs.debugStartingCampaignPhase
 		CWScript.Log("CWCampaignScript", " AdvanceCampaignPhase() forcing CWCampaignPhase to debugStartingCampaignPhase " + CWCampaignPhase.value )
	EndIf
	
	if DebugOn.value == 1
		debug.Notification("CWCampaignPhase: " + CWCampaignPhase.value)
	EndIf
	
	;Increment the NextPhaseDay
	NextPhaseDay = GameDaysPassed.value + AcceptDays
 	CWScript.Log("CWCampaignScript", " AdvanceCampaignPhase() set CWCampaignPhase NextPhaseDay to " + NextPhaseDay + " ( = GameDaysPassed(" + GameDaysPassed.value + ") AcceptDays(" + AcceptDays + ")." )
	
	;Reset Mission tracking properties
	Mission1Type = 0
	Mission2Type = 0
	Mission3Type = 0	
	AcceptedHooks = 0
	AcceptedMission = 0

	;set current attack delta
	SetCurrentAttackDelta()
	
	;Start missions:
	;CWO - Missions either start on a CWOMonitor or in CWMissionGeneratorTriggerScript
	;StartMissions()
	
	;if DebugOn.value == 1
	;	debug.MessageBox("CWCampaignScript: Ready to start campaign.")
	;EndIf
	
EndFunction




Function StartResolutionMission()
{Starts the proper resolution mission, checking if the Capital is a city or not, and whether the player should be attacking or defending.}
	
	;start an Attack the Capital Settlement resolution quest
	;createEvent CWResolution01Start  zBogusLocation FieldCO CampaignStartMarker 

	;start a Defend the Capital Settlement resolution quest
	;createEvent CWResolution02Start  zBogusLocation FieldCO CampaignStartMarker 

	If Capital.GetLocation().HasKeyword(LocTypeCity)	&& CWs.debugTreatCityCapitalsAsTowns == 0 ;capital is a city (note the debugTreatCityCapitalsAsTowns)
		;CWO - This might not have worked before. Added FieldCO
		CWSiegeStart.SendStoryEvent(Capital.GetLocation(), CWs.FieldCO.GetReference())	;the story manager handles checking the location, the player's allegiance and who is attacking to start the quests
	
	;	if Capital.GetLocation() == CWs.WhiterunLocation 	;ADD || OTHER CITY HERE
; 	;		CWScript.Log("CWCampaignScript", " StartResolutionMission() starting attack on Whiterun.")
	;		CWSiegeStart.SendStoryEvent(Capital.GetLocation())	;the story manager handles checking the location, the player's allegiance and who is attacking to start the quests
	;			
	;	Else ;SOME OTHER NOT YET IMPLEMENTED CITY
; 	;		CWScript.Log("CWCampaignScript", " StartResolutionMission() needs to start an Attack on a Capital CITY. Will RESOLVE OFFSCREEN.")
	;		debug.MessageBox("CWCampaignScript StartResolutionMission() needs to start an Attack on a Capital CITY. RESOLVE OFFSCREEN.")
	;		CWs.ResolveOffscreen(GetCurrentAttackDelta())
	;			
	;	EndIf

	Else
		; code	;start an Attack the Capital Settlement resolution quest
		;CWO - Resolution Quests do not really work so kicking off the CWFortSiegeMinorCapitalStart
 		CWScript.Log("CWCampaignScript", " StartResolutionMission() starting CWFortSiegeMinorCapitalStart for " + Capital.Getlocation())
		CWs.CWFortSiegeMinorCapitalStart.SendStoryEvent(Capital.Getlocation(), CWs.FieldCO.GetReference(), CampaignStartMarker.GetReference()) 
	
	EndIf

EndFunction


function setCurrentAttackDelta()

	CurrentAttackDelta = GetCurrentAttackDelta()

EndFunction


int Function GetCurrentAttackDelta()
{Returns the current Attack Delta based on situation affected by players actions on the ground. Garrisons don't provide points if all the soldiers are dead, or half points if a resource object is destroyed, plus any misc modifiers for doing special missions.}

	float myCurrentAttackDelta
	
 	CWScript.Log("CWCampaignScript", " GetmyCurrentAttackDelta() is running.")
	
	;Get points for capital garrison
	myCurrentAttackDelta += GetAttackDeltaPointsForCapital(Capital.GetLocation())

	;Get points for garrisons and their resource objects	--- Detailed note about resource objects: A garrison may have more than one resource object in it... we are only testing against the one that filled the alias. Effectively this means the player must get lucky, or destroy all of the resources to get the bonus. This shouldn't matter greatly.
	myCurrentAttackDelta += GetAttackDeltaPointsForDefenderOnlyGarrison(GarrisonDefenderOnly1.GetLocation(), GarrisonDefenderOnly1ResourceObject.GetReference())
	myCurrentAttackDelta += GetAttackDeltaPointsForDefenderOnlyGarrison(GarrisonDefenderOnly2.GetLocation(), GarrisonDefenderOnly2ResourceObject.GetReference())
	myCurrentAttackDelta += GetAttackDeltaPointsForDefenderOnlyGarrison(GarrisonDefenderOnly3.GetLocation(), GarrisonDefenderOnly3ResourceObject.GetReference())
	myCurrentAttackDelta += GetAttackDeltaPointsForDefenderOnlyGarrison(GarrisonDefenderOnly4.GetLocation(), GarrisonDefenderOnly4ResourceObject.GetReference())
	
	myCurrentAttackDelta += GetAttackDeltaPointsForGarrison(Garrison1.GetLocation(), Garrison1ResourceObject.GetReference())
	myCurrentAttackDelta += GetAttackDeltaPointsForGarrison(Garrison2.GetLocation(), Garrison2ResourceObject.GetReference())
	myCurrentAttackDelta += GetAttackDeltaPointsForGarrison(Garrison3.GetLocation(), Garrison3ResourceObject.GetReference())
	myCurrentAttackDelta += GetAttackDeltaPointsForGarrison(Garrison4.GetLocation(), Garrison4ResourceObject.GetReference())


	;Get points for Patrols
	myCurrentAttackDelta += GetAttackDeltaPointsForPatrols()
	
	;Get points for mission bonueses
	myCurrentAttackDelta += GetAttackDeltaMissionBonus()
	
 	CWScript.Log("CWCampaignScript", " GetmyCurrentAttackDelta() is returning myCurrentAttackDelta " + myCurrentAttackDelta + " rounded as int (" + (myCurrentAttackDelta as int) + ") compared to original campaign AttackDelta of " + CWs.AttackDelta)
	
	return myCurrentAttackDelta as int
	
EndFunction

int Function GetAttackDeltaPointsForCapital(Location CapitalLocation)
{Returns the CurrentAttackDelta points contributed by the capital.}

	;Note:
	;Since the defender gets the capital garrison for free, in otherwords it's not purchased at the start of the campaign, the defender gets no benefit if the guards are alive.
	;However, if the player killed all the guards there, then we want to give the attacker some bonus points so the player can feel like his actions have had an effect

	If CapitalLocation.GetRefTypeAliveCount(CWSoldier) == 0
 		CWScript.Log("CWCampaignScript", " GetAttackDeltaPointsForCapital() is returning " + AttackDeltaBonusForKillingCapitalGarrison + " points for the CurrentAttackDelta because all the soldiers in the garrison are dead.")
	
		return AttackDeltaBonusForKillingCapitalGarrison		;set in OnInit()
	
	else
 		CWScript.Log("CWCampaignScript", " GetAttackDeltaPointsForCapital() is returning 0 points for the CurrentAttackDelta because the garrison is intact:" + CapitalLocation )
		return 0	;There are soldiers alive in the capital, so the attacker is awarded no points
		
	EndIf

EndFunction

float Function GetAttackDeltaPointsForDefenderOnlyGarrison(Location Garrison, ObjectReference ResourceObject)
{Returns the CurrentAttackDelta points contributed by the Garrison and it's ResourceObject.}
	;Note:
	;Since the defender gets the garrison for free, in otherwords it's not purchased at the start of the campaign, the defender gets no benefit if the guards are alive.
	;However, if the player killed all the guards there, or destroyed a resourceObject there, then we want to give the attacker some bonus points so the player can feel like his actions have had an effect

	int BaseGarrisonValue 
	float GarrisonValue 

	If Garrison == None
		return 0
	EndIf
	
	BaseGarrisonValue = Garrison.GetKeywordData(CWCost) as Int
	GarrisonValue = BaseGarrisonValue
	
	if BaseGarrisonValue == CWs.iCostNonContestable
 		CWScript.Log("CWCampaignScript", " GetAttackDeltaPointsForDefenderOnlyGarrison() is returning 0 points for the CurrentAttackDelta because Garrison(" + Garrison + ") is Non-Contestable, ie has a CWCost value of:" + BaseGarrisonValue )
	
		return 0
	
	ElseIf Garrison.GetRefTypeAliveCount(CWSoldier) == 0
 		CWScript.Log("CWCampaignScript", " GetAttackDeltaPointsForDefenderOnlyGarrison() is returning " + BaseGarrisonValue + " points for the CurrentAttackDelta because all the soldiers are dead in Garrison(" + Garrison + ")")
	
		return BaseGarrisonValue
	
	;*** !!! THIS IS SIMILAR BUT NOT IDENTICAL TO ELSEIF IN GetAttackDeltaPointsForGarrison() BELOW
	ElseIf (ResourceObject as ResourceObjectScript).IsSabotaged()

		GarrisonValue *= AttackDeltaGarrisonValueModifierForDestroyingResource
		
 		CWScript.Log("CWCampaignScript", " GetAttackDeltaPointsForDefenderOnlyGarrison() is returning " + GarrisonValue + " points for the CurrentAttackDelta because the resource object is destroyed in the Garrison(" + Garrison + ")")
	
		return GarrisonValue		

	
	Else
	
 		CWScript.Log("CWCampaignScript", " GetAttackDeltaPointsForDefenderOnlyGarrison() is returning 0 points for the CurrentAttackDelta because the garrison is intact:"  + Garrison + ")")
		return 0

	EndIf
		
EndFunction

float Function GetAttackDeltaPointsForGarrison(Location Garrison, ObjectReference ResourceObject)
{Returns the CurrentAttackDelta points contributed by the Garrison and it's ResourceObject.}
	;Note:
	;Whoever owns the Garrison gets points for it based on if the resource object is destroyed or not, and if the guards there are alive or not.s so the player can feel like his actions have had an effect

 	CWScript.Log("CWCampaignScript", " GetAttackDeltaPointsForGarrison(Garrison[" + Garrison + "], ResourceObject[" + ResourceObject + "])")

	
	int BaseGarrisonValue 
	float GarrisonValue 

	If Garrison == None
		return 0
	EndIf
	
	BaseGarrisonValue = Garrison.GetKeywordData(CWCost) as Int
	GarrisonValue = BaseGarrisonValue
	
	if BaseGarrisonValue == CWs.iCostNonContestable	;Note this shouldn't be the case unless an error has occured setting the cost in the first place, only defender only garrisons should have a CWCost == iCostNonContestable
 		CWScript.Log("CWCampaignScript", "WARNING: GetAttackDeltaPointsForGarrison() is returning 0 points for the CurrentAttackDelta because Garrison(" + Garrison + ") UNEXPECTEDLY is Non-Contestable, ie has a CWCost value of:" + BaseGarrisonValue, 2)
	
		return 0
	
	ElseIf Garrison.GetRefTypeAliveCount(CWSoldier) == 0
 		CWScript.Log("CWCampaignScript", " GetAttackDeltaPointsForGarrison() is returning 0 points for the CurrentAttackDelta because all the soldiers are dead in Garrison(" + Garrison + ")")
	
		return 0
	
	;*** !!! THIS IS SIMILAR BUT NOT IDENTICAL TO ELSEIF IN GetAttackDeltaPointsForDefenderOnlyGarrison() ABOVE	
	ElseIf (ResourceObject as ResourceObjectScript) != none && (ResourceObject as ResourceObjectScript).IsSabotaged()

		GarrisonValue *= AttackDeltaGarrisonValueModifierForDestroyingResource
		
 		CWScript.Log("CWCampaignScript", " GetAttackDeltaPointsForGarrison() is returning " + GarrisonValue + " points for the CurrentAttackDelta because the resource object is destroyed in the Garrison(" + Garrison + ")")

		;DON'T RETURN, to give chance to process the attacker/defender below
		
	EndIf
	
	if Math.ABS(Garrison.GetKeywordData(CWOwner) as Int) == CWs.Attacker
 		CWScript.Log("CWCampaignScript", " GetAttackDeltaPointsForGarrison() is returning " + GarrisonValue + " points for the CurrentAttackDelta (ie positive value for the Attacker). Garrison:"  + Garrison)

		return GarrisonValue
	
	Else	;owned by Defender
		;only award points if the Defender won it back from the Attacker who purchased it
		;CWO - I don't like this. Defender should have the value regardless
;		if Garrison.GetKeywordData(CWPurchasedByAttacker) as Int == 1
 			CWScript.Log("CWCampaignScript", " GetAttackDeltaPointsForGarrison() is returning " + -(GarrisonValue) + " points for the CurrentAttackDelta (ie negative value for the Defender) because he won it back from the Attacker who purchased it. Garrison:"  + Garrison)

			return -(GarrisonValue)	;Negative value means in the defender's favor
;		Else
; 			CWScript.Log("CWCampaignScript", " GetAttackDeltaPointsForGarrison() is returning 0 points for the CurrentAttackDelta because it is owned by the Defender who did not have to purchase it. Garrison:"  + Garrison)

;			return 0
		
;		EndIf
		

		
	EndIf
	
EndFunction


int Function GetAttackDeltaPointsForPatrols()
{Returns the sum of the CurrentAttackDelta points contributed by the Patrols for both sides.}

	;If the patrol is owned, the owner get's points for it if the patrol isn't dead.
	
	int PatrolValue = CWs.iCostPatrol
	int PatrolsAttackDeltaPoints = 0

	if Patrols == none
		return 0
	endif
	
	Location PatrolsLoc = Patrols.GetLocation()
	;CWO - Check for nulls
	if PatrolsLoc == none
		return 0
	endif
	
	int Attacker = CWs.Attacker
	int Defender = CWs.Defender
	
	if PatrolsLoc.GetRefTypeAliveCount(CWPatrol1) >= 1
		if OwnerPatrol1 == Attacker
			PatrolsAttackDeltaPoints += PatrolValue
		Elseif OwnerPatrol1 == Defender		;must be explictly owned
			PatrolsAttackDeltaPoints += -(PatrolValue)	;negative value means in the defender's favor
		EndIf
	EndIf
	
	if PatrolsLoc.GetRefTypeAliveCount(CWPatrol2) >= 1
		if OwnerPatrol2 == Attacker
			PatrolsAttackDeltaPoints += PatrolValue
		Elseif OwnerPatrol1 == Defender		;must be explictly owned
			PatrolsAttackDeltaPoints += -(PatrolValue)	;negative value means in the defender's favor
		EndIf
	EndIf

	if PatrolsLoc.GetRefTypeAliveCount(CWPatrol3) >= 1
		if OwnerPatrol3 == Attacker
			PatrolsAttackDeltaPoints += PatrolValue
		Elseif OwnerPatrol1 == Defender		;must be explictly owned
			PatrolsAttackDeltaPoints += -(PatrolValue)	;negative value means in the defender's favor
		EndIf
	EndIf
	
	if PatrolsLoc.GetRefTypeAliveCount(CWPatrol4) >= 1
		if OwnerPatrol4 == Attacker
			PatrolsAttackDeltaPoints += PatrolValue
		Elseif OwnerPatrol1 == Defender		;must be explictly owned
			PatrolsAttackDeltaPoints += -(PatrolValue)	;negative value means in the defender's favor
		EndIf
	EndIf
	
	if PatrolsLoc.GetRefTypeAliveCount(CWPatrol5) >= 1
		if OwnerPatrol5 == Attacker
			PatrolsAttackDeltaPoints += PatrolValue
		Elseif OwnerPatrol1 == Defender		;must be explictly owned
			PatrolsAttackDeltaPoints += -(PatrolValue)	;negative value means in the defender's favor
		EndIf
	EndIf

 	CWScript.Log("CWCampaignScript", " GetAttackDeltaPointsForPatrols() is returning " + (PatrolsAttackDeltaPoints) + " points for the patrols. If positive it means the Attacker has more living patrols, if negative it means the defender has more living patrols.).")

	return PatrolsAttackDeltaPoints
	
EndFunction

function addAttackDeltaMissionBonus(int valueToAdd)
	attackDeltaMissionBonus += valueToAdd
 	CWScript.Log("CWCampaignScript", " addAttackDeltaMissionBonus() adding " + valueToAdd + " making AttackDeltaMissionBonus = " + attackDeltaMissionBonus)
	
EndFunction

function subtractAttackDeltaMissionBonus(int valueToSubtract)
	attackDeltaMissionBonus -= valueToSubtract
 	CWScript.Log("CWCampaignScript", " subtractAttackDeltaMissionBonus() subtracting " + valueToSubtract + " making AttackDeltaMissionBonus = " + attackDeltaMissionBonus)
	
EndFunction

int Function getAttackDeltaMissionBonus()
 	CWScript.Log("CWCampaignScript", " getAttackDeltaMissionBonus() returning AttackDeltaMissionBonus: " + attackDeltaMissionBonus)
	return attackDeltaMissionBonus

EndFunction

int Function GetCountFarms(ReferenceAlias ResourceObject1, ReferenceAlias ResourceObject2, ReferenceAlias ResourceObject3)
{Called by CWMissions. Returns the number of farm resource objects.}

	int count

	If ResourceObject1.GetReference() != None && GetResourceType(ResourceObject1) == 1
		count += 1
	endif
	
	If ResourceObject2.GetReference() != None && GetResourceType(ResourceObject2) == 1
		count += 1
	endif
	
	If ResourceObject3.GetReference() != None && GetResourceType(ResourceObject3) == 1
		count += 1
	endif

	return count
	
EndFunction

int Function GetCountMills(ReferenceAlias ResourceObject1, ReferenceAlias ResourceObject2, ReferenceAlias ResourceObject3)
{Called by CWMissions. Returns the number of mill resource objects.}
	
	int count
	
	If ResourceObject1.GetReference() != None && GetResourceType(ResourceObject1) == 2
		count += 1
	endif
	
	If ResourceObject2.GetReference() != None && GetResourceType(ResourceObject2) == 2
		count += 1
	endif
	
	If ResourceObject3.GetReference() != None && GetResourceType(ResourceObject3) == 2
		count += 1
	endif

	return count
	
EndFunction

int Function GetCountMines(ReferenceAlias ResourceObject1, ReferenceAlias ResourceObject2, ReferenceAlias ResourceObject3)
{Called by CWMissions. Returns the number of mine resource objects.}
	
	int count
	
	If ResourceObject1.GetReference() != None && GetResourceType(ResourceObject1) == 3
		count += 1
	endif
	
	If ResourceObject2.GetReference() != None && GetResourceType(ResourceObject2) == 3
		count += 1
	endif
	
	If ResourceObject3.GetReference() != None && GetResourceType(ResourceObject3) == 3
		count += 1
	endif

	return count

EndFunction

int function GetResourceType(ReferenceAlias ResourceObject)
{Returns an int signifying the resource type: 1 = Farm object, 2 = Mill object, 3 = Mine object}

	ResourceObjectScript ResourceObjectS = ResourceObject.GetReference() as ResourceObjectScript
	int type = ResourceObjectS.GetResourceType()
	
	if type < 1 || type > 3
 		CWScript.Log("CWCampaignScript", " GetResourceType() doesn't know what type to return for ResourceObject, will return 4")
		type = 4
	EndIf

 	CWScript.Log("CWCampaignScript", " GetResourceType(" + ResourceObject +") which is objectReference[" + ResourceObject.GetReference() + "]returning type =" + type)

	return type
	
EndFunction


function ForceFieldHQAliases()
{Forces The capitalHQ, or camp location into the FieldHQ and EnemyFieldHQ aliases based on the player's faction and the attacking faction.}

	int playerAllegiance = CWs.PlayerAllegiance
	int Attacker = CWs.Attacker
	int ownerContestedHold = CWs.ownerContestedHold
	int iImperials = CWs.iImperials
	int iSons = CWs.iSons
	
	
	If PlayerAllegiance == ownerContestedHold
		FieldHQ.ForceLocationTo(CapitalHQ.GetLocation())
		
		;make the enemy camp as the EnemyFieldHQ
		If playerAllegiance == iImperials 	;enemy is Sons
			EnemyFieldHQ.ForceLocationTo(CampSons.GetLocation())
		
		Elseif playerAllegiance == iSons ;enemy is Imperials
			EnemyFieldHQ.ForceLocationTo(CampImperial.GetLocation())
		
		Else	;unexpected allegiance
 			CWScript.Log("CWCampaignScript", "ERROR: ForceFieldHQAliases() expected playerAllegiance to be 1 or 2, instead found " + playerAllegiance, 2)
		
		EndIf
		
		
	Else	;player's faction is not the owner of the contested hold, so make his camp the fieldHQ and the capital the EnemyFieldHQ
		EnemyFieldHQ.ForceLocationTo(CapitalHQ.GetLocation())
	
		;make the player's faction camp as the FieldHQ
		If playerAllegiance == iImperials 	;player is Sons
			FieldHQ.ForceLocationTo(CampImperial.GetLocation())
			;CWO - Useful for CWMission06
			EnemyCamp.ForceLocationTo(CampSons.GetLocation())
		
		Elseif playerAllegiance == iSons ;player is Imperials
			FieldHQ.ForceLocationTo(CampSons.GetLocation())
			;CWO - Useful for CWMission06
			EnemyCamp.ForceLocationTo(CampImperial.GetLocation())
		
		Else	;unexpected allegiance
 			CWScript.Log("CWCampaignScript", "ERROR: ForceFieldHQAliases() expected playerAllegiance to be 1 or 2, instead found " + playerAllegiance, 2)
		
		EndIf		
	
	EndIf
	
 	CWScript.Log("CWCampaignScript", " ForceFieldHQAliases(): PlayerAllegiance ==" + PlayerAllegiance + ", ownerContestedHold ==" + ownerContestedHold + ", Attacker ==" + Attacker)
 	CWScript.Log("CWCampaignScript", " ForceFieldHQAliases(): Set FieldHQ to " + FieldHQ.GetLocation() + ", Set EnemyFieldHQ to " + EnemyFieldHQ.GetLocation())

EndFunction


Function PlayerJoinsActiveCampaign()
{When player get's involved in a civil war campaign for the first time, we need to roll it back to the begining.}
; 	CWScript.Log("CWCampaignScript", " PlayerJoinsActiveCampaign() will Call ForceFieldHQAliases(), SetCWCampaignFieldCOAliases, UpdateCWCampaignObjAliases, and AdvanceCampaignPhase(1) ")
	ForceFieldHQAliases()
	SetCWCampaignFieldCOAliases()
	UpdateCWCampaignObjAliases()
	AdvanceCampaignPhase(1) ;forces the campaign to "start over" with phase 1
	startTutorialMission()

EndFunction

function UpdateCWCampaignObjAliases()
{Forces the aliases in CWCampaignObj quest to have the current references/locations of the related aliases in CWCampaign}
 	CWScript.Log("CWCampaignScript", " UpdateCWCampaignObjAliases() forcing CWCampaignObj aliases to match. ")
	;CWO - Set to CWs.FieldCO. CWCampaign FieldCO getting filled in conflicts with dialogue and quests so leaving it empty and optional
	;I dont think CWCampaignObjFieldCO does anything but leave it just in case
	CWCampaignObjFieldCO.ForceRefTo(CWs.GetRikkeOrGalmar())
	CWCampaignObjFactionLeader.ForceRefTo(CWs.AliasFactionLeader.GetReference())
	CWCampaignObjCampaignStartMarker.ForceRefTo(CampaignStartMarker.GetReference())
	CWCampaignObjCampaignHold.ForceLocationTo(Hold.GetLocation())

EndFunction

Function startTutorialMission()
	int tutorial = CWs.TutorialMissionComplete

; 	CWScript.Log("CWCampaignScript", " StartTutorialMission()")	
	CWMissionTutorialStart.SendStoryEvent(Hold.Getlocation(), CampaignStartMarker.GetReference(), CWMission1Ref)
	
EndFunction

Function stopTutorialMission()

	;CWO - Not doing tutorial missions
	return

	int secondsWaiting = 0

	;This is called by "CWScript FinishCampaign()"
	;In the event that a campaign finishes before the player runs the mission, we need to be sure to completely stop the tutorial mission before the campaign wraps up, so when the next campaign starts we can start the tutorial mission properly.

; 	CWScript.Log("CWCampaignScript", " stopTutorialMission() stopping CWMission00")
	
	CWMission00.stop()
	
	while CWMission00.IsStopped() == False
		Utility.wait(5)
		secondsWaiting += 5
; 		CWScript.Log("CWCampaignScript", " stopTutorialMission() waiting for CWMission00 to stop. Seconds spent waiting:" + secondsWaiting, 1)
	EndWhile

EndFunction

;Used by CWCampaignFieldCOScript - see Stage 0 in CWCampaign
ObjectReference Function GetAttackerFieldHQCenterMarker()
	
	ObjectReference CenterMarkerRef
	
	if CWs.Attacker == CWs.iImperials
		CenterMarkerRef = CampImperialLocationCenterMarker.GetReference()
	
	elseif CWs.Attacker == CWs.iSons
		CenterMarkerRef = CampSonsLocationCenterMarker.GetReference()
			
	Else
; 		CWScript.Log("CWCampaignScript", " WARNING: GetAttackerFieldHQCenterMarker() expected CWs.Attacker to be 1 or 2, instead found " + CWs.Attacker, 2, 1, 1)
		CenterMarkerRef = none
	EndIf

; 	CWScript.Log("CWCampaignScript", " GetAttackerFieldHQCenterMarker() returning " + CenterMarkerRef)
	
	return CenterMarkerRef
	
EndFunction

ObjectReference function GetCapitalHQMarker()
	ObjectReference markerRef = CapitalHQMarker.GetReference()

 	CWScript.Log("CWCampaignScript", " GetCapitalHQMarker() returning " + MarkerRef)

	Return MarkerRef
	
EndFunction


ObjectReference  function GetFieldHQMarker()
 	CWScript.Log("CWCampaignScript", " GetFieldHQCenterMarker()")
	
	ObjectReference MarkerRef
	
	if CWs.PlayerAllegiance == CWs.Attacker
		MarkerRef = GetAttackerFieldHQCenterMarker()
	
	Else
		MarkerRef = GetCapitalHQMarker()
		
	EndIf

 	CWScript.Log("CWCampaignScript", " GetFieldHQMarker() is returning " + MarkerRef)
	
	Return MarkerRef
	
EndFunction


ObjectReference  function GetEnemyFieldHQMarker()
 	CWScript.Log("CWCampaignScript", " GetEnemyFieldHQMarker()")
	
	ObjectReference MarkerRef
	
	if CWs.PlayerAllegiance == CWs.Attacker
		MarkerRef = GetCapitalHQMarker()	;since player is attacking then the enemy is defending and has the captial hq
	
	Else
		MarkerRef = GetAttackerFieldHQCenterMarker() ;since player is defending then the enemy is attacking	
		
	EndIf

 	CWScript.Log("CWCampaignScript", " GetEnemyFieldHQMarker() is returning " + MarkerRef)
	
	Return MarkerRef
	
EndFunction



;*******************************************************************************************************************
;***	OBSOLETE FUNCTIONS BELOW	***
;*******************************************************************************************************************

Function StartMissions()
	;CWO - Mostly a rewrite of this function. If we have not yet reached the resolution phase
	;phase try to start 2 CWMissions... If reached or we could not start any CWMissions, start
	;final siege for the hold.
	;*******************************************************************
	;Do not do anything if missions are already running.
	CWScript.Log("CWCampaignScript", " StartMissions()")
	if StartMissionsRunning
		CWScript.Log("CWCampaignScript", "StartMissions() in progress...")
		return
	endif

	StartMissionsRunning = true

	if isCWMissionsOrSiegesRunning()
		CWScript.Log("CWCampaignScript", "StartMissions() Missions already running. Bailing out")
		StartMissionsRunning = false
		return
	endif
		
	If CWCampaignPhase.value < ResolutionPhase		;then start normal missions
	
 		CWScript.Log("CWCampaignScript", " StartMissions() CWCampaignPhase(" + CWCampaignPhase.value + ") < ResolutionPhase(" + ResolutionPhase + "). Starting Missions.")
		
		bool cwMission1Started = CWMissionStart.SendStoryEventAndWait(Hold.Getlocation(), CWs.FieldCO.GetActorRef(), CampaignStartMarker.GetReference(), aiValue1 = 1)
		utility.wait(2.0)
		bool cwMission2Started = CWOMissionStart2.SendStoryEventAndWait(Hold.Getlocation(), CWs.FieldCO.GetActorRef(), CampaignStartMarker.GetReference(), aiValue1 = 2)
		if !cwMission1Started && !cwMission2Started
			Debug.Notification("Warning! Could not start any radient missions. Commencing with city siege.")
			AdvanceCampaignPhase(ResolutionPhase)
			StartResolutionMission()
		elseif !cwMission1Started || !cwMission2Started
			AdvanceCampaignPhase()
		endif
		
		;we used to offer three missiosn, now we are only offering two at a time
		;CWMissionStart.SendStoryEvent(Hold.Getlocation(), CampaignStartMarker.GetReference(), CWMission3Ref)
		
;		((Self as Quest) as CWCampaignPollForMissionAcceptScript).StartPolling()
	
	Else	;then start the resolution Quest
		if CWs.TutorialMissionComplete == 0
; 			CWScript.Log("CWCampaignScript", " AdvanceCampaignPhase() CWCampaignPhase(" + CWCampaignPhase.value + ") == ResolutionPhase(" + ResolutionPhase + "). Tutorial mission not completed, resolving offscreen.")
			CWs.ResolveOffscreen(GetCurrentAttackDelta())
			
		Else
; 			CWScript.Log("CWCampaignScript", " AdvanceCampaignPhase() CWCampaignPhase(" + CWCampaignPhase.value + ") == ResolutionPhase(" + ResolutionPhase + "). Starting Resolution Mission.")
			StartResolutionMission()
;			((Self as Quest) as CWCampaignPollForMissionAcceptScript).StartPolling()
		
		EndIf
			
;	Else	; We are trying to advance into a phase after the resolution phase, which means we should resolve the resolution mission off screen
;; 		CWScript.Log("CWCampaignScript", " AdvanceCampaignPhase() CWCampaignPhase(" + CWCampaignPhase.value + ") > ResolutionPhase(" + ResolutionPhase + "). Resolving Resolution Mission OFFSCREEN.")
;		((Self as Quest) as CWCampaignPollForMissionAcceptScript).StopPolling()
;		CWs.ResolveOffscreen(GetCurrentAttackDelta())
	
	EndIf

	StartMissionsRunning = false

EndFunction

;*******************************************************************************************************************
;***	NEW CWO FUNCTIONS BELOW	***
;*******************************************************************************************************************

function SetReinforcementsMajorCity(CWSiegeScript kmyQuest)
	CWScript.Log("CWCampaignScript", " SetReinforcementsMajorCity()") 
	;schofida - Set pools for whiterun, windhelm, rift, markath and solitude
	CWReinforcementControllerScript CWReinforcementControllerS = (kmyQuest as quest ) as CWReinforcementControllerScript
	CWReinforcementControllerS.PoolRemainingAttackerObjective = 2999
	if kmyQuest.IsAttack()
		kmyQuest.SetPoolAttackerOnCWReinforcementScript(CWOSiegeReinforcements.GetValueInt(), 1.0, CWOPlayerAttackerScaleMult.GetValue(), false)
		kmyQuest.SetPoolDefenderOnCWReinforcementScript(999, 1.0, 1.0, false)
		CWReinforcementControllerS.PoolRemainingDefenderObjective = 9999
	else
		kmyQuest.SetPoolAttackerOnCWReinforcementScript(CWOSiegeReinforcements.GetValueInt(), 1.0, CWOEnemyAttackerScaleMult.GetValue(), false)
		kmyQuest.SetPoolDefenderOnCWReinforcementScript(CWOSiegeReinforcements.GetValueInt(), 1.0, CWOPlayerDefenderScaleMult.GetValue(), false)
		CWReinforcementControllerS.PoolRemainingDefenderObjective = 2998
	endIf
endfunction

function SetReinforcementsFort(Quest kmyQuest)
	CWScript.Log("CWCampaignScript", " SetReinforcementsFort()") 
	;schofida - Set pools for whiterun, windhelm, rift, markath and solitude
	if (kmyQuest as CWFortSiegeScript).IsPlayerAttacking()
		(kmyQuest as CWFortSiegeScript).SetPoolAttackerOnCWReinforcementScript(CWOFortReinforcements.GetValueInt(), 1.0, CWOPlayerAttackerScaleMult.GetValue(), false)
		(kmyQuest as CWFortSiegeScript).SetPoolDefenderOnCWReinforcementScript(CWOFortReinforcements.GetValueInt(), 1.0, CWOEnemyDefenderScaleMult.GetValue(), false)
	else
		(kmyQuest as CWFortSiegeScript).SetPoolAttackerOnCWReinforcementScript(CWOFortReinforcements.GetValueInt(), 1.0, CWOEnemyAttackerScaleMult.GetValue(), false)
		(kmyQuest as CWFortSiegeScript).SetPoolDefenderOnCWReinforcementScript(CWOFortReinforcements.GetValueInt(), 1.0, CWOPlayerDefenderScaleMult.GetValue(), false)
	endIf
endfunction

function SetReinforcementsMinorCity(Quest kmyQuest)
	CWScript.Log("CWCampaignScript", " SetReinforcementsMinorCity()") 
	;schofida - Set pools for whiterun, windhelm, rift, markath and solitude
	if (kmyQuest as CWFortSiegeScript).IsPlayerAttacking()
		(kmyQuest as CWFortSiegeScript).SetPoolAttackerOnCWReinforcementScript(CWOCapitalReinforcements.GetValueInt(), 1.0, CWOPlayerAttackerScaleMult.GetValue(), false)
		(kmyQuest as CWFortSiegeScript).SetPoolDefenderOnCWReinforcementScript(CWOCapitalReinforcements.GetValueInt(), 1.0, CWOEnemyDefenderScaleMult.GetValue(), false)
	else
		(kmyQuest as CWFortSiegeScript).SetPoolAttackerOnCWReinforcementScript(CWOCapitalReinforcements.GetValueInt(), 1.0, CWOEnemyAttackerScaleMult.GetValue(), false)
		(kmyQuest as CWFortSiegeScript).SetPoolDefenderOnCWReinforcementScript(CWOCapitalReinforcements.GetValueInt(), 1.0, CWOPlayerDefenderScaleMult.GetValue(), false)
	endIf
endfunction

function StartMonitors(Quest kmyQuest)
	CWScript.Log("CWCampaignScript", " StartMonitors()") 
	;CWO - This quest marks the player as essential and auto/resolves the battle if he/she falls
	if CWODisableFaint.GetValueInt() == 0
		CWOStillABetterEndingMonitor.start()
		CWOStillABetterEndingMonitor.triggerQuest = kmyQuest
	endif

	CWSiegePollPlayerLocation ppLocation = kmyQuest as CWSiegePollPlayerLocation
	if ppLocation != none
		ppLocation.PlayerHasBeenToLocationOfBattle = true
	endif

endfunction

function StopMonitors()
	CWScript.Log("CWCampaignScript", " StopMonitors()") 
	;CWO - Stops monitor quest, so player can die again :)
	CWOStillABetterEndingMonitor.Stop()
endfunction

function StopDisguiseQuest()
	CWScript.Log("CWCampaignScript", " StopDisguiseQuest()") 
	;schofida - revert Disguise changes
	CWOArmorDisguise.Stop()
	CWs.PlayerFaction.SetEnemy(CWs.getPlayerAllegianceEnemyFaction(true), false, false)
	CWODisguiseGlobal.SetValueInt(0)
endfunction

function StartDisguiseQuest()
	CWScript.Log("CWCampaignScript", " StartDisguiseQuest()") 
	;schofida - restart disguises quest
	CWOArmorDisguise.Start()
endfunction

function cwResetCrime()
	CWScript.Log("CWCampaignScript", " cwResetCrime()") 
	;schofida - reset crime on Stormcloaks/imperials so you are not attacked by soldiers when you are back at tent
	CWs.CrimeFactionImperial.SetCrimeGold(0)
	CWs.CrimeFactionImperial.SetCrimeGoldViolent(0)
	CWs.CrimeFactionSons.SetCrimeGold(0)
	CWs.CrimeFactionSons.SetCrimeGoldViolent(0)
endfunction

function StartDefense(Location CityFortOrGarrison)
	CWScript.Log("CWCampaignScript", " StartDefense()") 
	;This function is called at start up stage for CWMission01, CWFortSiegeFort, CWFortSiegeCapital, CWSiege
	;If player is on the defense for this campaign, start the courier quest.
	if CWS.CWAttacker.GetValueInt() != CWs.PlayerAllegiance && CWS.WhiterunSiegeFinished && PlayerAllegianceLastStand()
		CWScript.Log("CWCampaignScript", "StartDefense() - Player on defense. Starting Defender Quest")
		CWODefendingStart.sendstoryeventandwait(CityFortOrGarrison, Cws.GetRikkeOrGalmar(), none, 0, 0)
	elseif CWS.CWAttacker.GetValueInt() != CWs.PlayerAllegiance && CWS.WhiterunSiegeFinished
		CWScript.Log("CWCampaignScript", "StartDefense() - Player on defense. Starting Defender Quest")
		CWODefendingStart.sendstoryeventandwait(CityFortOrGarrison, Cws.GetReferenceHQFieldCOForHold(Hold.GetLocation(), CWs.PlayerAllegiance), none, 0, 0)		
	endIf
endfunction

bool function PlayerAllegianceLastStand()
	CWScript.Log("CWCampaignScript", " PlayerAllegianceLastStand() + " + CWOStillABetterEndingGlobal.GetValueInt())
	;This will be 1 when the player is on the defense for the final hold Windhelm/Solitude
	if CWOStillABetterEndingGlobal.GetValueInt() == 1
		return true 
	endif
	return false
endfunction

function SetLastStand(bool Flag)
	CWScript.Log("CWCampaignScript", " SetLastStand() + " + Flag)
	;This will be 1 when the player is on the defense for the final hold Windhelm/Solitude
	if Flag
		CWOStillABetterEndingGlobal.SetValueInt(1)
	Else
		CWOStillABetterEndingGlobal.SetValueInt(0)
	endif
endfunction

function DragonTime()
	CWScript.Log("CWCampaignScript", " DragonTime()") 
	;CWO - Dragon Time!
	if CWOPCChance.GetValueInt() > utility.randomint(0, 100)
		CWScript.Log("CWCampaignScript", " DragonTime() Starting Dragon Quest") 
		cwopartycrasher.SendStoryEvent(Capital.GetLocation() )
	endIf
endfunction

function NoMoreDragonTime()
	CWOPartyCrasherCageMatch.Stop()
endfunction

function CWOImperialsWin()

	CWs.SetOwnerHaafingar(CWs.iImperials, false)
	CWs.SetOwnerHjaalmarch(CWs.iImperials, false)
	CWs.SetOwnerReach(CWs.iImperials, false)
	CWs.SetOwnerFalkreath(CWs.iImperials, false)
	CWs.SetOwnerWhiterun(CWs.iImperials, false)
	CWs.SetOwnerPale(CWs.iImperials, false)
	CWs.SetOwnerWinterhold(CWs.iImperials, false)
	CWs.SetOwnerEastmarch(CWs.iImperials, false)
	ResolveCivilWarOffscreen()
endFunction

function CWOStormcloaksWin()

	CWs.SetOwnerHaafingar(CWs.iSons, false)
	CWs.SetOwnerHjaalmarch(CWs.iSons, false)
	CWs.SetOwnerReach(CWs.iSons, false)
	CWs.SetOwnerFalkreath(CWs.iSons, false)
	CWs.SetOwnerWhiterun(CWs.iSons, false)
	CWs.SetOwnerPale(CWs.iSons, false)
	CWs.SetOwnerWinterhold(CWs.iSons, false)
	CWs.SetOwnerEastmarch(CWs.iSons, false)
	ResolveCivilWarOffscreen()
endFunction

function CWOTotalReset()

	CWSiege.stop()
	CWS.CWFortSiegeCapital.stop()
	CWS.CWFortSiegeFort.stop()
	CWs.SetInitialOwners()
endFunction

function CompleteCWMissions(bool failMission = false)
	int stageToSet = 200
	int stageToSetFort = 9000 
	if failMission
		stageToSet = 205
		stageToSetFort = 9200
	endif
	if CWMission01.IsRunning()
		CWMission01.SetStage(stageToSet)
		Utility.wait(3)
	endIf
	if CWMission02.IsRunning()
		CWMission02.SetStage(stageToSet)
		Utility.wait(3)
	endIf
	if CWs.CWMission03.IsRunning()
		CWs.CWMission03.SetStage(stageToSet)
		Utility.wait(3)
	endIf
	if CWs.CWMission04.IsRunning()
		CWs.CWMission04.SetStage(stageToSet)
		Utility.wait(3)
	endIf
	if CWMission05.IsRunning()
		CWMission05.SetStage(stageToSet)
		Utility.wait(3)
	endIf
	if CWMission06.IsRunning()
		CWMission06.SetStage(stageToSet)
		Utility.wait(3)
	endIf
	if CWs.CWMission07.IsRunning()
		CWs.CWMission07.SetStage(stageToSet)
		Utility.wait(3)
	endIf
	if CWMission08Quest.IsRunning()
		CWMission08Quest.SetStage(stageToSet)
		Utility.wait(3)
	endIf
	if CWMission09.IsRunning()
		CWMission09.SetStage(stageToSet)
		Utility.wait(3)
	endIf
	If CWS.CWFortSiegeFort.IsRunning() && CWS.CWFortSiegeFort.GetStage() < 950
		if CWS.IsPlayerAttacking((CWS.CWFortSiegeFort as CWFortSiegeScript).Fort.GetLocation())
			if failMission
				CWS.CWFortSiegeFort.Setstage(2000)
			else
				CWS.CWFortSiegeFort.Setstage(1000)
			endif
		else
			if failMission
				CWS.CWFortSiegeFort.Setstage(1000)
			else
				CWS.CWFortSiegeFort.Setstage(2000)
			endif
		endIf
	endif
endFunction

bool function isCWMissionsOrSiegesRunning()
	CWScript.Log("CWCampaignScript", " isCWMissionsOrSiegesRunning()")
	string ret = ""
	if CWMission01.IsRunning()
		ret = "CWMission01"
	elseif CWMission02.IsRunning()
		ret = "CWMission02"
	elseif CWs.CWMission03.IsRunning()
		ret = "CWMission03"
	elseif CWs.CWMission04.IsRunning()
		ret = "CWMission04"
	elseif CWMission05.IsRunning()
		ret = "CWMission05"
	elseif CWMission06.IsRunning()
		ret = "CWMission06"
	elseif CWs.CWMission07.IsRunning()
		ret = "CWMission07"
	elseif CWMission08Quest.IsRunning()
		ret = "CWMission08Quest"
	elseif CWMission09.IsRunning()
		ret = "CWMission09"
	elseif CWs.CWFortSiegeFort.IsRunning()
		ret = "CWFortSiegeFort"
	elseif (CWs.CWFortSiegeCapital as CWFortSiegeScript).GetMinorCityQuestStillRunning()
		ret = "CWFortSiegeCapital"
	elseif (CWSiege as CWSiegeScript).GetQuestStillRunning()
		ret = "CWSiege"
	endif
	CWScript.Log("CWCampaignScript", " isCWMissionsOrSiegesRunning() = " + ret)
	return StringUtil.GetLength(ret) > 0
endFunction

function ResolveCivilWarOffscreen()

	if !PlayerAllegianceLastStand()
		if CWs.PlayerAllegiance == CWs.iImperials
			CWS.Galmar.GetActorReference().KillEssential(CWS.Rikke.GetActorReference())
			Utility.Wait(5.0)
			CWS.UlfricRef.KillEssential(CWS.GeneralTulliusRef)
		Else
			CWS.Rikke.GetActorReference().KillEssential(CWS.Galmar.GetActorReference())
			Utility.Wait(5.0)
			CWS.GeneralTulliusRef.KillEssential(CWS.UlfricRef)
		endif
	else
		if CWs.PlayerAllegiance == CWs.iImperials
			CWS.Rikke.GetActorReference().KillEssential(CWS.Galmar.GetActorReference())
			Utility.Wait(5.0)
			CWS.GeneralTulliusRef.KillEssential(CWS.UlfricRef)
		Else
			CWS.Galmar.GetActorReference().KillEssential(CWS.Rikke.GetActorReference())
			Utility.Wait(5.0)
			CWS.UlfricRef.KillEssential(CWS.GeneralTulliusRef)
		endif
	endif
endfunction

function AcceptRadiantMissions()
	int stageToSet = 10
	if CWMission01.IsRunning()
		CWMission01.SetStage(stageToSet)
		Utility.wait(3)
	endIf
	if CWMission02.IsRunning()
		CWMission02.SetStage(stageToSet)
		Utility.wait(3)
	endIf
	if CWs.CWMission03.IsRunning()
		CWs.CWMission03.SetStage(stageToSet)
		Utility.wait(3)
	endIf
	if CWs.CWMission04.IsRunning()
		CWs.CWMission04.SetStage(stageToSet)
		Utility.wait(3)
	endIf
	if CWMission05.IsRunning()
		CWMission05.SetStage(stageToSet)
		Utility.wait(3)
	endIf
	if CWMission06.IsRunning()
		CWMission06.SetStage(stageToSet)
		Utility.wait(3)
	endIf
	if CWs.CWMission07.IsRunning()
		CWs.CWMission07.SetStage(stageToSet)
		Utility.wait(3)
	endIf
	if CWMission08Quest.IsRunning()
		CWMission08Quest.SetStage(stageToSet)
		Utility.wait(3)
	endIf
	if CWMission09.IsRunning()
		CWMission09.SetStage(stageToSet)
		Utility.wait(3)
	endIf
	if CWs.CWFortSiegeFort.IsRunning()
		CWs.CWFortSiegeFort.SetStage(stageToSet)
	endIf
endfunction

Function StartSpanishInquisition(LocationAlias holdToStart)

	CWScript.Log("CWCampaignScript", " StartSpanishInquisition() starting CWSiegeStart for " + holdToStart.Getlocation())
	Location SAHoldLoc = CWs.GetMyCurrentHoldLocation(Game.GetPlayer())
	ObjectReference SAFieldCO = CWs.GetReferenceHQFieldCOForHold(SAHoldLoc, CWs.playerAllegiance)
	ObjectReference SACampaignStartMarker =  CWs.getCampaignStartMarker(CWs.getIntForHoldLocation(SAHoldLoc))

	If Capital.GetLocation().HasKeyword(LocTypeCity) && CWs.debugTreatCityCapitalsAsTowns == 0 && CWSiegeStart.SendStoryEventAndWait(holdToStart.GetLocation(), SAFieldCO);capital is a city (note the debugTreatCityCapitalsAsTowns)
		while CWSiege.GetStageDone(0) == False
			Utility.Wait(1)
		EndWhile
		(SAFieldCO As Actor).AddToFaction(CWODefensiveFaction)
		SetStage(200)
	EndIf

endfunction

function DisplayHoldObjective()
;THIS HANDLES THE NEW NON-LINEAR STYLE CAMPAIGN OBJECTIVES

	CWScript.log("CWCampaignScript", "DisplayHoldObjective()")

	CWs.CWObj.SetObjectiveDisplayed(100 * CWs.CWContestedHold.GetValueInt() + CWs.PlayerAllegiance, abDisplayed = true, abForce = true)
	;***THIS LOGIC MUST BE IDENTICAL TO THE STACK OF DIALOGUE IN THE CW DIALOGUE WHERE Tullis/Ulfric TELL YOU WHERE TO GO NEXT ***

	
	CWs.CWObj.SetActive()
	
EndFunction

function registerMissionSuccess(Location HoldLocation, bool isFortBattle = False)
	CWs.CountMissionSuccess += 1
	
	CWScript.log("CWScript", "registerMissionSuccess(HoldLocation:" + HoldLocation + ", isFortBattle:" + isFortBattle + ") CountMissionSuccess = " + CWs.CountMissionSuccess + ". Calling DisplayHoldObjective() if isFortBattle == false")
	
	;NOTE:
	;If isFortBattle is true, then we should skip displaying the Hold Objective, UNLESS we decide put reimplement the final battles at the capitals
	
	if isFortBattle == False
		DisplayHoldObjective()
	EndIf
	
EndFunction

Function MoveRikkeGalmarToCampIfNeeded(bool CheckIfUnloaded = False)
	{Moves them to the proper camp if not already there and, if not in the same location as the player.}
	;When called by Rikke/Galmar's OnUnload block, CheckIfUnloaded == false, when called by their OnPackageChange block it is True
	;CWO Clone of CWScript version but also includes the Whiterun camp
	CWScript.Log("CWScript", "MoveRikkeGalmarToCampIfNeeded()")
	
	if CWs.WarIsActive == 1 && CWs.GetStageDone(4)

		if CWs.PlayerAllegiance == CWs.iImperials
			CWScript.Log("CWScript", "MoveRikkeGalmarToCampIfNeeded() player is Imperial, checking Rikke")

			Actor RikkeActor = CWs.Rikke.GetActorReference()
			Package CurrentPackage =	RikkeActor.GetCurrentPackage()
			
			if CheckIfUnloaded
				If RikkeActor.Is3DLoaded()
					CWScript.Log("CWScript", "MoveRikkeGalmarToCampIfNeeded() CheckIfUnloaded == true, and Rikke has 3D so skip this.")
					return
				EndIf
			EndIf
			
			if CWs.CheckRikkeGalmarNotAtCampPackageLocationAndMoveIfNeeded(RikkeActor, CWs.CWRikkeAtCampPale, CWs.MilitaryCampPaleImperialLocation, CWs.CWFieldCOMapTableMarkerPaleCampImperial)
			elseif CWs.CheckRikkeGalmarNotAtCampPackageLocationAndMoveIfNeeded(RikkeActor, CWs.CWRikkeAtCampRift, CWs.MilitaryCampRiftImperialLocation, CWs.CWFieldCOMapTableMarkerRiftCampImperial)
			elseif CWs.CheckRikkeGalmarNotAtCampPackageLocationAndMoveIfNeeded(RikkeActor, CWs.CWRikkeAtCampWinterhold, CWs.MilitaryCampWinterholdImperialLocation, CWs.CWFieldCOMapTableMarkerWinterholdCampImperial)
			elseif CWs.CheckRikkeGalmarNotAtCampPackageLocationAndMoveIfNeeded(RikkeActor, CWs.CWRikkeAtCampHjaalmarch, CWs.MilitaryCampHjaalmarchImperialLocation, CWs.CWFieldCOMapTableMarkerHjaalmarchCampImperial)
			elseif CWs.CheckRikkeGalmarNotAtCampPackageLocationAndMoveIfNeeded(RikkeActor, CWs.CWRikkeAtCampFalkreath, CWs.MilitaryCampFalkreathImperialLocation, CWs.CWFieldCOMapTableMarkerFalkreathCampImperial)
			elseif CWs.CheckRikkeGalmarNotAtCampPackageLocationAndMoveIfNeeded(RikkeActor, CWs.CWRikkeAtCampReach, CWs.MilitaryCampReachImperialLocation, CWs.CWFieldCOMapTableMarkerReachCampImperial)
			elseif CWs.CheckRikkeGalmarNotAtCampPackageLocationAndMoveIfNeeded(RikkeActor, CWs.CWRikkeAtCampEastmarch, CWs.MilitaryCampEastmarchImperialLocation, CWs.CWFieldCOMapTableMarkerEastmarchCampImperial)
			elseif CWs.CheckRikkeGalmarNotAtCampPackageLocationAndMoveIfNeeded(RikkeActor, CWRikkeAtCampWhiterun, CWs.MilitaryCampWhiterunImperialLocation, CWs.CWFieldCOMapTableMarkerWhiterunCampImperial)
			EndIf
			
			
		elseif CWs.PlayerAllegiance == CWs.iSons
			CWScript.Log("CWScript", "MoveRikkeGalmarToCampIfNeeded() player is Sons, checking Galmar")
		
			Actor GalmarActor = CWs.Galmar.GetActorReference()
			Package CurrentPackage =	GalmarActor.GetCurrentPackage()
		
			if CheckIfUnloaded
				If GalmarActor.Is3DLoaded()
					CWScript.Log("CWScript", "MoveGalmarGalmarToCampIfNeeded() CheckIfUnloaded == true, and Galmar has 3D so skip this.")
					return
				EndIf
			EndIf
		
			CWScript.Log("CWScript", "MoveGalmarGalmarToCampIfNeeded() calling EvaluatePackage() on Galmar")
			GalmarActor.EvaluatePackage()
		
			if CWs.CheckRikkeGalmarNotAtCampPackageLocationAndMoveIfNeeded(GalmarActor, CWs.CWGalmarAtCampFalkreath, CWs.MilitaryCampFalkreathSonsLocation, CWs.CWFieldCOMapTableMarkerFalkreathCampSons)
			elseif CWs.CheckRikkeGalmarNotAtCampPackageLocationAndMoveIfNeeded(GalmarActor, CWs.CWGalmarAtCampReach, CWs.MilitaryCampReachSonsLocation, CWs.CWFieldCOMapTableMarkerReachCampSons)
			elseif CWs.CheckRikkeGalmarNotAtCampPackageLocationAndMoveIfNeeded(GalmarActor, CWs.CWGalmarAtCampHjaalmarch, CWs.MilitaryCampHjaalmarchSonsLocation, CWs.CWFieldCOMapTableMarkerHjaalmarchCampSons)
			elseif CWs.CheckRikkeGalmarNotAtCampPackageLocationAndMoveIfNeeded(GalmarActor, CWs.CWGalmarAtCampPale, CWs.MilitaryCampPaleSonsLocation, CWs.CWFieldCOMapTableMarkerPaleCampSons)
			elseif CWs.CheckRikkeGalmarNotAtCampPackageLocationAndMoveIfNeeded(GalmarActor, CWs.CWGalmarAtCampWinterhold, CWs.MilitaryCampWinterholdSonsLocation, CWs.CWFieldCOMapTableMarkerWinterholdCampSons)
			elseif CWs.CheckRikkeGalmarNotAtCampPackageLocationAndMoveIfNeeded(GalmarActor, CWs.CWGalmarAtCampRift, CWs.MilitaryCampRiftSonsLocation, CWs.CWFieldCOMapTableMarkerRiftCampSons)
			elseif CWs.CheckRikkeGalmarNotAtCampPackageLocationAndMoveIfNeeded(GalmarActor, CWs.CWGalmarAtCampHaafingar, CWs.MilitaryCampHaafingarSonsLocation, CWs.CWFieldCOMapTableMarkerHaafingarCampSons)
			elseif CWs.CheckRikkeGalmarNotAtCampPackageLocationAndMoveIfNeeded(GalmarActor, CWGalmarAtCampWhiterun, CWs.MilitaryCampWhiterunSonsLocation, CWs.CWFieldCOMapTableMarkerWhiterunCampSons)
			EndIf
				
		Else
			CWScript.Log("CWScript", "MoveRikkeGalmarToCampIfNeeded() player is Neither Imperial nor Sons, not checking Rikke or Galmar")
		
		EndIf

	Else
	
		CWScript.Log("CWScript", "MoveRikkeGalmarToCampIfNeeded() WarIsActive == false or GetStageDone(4) == false, not checking.")
		
	EndIf



EndFunction

function ShuffleGarrisons()
	Location[] Garrisons = new Location[4]
	ObjectReference[] GarrisonsEnableImperial = new ObjectReference[4]
	ObjectReference[] GarrisonsEnableSons = new ObjectReference[4]
	ObjectReference[] GarrisonsResourceObjects = new ObjectReference[4]

	Garrisons[0] = Garrison1.GetLocation()
	Garrisons[1] = Garrison2.GetLocation()
	Garrisons[2] = Garrison3.GetLocation()
	Garrisons[3] = Garrison4.GetLocation()	
	GarrisonsEnableImperial[0] = Garrison1EnableImperial.GetReference()
	GarrisonsEnableImperial[1] = Garrison2EnableImperial.GetReference()
	GarrisonsEnableImperial[2] = Garrison3EnableImperial.GetReference()
	GarrisonsEnableImperial[3] = Garrison4EnableImperial.GetReference()	
	GarrisonsEnableSons[0] = Garrison1EnableSons.GetReference()
	GarrisonsEnableSons[1] = Garrison2EnableSons.GetReference()
	GarrisonsEnableSons[2] = Garrison3EnableSons.GetReference()
	GarrisonsEnableSons[3] = Garrison4EnableSons.GetReference()	
	GarrisonsResourceObjects[0] = Garrison1ResourceObject.GetReference()
	GarrisonsResourceObjects[1] = Garrison2ResourceObject.GetReference()
	GarrisonsResourceObjects[2] = Garrison3ResourceObject.GetReference()
	GarrisonsResourceObjects[3] = Garrison4ResourceObject.GetReference()	

	int ascOrDesc = Utility.randomint(0, 1)
	if ascOrDesc == 0
		int i = 0
		while i <= 3
			if Garrisons[i] != none && GarrisonsEnableImperial[i] != none && GarrisonsEnableSons[i] != none && GarrisonsResourceObjects[i] != none
				Garrison1.ForceLocationTo(Garrisons[i])
				Garrison1EnableImperial.ForceRefTo(GarrisonsEnableImperial[i])
				Garrison1EnableSons.ForceRefTo(GarrisonsEnableSons[i])
				Garrison1ResourceObject.ForceRefTo(GarrisonsResourceObjects[i])
				i = 3
			endif
			i = i + 1
		EndWhile
	else
		int i = 3
		while i >= 0
			if Garrisons[i] != none && GarrisonsEnableImperial[i] != none && GarrisonsEnableSons[i] != none && GarrisonsResourceObjects[i] != none
				Garrison1.ForceLocationTo(Garrisons[i])
				Garrison1EnableImperial.ForceRefTo(GarrisonsEnableImperial[i])
				Garrison1EnableSons.ForceRefTo(GarrisonsEnableSons[i])
				Garrison1ResourceObject.ForceRefTo(GarrisonsResourceObjects[i])
				i = 0
			endif
			i = i - 1
		EndWhile
	endif
endfunction

function CompleteCWSieges()
	CWScript.Log("CWScript", "CompleteCWSieges()")
	if CWS.CWSiegeS.IsRunning() && CWS.CWSiegeS.GetStage() < 50 ;schofida - siege and capital are both running in final siege. Have capital take care of it
		if CWS.IsPlayerAttacking(CWS.CWSiegeS.City.GetLocation())
			CWS.CWSiegeS.Setstage(50)
			if CWS.CWFinale.IsRunning()
				ResolveCivilWarOffscreen()
			endif
		else
			CWS.CWSiegeS.Setstage(200)
		endIf
	elseIf CWS.CWFortSiegeCapital.IsRunning() && CWS.CWFortSiegeCapital.GetStage() < 1000
		if CWS.IsPlayerAttacking((CWS.CWFortSiegeCapital as CWFortSiegeScript).Fort.GetLocation())
			CWS.CWFortSiegeCapital.Setstage(1000)
		else
			CWS.CWFortSiegeCapital.Setstage(2000)
		endIf
	endIf
endfunction

function SetMonitorMajorCitySiegeStopping()
	(CWOMonitorQuest.GetAlias(0) as CWOMonitorScript).GoToState("WaitingForPlayerToBeOutOfMajorCity")
endfunction

function SetMonitorMinorCitySiegeStopping()
	(CWOMonitorQuest.GetAlias(0) as CWOMonitorScript).GoToState("WaitingForPlayerToBeOutOfMinorCity")
endfunction

function SetMonitorMajorCitySiegeStopped()
	(CWOMonitorQuest.GetAlias(0) as CWOMonitorScript).GoToState("WaitingForSiegeToStop")
endfunction

function StartCWOBAControllerQuest()
	CWOBAController.Start()
endfunction

function StopCWOBAControllerQuest()
	CWOBAController.Stop()
endfunction

Bool Function FactionOwnsAll(int FactionToTest)
	{Returns true if FactionToTest represents a faction that owns all the contestable holds.}
		
	;Note the use of \ to break the single if statement across multiple lines for ease of reading
	if 	CWs.GetOwner(CWs.ReachHoldLocation) == FactionToTest && \
		CWs.GetOwner(CWs.HjaalmarchHoldLocation) == FactionToTest && \
		CWs.GetOwner(CWs.WhiterunHoldLocation) == FactionToTest && \
		CWs.GetOwner(CWs.FalkreathHoldLocation) == FactionToTest && \
		CWs.GetOwner(CWs.PaleHoldLocation) == FactionToTest && \
		CWs.GetOwner(CWs.WinterholdHoldLocation) == FactionToTest && \
		CWs.GetOwner(CWs.RiftHoldLocation) == FactionToTest
		return True
	Else
		return False
	EndIf

EndFunction

function updateObjective(location HoldLocationWhoseObjectiveWeShouldUpdate, bool MarkObjectiveComplete = false, bool FailObjective = false, GlobalVariable GlobalToResetDueToFailure = None)
{This sets the global and flashes the objective for taking over the hold for the supplied location}

	if (CWs.PlayerInvolved == 1 && CWs.WarIsActive == 1) == false
		CWScript.log("CWScript", "updateObjective() PlayerInvolved or WarIsActive, is not 1, NOT updating the objective." )
		
		Return
	
	EndIf


	;note: this works because in the CWObj quest are objectives with the following formula:
	;x0y where x is the number of the hold, and y is the number for the players Faction
	
	int HoldID = CWs.GetHoldID(HoldLocationWhoseObjectiveWeShouldUpdate) 
	
	int Obj = 100 * HoldID
	Obj += CWs.PlayerAllegiance

	if CWs.CWObj.IsObjectiveCompleted(Obj)
		;do nothing
	
	Else
	
		if MarkObjectiveComplete == True
			CWs.CWObj.SetObjectiveCompleted(Obj)
			CWs.displayFactionLeaderObjective()
		
		ElseIf FailObjective == True
		
			;Fail it
			CWs.CWObj.SetObjectiveFailed(Obj)
			
			;reset the percentage to completion
			GlobalToResetDueToFailure.SetValue(0)
			
			;reshow it
			Cws.CWObj.SetObjectiveFailed(Obj, True)
			Cws.CWObj.SetObjectiveDisplayed(Obj, abDisplayed = true, abForce = true)

			;displayFactionLeaderObjective()
		
		else
		
			CWs.CWObj.UpdateCurrentInstanceGlobal(CWs.GetCWObjGlobal(HoldID))
			CWs.CWObj.SetObjectiveDisplayed(Obj, abDisplayed = true, abForce = true)
		
		EndIf
	endif

EndFunction

;OBSOLETE - from when there was multiple campaigns running at the same time
function failCWObj(Location HoldWhoseObjectiveToFail)
	int myHoldID = CWs.GetHoldID(HoldWhoseObjectiveToFail)
	GlobalVariable myCWObjGlobal = CWs.GetCWObjGlobal(myHoldID)

	;if this is the first Whiterun siege (we assume this because the whiterun siege because that is always the first one)
	if CWs.WhiterunSiegeFinished == False
		CWs.WhiterunSiegeFinished = True
		CWs.displayFactionLeaderObjective()
		
	else
		updateObjective(HoldWhoseObjectiveToFail, FailObjective = True, GlobalToResetDueToFailure = myCWObjGlobal)
		myCWObjGlobal.setValue(0)
		CWs.updateObjective(HoldWhoseObjectiveToFail)
		
	EndIf
	
EndFunction

function enableCamp()
	Location HoldLoc = Hold.GetLocation()
	int iAllegiance = CWs.getOppositeFactionInt(Cws.PlayerAllegiance)

	if iAllegiance == CWs.iSons
		if HoldLoc == CWs.RiftHoldLocation
			CWGarrisonEnableMarkerSonsCampRift.Enable(false)
			CWs.MilitaryCampRiftSonsMapMarker.AddToMap()
		elseif HoldLoc == CWs.WinterholdHoldLocation
			CWGarrisonEnableMarkerSonsCampWinterhold.Enable(false)
			CWs.MilitaryCampWinterholdSonsMapMarker.AddToMap()
		elseif holdLoc == CWs.PaleHoldLocation
			CWGarrisonEnableMarkerSonsCampPale.Enable(false)
			CWs.MilitaryCampPaleSonsMapMarker.AddToMap()
		elseif holdLoc == CWs.FalkreathHoldLocation
			CWGarrisonEnableMarkerSonsCampFalkreath.Enable(false)
			CWs.MilitaryCampFalkreathSonsMapMarker.AddToMap()
		elseif holdLoc == CWs.WhiterunHoldLocation
			CWGarrisonEnableMarkerSonsCampWhiterun.Enable(false)
			CWs.MilitaryCampWhiterunSonsMapMarker.AddToMap()
		elseif holdLoc == CWs.HjaalmarchHoldLocation
			CWGarrisonEnableMarkerSonsCampHjaalmarch.Enable(false)
			CWs.MilitaryCampHjaalmarchSonsMapMarker.AddToMap()
		elseif holdLoc == CWs.ReachHoldLocation
			CWGarrisonEnableMarkerSonsCampReach.Enable(false)
			CWs.MilitaryCampReachSonsMapMarker.AddToMap()
		Endif
	Elseif  iAllegiance == CWs.iImperials
		if holdLoc == CWs.RiftHoldLocation
			CWGarrisonEnableMarkerImperialCampRift.Enable(false)
			CWs.MilitaryCampRiftImperialMapMarker.AddToMap()
		elseif holdLoc == CWs.WinterholdHoldLocation
			CWGarrisonEnableMarkerImperialCampWinterhold.Enable(false)
			CWs.MilitaryCampWinterholdImperialMapMarker.AddToMap()
		elseif holdLoc == CWs.PaleHoldLocation
			CWGarrisonEnableMarkerImperialCampPale.Enable(false)
			CWs.MilitaryCampPaleImperialMapMarker.AddToMap()
		elseif holdLoc == CWs.FalkreathHoldLocation
			CWGarrisonEnableMarkerImperialCampFalkreath.Enable(false)
			CWs.MilitaryCampFalkreathImperialMapMarker.AddToMap()
		elseif holdLoc == CWs.WhiterunHoldLocation
			CWGarrisonEnableMarkerImperialCampWhiterun.Enable(false)
			CWs.MilitaryCampWhiterunImperialMapMarker.AddToMap()
		elseif holdLoc == CWs.HjaalmarchHoldLocation
			CWGarrisonEnableMarkerImperialCampHjaalmarch.Enable(false)
			CWs.MilitaryCampHjaalmarchImperialMapMarker.AddToMap()
		elseif holdLoc == CWs.ReachHoldLocation
			CWGarrisonEnableMarkerImperialCampReach.Enable(false)
			CWs.MilitaryCampReachImperialMapMarker.AddToMap()
		Endif
	endif
endfunction

bool function DisableLydiaDuringSiege()
	if HousecarlWhiterunRef.IsEnabled() && !HousecarlWhiterunRef.IsInFaction(CurrentFollowerFaction) && (HousePurchase as HousePurchaseScript).whiterunhousevar == 0
		HousecarlWhiterunRef.Disable()
		return true
	endif
	return false
endfunction

function EnableLydiaAfterSiege()
	HousecarlWhiterunRef.Enable()
endfunction

function AddGeneralToRewardFaction(Location City)
	Actor General
	if CWs.PlayerAllegiance == CWs.iImperials
		General = CWs.GeneralTulliusRef
	else
		General = CWs.UlfricRef
	endif
	if City == Cws.WhiterunLocation
		General.AddToFaction(CWs.CWRewardFactionWhiterun)
	elseif City == CWs.DawnstarLocation
		General.AddToFaction(CWs.CWRewardFactionPale)
	elseif City == Cws.RiftenLocation
		General.AddToFaction(CWs.CWRewardFactionRift)
	elseif City == CWs.WinterholdLocation
		General.AddToFaction(CWs.CWRewardFactionWinterhold)
	elseif City == CWs.FalkreathLocation
		General.AddToFaction(CWs.CWRewardFactionFalkreath)
	elseif City == CWs.MarkarthLocation
		General.AddToFaction(CWs.CWRewardFactionReach)
	elseif City == CWs.MorthalLocation
		General.AddToFaction(CWs.CWRewardFactionHjaalmarch)
	endif

endfunction

function RemoveGeneralFromRewardFaction(Actor General)

	General.RemoveFromFaction(CWs.CWRewardFactionWhiterun)
	General.RemoveFromFaction(CWs.CWRewardFactionPale)
	General.RemoveFromFaction(CWs.CWRewardFactionRift)
	General.RemoveFromFaction(CWs.CWRewardFactionWinterhold)
	General.RemoveFromFaction(CWs.CWRewardFactionFalkreath)
	General.RemoveFromFaction(CWs.CWRewardFactionReach)
	General.RemoveFromFaction(CWs.CWRewardFactionHjaalmarch)
endfunction
