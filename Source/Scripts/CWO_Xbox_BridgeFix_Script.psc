Scriptname CWO_Xbox_BridgeFix_Script extends ActiveMagicEffect

Quest Property CWOApolloFixMeQuest auto

Event OnEffectStart(actor AkTarget, actor AkCaster)
    CWOApolloFixMeQuest.Reset()
    CWOApolloFixMeQuest.SetStage(50)
EndEvent