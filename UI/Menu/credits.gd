extends Control

@onready var select = $AudioStreamPlayer2D


func _on_texture_button_button_up():
	select.play()
	await select.finished
	get_tree().change_scene_to_file("res://UI/Menu/Main_menu.tscn")
