#var cartucho = 10
#var teste_bala = 0
#export var bala = 10
#export var reload = 20
#export var life = 10 
#func regarregar():
#	if Input.is_action_just_pressed("ui_reload"):
#		if not bala == 10 and reload >= 1:
#			$Spr.play("reload")
#			bala += teste_bala
#			reload -= teste_bala 
#			if reload < 0:
#				reload = 0
#func reload():
#	var aux = 0
#	aux = abs((ammor - 10))
#	if shells > 0 and aux > 0:
#		shells = max(0,shells - aux)
#		ammor += ammoAux
#		print(ammor)
#		print("aux: "+str(aux))
#		aux = 0
#		ammoAux=0
#func atirar (delta):
##---------------ataque--------------------
#	if Input.is_action_just_pressed("ui_fire") and t_shoot<= 0 and mirando == true: 
#		
#		bala -= 1
#		if direction == 1: 
#			shoot(direction,$Spr/Position2D.global_position)
#		elif direction == -1:
#			shoot(direction,$Spr/Position2D2.global_position)
#	yield(get_tree().create_timer(.01),"timeout")
#	t_shoot -= delta

