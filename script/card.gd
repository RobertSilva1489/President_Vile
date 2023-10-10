extends Area2D

@export var password_id : int
func _ready() -> void:
	match password_id:
		1:
			Global.P_id1 = true
		2:
			Global.P_id2 = true
		3:
			Global.P_id3 = true
func _on_body_entered(body):
	if body.is_in_group("player"):
		match password_id:
			1:
				Global.card1 = true
				Global.check_card = false
								
				$AudioStreamPlayer2D.play()
				$Sprite2D.visible = false
				await $AudioStreamPlayer2D.finished
				queue_free()
			2:
				Global.card2 = true
				Global.check_card = false
				
				$AudioStreamPlayer2D.play()
				$Sprite2D.visible = false
				await $AudioStreamPlayer2D.finished
				queue_free()
			3:
				Global.card3 = true
				Global.check_card = false
			
				$AudioStreamPlayer2D.play()
				$Sprite2D.visible = false
				await $AudioStreamPlayer2D.finished
				queue_free()
