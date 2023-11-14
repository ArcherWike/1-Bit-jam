extends Control

@onready var select = $AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#func _on_continue_button_up():
	#select.play()
	#await select.finished
	

func _on_quit_button_up():
	select.play()
	await select.finished
	get_tree().quit()

func _on_menu_button_up():
	select.play()
	await select.finished
	get_tree().change_scene_to_file("res://UI/Menu/Main_menu.tscn")
