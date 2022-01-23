Scriptname CWReinforcementAliasScript extends ReferenceAlias 


Event OnDeath(Actor akKiller)
 	CWScript.Log ("CWReinforcementAliasScript", self + "OnDeath() will call CWReinforcementControllerScript RegisterDeath(" + self + ")")
	;CWO - Block OP gear from being taken from troops
	self.getreference().BlockActivation(true)
	(GetOwningQuest() as CWReinforcementControllerScript).registerDeath(self)

EndEvent
