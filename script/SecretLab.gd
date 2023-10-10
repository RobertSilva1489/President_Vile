extends Node2D
@onready var light_4 = $"../light/light4"
@onready var light_10 = $"../light/light10"
@onready var light_11 = $"../light/light11"

func _on_secret_1_area_entered(area):
	Global.secretDoor+= 1
	$secret.play()
	$Secret1.queue_free()
	light_4._off()	

func _on_secret_2_area_entered(area):
	Global.secretDoor+= 1	
	$Secret2.queue_free()
	$secret.play()
	light_10._off()


func _on_secret_3_area_entered(area):
	Global.secretDoor+= 1
	$Secret3.queue_free()
	$secret.play()
	light_11._off()
