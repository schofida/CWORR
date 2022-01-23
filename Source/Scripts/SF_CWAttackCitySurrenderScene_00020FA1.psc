;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SF_CWAttackCitySurrenderScene_00020FA1 Extends Scene Hidden

function Fragment_4()

	Justiciar.getactorreference().SetAV("Health", 1 as Float)
endFunction

function Fragment_1()

	FieldCO.getactorreference().StopCombatAlarm()
endFunction

function Fragment_14()

	Justiciar.getactorreference().GetActorBase().setessential(false)
endFunction

function Fragment_11()

	Justiciar.getactorreference().GetActorBase().setessential(true)
endFunction

function Fragment_9()

	Justiciar.getactorreference().setactorvalue("Health", 1 as Float)
endFunction

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE

if self.GetOwningQuest().GetStage() < 50
    self.GetOwningQuest().SetStage(50)
endIf
;END CODE
EndFunction

referencealias property FieldCO auto
referencealias property Justiciar auto

;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
