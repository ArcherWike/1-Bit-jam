extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
#
func _on_timer_timeout():
	$CanvasModulate.visible = false
	$Thunder.play()
	$CanvasLayer/ColorRect.material.set("Multiply", 3);
func _on_timer_2_timeout():
	$CanvasModulate.visible = true
	$CanvasLayer/ColorRect.material.set("Multiply", 1);
