extends Node2D
@onready var button_r: Button = $Control/Button
@onready var button_e: Button = $Control/Button2
@onready var hud : CanvasLayer = $"/root/Hud"
@onready var fade = $"/root/TransitionNode/Fill/animation"
# Called when the node enters the scene tree for the first time.
func _ready():
	fade.play("fade_out")
	await fade.animation_finished
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hud.visible = false
	if button_r.button_pressed:
		$Control/AudioStreamPlayer2D.play()
		fade.play("fade_in")
		await fade.animation_finished
		get_tree().change_scene_to_file("res://scene/World.tscn")
	if button_e.button_pressed:
		$Control/AudioStreamPlayer2D.play()
		fade.play("fade_in")
		await fade.animation_finished
		get_tree().quit()

	
