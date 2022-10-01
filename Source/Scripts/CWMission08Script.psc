Scriptname CWMission08Script extends CWMissionScript  Conditional
{Extends CWMissionScript which extends Quest}

faction Property CWMission08EnemyToGiant auto
faction Property CWMission08GiantPlayerAlliesFaction Auto
faction Property CWMission08AllGiantsPlayerFriendFaction Auto

scene Property CWMission08Scene1 auto
scene Property CWMission08Scene2 auto

int Property playerAtAttackPoint auto conditional hidden	;0 = unset, 1 = player arrived - used to control scene, making sure the player is present before the giant takes the herd and gaurds attack

bool Property CowHandGreetedPlayer = false Auto Conditional hidden

bool Property PlayerReachedAttackPoint = false auto hidden

CWAlliesScript Property CWAlliesS Auto	;pointer to script on CWAllies Quest

function TryToFixQuest()
	debug.notification("Trying to fix CWMission08 quest")
endfunction
