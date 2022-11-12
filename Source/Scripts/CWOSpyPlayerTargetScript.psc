Scriptname CWOSpyPlayerTargetScript extends ReferenceAlias  

Potion Property CWOBAPoisoned Auto
ReferenceAlias Property Spy1 Auto

Event OnHit(ObjectReference akAggressor, Form akWeapon, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
    if self.GetActorRef() == none
        return
    endif
    actor actorRef = akAggressor as Actor
    if actorRef == none
        return
    endif
    bool aggressorIsSpy = false
    if actorRef == Spy1.GetActorRef()
       aggressorIsSpy = true
   endif

    if !aggressorIsSpy
        return
    endif
    if  (GetOwningQuest() as CWOBAQuestScript).TargetHit
       return 
    endif
    (GetOwningQuest() as CWOBAQuestScript).TargetHit = true
    self.GetActorRef().AddItem(CWOBAPoisoned, 1, true)
    self.GetActorRef().EquipItem(CWOBAPoisoned, true, true)
EndEvent
