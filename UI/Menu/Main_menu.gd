extends Control

@onready var select = $AudioStreamPlayer2D

func _ready():
	$NewGame.grab_focus()
	#get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN


func _on_new_game_button_up():
	select.play()
	await select.finished
	get_tree().change_scene_to_file("res://UI/Tutorial/tutorial_question.tscn")
	
func _on_credits_button_up():
	select.play()
	await select.finished
	get_tree().change_scene_to_file("res://UI/Menu/credits.tscn")

func _on_quit_button_up():
	select.play()
	await select.finished
	get_tree().quit()



