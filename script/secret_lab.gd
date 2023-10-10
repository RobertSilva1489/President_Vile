extends Node2D

var player
var card : int
@export var card1 = false
@export var card2 = false
@export var card3 = false
@onready var zombie_man_2 = $enemy/zombie_man2
@onready var fade = $"/root/TransitionNode/Fill/animation"
@onready var hud = $"/root/Hud"

# Called when the node enters the scene tree for the first time.
func _ready():
	$"trap/wall spikes/AnimationPlayer".play("new_animation")
	$enemy/Card.visible = false
	$enemy/Card.monitoring = false
	$enemy/Card2.visible = false
	$enemy/Card2.monitoring = false
	fade.play("fade_out")
	hud.show()
	await fade.animation_finished
func _process(delta) -> void:
	card1 = Global.card1
	card2 = Global.card2
	card3 = Global.card3
	if Global.check_card == true and Global.P_id1 == true:
		$enemy/Card.visible = true
		$enemy/Card.monitoring = true
		Global.P_id1 = false
		Global.check_card = false
	if Global.check_card == true and Global.P_id2 ==true:
		$enemy/Card2.visible = true
		$enemy/Card2.monitoring = true
		Global.P_id2 = false
	if card == 1 and card1 == true:
		if Input.is_action_just_pressed("action"):
			$panels/Panel/AnimatedSprite2D.play("desactivate")
			$panels/Panel/AudioStreamPlayer2D.play()
			$trap/laser._deactivate()
			$trap/laser2._deactivate()
			$trap/laser3._deactivate()
			Global.card1 = false
	if card == 2 and card2 == true:
		if Input.is_action_just_pressed("action"):
			$panels/Panel2/AnimatedSprite2D.play("desactivate")
			$panels/Panel2/AudioStreamPlayer2D.play()
			$trap/saw._deactivate()
			$trap/saw2._deactivate()
			$trap/saw3._deactivate()
			$trap/saw4._deactivate()
			Global.card2 = false
	if card == 3 and card3 == true:
		if Input.is_action_just_pressed("action"):
			$panels/Panel3/AnimatedSprite2D.play("desactivate")
			$panels/Panel3/AudioStreamPlayer2D.play()
			$"Exist door lab/AnimatedSprite2D".play("open")
			$exist.monitoring = true
			$exist/CollisionShape2D.disabled = false
			Global.card3 = false

func _on_card_1_body_entered(body):
	if body.is_in_group("player"):
		card = 1


func _on_card_1_body_exited(body):
	if body.is_in_group("player"):
		card = 0


func _on_card_2_body_entered(body):
	if body.is_in_group("player"):
		card = 2


func _on_card_2_body_exited(body):
	if body.is_in_group("player"):
		card = 0


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		$trap/laser._activate()
		await get_tree().create_timer(.5).timeout
		$trap/laser2._activate()
		await get_tree().create_timer(.5).timeout
		$trap/laser3._activate()
		$trap/Area2D.queue_free()


func _on_card_3_body_entered(body):
	if body.is_in_group("player"):
		card = 3


func _on_card_3_body_exited(body):
	if body.is_in_group("player"):
		card = 0

func _on_exist_body_entered(body):
	if body.is_in_group("player"):
		fade.play("fade_in")
		$exint.play()
		await fade.animation_finished
		get_tree().change_scene_to_file("res://scene/end_lab.tscn")
