extends Control

@onready var select = $AudioStreamPlayer2D
func _on_credits_button_up():
	select.play()
	await select.finished
	get_tree().change_scene_to_file("res://UI/Menu/credits.tscn")


func _on_menu_button_up():
	select.play()
	await select.finished
	get_tree().change_scene_to_file("res://UI/Menu/Main_menu.tscn")
