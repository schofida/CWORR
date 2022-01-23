scriptName CWOMagicMissileScript extends activemagiceffect

;-- Properties --------------------------------------
Float property DaSpeed auto
Float property ZOffSet auto
Float property XOffset auto
objectreference property Light1 auto
Bool property No4 auto
Bool property No3 auto
objectreference property Quad2 auto
objectreference property Quad4 auto
Int property Turn auto
Bool property No2 auto
Float property Radius auto
actor property Target4 auto
Float property RotSpeed auto
objectreference property Light4 auto
light property DaLights auto
objectreference property Quad3 auto
Float property YOffSet auto
actor property Target3 auto
Float property TimeToUpdate auto
actor property Target1 auto
objectreference property Light2 auto
spell property SpellToCast auto
actor property Target2 auto
activator property FXEmptyActivator auto
actor property DaCaster auto
objectreference property Light3 auto
Bool property No1 auto
Float property TanMag auto
objectreference property Quad1 auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function Spin()

	Quad1.MoveTo(DaCaster as objectreference, XOffset, 0 as Float, ZOffSet, true)
	Quad2.MoveTo(DaCaster as objectreference, -XOffset, 0 as Float, ZOffSet / 2 as Float, true)
	Quad3.MoveTo(DaCaster as objectreference, 0 as Float, YOffSet, ZOffSet, true)
	Quad4.MoveTo(DaCaster as objectreference, 0 as Float, -YOffSet, ZOffSet / 2 as Float, true)
	if Turn == 0
		Light1.SplineTranslateToRef(Quad3, TanMag, DaSpeed, RotSpeed)
		Light2.SplineTranslateToRef(Quad4, TanMag, DaSpeed, RotSpeed)
		Light3.SplineTranslateToRef(Quad2, TanMag, DaSpeed, RotSpeed)
		Light4.SplineTranslateToRef(Quad1, TanMag, DaSpeed, RotSpeed)
		Turn += 1
	elseIf Turn == 1
		Light1.SplineTranslateToRef(Quad2, TanMag, DaSpeed, RotSpeed)
		Light2.SplineTranslateToRef(Quad1, TanMag, DaSpeed, RotSpeed)
		Light3.SplineTranslateToRef(Quad4, TanMag, DaSpeed, RotSpeed)
		Light4.SplineTranslateToRef(Quad3, TanMag, DaSpeed, RotSpeed)
		Turn += 1
	elseIf Turn == 2
		Light1.SplineTranslateToRef(Quad4, TanMag, DaSpeed, RotSpeed)
		Light2.SplineTranslateToRef(Quad3, TanMag, DaSpeed, RotSpeed)
		Light3.SplineTranslateToRef(Quad1, TanMag, DaSpeed, RotSpeed)
		Light4.SplineTranslateToRef(Quad2, TanMag, DaSpeed, RotSpeed)
		Turn += 1
	elseIf Turn == 3
		Light1.SplineTranslateToRef(Quad1, TanMag, DaSpeed, RotSpeed)
		Light2.SplineTranslateToRef(Quad2, TanMag, DaSpeed, RotSpeed)
		Light3.SplineTranslateToRef(Quad3, TanMag, DaSpeed, RotSpeed)
		Light4.SplineTranslateToRef(Quad4, TanMag, DaSpeed, RotSpeed)
		Turn = 0
	endIf
endFunction

function CheckandResetTargets()

	if No4 as Bool || Target4.IsDead()
		if !No3 || Target3.IsDead()
			Target4 = Target3
		elseIf !No2 || Target2.IsDead()
			Target4 = Target2
		elseIf !No1 || Target1.IsDead()
			Target4 = Target1
		else
			Target4 = none
		endIf
	endIf
	if No3 as Bool || Target3.IsDead()
		if !No4 || Target4.IsDead()
			Target3 = Target4
		elseIf !No2 || Target2.IsDead()
			Target3 = Target2
		elseIf !No1 || Target1.IsDead()
			Target3 = Target1
		else
			Target3 = none
		endIf
	endIf
	if No2 as Bool || Target2.IsDead()
		if !No3 || Target3.IsDead()
			Target2 = Target3
		elseIf !No4 || Target4.IsDead()
			Target2 = Target4
		elseIf !No1 || Target1.IsDead()
			Target2 = Target1
		else
			Target2 = none
		endIf
	endIf
	if No1 as Bool || Target1.IsDead()
		if !No3 || Target3.IsDead()
			Target1 = Target3
		elseIf !No2 || Target2.IsDead()
			Target1 = Target2
		elseIf !No4 || Target4.IsDead()
			Target1 = Target4
		else
			Target1 = none
		endIf
	endIf
