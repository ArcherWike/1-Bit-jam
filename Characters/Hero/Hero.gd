extends CharacterBody2D

var lastdirection = "Up"
var direction = "Up"
@export var ACCELERATION = 1000
@export var MAX_SPEED = 500
@export var FRICTION = 1000
@export var Y_AXIS_MOVE_DECELERATION = 0.5
@onready var ANIMATIONS = $AnimatedSprite2D

func _process(delta):
	move_state(delta)

var roll_vector = Vector2.DOWN
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * Y_AXIS_MOVE_DECELERATION
	input_vector.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")) * Y_AXIS_MOVE_DECELERATION
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move()
func updateAnimation():
	if velocity.x < 0: direction = "Left" 
	elif velocity.x > 0: direction = "Right"
	elif velocity.y > 0: direction = "Down" 
	elif velocity.y < 0: direction = "Up"
	elif velocity == Vector2(0,0):  ANIMATIONS.play("Idle_" + lastdirection)
	ANIMATIONS.play(direction)
	lastdirection = direction
	
func move():
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity
	updateAnimation()


