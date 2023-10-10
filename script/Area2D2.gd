extends Area2D
enum StateMachine {IDLE, DEATH}
var enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemy!=null:
		enemy._enter_state(StateMachine.IDLE)
		if enemy.health <= 0:
			enemy._enter_state(StateMachine.DEATH)
			enemy.queue_free()

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		enemy = body


func _on_body_exited(body):
	enemy = null
