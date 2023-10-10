extends Area2D



func _on_body_entered(body):
	if body.is_in_group("player"):
		body.trap(true)
		
func _deactivate():
	$AnimatedSprite2D.play("deactivate")
	$".".monitoring = false
	$AudioStreamPlayer2D.queue_free()
	$CollisionShape2D.disabled = true
