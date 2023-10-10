extends CharacterBody2D

@export var health = 100
@export var SPEED = 100.0
const JUMP_VELOCITY = -300
var run = false
var fire = false
var dead = false
@export var t_shoot = .0
@export var keyW = false
@export var keyb = false
@export var ammor = 10
@export var mag = 10
var ammoAux = 0
var _direction = 1
var gravity = 980
@export var shells = 10
@onready var fade = $"/root/TransitionNode/Fill/animation"
var bullet: PackedScene = preload("res://scene/bullet.tscn")


# Get the gravity from the project settings to be synced with RigidBody nodes
 
func _ready():
	$Body/AnimatedSprite2D.play("idle")
	freeze_frame(0.05, 1.0)
func _physics_process(delta) -> void:
	ammoAux = mag - ammor
	health = Global.health
	ammor = Global.ammo
	shells = Global.shells 
	keyW = Global.keyWT
	keyb = Global.keyBT
	if dead == true:
		$Body/AnimatedSprite2D.play("die")
		await $Body/AnimatedSprite2D.animation_finished
		get_tree().change_scene_to_file("res://scene/game_over.tscn")
		queue_free()
	if dead != true and Global.pause != true:
		if not is_on_floor():
			velocity.y += gravity * delta

		# Handle Jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")

		if direction:
			velocity.x = direction * SPEED
			run = true
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if direction > 0:
			$Body/AnimatedSprite2D.play("run")
			$Body.transform.x.x = 1
			_direction = 1
			if $Timer.time_left <=0:
				$step.pitch_scale = randf_range(0.8,1.2)
				$step.play()
				$Timer.start(0.2)
		if direction < 0:
			$Body/AnimatedSprite2D.play("run")
			$Body.transform.x.x = -1
			_direction = -1
			if $Timer.time_left <=0:
				$step.pitch_scale = randf_range(0.8,1.2)
				$step.play()
				$Timer.start(0.2)
		if !is_on_floor() and fire:
			$Body/AnimatedSprite2D.pause()	
		if Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
			
			$step.stop()
			$Body/AnimatedSprite2D.play("idle")
			run = false
		if Input.is_action_just_pressed("shoot") and !run and t_shoot<=0:
			shoot()
			ammoAux+=1
			await get_tree().create_timer(5).timeout		
		if Input.is_action_just_pressed("reload"):
			if ammor < 10:
				reload()
			
		move_and_slide()
func take_damage(dame):
	blink()
	Global.health = max(0,Global.health - dame)
	$hit.play()
	$Body/AnimatedSprite2D.play("hit")
	if Global.health <= 0:
		dead = true
		$Body/AnimatedSprite2D.play("die") 
		$Body/hitbox.monitorable = false
		$Body/hitbox.monitoring = false
		$dead.play()
		await $Body/AnimatedSprite2D.animation_finished
		fade.play("fade_in")
		await fade.animation_finished
		get_tree().change_scene_to_file("res://scene/game_over.tscn")
		queue_free()
	await $Body/AnimatedSprite2D.animation_finished
	$Body/AnimatedSprite2D.play("idle")
func shoot():
	if Global.ammo > 0 and bullet!= null:
		Global.ammo -= 1
		$Body/AnimatedSprite2D.play("shoot")
		var bullets = bullet.instantiate()
		get_parent().add_child(bullets)
		$shoot.play()
		bullets.global_position = $Body/gun_point.global_position
		bullets.direction = _direction
		await $Body/AnimatedSprite2D.animation_finished
		$Body/AnimatedSprite2D.play("idle")
func reload():
	if Global.shells > 0 and ammoAux > 0:
		$Body/AnimatedSprite2D.play("reload")
		$reload.play()
		await $Body/AnimatedSprite2D.animation_finished
		$Body/AnimatedSprite2D.play("idle")
		if ammoAux > Global.shells:
			Global.ammo += Global.shells
		else:
			Global.ammo += ammoAux
		Global.shells = max(0,Global.shells - ammoAux)
		ammoAux=0	
func trap (instaK: bool) -> void:
	blink()
	if instaK == true:
		Global.health = 0
		if Global.health == 0:
			dead = true
			$Body/AnimatedSprite2D.play("die")
			$dead.play()
			await $Body/AnimatedSprite2D.animation_finished
			fade.play("fade_in")
			await fade.animation_finished
			get_tree().change_scene_to_file("res://scene/game_over.tscn")
			queue_free()
	elif instaK == false:
		Global.health = max(0,Global.health - 50)
		$hit.play()
		if Global.health == 0:
			dead = true
			$Body/AnimatedSprite2D.play("die")
			$Body/hitbox/box.disabled = true
			$dead.play()
			await $Body/AnimatedSprite2D.animation_finished
			fade.play("fade_in")
			await fade.animation_finished
			get_tree().change_scene_to_file("res://scene/game_over.tscn")
			queue_free()
	
func freeze_frame(time, duration):
	Engine.time_scale = time
	await get_tree().create_timer(duration * time).timeout
	Engine.time_scale = 1.0
		
func blink() -> void:
	$Body/AnimatedSprite2D.modulate = Color(10,10,10,10)
	await get_tree().create_timer(.1).timeout
	$Body/AnimatedSprite2D.modulate = Color(1,1,1,1)
		
		
