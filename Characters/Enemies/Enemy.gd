extends Area2D

var endangered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameStat.EnemyKilable() && $KillingRange.visible:
		$KillingRange.show()
	elif !GameStat.EnemyKilable() && $KillingRange.visible:
		$KillingRange.hide()
	if Input.is_action_just_pressed("ui_accept") && endangered:
		Self_destroy()
		
		


func _on_killing_range_body_entered(body):
	if body.name == "Hero":
		endangered = true


func _on_killing_range_body_exited(body):
	if body.name == "Hero":
		endangered = false
		
func Self_destroy():
	print("ded")
	GameStat.ChangeState()
	self.queue_free()
