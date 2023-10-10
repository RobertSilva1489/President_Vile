extends Node2D
@onready var fade = $"/root/TransitionNode/Fill/animation"
@onready var hud = $"/root/Hud"

func _ready():
	fade.play("fade_out")
	hud.show()
	await fade.animation_finished

func _on_fall_body_entered(body):
	if body.is_in_group("player"):
		Global.health = 0
		$Player/Body/AnimatedSprite2D.play("die")
		$Player/dead.play()
		await get_tree().create_timer(0.9).timeout
		get_tree().change_scene_to_file("res://scene/game_over.tscn")
