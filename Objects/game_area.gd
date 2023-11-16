extends Area2D

var start = false
var is_active = false

#code of the game to be launched from this interaction - from GameStat singleton
@export var run_game = 0

signal start_game(game_type)

func _process(delta):
	if is_active:		
		if Input.is_action_just_pressed("ui_accept") && start:
			#Player has interacted - start the game
			emit_signal("start_game", GameStat.Games[run_game])
			start = false
		
func _on_body_exited(body):
	if (body.name == 'Hero'):
		start = false
		$GPUParticles2D.emitting = false
		
func _on_body_entered(body):
	if (body.name == 'Hero'):
		start = true
		$GPUParticles2D.emitting = true
		
func Set_activity(mode):
	is_active = mode
	$CollisionShape2D.disabled = !(is_active)
	start = false
	$Label.text = str(is_active)
		
