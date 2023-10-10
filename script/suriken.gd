extends Area2D


var player

func _physics_process(delta):

	if player != null:
		player.trap(true)
		
func _on_body_entered(body):
	if body.is_in_group("player"):
		player = body
#		player.trap(false)
		
func _on_body_exited(body):
	if body.is_in_group("player"):
		player = null

