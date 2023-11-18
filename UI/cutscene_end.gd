extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")
	await $AnimatedSprite2D.animation_finished
	

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_animated_sprite_2d_animation_finished():
	get_tree().change_scene_to_file("res://UI/Menu/WinScreen.tscn")

	pass # Replace with function body.
