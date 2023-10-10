extends Node2D
@onready var button_r: Button = $Control/Button
@onready var button_e: Button = $Control/Button3
@onready var button_m: Button = $Control/Button2
@onready var hud : CanvasLayer = $"/root/Hud"
@onready var fade = $"/root/TransitionNode/Fill/animation"
# Called when the node enters the scene tree for the first time.
func _ready():
	fade.play("fade_out")
	Hud.hide()
	await fade.animation_finished

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hud.visible = false
	if button_r.button_pressed:
		$Control/select.play()
		fade.play("fade_in")
		await fade.animation_finished
		Global.health = 100
		Global.ammo = 10
		Global.shells = 30
		match Global.check_world:
			"World1":
				get_tree().change_scene_to_file("res://scene/World.tscn")
				Hud.show()
			"World2":
				get_tree().change_scene_to_file("res://scene/world_2.tscn")
				Hud.show()
			"World3":
				get_tree().change_scene_to_file("res://scene/world_3.tscn")
				Hud.show()
			"lab":
				get_tree().change_scene_to_file("res://scene/secret_lab.tscn")
				Hud.show()
		
	if button_e.button_pressed:
		$Control/select.play()
		fade.play("fade_in")
		await fade.animation_finished
		get_tree().quit()

	if button_m.button_pressed:
		$Control/select.play()
		fade.play("fade_in")
		await fade.animation_finished
		get_tree().change_scene_to_file("res://scene/menu.tscn")
