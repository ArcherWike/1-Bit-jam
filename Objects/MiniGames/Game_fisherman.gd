extends Node2D

var speed = 10
signal completed_game(is_completed)

func _ready():
	print("dsa yol")
	self.set_process(true)
	self.set_physics_process(true)
	self.set_process_input(true)
	$target.position = Vector2(randf_range(100, 1800),randf_range(100, 800))

func _process(delta):
	pass
	
	
	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("ui_right") && $fishing_rod.position.x < 1800:
		$fishing_rod.position.x += speed
	if Input.is_action_pressed("ui_left") && $fishing_rod.position.x > 50:
		$fishing_rod.position.x -= speed
	if Input.is_action_pressed("ui_down") && $fishing_rod.position.y < 800:
		$fishing_rod.position.y += speed
	if Input.is_action_pressed("ui_up") && $fishing_rod.position.y > 100:
		$fishing_rod.position.y -= speed

func _on_target_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.name == "fishing_rod":
		emit_signal("completed_game", true)
		
func SetGameTimer(get_seconds):
	pass

