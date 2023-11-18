extends CanvasLayer

var active_game_area
var active_game_node
var root
var tutorial_info = true

func _ready():
	$StartInfo/VBoxContainer/Button_yes.grab_focus()
	root = get_tree().get_root()
	GameStat.ChangeState()
	GameStat.connect("change_state", Callable(self, "_game_stat_was_changed"))
	$Panel.hide()
	$StartInfo.show()
	$fault.hide()
	$infoCapitan.hide()
	tutorial_info = true
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	#task one completed - kill companion - configured next step
func _on_enemy_2_child_exiting_tree(node):	
	$Panel.set_size(Vector2(450,300))
	$Panel/VBoxContainer/Quest1.modulate = Color("#3d0c02")
	$Panel/VBoxContainer/Quest2.show()
	active_game_area = root.get_node("/root/Ship_tutorial/interact")
	active_game_area.Set_activity(true)
	$fault.show()
	$fault/VBoxContainer/Button_yes.grab_focus()
	get_tree().paused = true

func _on_button_yes_tutorial_info_pressed():
	get_node("/root/Ship_tutorial/CanvasModulate").show()
	$StartInfo.hide()
	tutorial_info = false
	$Panel.show()
	$NotifyByEnemy.play("notify of problems")
	get_tree().paused = false
	
func _game_stat_was_changed():
	pass
	
	#received a signal that the task has been completed 
	#- decide what to do next game over/ continue
func _completed_game(is_completed):
	GameStat.MiniGameIsActive = false
	if (!is_completed):
		get_tree().change_scene_to_file("res://UI/Menu/GameOver.tscn")
	get_tree().paused = false
	##Change mode
	GameStat.ChangeState()
	active_game_area.Set_activity(false)
	active_game_node.queue_free()
	active_game_area = null
	get_tree().change_scene_to_file("res://UI/cutscene_start.tscn")
	
	#interaction with the play game area - interract
	#gets the signal from her to start the game
func _on_interact_start_game(game_type):
	var Game_load = load("res://Objects/MiniGames/Game_"+str(game_type)+".tscn")
	var Game_instance = Game_load.instantiate()
	add_child(Game_instance)
	GameStat.MiniGameIsActive = true
	active_game_node = get_node("Game_"+str(game_type))
	active_game_node.SetGameTimer(GameStat.time_task)
	active_game_node.connect("completed_game", Callable(self, "_completed_game"))			
	if game_type != GameStat.Games[1]:
		get_tree().paused = true
		
	#Pause Game - set up visibility of nodes
func _on_pause_visibility_changed():
	var pause = root.get_node("/root/Ship_tutorial/CanvasLayer/Pause")
	if pause.visible:
		$StartInfo.hide()
	else:
		if (tutorial_info):
			var canvas_modulate = root.get_node("/root/Ship_tutorial/CanvasModulate")
			canvas_modulate.hide()
			$StartInfo.show()


func _on_button_yes_pressed():
	$fault.hide()
	$infoCapitan.show()
	$infoCapitan/VBoxContainer/Button_yes.grab_focus()


func _on_button_yes_pressed_infoCapitan():
	$infoCapitan.hide()
	get_tree().paused = false
