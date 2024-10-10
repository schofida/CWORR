Scriptname CWOBAEvaluatePackageScript extends ActiveMagicEffect

Event OnEffectStart(actor AkTarget, actor AkCaster)
    if AkTarget != none
        AkTarget.EvaluatePackage()
    endif
EndEvent