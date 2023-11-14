extends CanvasLayer

#push_error("Item haven't name")
var active_game_node
var Game_interact_List = []
var active_game_area = null 

func _ready():
	GameStat.connect("change_state", Callable(self, "_game_stat_was_changed"))
	for child in get_node("Game_interact").get_children():
		Game_interact_List.append(child)
	if len(Game_interact_List) <= 0:
		push_error("Game starting points missing - interact scene in Game_interact Node")
		#if has_methon
	Select_starting_area()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer_run:
		set_label_timer()

#Select the starting area of game and start the collision activity
func Select_starting_area():
	var random_index = int(RandomNumberGenerator.new().randf_range(0, len(Game_interact_List) - 1))
	active_game_area = Game_interact_List[random_index]
	active_game_area.Set_activity(true)	

func _completed_game(is_completed):
	if (!is_completed):
		print("GAME OVER")
	get_tree().paused = false
	active_game_node.queue_free()
	##Change mode
	GameStat.ChangeState()
	active_game_area.Set_activity(false)
	active_game_area = null
	
func _on_interact_start_game(game_type):
	for i in GameStat.Games:
		if GameStat.Games[i] == game_type:
			if !(self.has_node("Game_"+str(game_type))):
				var Game_load = load("res://Objects/MiniGames/Game_"+str(game_type)+".tscn")
				var Game_instance = Game_load.instantiate()
				add_child(Game_instance)
				#active_game_node.set_process = PROCESS_MODE_ALWAYS
				active_game_node = get_node("Game_"+str(game_type))
				active_game_node.SetGameTimer(GameStat.time_task)
				active_game_node.connect("completed_game", Callable(self, "_completed_game"))			
	get_tree().paused = true

func _game_stat_was_changed():
	if GameStat.ActiveStat == 0:
		$Label.text = "TASKS"
		GameStat.time_kill -= 20
		Select_starting_area()
	else:
		$Label.text = "KILLING"
		GameStat.time_task -= 20
		SetKillTimer(GameStat.time_kill)
		
## ----------------------------------## Timer - GameStat = KILLING enemy ##-------------------------##
var minutes = 0
var seconds = 0
var timer_run = false

func get_minutes_and_seconds():
	var time_left = $TimerKillEnemyTask.get_wait_time() + $TimerKillEnemyTask.get_time_left()
	minutes = floor(time_left / 60)
	seconds = int(time_left) % 60
	
func set_label_timer():
	get_minutes_and_seconds()
	$TimeLabel.text = "0" + str(minutes) + ":"
	if seconds < 10:
		$TimeLabel.text += "0" + str(seconds)
	else:
		$TimeLabel.text += str(seconds)
		
func SetKillTimer(get_seconds):
	timer_run = true
	
	seconds = get_seconds
	$TimerKillEnemyTask.wait_time = seconds
	set_label_timer()
	$TimeLabel.visible = true
	$TimerKillEnemyTask.start()

func _on_timer_kill_enemy_task_timeout():
	timer_run = false
	$TimeLabel.visible = false
	print("GAME OVER")
