extends CanvasLayer
@onready var pause = $"."
@onready var buttonc = $Control/Button
@onready var buttonm = $Control/Button2
@onready var buttone = $Control/Button3
@onready var fade = $"/root/TransitionNode/Fill/animation"

func _ready():
	pause.hide()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		_pause()
		$Control/select.play()
	if buttonc.button_pressed:
		_unpause()
	if buttonm.button_pressed:
		_unpause()
		$Control/select.play()
		fade.play("fade_in")
		await fade.animation_finished
		get_tree().change_scene_to_file("res://scene/menu.tscn")
		
	if buttone.button_pressed:
		$Control/select.play()
		_unpause()
		fade.play("fade_in")
		await fade.animation_finished
		get_tree().quit()
func _pause():
	pause.show()
	Global.pause = true
	Engine.time_scale = 0
func _unpause():
	pause.hide()
	Global.pause = false
	Engine.time_scale = 1.0
