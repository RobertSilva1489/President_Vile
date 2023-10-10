extends Area2D

@onready var item:PackedScene = preload("res://scene/itens.tscn")
var player = false
@export var prop = int(randf_range(2,4))
func _ready():
	$AnimationPlayer.play("idle")

func _process(delta):
	if Input.is_action_just_pressed("action") and player!=null:
		if Global.keyBT == true:
			$AnimationPlayer.play("open")
			$open.play()
			Global.keyBT = false
func drop ():
	var _drop = item.instantiate()
	get_parent().add_child(_drop)
	_drop.global_position = self.global_position
	_drop.itens = prop


func _on_body_entered(body):
	if body.is_in_group("player"):
		player = body
func _on_body_exited(body):
	if body.is_in_group("player"):
		player = null
