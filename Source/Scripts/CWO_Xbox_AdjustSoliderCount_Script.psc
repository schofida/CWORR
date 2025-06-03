Scriptname CWO_Xbox_AdjustSoliderCount_Script extends ActiveMagicEffect

Int Property NewSoliderCount auto
GlobalVariable Property CWOEnableAdditionalSoldiers auto

Event OnEffectStart(actor AkTarget, actor AkCaster)
    CWOEnableAdditionalSoldiers.SetValueInt(NewSoliderCount)
EndEvent