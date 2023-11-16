extends Node2D

@onready var ActiveSlot = get_node("GridContainer/Slot"+ str(active_slot))
var active_slot = 1
@onready var gridContainer = get_node("GridContainer")
var min_val = 1

var timer_run = false
var minutes = 0
var seconds = 0

signal completed_game(is_completed)

@onready var max_val = gridContainer.get_children().size()
# Called when the node enters the scene tree for the first time.
func _ready():
	ActiveSlot.set_color(Color(0,0,0))
	Randomize_Slot()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if  Input.is_action_just_pressed("ui_right"):
		ChangeActiveBlock(1)
	if  Input.is_action_just_pressed("ui_left"):
		ChangeActiveBlock(-1)
	if Input.is_action_just_pressed("ui_accept"):
		ActiveSlot.get_node("image").rotation_degrees += 90
		#Check Game state
		if (TaskIsCompleted()):
			print("winn")
			emit_signal("completed_game", true)
	if timer_run:
		set_label_timer()

		
func ChangeActiveBlock(value):
	ActiveSlot.set_color(Color(1,1,1))
	active_slot += value
	if (active_slot > max_val): 
		active_slot = 1
	if (active_slot < min_val): 
		active_slot = max_val

	ActiveSlot = get_node("GridContainer/Slot"+ str(active_slot))
	#ActiveSlot.set_color(Color(0,0,0))
	ActiveSlot.light_mask = 2
func Randomize_Slot():
	for t in range(1, max_val + 1):
		active_slot = t
		ActiveSlot = get_node("GridContainer/Slot"+ str(active_slot))
		var random_rotation = (int(RandomNumberGenerator.new().randf_range(0, 2))*90) 
		ActiveSlot.get_node("image").rotation_degrees = random_rotation
	active_slot = 1
	ActiveSlot = get_node("GridContainer/Slot"+ str(active_slot))
	
func TaskIsCompleted():
	for t in range(1, max_val + 1):
		if ((int(get_node("GridContainer/Slot"+ str(t)).get_node("image").get_rotation_degrees())%360) != 0):
			return false
	return true
	
func get_minutes_and_seconds():
	var time_left = 0
	time_left = round($Timer.get_time_left())
	minutes = floor(time_left / 60)
	seconds = int(time_left) % 60
	
func set_label_timer():
	get_minutes_and_seconds()
	$TimerLabel.text = "0" + str(minutes) + ":"
	if seconds < 10:
		$TimerLabel.text += "0" + str(seconds)
	else:
		$TimerLabel.text += str(seconds)
		
func SetGameTimer(get_seconds):
	if get_seconds > 0:
		timer_run = true
		seconds = get_seconds
		$Timer.wait_time = seconds
		set_label_timer()
		$Timer.start()


func _on_timer_timeout():
	emit_signal("completed_game", false)
	timer_run = false
