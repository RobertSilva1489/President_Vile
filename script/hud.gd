extends CanvasLayer



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Control/health.text = str(Global.health)
	$Control/ammo.text = str(Global.ammo)
	$Control/shells.text = str(Global.shells)
	if Global.keyBT == true:
		$Control/keyBlue.visible = true
	else:
		$Control/keyBlue.visible = false
	if Global.keyWT == true:
		$Control/keyWhite.visible = true
	else:
		$Control/keyWhite.visible = false
	if Global.card1 or Global.card2 or Global.card3:
		$Control/Card.visible = true
	else :
		$Control/Card.visible = false
	if Global.sample == true:
		$sample.visible = true
	else:
		$sample.visible = false 
