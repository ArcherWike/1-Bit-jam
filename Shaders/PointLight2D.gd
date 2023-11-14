extends PointLight2D

var color_speed = 2
var current_time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var noise = sin(1*PI*current_time)+sin(0.3*PI*current_time)+sin(0.5*PI*current_time)
	current_time += delta * color_speed
	$".".energy= remap(noise,-2.73,2.73,300,600 )
	#remap(sin(current_time),-1,1,100,500)
	pass



