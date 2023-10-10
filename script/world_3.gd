extends Node2D

@onready var fade = $"/root/TransitionNode/Fill/animation"
@onready var hud = $"/root/Hud"
@onready var boss = $Boss
var boat = false
var lab = false
var t:= 0.0

func _ready():
	fade.play("fade_out")
	hud.show()
	await fade.animation_finished
	
func _physics_process(delta) -> void:
	if Global.secretDoor == 3:
		lab = true
		boat = true
	if Global.boss_die != false and boat == false and lab == false:
		await get_tree().create_timer(3).timeout
		$SecretLab/AnimationPlayer.play("ship")
		$boat.play()
		boat = true
	if Global.boss_die != false and lab != false:
		Global.secretDoor = 0
		lab = false
		$SecretLab/AnimationPlayer.play("show")
		await $SecretLab/AnimationPlayer.animation_finished
		$SecretLab/AnimationPlayer.play("close")
		$lab.play()
		await $SecretLab/AnimationPlayer.animation_finished
		
		
		
		
func _on_fall_body_entered(body):
	if body.is_in_group("player"):
		Global.health = 0
		$Player/Body/AnimatedSprite2D.play("die")
		$Player/dead.play()
		await get_tree().create_timer(0.9).timeout
		get_tree().change_scene_to_file("res://scene/game_over.tscn")
		
func dust ():
	$dust.visible = true
	$dust.play("dust")
	await $dust.animation_finished
	$dust.visible = false


func _on_end_1_body_entered(body):
	if body.is_in_group("player"):
		fade.play("fade_in")
		await fade.animation_finished
		get_tree().change_scene_to_file("res://scene/end_1.tscn")
	


func _on_lab_door_body_entered(body):
	if body.is_in_group("player"):
		fade.play("fade_in")
		await fade.animation_finished
		get_tree().change_scene_to_file("res://scene/secret_lab.tscn")


func _on_trigger_body_entered(body):
	if body.is_in_group("player"):
		Global.trigger = true
		$trigger.queue_free()
		
