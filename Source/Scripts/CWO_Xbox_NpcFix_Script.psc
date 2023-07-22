Scriptname CWO_Xbox_NpcFix_Script extends ActiveMagicEffect

Quest Property CWOApolloFixMeQuest auto

Event OnEffectStart(actor AkTarget, actor AkCaster)
    CWOApolloFixMeQuest.Reset()
    CWOApolloFixMeQuest.SetStage(40)
EndEvent