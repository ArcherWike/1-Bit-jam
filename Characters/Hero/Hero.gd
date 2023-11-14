extends CharacterBody2D

@export var ACCELERATION = 500
@export var MAX_SPEED = 500
@export var FRICTION = 500
@export var Y_AXIS_MOVE_DECELERATION = 0.5
@onready var ANIMATIONS = $AnimatedSprite2D

func _process(delta):
	move_state(delta)

var roll_vector = Vector2.DOWN

const SPEED = 500.0
const JUMP_VELOCITY = -400.0

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")) * Y_AXIS_MOVE_DECELERATION
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move()
func updateAnimation():
	var direction = "Left" #down
	if velocity.x < 0: direction = "Left"
	elif velocity.x > 0: direction = "Right"
	elif velocity.y < 0: direction = "Right" #up
	ANIMATIONS.play(direction)
	
func move():
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity
	updateAnimation()

