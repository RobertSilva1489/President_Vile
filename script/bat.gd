extends CharacterBody2D
enum StateMachine {IDLE, WALK, ATTACK, DEATH}
@export var SPEED = 100
@export var DIST_FOLLOW := 300
@export var DIST_ATTACK := 40
var distance := 0.0
@export var strong = 5
@export var health = 10
var animation = ""
var state = StateMachine.IDLE
var direction = 0
var death = false
var gravity = 1200
@onready var animation_player: AnimatedSprite2D = $AnimatedSprite2D
@onready var player = owner.get_node("Player")
func _ready():
	$bat.play()
	freeze_frame(0.05, 1.0)
func _physics_process(delta: float) -> void:
	if player !=null:
		distance = global_position.distance_to(player.global_position)
	if death == false:
		match state:
			StateMachine.IDLE:
				_set_animation("fly")
				if distance <= DIST_FOLLOW:
					_enter_state(StateMachine.WALK)
			StateMachine.WALK:
				_set_animation("fly")
				_flip()
				velocity.x = direction * SPEED
				if global_position.y != player.global_position.y:
					if global_position.y > player.global_position.y:
						velocity.y = -70
					if global_position.y < player.global_position.y:
						velocity.y = 70
				move_and_slide()
				if distance >= DIST_FOLLOW + 200:
					_enter_state(StateMachine.IDLE)
				if distance <= DIST_ATTACK:
					_enter_state(StateMachine.ATTACK)
			StateMachine.ATTACK:
				if Global.health > 0 :
					$attack.monitoring = true
					await get_tree().create_timer(.1).timeout
					$attack.monitoring = false
					
					_enter_state(StateMachine.IDLE)
			StateMachine.DEATH:
				_set_animation("die")
				$bat.stop()
				velocity.y += gravity 
				death = true
				await animation_player.animation_finished
				queue_free()
func _enter_state(new_state: StateMachine)->void:
	if state != new_state:
		state = new_state

func _set_animation(anim:String) -> void:
	if animation != anim:
		animation = anim
		animation_player.play(animation)
func _flip() -> void:
	if player !=null:
		if global_position.x < player.global_position.x:
			$AnimatedSprite2D.flip_h = false
			direction = 1
		elif global_position.x > player.global_position.x:
			$AnimatedSprite2D.flip_h = true
			direction = -1	
func damage (dame) -> void:
	dame = int(randf_range(5,10))
	health -= dame
	blink()
	_enter_state(StateMachine.IDLE)
	if health <=0:
		_enter_state(StateMachine.DEATH)
		

func _on_attack_body_entered(body):
	if player !=null:
		if player.is_in_group("player") and $Timer.time_left <=0:
			player.take_damage(strong)
			$Timer.start(1)

func blink() -> void:
	$AnimatedSprite2D.modulate = Color(10,10,10,10)
	await get_tree().create_timer(.1).timeout
	$AnimatedSprite2D.modulate = Color(1,1,1,1)

func freeze_frame(time, duration):
	Engine.time_scale = time
	await get_tree().create_timer(duration * time).timeout
	Engine.time_scale = 1.0
	
