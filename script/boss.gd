extends CharacterBody2D

enum stateMachine {NULL, INTRO, IDLE, WALK, ATTACK, EMERGE, EMERGE_WALK, EMERGE_ATTACK, DEATH}
const DIS_FLOW = 1000
const DIS_ATTACK = 100

var state = stateMachine.NULL
@export var speed = 50
@export var health = 100
@export var strong = 20
var direction = 0
var enter_state = true
var death = false
var animation = ""
var invencible = false
var can_emerge = true

@onready var animation_player = $AnimationPlayer
@onready var animation_world = $"../SecretLab/AnimationPlayer"

@onready var player: CharacterBody2D = get_parent().get_node("Player")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Global.trigger == true:
		_enter_state(stateMachine.INTRO)
		Global.trigger = false
	if health <= 30 :
		emeger()
		speed = 100
		
		
	if player != null and death == false:
		var distance = global_position.distance_to(player.global_position)
		match  state:
			stateMachine.NULL:
				pass
			stateMachine.INTRO:
				if enter_state:
					enter_state = false
					visible = true
					animation_world.play("boss")
					$emerge.play()
					await animation_world.animation_finished
					_enter_state(stateMachine.IDLE)
			stateMachine.IDLE:
				_set_animation("idle")
				freeze_frame(0.05, 0.2)
				if distance <= DIS_FLOW:
					_enter_state(stateMachine.WALK)
			stateMachine.WALK:
				_set_animation("run")
				_flip()
				velocity.x = direction * speed
				move_and_slide()
				if distance <= DIS_ATTACK and $Timer.time_left <=0:
					_enter_state(stateMachine.ATTACK)
			stateMachine.ATTACK:
				_set_animation("attack")
				$attack.play()
				$Timer.start(.9)
				await animation_player.animation_finished
				_enter_state(stateMachine.IDLE)
			stateMachine.DEATH:
				_set_animation("die")
				$die.play()
				death = true
				Global.boss_die = true
				await animation_player.animation_finished
			


func _enter_state(new_state: stateMachine) -> void:
	if state != new_state:
		state = new_state
		enter_state = true

func _set_animation(anim:String) -> void:
	if animation != anim:
		animation = anim
		animation_player.play(animation)
		
		
func freeze_frame(time, duration):
	Engine.time_scale = time
	await get_tree().create_timer(duration * time).timeout
	Engine.time_scale = 1.0
		
func blink() -> void:
	$Body/Sprite2D.modulate = Color(10,10,10,10)
	await get_tree().create_timer(.1).timeout
	$Body/Sprite2D.modulate = Color(1,1,1,1)
	
func _flip() -> void:
	if global_position.x > player.global_position.x and $Timer.time_left <=0:
		$Body.scale.x = 1
		direction = -1
	
	if global_position.x < player.global_position.x and $Timer.time_left <=0:
		$Body.scale.x = -1 
		direction = 1

func damage (dame) -> void:
	if invencible != true:
		health -= dame
		$hurt.play()
		blink()
	if health <=0:
		_enter_state(stateMachine.DEATH)
		


func _on_attack_body_entered(body):
	if player !=null:
		if player.is_in_group("player"):
			player.take_damage(strong)
			
			
func emeger() -> void:
	$Body/Sprite2D.modulate = Color(0.93,0,0,1)
