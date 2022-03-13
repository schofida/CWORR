scriptName EGO_QF_CWOBAQuest_0203B24F extends Quest hidden

;-- Properties --------------------------------------
referencealias property Alias_StormcloakSpy01 auto
referencealias property Alias_StormcloakSpy02 auto
referencealias property Alias_StormcloakSpy03 auto
referencealias property Alias_StormcloakSpy04 auto
referencealias property Alias_StormcloakSpy05 auto
referencealias property Alias_StormcloakSpy06 auto
referencealias property Alias_StormcloakSpy07 auto
referencealias property Alias_StormcloakSpy08 auto
referencealias property Alias_StormcloakSpy09 auto
globalvariable property QuestLength auto
referencealias property Alias_StormcloakSpy10 auto
referencealias property Alias_StormcloakSpy11 auto
referencealias property Alias_ImperialSpy01 auto
referencealias property Alias_ImperialSpy02 auto
referencealias property Alias_ImperialSpy03 auto
referencealias property Alias_ImperialSpy04 auto
referencealias property Alias_ImperialSpy05 auto
referencealias property Alias_ImperialSpy06 auto
referencealias property Alias_ImperialSpy07 auto
referencealias property Alias_ImperialSpy08 auto
referencealias property Alias_ImperialSpy09 auto
referencealias property Alias_ImperialSpy10 auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GetState

; Skipped compiler generated GotoState

function Fragment_1()

	(Alias_StormcloakSpy11 as cwobascript2).RevertFactions()
	(Alias_StormcloakSpy10 as cwobascript2).RevertFactions()
	(Alias_StormcloakSpy09 as cwobascript2).RevertFactions()
	(Alias_StormcloakSpy08 as cwobascript2).RevertFactions()
	(Alias_StormcloakSpy07 as cwobascript2).RevertFactions()
	(Alias_StormcloakSpy06 as cwobascript2).RevertFactions()
	(Alias_StormcloakSpy05 as cwobascript2).RevertFactions()
	(Alias_StormcloakSpy04 as cwobascript2).RevertFactions()
	(Alias_StormcloakSpy03 as cwobascript2).RevertFactions()
	(Alias_StormcloakSpy02 as cwobascript2).RevertFactions()
	(Alias_StormcloakSpy01 as cwobascript2).RevertFactions()
	(Alias_ImperialSpy10 as cwobascript2).RevertFactions()
	(Alias_ImperialSpy09 as cwobascript2).RevertFactions()
	(Alias_ImperialSpy08 as cwobascript2).RevertFactions()
	(Alias_ImperialSpy07 as cwobascript2).RevertFactions()
	(Alias_ImperialSpy06 as cwobascript2).RevertFactions()
	(Alias_ImperialSpy05 as cwobascript2).RevertFactions()
	(Alias_ImperialSpy04 as cwobascript2).RevertFactions()
	(Alias_ImperialSpy03 as cwobascript2).RevertFactions()
	(Alias_ImperialSpy02 as cwobascript2).RevertFactions()
	(Alias_ImperialSpy01 as cwobascript2).RevertFactions()
endFunction

function Fragment_0()
	Quest __temp = self as Quest
	CWOBAQuestScript kmyQuest = __temp as CWOBAQuestScript

	kmyQuest.registerforsingleupdate(QuestLength.GetValue())
endFunction
