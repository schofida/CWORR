Scriptname CWO_Xbox_QuestFix_Script extends ActiveMagicEffect


Quest Property CWOApolloFixMeQuest auto

Event OnEffectStart(actor AkTarget, actor AkCaster)
    CWOApolloFixMeQuest.Reset()
    CWOApolloFixMeQuest.SetStage(10)
EndEvent