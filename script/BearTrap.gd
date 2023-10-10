extends Area2D

var player

func _physics_process(delta):
#	if player != null:
#		player.trap(false)
	pass

func _on_body_entered(body):
	if body.is_in_group("player"):
		player = body
		$AnimationPlayer.play("new_animation")
		$AudioStreamPlayer2D.play()
		player.trap(false)
		await $AnimationPlayer.animation_finished
		$".".monitoring = false
			
		

func _on_body_exited(body):
	if body.is_in_group("player"):
		player = null
