Scriptname CWMission05EnemyFieldCOScript extends ReferenceAlias  

Event OnDeath(Actor akKiller)
	GetOwningQuest().setStage(100)
	; Reddit Bugfix #6
	Location currentHold = (GetOwningQuest() as cwmission05script).CWs.GetMyCurrentHoldLocation(self.GetActorReference())
	int aliasAllegiance = (GetOwningQuest() as cwmission05script).CWs.GetActorAllgeiance(self.GetActorReference())
	Actor FieldCOHQ = (GetOwningQuest() as cwmission05script).CWs.GetAliasHQFieldCOForHold(currentHold, aliasAllegiance).GetActorReference()
	Actor FieldCOCamp = (GetOwningQuest() as cwmission05script).CWs.GetAliasCampFieldCOForHold(currentHold, aliasAllegiance).GetActorReference()
	
	if FieldCOHQ.IsDead() == false
		FieldCOHQ.Kill(Game.GetPlayer())
	endif
	if FieldCOCamp.IsDead() == false
		FieldCOCamp.Kill(Game.GetPlayer())
	endif
EndEvent
