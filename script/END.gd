extends Node2D

@onready var hud = $"/root/Hud"
@onready var fade = $"/root/TransitionNode/Fill/animation"
@onready var buttonM = $Control/MenuBar/Button
@onready var buttonQ = $Control/MenuBar/Button2
# Called when the node enters the scene tree for the first time.
func _ready():
	hud.hide()
	fade.play("fade_out")
	await fade.animation_finished


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if buttonM.button_pressed:
		fade.play("fade_in")
		$AudioStreamPlayer2D.play()
		await fade.animation_finished
		get_tree().change_scene_to_file("res://scene/menu.tscn")
	if buttonQ.button_pressed:
		fade.play("fade_in")
		$AudioStreamPlayer2D.play()
		await fade.animation_finished
		get_tree().quit()
