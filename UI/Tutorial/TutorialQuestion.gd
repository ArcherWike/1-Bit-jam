extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$HBoxContainer/Yes.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_no_button_up():
	get_tree().change_scene_to_file("res://UI/Tutorial/tutorial.tscn")


func _on_yes_button_up():
		get_tree().change_scene_to_file("res://UI/cutscene_start.tscn")
