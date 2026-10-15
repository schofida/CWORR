Scriptname CWFieldCOScript extends Actor
{Script on the CWFieldCOImperial/Sons base objects, Extends Object Reference}

;THIS SCRIPT HAS LOGIC IN IT FOR WHEN EACH CAMP HAD ITS OWN FIELD CO AND THERE WERE RANDOM MISSIONS, BUT BECAUSE I DON'T HAVE TIME TO OVERHAUL THE WHOLE SYSTEM
;I'm hacking it for use with Rikke and Galmar giving out specific missions (rules in the story manager limit the missions per camp)
;note: this all will seem ridiculously complicated for what we are actually presenting to the player now. But it's simpler and safer to hack this than overhail everything.

CWScript Property CWs Auto	;CW quest's CWScript

bool Property startWhiterunSiege = False Auto
{REFERENCE PROPERTY: This should be set to true on the Imperial Field CO in Whiterun, and true on the Sons Field CO in the Whiterun camp. Will cause the Whiterun siege to start of Stage 3 has been set in CW}


bool CrimeFactionSet

int CW03StageForWhiterunSiege = 100

Actor RikkeRef
Actor GalmarRef

;[DVs CW Fix] Diagnostic state tracking — only logs when state changes
int prev_WarIsActive = -99
int prev_campaignRunning = -99
int prev_contestedHold = -99
int prev_playerReport = -99
int prev_holdsImperial = -99
int prev_holdsSons = -99
bool prev_campaignQuestRunning = false
bool prev_hasPotentialMission1 = false
bool prev_hasActiveMission = false
bool prev_hasSuccessfulMission = false
bool prev_hasFailedMission = false


Event OnLoad()
	Debug.Trace("[DVs CW Fix] === DVs Civil War Fixes v1.1 ACTIVE === (" + self + ")")

	;On load we pass some events into the story manager so we have some quests ready for the player to get from the fieldco

; 	CWScript.Log("CWFieldCOScript", self + "OnLoad()")

	RikkeRef = CWs.Rikke.GetActorReference()
	GalmarRef = CWs.Galmar.GetActorReference()

	If Self == RikkeRef || Self == GalmarRef
		CrimeFactionSet = True
	EndIf

	if CrimeFactionSet == False && GetEditorLocation().HasKeyword(CWs.CWCapital)   ;THIS IS SO WE CAN SET THE GENERIC FIELD COS IN THE CAPTIAL TOWNS AND CITIES
; 		CWScript.Log("CWFieldCOScript", self + "OnLoad() Editor Location has CWCapital keyword, so I'm setting my crime faction to be the hold's crime faction.")

		CWs.setCrimeFactionOnActorForEditorLocationsHold(self)

	EndIf

	if CWs.IsPlayerInMyFaction(self)

		if CWs.WarIsActive == 1 && (Self == RikkeRef || Self == GalmarRef)

			;[DVs CW Fix] Bug 9.1: Restore SetFieldCOAlias — was commented out by Bethesda, breaking FieldCO dialogue alias
			CWs.SetFieldCOAlias(self)
			Debug.Trace("[DVs CW Fix] CWFieldCO OnLoad: Set FieldCO alias to " + self)

			;[DVs CW Fix] Triple-guarded fallback: Only create missions if no campaign is active and no missions are queued
			;Guard 1: CWCampaign quest isn't running or mid-setup
			;Guard 2: Global campaignRunning confirms no campaign in flight (0=not running, 1=setting up, 2=running)
			;Guard 3: No missions already queued on this CO (PotentialMission1 faction = missions exist)
			if CWs.CWCampaign.IsStopped() && CWs.campaignRunning == 0 && !self.IsInFaction(CWs.CWFieldCOPotentialMission1Faction)
				Debug.Trace("[DVs CW Fix] CWFieldCO OnLoad: No campaign/missions detected, using fallback CreateMissions for " + self)
				CWs.CreateMissions(CWs.GetMyCurrentHoldLocation(self), self)
			endif

			;[DVs CW Fix] Bug 9.2: Strip stale ActiveMissionFaction if no campaign running
			;CWCampaign stopped + campaignRunning==0 means no mission should be active — stale faction blocks "Report for Duty" dialogue
			if self.IsInFaction(CWs.CWFieldCOActiveMissionFaction) && CWs.CWCampaign.IsStopped() && CWs.campaignRunning == 0
				Debug.Trace("[DVs CW Fix] CWFieldCO OnLoad: Cleaning stale ActiveMissionFaction from " + self)
				self.RemoveFromFaction(CWs.CWFieldCOActiveMissionFaction)
			endif

			;[DVs CW Fix] Start diagnostic monitoring — polls every 60s, only logs on state change
			RegisterForUpdate(60)
			Debug.Trace("[DVs CW Fix] CWFieldCO OnLoad: Started diagnostic monitoring on " + self)

		elseif CWs.WarIsActive == 0 && startWhiterunSiege && CWs.CW03.GetStageDone(CW03StageForWhiterunSiege) && CWs.WhiterunSiegeStarted == False ;I BELIEVE THIS SHOULD ONLY BE THE GENERIC FIELD CO IN WHITERUN CITY
