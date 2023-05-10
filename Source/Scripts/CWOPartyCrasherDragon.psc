Scriptname CWOPartyCrasherDragon extends ReferenceAlias

ReferenceAlias Property OtherDragon Auto

Event OnDeath(Actor akKiller)
    Actor OtherDragonRef = OtherDragon.GetActorRef()
    If OtherDragonRef != none
		OtherDragonRef.AddToFaction((GetOwningQuest() As CWOPartyCrasherCageMatchScript).DragonFaction)
		OtherDragonRef.StartCombat(Game.GetPlayer())
        OtherDragonRef.EvaluatePackage()
    endif
EndEvent