extends Area2D

@export var itens: int
@export var anim = ""
@export var bullets = 10
func _process(delta):
	match  itens:
		0:
			$Sprite2D.play("key-blue") 
			anim = "key-blue"
		1:
			$Sprite2D.play("key-white")
			anim = "key-white"
		2:
			$Sprite2D.play("health") 
			anim = "health"
		3:
			$Sprite2D.play("ammo") 
			anim = "ammo"
func _on_body_entered(body):
	if body.is_in_group("player") and body !=null:
		
		match anim:
			"health": 
				if body.health < 100:
					Global.health = 100
					$caght.play()
					self.visible = false
					await $caght.finished
					queue_free()
			"ammo":
				Global.shells += bullets
				$caght.play()
				self.visible = false
				await $caght.finished
				queue_free()
			"key-white":
				Global.keyWT = true
				$caght.play()
				self.visible = false
				await $caght.finished
				queue_free()
			"key-blue":
				Global.keyBT = true
				$caght.play()
				self.visible = false
				await $caght.finished
				queue_free()
		
