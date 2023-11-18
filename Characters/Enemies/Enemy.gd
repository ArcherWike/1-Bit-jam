extends Area2D

var endangered = false
var killing_option_active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	GameStat.connect("change_state", Callable(self, "_game_stat_was_changed"))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameStat.EnemyKilable() && $KillingRange.visible:
		$KillingRange.show()
	elif !GameStat.EnemyKilable() && $KillingRange.visible:
		$KillingRange.hide()
		
		#if Hero can kill - destroy me
	if Input.is_action_just_pressed("ui_accept") && endangered && killing_option_active:
		GameStat.Paranoia()
		$"../../AnimationPlayer".play("Lightning_2")
		Self_destroy()
		
		


func _on_killing_range_body_entered(body):
	if body.name == "Hero":
		endangered = true


func _on_killing_range_body_exited(body):
	if body.name == "Hero":
		endangered = false
		
func Self_destroy():
	GameStat.ChangeState()
	self.queue_free()

func _game_stat_was_changed():
	if GameStat.ActiveStat == 1:
		killing_option_active = true
	else:
		killing_option_active = false
