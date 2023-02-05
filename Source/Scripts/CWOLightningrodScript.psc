scriptName CWOLightningrodScript extends activemagiceffect

;-- Properties --------------------------------------
spell property SpellToCast auto
Float property DaRadius auto
actor property DaCaster auto
Float property ZOffSet auto
Float property XOffSetRandom auto
objectreference property ActivatorRef auto
Float property TimeToUpdate auto
Float property YOffsetRandom auto
activator property FXEmptyActivator auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function SetAndFire()

	Float Xoff = utility.RandomFloat(-XOffSetRandom, XOffSetRandom)
	Float Yoff = utility.RandomFloat(-YOffsetRandom, YOffsetRandom)
	ActivatorRef.Moveto(DaCaster as objectreference, Xoff, Yoff, ZOffSet, true)
	self.TargetAndFire()
endFunction

function TargetAndFire()

	Float TimeOut = TimeToUpdate
	actor Target = game.FindRandomActorFromRef(DaCaster as objectreference, DaRadius)
	while !Target.IsHostileToActor(DaCaster) && !Target.IsDead() && TimeOut > 0 as Float
		Target = game.FindRandomActorFromRef(DaCaster as objectreference, DaRadius)
		TimeOut -= 1 as Float
	endWhile
	if TimeOut >= 0 as Float && Target.IsHostileToActor(DaCaster) && !Target.IsDead()
		SpellToCast.RemoteCast(ActivatorRef, DaCaster, Target as objectreference)
	endIf
endFunction

; Skipped compiler generated GetState

function OnEffectStart(actor AkTarget, actor AkCaster)

	ActivatorRef = AkCaster.PlaceAtme(FXEmptyActivator as form, 1, false, false)
	DaCaster = AkCaster
	self.SetAndFire()
	self.RegisterForSingleUpdate(TimeToUpdate)
endFunction

function OnEffectFinish(actor AkTarget, actor AkCaster)

	if ActivatorRef
		ActivatorRef.Delete()
	endif
	self.UnregisterForUpdate()
endFunction

; Skipped compiler generated GotoState

function OnUpdate()

	self.SetAndFire()
	self.RegisterForSingleUpdate(TimeToUpdate)
endFunction
