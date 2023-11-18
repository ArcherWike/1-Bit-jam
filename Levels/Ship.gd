extends Node2D
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	GameStat.killed = 0
	RenderingServer.global_shader_parameter_set("Paranoia",Vector4(1,1-(0.3*GameStat.killed),1-(0.3*GameStat.killed),1))	
	pass # Replace with function body.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		pauseMenu()
	if GameStat.killed == 3:
		get_tree().change_scene_to_file("res://UI/cutscene_end.tscn")
func _on_timer_timeout():
	$AnimationPlayer.play("Lightning")
	$Timer.wait_time = int(RandomNumberGenerator.new().randf_range(7,10))
	$Timer.start() 

func pauseMenu():
	GameStat.ChangePause()
	if paused == true:
		$CanvasModulate.show()
		$CanvasLayer/Pause.hide()
		get_tree().paused = false
	else:
		get_tree().paused = true
		$CanvasModulate.hide()
		$CanvasLayer/Pause.show()
	paused = !paused
	
