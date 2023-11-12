extends Node2D

@onready var ActiveSlot = get_node("GridContainer/Slot"+ str(active_slot))
var active_slot = 1
@onready var gridContainer = get_node("GridContainer")
var min_val = 1

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
		ActiveSlot.get_node("image").rotation_degrees -= 90
		
		#Check Game state
		if (TaskIsCompleted()):
			print("winn")
		
func ChangeActiveBlock(value):
	ActiveSlot.set_color(Color(1,1,1))
	active_slot += value
	
	#clamp(active_slot,min_val,max_val - 1)
	if (active_slot > max_val): 
		active_slot = 1
	if (active_slot < min_val): 
		active_slot = max_val - 1
	
	ActiveSlot = get_node("GridContainer/Slot"+ str(active_slot))
	ActiveSlot.set_color(Color(0,0,0))
	
func Randomize_Slot():
	for t in range(1, max_val):
		active_slot = t
		ActiveSlot = get_node("GridContainer/Slot"+ str(active_slot))
		var random_rotation = (int(RandomNumberGenerator.new().randf_range(0, 4))*90) 
		ActiveSlot.get_node("image").rotation_degrees = random_rotation
	active_slot = 1
	ActiveSlot = get_node("GridContainer/Slot"+ str(active_slot))
	
func TaskIsCompleted():
	for t in range(1, max_val):
		if ((int(get_node("GridContainer/Slot"+ str(t)).get_node("image").get_rotation_degrees())%360) != 0):
			return false
	return true
