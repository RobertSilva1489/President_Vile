extends Area2D
@export var dooor: int
@onready var fade = $"/root/TransitionNode/Fill/animation"
var player
var opinning = false
func _process(delta):
	if Input.is_action_just_pressed("action") and player!= null:
		if Global.keyWT != false:
			match dooor:
				1:
					fade.play("fade_in")
					$world1.play()
					await fade.animation_finished
					Global.keyWT = false
					get_tree().change_scene_to_file("res://scene/world_2.tscn")
				2:
					fade.play("fade_in")
					Global.keyWT = false
					opinning = true
					$Sprite2D.play("default")
					$word2.play()
					await $Sprite2D.animation_finished
					await get_tree().create_timer(1).timeout
					get_tree().change_scene_to_file("res://scene/world_3.tscn")
				3:
					Global.keyWT = false
					#get_tree().change_scene_to_file()
				4:
					Global.keyWT = false
					get_tree().change_scene_to_file("res://scene/END.tscn")
func _on_body_entered(body):
	if body.is_in_group("player"):
		player = body
		if dooor ==2 and opinning == true:
			pass
func _on_body_exited(body):
	if body.is_in_group("player"):
		player = null
