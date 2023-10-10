extends Node2D
@onready var fade = $"/root/TransitionNode/Fill/animation"
@onready var hud = $"/root/Hud"
var t:= 0.0

func _ready():
	fade.play("fade_out")
	hud.show()
	await fade.animation_finished

func _process(delta: float) -> void:
	t+=delta
	$Path2D/PathFollow2D.progress = t * 200.0

