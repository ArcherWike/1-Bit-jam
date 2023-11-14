extends PointLight2D

var color_speed = 2
var current_time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_time += delta * color_speed
	$".".energy= remap(sin(current_time),-1,1,100,500)
	pass



