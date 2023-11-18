extends Control


func _ready():
	$AnimatedSprite2D.play("default")
	await $AnimatedSprite2D.animation_finished
	

func _on_animated_sprite_2d_animation_finished():
	get_tree().change_scene_to_file("res://Levels/Ship.tscn")
