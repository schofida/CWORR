;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 49
Scriptname _Vx__QF_OCW03_020012C9 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Frothar
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Frothar Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Proventus
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Proventus Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Brill
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Brill Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Avulstein
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Avulstein Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Balgruuf
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Balgruuf Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Vignar
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Vignar Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Olfina
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Olfina Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Olfrid
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Olfrid Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HousecarlImperial
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_HousecarlImperial Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Hrongar
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Hrongar Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Irileth
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Irileth Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Nelkir
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Nelkir Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Dagny
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Dagny Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Idolaf
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Idolaf Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
; forces change of Whiterun hold ownership to the other side

CWScript CWs = CW as CWScript
CWs.WinHoldOffScreenIfNotDoingCapitalBattles(CWs.getLocationForHold(4))
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_21
Function Fragment_21()
;BEGIN AUTOCAST TYPE OCW03SiegeQuickStartScript
;Quest __temp = self as Quest
;OCW03SiegeQuickStartScript kmyQuest = __temp as OCW03SiegeQuickStartScript
;END AUTOCAST
;BEGIN CODE
if CWObj.isObjectiveDisplayed(1001)
  CWObj.setObjectiveCompleted(1001)  ; "Report to Tullius"
endIf

;kmyQuest.Do4110()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
; force the Whiterun ownership to change to Stormcloak

; (CW as CWScript).SetHoldOwnerByInt(4, 2, DiplomaticVictory = true)

