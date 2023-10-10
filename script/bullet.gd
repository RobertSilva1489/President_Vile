extends Area2D

var speed = 300
var direction = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	$AnimatedSprite2D.play("fire")

func _physics_process(delta) -> void:
	if direction == 1:
		scale.x = 1
		position.x += speed * delta
	if direction == -1:
		scale.x = -1
		position.x -= speed * delta

func _on_body_entered(body):
	$AnimatedSprite2D.play("hit")
	if body.is_in_group("enemy"):
		body.damage(int(randf_range(5,10)))
	await $AnimatedSprite2D.animation_finished
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
