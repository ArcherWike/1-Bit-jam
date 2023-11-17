extends CanvasLayer

var active_game_area
var active_game_node
# Called when the node enters the scene tree for the first time.
func _ready():
	GameStat.ChangeState()
	GameStat.connect("change_state", Callable(self, "_game_stat_was_changed"))
	$Panel.hide()
	$StartInfo.show()
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_2_child_exiting_tree(node):	
	$Panel.set_size(Vector2(450,300))
	$Panel/VBoxContainer/Quest1.modulate = Color("#89ff47")
	$Panel/VBoxContainer/Quest2.show()
	active_game_area = get_node("/root/Ship/interact")
	#active_game_area.connect("start_game", Callable(self, "_on_interact_start_game"))
	active_game_area.Set_activity(true)
	$NotifyByEnemy.play("notify of problems")

func _on_button_yes_tutorial_info_pressed():
	get_node("/root/Ship/CanvasModulate").show()
	$StartInfo.hide()
	$Panel.show()
	get_tree().paused = false
	
func _game_stat_was_changed():
	pass
	

func _completed_game(is_completed):
	GameStat.MiniGameIsActive = false
	if (!is_completed):
		print("GAME OVER")
		get_tree().change_scene_to_file("res://UI/Menu/GameOver.tscn")
	get_tree().paused = false
	active_game_node.queue_free()
	##Change mode
	GameStat.ChangeState()
	active_game_area.call_deferred("Set_activity",false)
	active_game_area = null
	get_tree().change_scene_to_file("res://Levels/Ship.tscn")
	
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
		
func test():
	pass
