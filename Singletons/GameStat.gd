extends Node

signal change_state(new_state)

var time_task = 60
var time_kill = 120

enum PlayerStat{
	KILLING,
	TASKS
}
	
var ActiveStat = PlayerStat.KILLING

func EnemyKilable():
	if ActiveStat == PlayerStat.KILLING:
		return true
	return false

func ChangeState():
	match ActiveStat:
		PlayerStat.KILLING:
			ActiveStat = PlayerStat.TASKS
		PlayerStat.TASKS:
			ActiveStat = PlayerStat.KILLING
	emit_signal("change_state")
		

	
var Games = {
	0: "rotate", #0
	1: "memory"  #1
}
