Scriptname CWSiegeGeneralScript extends ReferenceAlias  

;-- Properties --------------------------------------
int DistanceToPlayerNeeded = 250
int stageToSetWhenPlayerNear = 10

bool FightingForAwhile
int countSecondsFighting
int secondsToFightForBeforeSettingStage
int stageToSetAfterFightingForAwhile 


state CheckDistanceToPlayer
	Event OnUpdate()

		Quest myOwningQuest = GetOwningQuest()
		CWSiegeScript CWSiegeS = (myOwningQuest as CWSiegeScript)
		Actor SelfRef = GetActorReference()
		ActorBase SelfRefBase = SelfRef.GetActorBase()
		
		ActorBase Tullius = CWSiegeS.CWs.CWCampaignS.CWBattleTulliusBase
		ActorBase Rikke = CWSiegeS.CWs.CWCampaignS.CWBattleRikkeBase
		ActorBase Ulfric = CWSiegeS.CWs.CWCampaignS.CWBattleUlfricBase
		ActorBase Galmar = CWSiegeS.CWs.CWCampaignS.CWBattleGalmarBase
		if SelfRefBase == Rikke || SelfRefBase == Galmar || SelfRefBase == Ulfric || SelfRefBase == Tullius	; Reddit BugFix #14
			self.UnregisterForUpdate()
		else
			if SelfRef.GetDistance(Game.GetPlayer()) <= DistanceToPlayerNeeded
			; If the player is near the General then set stage 10
	 			CWScript.Log("CWSiegeGeneralScript", self + "OnUpdate() - player within distance to general, setting stage:" + stageToSetWhenPlayerNear)
				myOwningQuest.setStage(stageToSetWhenPlayerNear)
				
				UnregisterForUpdate()
			EndIf
			
			if myOwningQuest.GetStage() >= stageToSetWhenPlayerNear
			; If the stage is 10 or higher then just stop updating altogether
				UnregisterForUpdate()
			EndIf
		endif
	EndEvent

EndState


state FightingForAwhile
	Event OnUpdate()

		Quest myOwningQuest = GetOwningQuest()
		ObjectReference SelfRef = GetReference()	
		
		if myOwningQuest.GetStage() >= stageToSetAfterFightingForAwhile
		; If the stage is "stageToSetWhenPlayerNear" or higher then just stop updating altogether
			UnregisterForUpdate()
			FightingForAwhile = False
		EndIf
		
		if myOwningQuest.GetStageDone(stageToSetAfterFightingForAwhile)
			FightingForAwhile = False
			UnregisterForUpdate()
			
		ElseIf FightingForAwhile
			countSecondsFighting += 1
		
			if countSecondsFighting > secondsToFightForBeforeSettingStage 
; 				CWScript.Log("CWSiegeGeneralScript", self + "OnUpdate() - done FightingForAwhile calling setStage:" + stageToSetAfterFightingForAwhile)
				FightingForAwhile = False
				UnregisterForUpdate()
				myOwningQuest.setStage(stageToSetAfterFightingForAwhile)
			
			EndIf
		
		EndIf
		
	EndEvent

EndState


function StartCheckingDistanceToPlayer()
	GoToState("CheckDistanceToPlayer")
	RegisterForUpdate(5)

EndFunction


function FightForAwhile(int SecondsToFightFor, int stageToSetWhenDoneFighting)
	ObjectReference selfRef = GetReference()

	GoToState("FightingForAwhile")
	
	secondsToFightForBeforeSettingStage = SecondsToFightFor
	stageToSetAfterFightingForAwhile = stageToSetWhenDoneFighting

	FightingForAwhile = True
	RegisterForUpdate(5)
	
EndFunction
