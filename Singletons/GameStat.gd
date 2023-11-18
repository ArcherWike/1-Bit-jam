extends Node

signal change_state(new_state)
signal change_pause(new_state)

var MiniGameIsActive = false
var Game_paused = false
var ActiveStat = PlayerStat.KILLING

var time_task = 60
var time_kill = 120
var killed = 0

enum PlayerStat{
	KILLING,
	TASKS
}
	

func EnemyKilable():
	if ActiveStat == PlayerStat.KILLING:
		return true
	return false

func ChangePause():
	Game_paused = !Game_paused
	emit_signal("change_pause")

func ChangeState():
	match ActiveStat:
		PlayerStat.KILLING:
			ActiveStat = PlayerStat.TASKS
		PlayerStat.TASKS:
			ActiveStat = PlayerStat.KILLING
	emit_signal("change_state")
		
func Paranoia():
	killed += 1
	RenderingServer.global_shader_parameter_set("Paranoia",Vector4(1,1-(0.3*killed),1-(0.3*killed),1))	
	
var Games = {
	0: "rotate", #0
	1: "fisherman",  #1
	2: "ship" #2
}
