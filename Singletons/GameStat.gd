extends Node

signal change_state(new_state)


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
		
