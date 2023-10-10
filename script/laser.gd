extends Area2D

var player
	
func _activate():
	$AnimatedSprite2D.play("ativate")
	$CollisionShape2D.disabled = false
	$".".monitoring = true
	$AudioStreamPlayer2D.play()
	await $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.play("idle")
func _deactivate():
	$AnimatedSprite2D.play("desativate")
	await $AnimatedSprite2D.animation_finished
	$AudioStreamPlayer2D.queue_free()
	$CollisionShape2D.disabled = true
	$".".monitoring = false


func _on_body_entered(body):
	if body.is_in_group("player"):
		player = body
		player.trap(true)

func _on_body_exited(body):
	if body.is_in_group("player"):
		player = null
