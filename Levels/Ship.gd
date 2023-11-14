extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
#


func _on_timer_timeout():
	$AnimationPlayer.play("Lightning")
	$Timer.wait_time = int(RandomNumberGenerator.new().randf_range(3, 5))
	$Timer.start() 
