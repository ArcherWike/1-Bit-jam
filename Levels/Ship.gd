extends Node2D
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		pauseMenu()
	if GameStat.killed == 3:
		get_tree().change_scene_to_file("res://UI/Menu/WinScreen.tscn")
func _on_timer_timeout():
	$AnimationPlayer.play("Lightning")
	$Timer.wait_time = int(RandomNumberGenerator.new().randf_range(7,10))
	$Timer.start() 

func pauseMenu():
	if paused == true:
		$CanvasLayer/Pause.hide()
		get_tree().paused = false
		$CanvasModulate.show()
	else:
		get_tree().paused = true
		$CanvasLayer/Pause.show()
		$CanvasModulate.hide()
	paused = !paused
	