endFunction

function Cleanup()

	Quad1.Delete()
	Quad2.Delete()
	Quad3.Delete()
	Quad4.Delete()
	Light1.Delete()
	Light2.Delete()
	Light3.Delete()
	Light4.Delete()
	self.UnRegisterForUpdate()
endFunction

; Skipped compiler generated GetState

function OnEffectStart(actor AkTarget, actor Akcaster)

	DaCaster = Akcaster
	Light1 = self.SetUpLight(0)
	Light2 = self.SetUpLight(1)
	Light3 = self.SetUpLight(2)
	Light4 = self.SetUpLight(3)
	self.Spin()
	self.RegisterForSingleUpdate(TimeToUpdate)
	self.QueueTargets()
endFunction

function OnUpdate()

	self.Spin()
	self.RegisterForSingleUpdate(TimeToUpdate)
endFunction

function QueueTargets()

	Target1 = self.Target()
	if !Target1
		No1 = true
	endIf
	Target2 = self.Target()
	if !Target2
		No2 = true
	endIf
	Target3 = self.Target()
	if !Target3
		No3 = true
	endIf
	Target4 = self.Target()
	if !Target4
		No4 = true
	endIf
endFunction

objectreference function SetUpLight(Int Quadrant)

	objectreference TheLight = DaCaster.PlaceAtMe(DaLights as form, 1, false, false)
	if Quadrant == 0
		TheLight.MoveTo(TheLight, XOffset, 0 as Float, ZOffSet, true)
		Quad1 = TheLight.PlaceAtMe(FXEmptyActivator as form, 1, false, false)
	elseIf Quadrant == 1
		TheLight.MoveTo(TheLight, -XOffset, 0 as Float, ZOffSet / 2 as Float, true)
		Quad2 = TheLight.PlaceAtMe(FXEmptyActivator as form, 1, false, false)
	elseIf Quadrant == 2
		TheLight.MoveTo(TheLight, 0 as Float, YOffSet, ZOffSet, true)
		Quad3 = TheLight.PlaceAtMe(FXEmptyActivator as form, 1, false, false)
	elseIf Quadrant == 3
		TheLight.MoveTo(TheLight, 0 as Float, -YOffSet, ZOffSet / 2 as Float, true)
		Quad4 = TheLight.PlaceAtMe(FXEmptyActivator as form, 1, false, false)
	endIf
	return TheLight
endFunction

actor function Target()

	actor WeAre
	Int TimeOut = 8
	while !WeAre && TimeOut > 0
		WeAre = game.FindRandomActorFromRef(DaCaster as objectreference, Radius)
		if !WeAre || !WeAre.IsHostileToActor(DaCaster) || WeAre.IsDead()
			WeAre = none
		endIf
		TimeOut -= 1
	endWhile
	return WeAre
endFunction

; Skipped compiler generated GotoState

function OnEffectFinish(actor AkTarget, actor Akcaster)

	self.CheckandResetTargets()
	self.Fire(Light1, No1, Target1)
	self.Fire(Light2, No2, Target2)
	self.Fire(Light3, No3, Target3)
	self.Fire(Light4, No4, Target4)
	self.Cleanup()
endFunction

function Fire(objectreference DisLight, Bool Check, actor Targetee)

	if !Targetee
		DisLight.Disable(true)
		return 
	endIf
	SpellToCast.RemoteCast(DisLight, DaCaster, Targetee as objectreference)
	DisLight.Disable(false)
endFunction