; with diplomatic victory, no promo. let's try out then:
(CW as CWScript).SetHoldOwnerByInt(4, 2, DiplomaticVictory = false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
OCW03Proventus01Scene.Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN AUTOCAST TYPE SCW_OCW03BalgruufDefaultScript
Quest __temp = self as Quest
SCW_OCW03BalgruufDefaultScript kmyQuest = __temp as SCW_OCW03BalgruufDefaultScript
;END AUTOCAST
;BEGIN CODE
; jarl is not convinced - go on / resume the vanilla scene

kmyQuest.BalgruufDecide()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_35
Function Fragment_35()
;BEGIN CODE
if !getStageDone(60)
  return
endIf

; apply fix 0.8beta

if !getStageDone(30)
  Actor Hrongar = alias_Hrongar.GetActorReference()
  Hrongar.removeFromFaction(JobJarlFaction)
  Actor Idolaf = alias_Idolaf.GetActorReference()
  Idolaf.removeFromFaction(JobHousecarlFaction)
endIf

setStage(65)  ; correct the DialogueWhiterun aliases exchange
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_45
Function Fragment_45()
;BEGIN CODE
;If Balgruuf's Thane, swap Get Out of Jail to Stormcloak

FavorJarlsMakeFriendsScript FavorJMFScript = FavorJarlsMakeFriends as FavorJarlsMakeFriendsScript

FavorJMFScript.WhiterunSonsGetOutofJail = FavorJMFScript.WhiterunImpGetOutofJail
FavorJMFScript.WhiterunImpGetOutofJail = 0
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN CODE
CW03.stop()  ; failsafe

QF_CWAttackCity_0004F8BF qf = CWAttackCity as QF_CWAttackCity_0004F8BF

if getStageDone(30)
  ; TODO test and fix what is necessary
  qf.alias_NewJarl.ForceRefTo(Alias_Balgruuf.GetReference())
else
  qf.alias_NewJarl.ForceRefTo(Alias_Hrongar.GetReference())
endIf

TurnWhiterunBodyguardStormcloak(qf.alias_Bodyguard1.getActorReference())
TurnWhiterunBodyguardStormcloak(qf.alias_Bodyguard2.getActorReference())
TurnWhiterunBodyguardStormcloak(qf.alias_Bodyguard3.getActorReference())
TurnWhiterunBodyguardStormcloak(qf.alias_Bodyguard4.getActorReference())
TurnWhiterunBodyguardStormcloak(qf.alias_Bodyguard5.getActorReference())
TurnWhiterunBodyguardStormcloak(qf.alias_Bodyguard6.getActorReference())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
; add Balgruuf to Gov Sons instead of Vignar

Actor Balgruuf = alias_Balgruuf.GetActorReference()
Actor Hrongar = alias_Hrongar.GetActorReference()
Actor Vignar = alias_Vignar.GetActorReference()

;Hrongar.addToFaction(JobJarlFaction)          ; commented out for fix-08beta
;Vignar.removeFromFaction(JobJarlFaction)   ; a no-op

Vignar.removeFromFaction(GovSons)

if getStageDone(30)  ; Hrongar coup
  Hrongar.addToFaction(GovSons)
else
  Balgruuf.removeFromFaction(GovImperial)
  Balgruuf.addToFaction(GovSons)
  Hrongar.addToFaction(GovImperial)
endIf

Hrongar.AddToFaction(Favor253QuestGiverFaction) ;Hrongar can give Thane quest --Enodoc
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
if CW03Scene.isPlaying()
  CW03Scene.Stop()
endIf
setStage(40)
OCW03ForcegreetScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_33
Function Fragment_33()
;BEGIN CODE
if CW03Scene.isPlaying()
  CW03Scene.Stop()
endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
; stage 73, repurposed in Balgruuf Dilemma 0.1.3
GlobalVariable CWOWarBegun = Game.GetFormFromFile(0x01d792, "Civil War Overhaul.esp") as GlobalVariable
if CWOWarBegun == None
	return
endIf
GlobalVariable CWOCurrentHold = Game.GetFormFromFile(0x0d4e5, "Civil War Overhaul.esp") as GlobalVariable
CWOWarBegun.setValue(1)
CWOCurrentHold.setValue(5)  ; player joined Stormcloaks, next hold is Falkreath

CWScript CWs = CW as CWScript
CWs.CWDefender.SetValueInt(CWs.iSons)
CWs.CWAttacker.SetValueInt(CWs.iImperials)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
; Proventus goes with Balgruuf/Hrongar to Stormcloaks, too

Actor proventus = alias_Proventus.GetActorReference()
Proventus.addToFaction(GovSons)

; but he stays on the Imperial side, as well - don't remove him from this
; Proventus.removeFromFaction(GovImperial)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_27
Function Fragment_27()
;BEGIN CODE
; Balgruuf's children stay in Whiterun

alias_Dagny.GetActorReference().addToFaction(GovSons)
alias_Frothar.GetActorReference().addToFaction(GovSons)
alias_Nelkir.GetActorReference().addToFaction(GovSons)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_32
Function Fragment_32()
;BEGIN CODE
if getStageDone(30)  ; Hrongar coup

; Hrongar on rebel side, gets Avulstein Gray-Mane as an extra Housecarl

Actor avulstein = alias_Avulstein.GetActorReference()
avulstein.addToFaction(GovRuling)
avulstein.addToFaction(GovSons)
avulstein.Enable()
; avulstein.addToFaction(JobHousecarlFaction)  ;; already there in vanilla


else
; Hrongar on imperial side, gets Olfrid Battle-Born as Housecarl
; TODO Idolaf, maybe? (Olfrid is essential in vanilla, but still...) ;Done --Enodoc

Actor Idolaf = alias_Idolaf.GetActorReference()
Idolaf.addToFaction(GovRuling)
Idolaf.addToFaction(GovImperial)

; Idolaf.addToFaction(JobHousecarlFaction)  ; commented out for fix-08beta

alias_HousecarlImperial.ForceRefTo(Idolaf)  ; contains packages for exile, etc ?

endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_29
Function Fragment_29()
;BEGIN CODE
; Irileth stays with Balgruuf

if getStageDone(30)  ; Hrongar coup
  return
endIf

Actor Irileth = alias_Irileth.GetActorReference()
Irileth.addToFaction(GovSons)
Irileth.removeFromFaction(GovImperial)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
; forces change of Whiterun hold ownership to the other side

CWScript CWs = CW as CWScript
CWs.WinHoldOffScreenIfNotDoingCapitalBattles(CWs.getLocationForHold(4))
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_44
Function Fragment_44()
;BEGIN CODE
; jarl is convinced - Imperial
setStage(50)

; just in case, stop our scenes
OCW03ForcegreetScene.Stop()
OCW03Proventus01Scene.Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_36
Function Fragment_36()
;BEGIN CODE
; set up the DialogueWhiterun main/backup aliases

; they are going to be corrected in 5 seconds by the update to the vanilla swap script,
; after given NPC are added to GovExiled faction
; so we  need to set up the correct pair

WhiterunJarl_MainAlias.ForceRefTo(alias_Balgruuf.getReference())
WhiterunJarl_BackupAlias.ForceRefTo(alias_Hrongar.getReference())

; no need to change Steward alias pairs, because Proventus will never get exiled 
; and Guard Captains exchange is another story....

WhiterunHousecarl_MainAlias.ForceRefTo(alias_Irileth.getReference())
if getStageDone(30)   ; Hrongar is jarl
  WhiterunHousecarl_BackupAlias.ForceRefTo(alias_Avulstein.getReference())
else
  WhiterunHousecarl_BackupAlias.ForceRefTo(alias_Idolaf.getReference())
endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_42
Function Fragment_42()
;BEGIN AUTOCAST TYPE OCW03SiegeQuickStartScript
;Quest __temp = self as Quest
;OCW03SiegeQuickStartScript kmyQuest = __temp as OCW03SiegeQuickStartScript
;END AUTOCAST
;BEGIN CODE
; fix the interior city soldiers

QF_CWAttackCity_0004F8BF qf = CWAttackCity as QF_CWAttackCity_0004F8BF

; whiterun guards - enemy soldiers now

TurnWhiterunBodyguardStormcloak(qf.alias_EnemySoldier1.getActorReference())
TurnWhiterunBodyguardStormcloak(qf.alias_EnemySoldier2.getActorReference())
TurnWhiterunBodyguardStormcloak(qf.alias_EnemySoldier3.getActorReference())
TurnWhiterunBodyguardStormcloak(qf.alias_EnemySoldier4.getActorReference())
TurnWhiterunBodyguardStormcloak(qf.alias_EnemySoldier5.getActorReference())
TurnWhiterunBodyguardStormcloak(qf.alias_EnemySoldier6.getActorReference())
TurnWhiterunBodyguardStormcloak(qf.alias_EnemySoldier7.getActorReference())
TurnWhiterunBodyguardStormcloak(qf.alias_EnemySoldier8.getActorReference())
TurnWhiterunBodyguardStormcloak(qf.alias_EnemySoldier9.getActorReference())
TurnWhiterunBodyguardStormcloak(qf.alias_EnemySoldier10.getActorReference())
TurnWhiterunBodyguardStormcloak(qf.alias_EnemySoldier11.getActorReference())
TurnWhiterunBodyguardStormcloak(qf.alias_EnemySoldier12.getActorReference())

; ally soldiers at the enterance

ObjectReference SpawnAttacker1 =  qf.Alias_SpawnAttacker1.GetReference()
ObjectReference SpawnAttacker2 =  qf.Alias_SpawnAttacker1.GetReference()
CWAttackCityScript cwacs = (CWAttackCity as CWAttackCityScript)
qf.Alias_Soldier1.GetReference().Delete()
cwacs.CreateAliasedSoldierAlly(qf.Alias_Soldier1, SpawnAttacker1 , false, false)
qf.Alias_Soldier2.GetReference().Delete()
cwacs.CreateAliasedSoldierAlly(qf.Alias_Soldier2, SpawnAttacker1 , false, false)
qf.Alias_Soldier3.GetReference().Delete()
cwacs.CreateAliasedSoldierAlly(qf.Alias_Soldier3, SpawnAttacker1 , false, false)
qf.Alias_Soldier4.GetReference().Delete()
cwacs.CreateAliasedSoldierAlly(qf.Alias_Soldier4, SpawnAttacker2 , false, false)
qf.Alias_Soldier5.GetReference().Delete()
cwacs.CreateAliasedSoldierAlly(qf.Alias_Soldier5, SpawnAttacker2 , false, false)
qf.Alias_Soldier6.GetReference().Delete()
cwacs.CreateAliasedSoldierAlly(qf.Alias_Soldier6, SpawnAttacker2 , false, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_38
Function Fragment_38()
;BEGIN CODE
; Whiterun join SC, guard/soldiers outfits - stormcloak armor + whiterun shield

if !OCW03WhiterunStormcloakGuardsOutfitEnabled.getValue()
  Debug.Trace("!OCW03WhiterunStormcloakGuardsOutfitEnabled.getValue()")
  return
endIf

GuardWhiterunSonsTemplate.setOutfit(OCW03_ArmorStormcloakWhiterunOutfit)
GuardWhiterunImperialTemplate.setOutfit(GuardImperialOutfit)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
(CW as CWScript).AddEnemyFortsToBackToWar()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_40
Function Fragment_40()
;BEGIN CODE
; necessary fix for testing using MQ quickstart on SC side...
(CW as CWScript).playerAllegiance = 2
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
OCW03Proventus01Scene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
; jarl is convinced - Stormcloak
setStage(50)
;CW03Scene.Stop()
; just in case, stop our scenes as well
OCW03ForcegreetScene.Stop()
OCW03Proventus01Scene.Stop()

CWScript CWs = CW as CWScript

;Removed completion of CW03 quest at this point --Enodoc
;CWs.CW03.setObjectiveCompleted(20)
;CWs.CW03.completeQuest()
; CWs.CW03.setStage(255) ; done by stop()
;CWs.CW03.stop()

; CWs.WhiterunSiegeStarted = true
;CWs.WhiterunSiegeFinished = true
;CWs.WarIsActive = 1
;CWs.displayFactionLeaderObjective()

setStage(59)  ; fix 0.8beta

setStage(60)
setStage(61)
setStage(62)
setStage(63)
setStage(64)
setStage(65) 
setStage(66)

setStage(73)  ; added in Balgruuf Dilemma 0.1.3 - updates global variables of CWO

CWs.SetOwnerKeywordDataOnly(CWs.WhiterunLocation, 2)
;setStage(70)  ; blocking until Whiterun civil war locations are unloaded !
;RegisterForSingleUpdate(30) ;Set stage 70 in an OnUpdate event, rather than immediately

;CWs.AddEnemyFortsToBackToWar()

OCW03WhiterunGuardOutfitNote.Enable()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property GovSons  Auto  

Faction Property GovImperial  Auto  

Quest Property CW  Auto  

Scene Property CW03Scene  Auto  

Scene Property OCW03ForcegreetScene  Auto  

Scene Property OCW03Proventus01Scene  Auto  

Quest Property CWAttackCity  Auto  

Faction Property JobHousecarlFaction  Auto  

Faction Property JobJarlFaction  Auto  

Faction Property GovRuling  Auto  

Faction Property GovExiled  Auto  

ReferenceAlias Property WhiterunJarl_MainAlias  Auto  

ReferenceAlias Property WhiterunJarl_BackupAlias  Auto  

ReferenceAlias Property WhiterunHousecarl_MainAlias  Auto  

ReferenceAlias Property WhiterunHousecarl_BackupAlias  Auto  

ActorBase Property GuardWhiterunSonsTemplate  Auto  

Outfit Property OCW03_ArmorStormcloakWhiterunOutfit  Auto  

GlobalVariable Property OCW03WhiterunStormcloakGuardsOutfitEnabled  Auto  

ObjectReference Property OCW03WhiterunGuardOutfitNote  Auto  

Faction Property CWImperialFaction  Auto  
Faction Property CWImperialFactionNPC  Auto  
Faction Property CWSonsFaction  Auto  
Faction Property CWSonsFactionNPC  Auto  

Function TurnWhiterunBodyguardStormcloak(Actor guard)
  guard.setOutfit(OCW03_ArmorStormcloakWhiterunOutfit)
  guard.removeFromFaction(CWImperialFaction)
  guard.removeFromFaction(CWImperialFactionNPC)
  guard.addToFaction(CWSonsFaction)
  guard.addToFaction(CWSonsFactionNPC)
EndFunction

Quest Property CW03  Auto  

Quest Property CWObj  Auto  

ActorBase Property GuardWhiterunImperialTemplate  Auto  

Outfit Property GuardImperialOutfit  Auto  

Faction Property Favor253QuestGiverFaction  Auto  

Quest Property FavorJarlsMakeFriends  Auto  
