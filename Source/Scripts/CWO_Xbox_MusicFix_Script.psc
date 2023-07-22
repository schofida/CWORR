Scriptname CWO_Xbox_MusicFix_Script extends ActiveMagicEffect

Quest Property CWOApolloFixMeQuest auto

Event OnEffectStart(actor AkTarget, actor AkCaster)
    CWOApolloFixMeQuest.Reset()
    CWOApolloFixMeQuest.SetStage(30)
EndEvent