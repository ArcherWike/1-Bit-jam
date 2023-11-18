extends CharacterBody2D


@onready var target_agent = $NavigationAgent2D
var agent_speed = 75
var targ: Vector2

var timer_wait = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	targ = Vector2(710,651)
	$Timer.wait_time = 0.1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.distance_to(targ) > 0.5:
		var curLoc = global_transform.origin
		var nextLoc = target_agent.get_next_path_position()
		var newVel = (nextLoc - curLoc).normalized() * agent_speed
		velocity = newVel
		move_and_slide()

func updateTargetPosition(target):
	target_agent.set_target_position(target)


func _on_timer_timeout():
	var random_x = randi() % 1900
	var random_y = randi() % 900
	if $TextureRect.flip_h == false&& targ.x > random_x:
		$TextureRect.set_flip_h(true)
	elif $TextureRect.flip_h && targ.x < random_x:
		$TextureRect.set_flip_h(false)
	targ = Vector2(random_x,random_y)
	updateTargetPosition(targ)
	$Timer.wait_time = timer_wait + randi()%5
	$Timer.start()