; 			CWScript.Log("CWFieldCOScript", self + "OnLoad() IsPlayerInMyFaction == true && WarIsActive == false, CWs.CW03.GetStageDone(" + CW03StageForWhiterunSiege + ") == true,  so starting the siege at Whiterun by calling CWScript SetFieldCOAlias() and CreateMissions()")
			CWs.SetFieldCOAlias(self)	;for dialogue purposes
			CWs.WhiterunSiegeStarted = True
			CWs.CreateMissions(CWs.GetMyCurrentHoldLocation(self), self, ForceFinalSiege = true)

		Else
; 			CWScript.Log("CWFieldCOScript", self + "OnLoad() WarIsActive == false, not generating missions.")

		EndIf

	Else
; 		CWScript.Log("CWFieldCOScript", self + "OnLoad() IsPlayerInMyFaction == false, not generating missions.")

	EndIf

EndEvent


;[DVs CW Fix] Diagnostic monitoring — periodic CW state snapshot, only logs when state changes
Event OnUpdate()

	;Stop monitoring if war is no longer active
	if CWs.WarIsActive != 1
		Debug.Trace("[DVs CW Fix] CW Diag: War no longer active (WarIsActive=" + CWs.WarIsActive + "), stopping monitoring")
		UnregisterForUpdate()
		return
	endif

	;Snapshot current state
	int cur_WarIsActive = CWs.WarIsActive
	int cur_campaignRunning = CWs.campaignRunning
	int cur_contestedHold = CWs.contestedHold
	int cur_playerReport = CWs.playerReport
	int cur_holdsImperial = CWs.countHoldsImperial
	int cur_holdsSons = CWs.countHoldsSons
	bool cur_campaignQuestRunning = CWs.CWCampaign.IsRunning()
	bool cur_hasPotentialMission1 = self.IsInFaction(CWs.CWFieldCOPotentialMission1Faction)
	bool cur_hasActiveMission = self.IsInFaction(CWs.CWFieldCOActiveMissionFaction)
	bool cur_hasSuccessfulMission = self.IsInFaction(CWs.CWFieldCOSuccessfulMissionFaction)
	bool cur_hasFailedMission = self.IsInFaction(CWs.CWFieldCOFailedMissionFaction)

	;Only log if something changed
	bool stateChanged = false
	if cur_WarIsActive != prev_WarIsActive || cur_campaignRunning != prev_campaignRunning || \
	   cur_contestedHold != prev_contestedHold || cur_playerReport != prev_playerReport || \
	   cur_holdsImperial != prev_holdsImperial || cur_holdsSons != prev_holdsSons || \
	   cur_campaignQuestRunning != prev_campaignQuestRunning || \
	   cur_hasPotentialMission1 != prev_hasPotentialMission1 || cur_hasActiveMission != prev_hasActiveMission || \
	   cur_hasSuccessfulMission != prev_hasSuccessfulMission || cur_hasFailedMission != prev_hasFailedMission
		stateChanged = true
	endif

	if stateChanged
		Debug.Trace("[DVs CW Diag] === Civil War State Snapshot ===")
		Debug.Trace("[DVs CW Diag] WarIsActive: " + cur_WarIsActive + " | PlayerAllegiance: " + CWs.playerAllegiance + " (" + CWs.FactionName(CWs.playerAllegiance) + ")")
		Debug.Trace("[DVs CW Diag] campaignRunning: " + cur_campaignRunning + " | CWCampaign quest running: " + cur_campaignQuestRunning)
		Debug.Trace("[DVs CW Diag] contestedHold: " + cur_contestedHold + " (" + CWs.HoldName(cur_contestedHold) + ") | Attacker: " + CWs.FactionName(CWs.attacker) + " | Defender: " + CWs.FactionName(CWs.defender))
		Debug.Trace("[DVs CW Diag] Holds — Imperial: " + cur_holdsImperial + " | Sons: " + cur_holdsSons)
		Debug.Trace("[DVs CW Diag] playerReport: " + cur_playerReport + " | FieldCO: " + CWs.FieldCO.GetReference())
		Debug.Trace("[DVs CW Diag] Factions on " + self + " — PotentialMission1: " + cur_hasPotentialMission1 + " | ActiveMission: " + cur_hasActiveMission + " | Success: " + cur_hasSuccessfulMission + " | Failed: " + cur_hasFailedMission)
		Debug.Trace("[DVs CW Diag] ================================")

		;Update previous state
		prev_WarIsActive = cur_WarIsActive
		prev_campaignRunning = cur_campaignRunning
		prev_contestedHold = cur_contestedHold
		prev_playerReport = cur_playerReport
		prev_holdsImperial = cur_holdsImperial
		prev_holdsSons = cur_holdsSons
		prev_campaignQuestRunning = cur_campaignQuestRunning
		prev_hasPotentialMission1 = cur_hasPotentialMission1
		prev_hasActiveMission = cur_hasActiveMission
		prev_hasSuccessfulMission = cur_hasSuccessfulMission
		prev_hasFailedMission = cur_hasFailedMission
	endif

EndEvent
