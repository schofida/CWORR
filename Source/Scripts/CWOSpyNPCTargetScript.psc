Scriptname CWOSpyNPCTargetScript extends ReferenceAlias  

ReferenceAlias Property Spy1 Auto

Event OnDeath(Actor akKiller)
    if akKiller == none
        return
    endif 
    Utility.Wait(2.0)
    akKiller.EvaluatePackage()
endEvent

Event OnHit(ObjectReference akAggressor, Form akWeapon, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
    if GetActorRef() == none
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
    if actorRef.IsSneaking()
        actorRef.StartSneaking()
    endif
    (GetOwningQuest() as CWOBAQuestScript).TargetHit = true
    GetActorRef().Kill(actorRef)
    actorRef.StopCombatAlarm()
    GetOwningQuest().SetStage(40)
EndEvent
