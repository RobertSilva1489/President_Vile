extends Area2D


@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "Start"

func action() -> void:
	DialogueManager.show_example_dialogue_balloon(dialogue_resource,dialogue_start)


func _on_body_entered(body):
	action()
	await get_tree().create_timer(1).timeout
	self.queue_free()
