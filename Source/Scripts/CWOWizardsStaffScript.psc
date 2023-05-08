scriptName CWOWizardsStaffScript extends ObjectReference

;-- Properties --------------------------------------
spell property SpellToAdd auto
Int property SkillMax auto
Int property SkillMin auto
Weapon Property ThisItem auto


;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GetState

; Skipped compiler generated GotoState

function OnUnequipped(Actor AkActor)

	AkActor.RemoveSpell(SpellToAdd)
endFunction

function OnEquipped(Actor AkActor)

	if AkActor != Game.GetPlayer() || ((AkActor.GetAv("Destruction") > SkillMin as Float && AkActor.GetAv("Conjuration") > SkillMin as Float && AkActor.GetAv("Restoration") > SkillMin as Float && AkActor.GetAv("Alteration") > SkillMin as Float && AkActor.GetAv("Illusion") > SkillMin as Float) || AkActor.GetAv("Destruction") > SkillMax as Float || AkActor.GetAv("Illusion") > SkillMax as Float || AkActor.GetAv("Conjuration") > SkillMax as Float || AkActor.GetAv("Alteration") > SkillMax as Float || AkActor.GetAv("Restoration") > SkillMax as Float)
		AkActor.AddSpell(SpellToAdd, true)
	else
;		AkActor.UnequipItem(AkActor.GetEquippedObject(0), false, true)
;		AkActor.UnequipItem(AkActor.GetEquippedObject(1), false, true)
;		debug.notification("You are not worthy")
		akActor.UnequipItem(ThisItem)
		debug.notification("You are not worthy")
	endIf
endFunction
