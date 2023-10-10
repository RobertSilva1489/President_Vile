extends Node2D
@onready var hud : CanvasLayer = $"/root/Hud"
@onready var fade = $"/root/TransitionNode/Fill/animation"
# Called when the node enters the scene tree for the first time.
func _ready():
	hud.visible = false
	fade.play("fade_out")
	await get_tree().create_timer(3).timeout
	fade.play("fade_in")
	await fade.animation_finished
	get_tree().change_scene_to_file("res://scene/END.tscn")
