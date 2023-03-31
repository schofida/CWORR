Scriptname CWMission08CowOfferingScript extends ReferenceAlias  

message property CWMission08FeedCowMsg auto
Potion Property FoodApple  Auto  
Potion Property FoodApple02  Auto  
ReferenceAlias Property Goldar Auto

int DistanceFromCow = 2000				;how close does the player need to be to make the giant non-hostile (until he recieves the cow)
int DistanceFromPlayer = 3000				;how close does the player need to be to make the giant non-hostile (until he recieves the cow)

int StopCheckingDistanceAtStage	= 20	;what quest stage to stop checking distance to cow (ie the player gave the cow to the giant)

int TimeForAnotherApple = 30			;how close does the player need to be to make the giant non-hostile (until he recieves the cow)
int IntervalCheck	= 1	;what quest stage to stop checking distance to cow (ie the player gave the cow to the giant)

Event OnDeath(Actor akKiller)
	if GetOwningQuest().GetStageDone(20) == False	;player hasn't delivered it yet
		GetOwningQuest().setStage(205) ;fail quest
	
	
	EndIf

EndEvent

Event OnUnload()

	; 	CWScript.Log("CWMission08GiantScript", self + "OnUnload()")
	if GetOwningQuest().GetStage() >= 200
	; 		CWScript.Log("CWMission08GiantScript", self + "quest stage >= 200, stopping quest.")
			Goldar.TryToDisable()
	
	EndIf

EndEvent

Event OnUpdate()
	CWScript.Log("CWMission08CowOfferingScript", self + "OnUpdate()")
	Actor GoldarRef = Goldar.GetActorRef()
	Actor PlayerRef = Game.GetPlayer()
	if GetOwningQuest().getStage() < StopCheckingDistanceAtStage

		if  GetReference().GetDistance(PlayerRef) <= DistanceFromCow && GoldarRef.Is3dLoaded() && GoldarRef.GetDistance(PlayerRef) <= DistanceFromPlayer
; 			CWScript.Log("CWMission08CowOfferingScript", "Player close to cow, adding player to CWMission08AllGiantsPlayerFriendFaction")
			Game.GetPlayer().AddToFaction((GetOwningQuest() as CWMission08Script).CWMission08AllGiantsPlayerFriendFaction)
			
			GetOwningQuest().SetStage(20)
		EndIf
	elseif IntervalCheck > TimeForAnotherApple
		IntervalCheck = 0
		GetOwningQuest().SetStage(10)
		UnregisterForUpdate()
	Else
		UnRegisterForUpdate()
	
	EndIf
	IntervalCheck += 1
EndEvent


Event OnActivate(ObjectReference akActionRef)
	Actor player = Game.GetPlayer()
	if akActionRef == player && GetOwningQuest().GetStage() < 15 && (player.GetItemCount(FoodApple) > 0 || player.GetItemCount(FoodApple02) > 0)
		if CWMission08FeedCowMsg.show() == 1
			;Note: I'm assuming the player has an apple because I give him one in the quest and I don't really care if he doesn't have one... it's not that important.
			if player.GetItemCount(FoodApple) > 0
				player.removeItem(FoodApple, 1)
			Else
				player.removeItem(FoodApple02, 1)
			endif
			GetOwningQuest().setStage(15)
			RegisterForUpdate(3)
			
		endif

	endif

EndEvent

